import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/user_permission_class.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/people_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../users_repository.dart';

class EditUserUseCase extends UseCase<EditUserResponse, EditUserRequest> {
  EditUserUseCase();

  @override
  Future<Result<EditUserResponse>> call({required EditUserRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    UsersRepository repository = UsersRepository();
    return repository.editUser(request);
  }
}

class EditUserRequest extends RequestInterface {
  final People people;
  final bool active;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? password;
  final UserPermission updatedPermission;
  final Map<String, dynamic> attributes;

  EditUserRequest({required this.people,

    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password, required this.active, required this.updatedPermission, required this.attributes});

  @override
  Map<String, dynamic> toJson() {
    final json =  {"enable": active,
      "firstname":firstname,
      "lastname":lastname,
      "permission": updatedPermission.toPermissionMap(), "attributes": attributes};
    if(password!= null){
      json.putIfAbsent("newPassword", ()=>password!);
    }
    if(email!= null){
      json.putIfAbsent("email", ()=>email!);
    }
    return json;
  }

  Failure? validate() {
    return null;
  }
}

class EditUserResponse extends ResponseInterface {
  final String msg;

  EditUserResponse({required super.status, required super.message, required this.msg}) : super(body: msg);

  factory EditUserResponse.fromResponse(ResponseInterface res) {
    // log(jsonEncode(res.body));
    return EditUserResponse(status: res.status, message: res.message, msg: res.message);
  }
}
