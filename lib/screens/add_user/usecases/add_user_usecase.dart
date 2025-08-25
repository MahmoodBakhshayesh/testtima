import 'package:abds/core/extenstions/string_ext.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/people_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../add_user_repository.dart';

class AddUserUseCase extends UseCase<AddUserResponse,AddUserRequest> {
  AddUserUseCase();

  @override
  Future<Result<AddUserResponse>> call({required AddUserRequest request}) {
  if(request.validate()!=null) return Future(() =>Result.error(request.validate()!));
    AddUserRepository repository = AddUserRepository();
    return repository.addUser(request);
  }

}

class AddUserRequest extends RequestInterface {
  final String? email;
  final String? username;
  final String? password;
  final String? firstname;
  final String? lastname;
  final UserPermission permissions;

  AddUserRequest({required this.email, required this.username, required this.password, required this.firstname, required this.lastname, required this.permissions});

  @override
  Map<String, dynamic> toJson() =>{
    "email": email.pureValue,
    "username": username.pureValue,
    "password": password.pureValue,
    "firstname": firstname.pureValue,
    "middlename": null,
    "lastname":lastname.pureValue,
    "permissions":permissions.toJson(),


  };

  Failure? validate(){
    return null;
  }
}


class AddUserResponse extends ResponseInterface {
  final People? people;
  AddUserResponse({required super.status, required super.message, required this.people})
      : super(
          body: {
            "People" : people?.toJson(),
          },
        );

    factory AddUserResponse.fromResponse(ResponseInterface res) => AddUserResponse(
        status: res.status,
        message: res.message,
        people:res.body["People"]== null? null:People.fromJson(res.body["People"]),
      );

}
