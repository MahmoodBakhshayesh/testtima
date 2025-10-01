import 'dart:convert';

import 'package:abds/core/classes/ref_history_log_class.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/classes/current_status_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class AskSupervisorUseCase extends UseCase<AskSupervisorResponse, AskSupervisorRequest> {
  AskSupervisorUseCase();

  @override
  Future<Result<AskSupervisorResponse>> call({required AskSupervisorRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.askSupervisor(request);
  }
}

class AskSupervisorRequest extends RequestInterface {
  final String logId;
  final String supervisorId;
  final String message;

  AskSupervisorRequest({required this.logId, required this.supervisorId, required this.message});

  @override
  Map<String, dynamic> toJson() => {"supervisorId": supervisorId, "message": message};

  Failure? validate() {
    return null;
  }
}

class AskSupervisorResponse extends ResponseInterface {
  final String msg;
  final List<RefHistoryLog> logs;
  final CurrentStatus currentStatus;

  AskSupervisorResponse({required super.status, required super.message, required this.msg, required this.logs, required this.currentStatus})
    : super(body: {"logs": logs.map((l) => l.toJson()).toList(), "result": currentStatus.toJson()});

  factory AskSupervisorResponse.fromResponse(ResponseInterface res) => AskSupervisorResponse(
    status: res.status,
    message: res.message,
    msg: res.message,
    currentStatus: CurrentStatus.fromJson(res.body["result"]),
    logs: List<RefHistoryLog>.from((res.body["logs"].map((a) => RefHistoryLog.fromJson(a)))),
  );
}
