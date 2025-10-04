import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../home_repository.dart';

class ValidateEmployeeIdUseCase extends UseCase<ValidateEmployeeIdResponse,ValidateEmployeeIdRequest> {
  ValidateEmployeeIdUseCase();

  @override
  Future<Result<ValidateEmployeeIdResponse>> call({required ValidateEmployeeIdRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    HomeRepository repository = HomeRepository();
    return repository.validateEmployeeId(request);
  }

}

class ValidateEmployeeIdRequest extends RequestInterface {
  final String id;

  ValidateEmployeeIdRequest({required this.id});

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "ValidateEmployeeId",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}


class ValidateEmployeeIdResponse extends ResponseInterface {
  final bool valid;
  ValidateEmployeeIdResponse({required super.status, required super.message, required this.valid})
      : super(
          body: {

          },
        );

    factory ValidateEmployeeIdResponse.fromResponse(ResponseInterface res) => ValidateEmployeeIdResponse(
        status: res.status,
        message: res.message,
        valid:true
      );

}


