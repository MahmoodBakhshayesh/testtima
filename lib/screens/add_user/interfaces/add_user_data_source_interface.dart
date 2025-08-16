import '../usecases/add_user_usecase.dart';

abstract class AddUserDataSourceInterface {
  Future<AddUserResponse> addUser({required AddUserRequest request});
}