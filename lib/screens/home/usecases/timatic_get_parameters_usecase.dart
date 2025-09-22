import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class TimaticGetParametersUseCase extends UseCase<TimaticGetParametersResponse, TimaticGetParametersRequest> {
  TimaticGetParametersUseCase();

  @override
  Future<Result<TimaticGetParametersResponse>> call({required TimaticGetParametersRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.timaticGetParameters(request);
  }
}

class TimaticGetParametersRequest extends RequestInterface {
  final List<String> codes;
  final String? name;

  TimaticGetParametersRequest({required this.codes, required this.name});

  @override
  Map<String, dynamic> toJson() => {
    "Body": {"Execution": "TimaticGetParameters", "Token": token, "Request": {}},
  };

  Failure? validate() {
    return null;
  }
}

class TimaticGetParametersResponse extends ResponseInterface {
  final ParametersEnvelope parametersEnvelope;

  TimaticGetParametersResponse({required super.status, required super.message, required this.parametersEnvelope}) : super(body:parametersEnvelope.toJson());

  factory TimaticGetParametersResponse.fromResponse(ResponseInterface res) => TimaticGetParametersResponse(status: res.status, message: res.message, parametersEnvelope: ParametersEnvelope.fromJson(res.body));
}
