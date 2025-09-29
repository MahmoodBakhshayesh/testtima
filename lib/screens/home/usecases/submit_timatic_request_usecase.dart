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
  SubmitTimaticRequestRequest({required this.documentRequest,required this.employeeId});

  @override
  Map<String, dynamic> toJson() => documentRequest.toJson();

  Failure? validate() {
    return null;
  }
}

class SubmitTimaticRequestResponse extends ResponseInterface {
  final TimaticResponseNew response;
  final String refCode;

  SubmitTimaticRequestResponse({required super.status, required super.message, required this.response, required this.refCode}) : super(body: response.toJson());

  factory SubmitTimaticRequestResponse.fromResponse(ResponseInterface res) =>
      SubmitTimaticRequestResponse(status: res.status, message: res.message, refCode: res.body["refCode"], response: TimaticResponseNew.fromJson(res.body));
}
