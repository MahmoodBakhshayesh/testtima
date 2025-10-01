import 'dart:developer';

import 'package:abds/core/classes/people_class.dart';
import 'package:logging/logging.dart';
import '../../core/classes/user_permission_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/interfaces/success_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/handlers/success_handler.dart';
import '../../initialize.dart';
import '../users/users_controller.dart';
import 'usecases/add_user_usecase.dart';

class AddUserController extends ControllerInterface {
  final _log = Logger('AddUserController');

  Future<People?> addUser({required String? username, required String? email, required String? password, required String? firstname, required String? lastname, required UserPermission permissions,required Map<String,dynamic> attributes}) async {
    People? user;
    AddUserUseCase addUserUseCase = AddUserUseCase();
    AddUserRequest addUserRequest = AddUserRequest(email: email, username: username, password: password, firstname: firstname, lastname: lastname, permissions: permissions, attributes: attributes);
    final result = await addUserUseCase(request: addUserRequest);

    switch (result) {
      case Err<AddUserResponse>():
        log(result.error.code.toString());
        FailureHandler.handle(result.error);

      case Ok<AddUserResponse>():
        final r = result.value;
        getIt<UsersController>().getUserList();

        navigation.pop();
        Future.delayed(Duration(milliseconds: 300), () {
          SuccessHandler.handle(ServerSuccess(code: 1, msg: "User added Successfully!"));
        });
    }

    return user;
  }
}
