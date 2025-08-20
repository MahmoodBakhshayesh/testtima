import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/users_repository_interface.dart';
import 'data_sources/users_local_ds.dart';
import 'data_sources/users_remote_ds.dart';
import 'usecases/edit_user_usecase.dart';
import 'usecases/get_users_usecase.dart';
import 'usecases/update_user_usecase.dart';

class UsersRepository implements UsersRepositoryInterface {
  final UsersRemoteDataSource usersRemoteDataSource = UsersRemoteDataSource();
  final UsersLocalDataSource usersLocalDataSource = UsersLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  UsersRepository();

  @override
  Future<Result<GetUserListResponse>> getUserList(GetUserListRequest request) async {
    try {
      GetUserListResponse getUserListResponse;
      if (await networkInfo.isConnected) {
        getUserListResponse = await usersRemoteDataSource.getUserList(request: request);
      } else {
        getUserListResponse = await usersLocalDataSource.getUserList(request: request);
      }
      return Result.ok(getUserListResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<EditUserResponse>> editUser(EditUserRequest request) async {
    try {
      EditUserResponse editUserResponse;
      if (await networkInfo.isConnected) {
        editUserResponse = await usersRemoteDataSource.editUser(request: request);
      } else {
        editUserResponse = await usersLocalDataSource.editUser(request: request);
      }
      return Result.ok(editUserResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
  
  @override
  Future<Result<UpdateUserResponse>> updateUser(UpdateUserRequest request) async {
    try {
      UpdateUserResponse editUserResponse;
      if (await networkInfo.isConnected) {
        editUserResponse = await usersRemoteDataSource.updateUser(request: request);
      } else {
        editUserResponse = await usersLocalDataSource.updateUser(request: request);
      }
      return Result.ok(editUserResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
