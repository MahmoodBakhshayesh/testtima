import '../../../core/interfaces/result_int.dart';
import '../usecases/edit_user_usecase.dart';
import '../usecases/get_users_usecase.dart';

abstract class UsersDataSourceInterface {
  Future<GetUserListResponse> getUserList({required GetUserListRequest request});
  Future<EditUserResponse> editUser({required EditUserRequest request});
  // Future<Response> ({required Request request});
}