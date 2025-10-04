import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../login_repository.dart';

class GetPublishServerUseCase extends UseCase<GetPublishServerResponse,GetPublishServerRequest> {
  GetPublishServerUseCase();

  @override
  Future<Result<GetPublishServerResponse>> call({required GetPublishServerRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    LoginRepository repository = LoginRepository();
    return repository.getPublishServer(request);
  }

}

class GetPublishServerRequest extends RequestInterface {
  GetPublishServerRequest();

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetPublishServer",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}


class GetPublishServerResponse extends ResponseInterface {
  final String apiAddress;
  GetPublishServerResponse({required super.status, required super.message, required this.apiAddress})
      : super(
          body: {
            "apiAddress" : apiAddress,
          },
        );

    factory GetPublishServerResponse.fromResponse(ResponseInterface res) => GetPublishServerResponse(
        status: res.status,
        message: res.message,
        apiAddress:res.body["apiAddress"]
      );

}

