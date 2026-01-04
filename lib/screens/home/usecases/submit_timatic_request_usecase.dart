import 'dart:convert';

import 'package:abds/core/classes/current_status_class.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/timatic_response_new_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class SubmitTimaticRequestUseCase extends UseCase<SubmitTimaticRequestResponse, SubmitTimaticRequestRequest> {
  SubmitTimaticRequestUseCase();

  @override
  Future<Result<SubmitTimaticRequestResponse>> call({required SubmitTimaticRequestRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.submitTimaticRequest(request);
  }
}

class SubmitTimaticRequestRequest extends RequestInterface {
  final DocumentRequest documentRequest;
  final String? employeeId;

  SubmitTimaticRequestRequest({required this.documentRequest, required this.employeeId});

  @override
  Map<String, dynamic> toJson() {
    final reqJson = documentRequest.toJson();
    reqJson.putIfAbsent("employeeId", () => employeeId);
    return reqJson;
  }

  Failure? validate() {
    return null;
  }
}

class SubmitTimaticRequestResponse extends ResponseInterface {
  final TimaticResponseNew response;
  final CurrentStatus currentStatus;
  final String refCode;
  final String showCode;

  SubmitTimaticRequestResponse({required super.status, required super.message, required this.response, required this.refCode,required this.showCode, required this.currentStatus}) : super(body: response.toJson());

  factory SubmitTimaticRequestResponse.fromResponse(ResponseInterface res) =>
      SubmitTimaticRequestResponse(status: res.status, currentStatus: CurrentStatus.fromJson(res.body["result"]),
          message: res.message,
          refCode: res.body["refCode"].toString(),
          showCode: res.body["showCode"].toString(),
          response: TimaticResponseNew.fromJson(jsonDecode(res.body["logs"][0]["payload"]["output"])

          ));
}
