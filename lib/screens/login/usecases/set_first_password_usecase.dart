import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../login_repository.dart';

class SetFirstPasswordUseCase extends UseCase<SetFirstPasswordResponse, SetFirstPasswordRequest> {
  SetFirstPasswordUseCase();

  @override
  Future<Result<SetFirstPasswordResponse>> call({required SetFirstPasswordRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    LoginRepository repository = LoginRepository();
    return repository.setFirstPassword(request);
  }
}

class SetFirstPasswordRequest extends RequestInterface {
  final String oldPass;
  final String newPass;

  SetFirstPasswordRequest({required this.oldPass, required this.newPass});

  @override
  Map<String, dynamic> toJson() => {
    "oldPassword": oldPass,
    "newPassword": newPass
  };

  Failure? validate() {
    return null;
  }
}

class SetFirstPasswordResponse extends ResponseInterface {
  final String msg;

  SetFirstPasswordResponse({required super.status, required super.message, required this.msg})
      : super(
          body: msg,
        );

  factory SetFirstPasswordResponse.fromResponse(ResponseInterface res) => SetFirstPasswordResponse(
        status: res.status,
        message: res.message,
        msg: res.message,
      );
}
