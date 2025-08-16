import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../login_repository.dart';

class SendForgetPasswordCodeUseCase extends UseCase<SendForgetPasswordCodeResponse,SendForgetPasswordCodeRequest> {
  SendForgetPasswordCodeUseCase();

  @override
  Future<Result<SendForgetPasswordCodeResponse>> call({required SendForgetPasswordCodeRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    LoginRepository repository = LoginRepository();
    return repository.sendForgetPasswordCode(request);
  }

}

class SendForgetPasswordCodeRequest extends RequestInterface {
  final String email;

  SendForgetPasswordCodeRequest({required this.email});

  @override
  Map<String, dynamic> toJson() =>{
    "email": email
  };

  Failure? validate(){
    return null;
  }
}


class SendForgetPasswordCodeResponse extends ResponseInterface {
  final String msg;
  SendForgetPasswordCodeResponse({required super.status, required super.message, required this.msg})
      : super(
          body: {
            "String" : msg,
          },
        );

    factory SendForgetPasswordCodeResponse.fromResponse(ResponseInterface res) => SendForgetPasswordCodeResponse(
        status: res.status,
        message: res.message,
        msg:res.message,
      );

}


