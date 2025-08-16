import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/add_user_usecase.dart';


abstract class AddUserRepositoryInterface {
  Future<Result<AddUserResponse>> addUser(AddUserRequest request);
}