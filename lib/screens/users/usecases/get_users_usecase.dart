import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/classes/people_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../users_repository.dart';

class GetUserListUseCase extends UseCase<GetUserListResponse,GetUserListRequest> {
  GetUserListUseCase();

  @override
  Future<Result<GetUserListResponse>> call({required GetUserListRequest request}) {
    if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    UsersRepository repository = UsersRepository();
    return repository.getUserList(request);
  }

}

class GetUserListRequest extends RequestInterface {
  GetUserListRequest();

  @override
  Map<String, dynamic> toJson() =>{
    "Body": {
      "Execution": "GetUserList",
      "Token":token,
      "Request": {
      }
    }
  };

  Failure? validate(){
    return null;
  }
}


class GetUserListResponse extends ResponseInterface {
  final List<People> peoples;

  GetUserListResponse({required super.status, required super.message, required this.peoples})
      : super(body:peoples.map((e)=>e.toJson()).toList());

  factory GetUserListResponse.fromResponse(ResponseInterface res) {
    return GetUserListResponse(
      status: res.status,
      message: res.message,
      peoples: List<People>.from(res.body.map((x) => People.fromJson(x))),
    );
  }
}
