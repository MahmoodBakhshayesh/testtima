import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/ref_history_log_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class SupervisorResponseUseCase extends UseCase<SupervisorResponseResponse, SupervisorResponseRequest> {
  SupervisorResponseUseCase();

  @override
  Future<Result<SupervisorResponseResponse>> call({required SupervisorResponseRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.supervisorResponse(request);
  }
}

class SupervisorResponseRequest extends RequestInterface {
  final String logId;
  final String msg;
  final SupervisorResponse supervisorResponse;

  SupervisorResponseRequest({required this.logId, required this.msg, required this.supervisorResponse});

  @override
  Map<String, dynamic> toJson() => {"actionId": supervisorResponse.actionId, "message": msg};

  Failure? validate() {
    return null;
  }
}

class SupervisorResponseResponse extends ResponseInterface {
  final String msg;
  final List<RefHistoryLog> logs;

  SupervisorResponseResponse({required super.status, required super.message, required this.msg, required this.logs}) : super(body: {"logs": logs.map((a) => a.toJson()).toList()});

  factory SupervisorResponseResponse.fromResponse(ResponseInterface res) =>
      SupervisorResponseResponse(status: res.status, message: res.message, msg: res.message, logs: List<RefHistoryLog>.from((res.body["logs"].map((a) => RefHistoryLog.fromJson(a)))));
}
