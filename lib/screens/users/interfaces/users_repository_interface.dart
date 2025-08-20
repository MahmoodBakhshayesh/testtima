import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/edit_user_usecase.dart';
import '../usecases/get_users_usecase.dart';
import '../usecases/update_user_usecase.dart';


abstract class UsersRepositoryInterface {
  Future<Result<GetUserListResponse>> getUserList(GetUserListRequest request);
  Future<Result<EditUserResponse>> editUser(EditUserRequest request);
  Future<Result<UpdateUserResponse>> updateUser(UpdateUserRequest request);
  // Future<Result<Response>> (Request request);
}