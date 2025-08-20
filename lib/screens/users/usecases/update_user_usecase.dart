import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../core/classes/people_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../users_repository.dart';

class UpdateUserUseCase extends UseCase<UpdateUserResponse,UpdateUserRequest> {
  UpdateUserUseCase();

  @override
  Future<Result<UpdateUserResponse>> call({required UpdateUserRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    UsersRepository repository = UsersRepository();
    return repository.updateUser(request);
  }

}

class UpdateUserRequest extends RequestInterface {
  final String defaultAirport;

  UpdateUserRequest({required this.defaultAirport});

  @override
  Map<String, dynamic> toJson() =>{
    "defaultAirport": defaultAirport
  };

  Failure? validate(){
    return null;
  }
}


class UpdateUserResponse extends ResponseInterface {
  final String msg;
  UpdateUserResponse({required super.status, required super.message, required this.msg})
      : super(
          body: msg,
        );

    factory UpdateUserResponse.fromResponse(ResponseInterface res) {
      // log(jsonEncode(res.body));
      return UpdateUserResponse(
        status: res.status,
        message: res.message,
        msg:res.message,
      );
    }

}


