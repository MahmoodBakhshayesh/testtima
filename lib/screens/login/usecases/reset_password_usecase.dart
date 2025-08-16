import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../login_repository.dart';

class ResetPasswordUseCase extends UseCase<ResetPasswordResponse,ResetPasswordRequest> {
  ResetPasswordUseCase();

  @override
  Future<Result<ResetPasswordResponse>> call({required ResetPasswordRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    LoginRepository repository = LoginRepository();
    return repository.resetPassword(request);
  }

}

class ResetPasswordRequest extends RequestInterface {
  final String email;
  final String newPassword;
  final String code;

  ResetPasswordRequest({required this.email, required this.newPassword, required this.code});

  @override
  Map<String, dynamic> toJson() =>{
    "email": email,
    "code": code,
    "newPassword": newPassword
  };

  Failure? validate(){
    return null;
  }
}


class ResetPasswordResponse extends ResponseInterface {
  final String msg;
  ResetPasswordResponse({required super.status, required super.message, required this.msg})
      : super(
          body: {
            "String" : msg
          },
        );

    factory ResetPasswordResponse.fromResponse(ResponseInterface res) => ResetPasswordResponse(
        status: res.status,
        message: res.message,
        msg:res.message
      );

}


