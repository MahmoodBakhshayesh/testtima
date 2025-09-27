import 'package:abds/core/classes/constant_data_class.dart';
import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../login_repository.dart';

class GetConsDataUseCase extends UseCase<GetConsDataResponse,GetConsDataRequest> {
  GetConsDataUseCase();

  @override
  Future<Result<GetConsDataResponse>> call({required GetConsDataRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    LoginRepository repository = LoginRepository();
    return repository.getConsData(request);
  }

}

class GetConsDataRequest extends RequestInterface {
  final String constVersion;

  GetConsDataRequest({required this.constVersion});

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetConsData",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}


class GetConsDataResponse extends ResponseInterface {
  final VersionedConstantData constantData;
  GetConsDataResponse({required super.status, required super.message, required this.constantData})
      : super(
          body: constantData.toJson(),
        );

    factory GetConsDataResponse.fromResponse(ResponseInterface res) => GetConsDataResponse(
        status: res.status,
        message: res.message,
        constantData:VersionedConstantData.fromJson(res.body),
      );

}


