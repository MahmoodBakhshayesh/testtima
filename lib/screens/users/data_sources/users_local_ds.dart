import 'package:abds/core/interfaces/result_int.dart';

import 'package:abds/screens/users/usecases/edit_user_usecase.dart';

import 'package:abds/screens/users/usecases/get_users_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/users_data_source_interface.dart';

class UsersLocalDataSource implements UsersDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  UsersLocalDataSource();

  @override
  Future<EditUserResponse> editUser({required EditUserRequest request}) {
    // TODO: implement editUser
    throw UnimplementedError();
  }

  @override
  Future<GetUserListResponse> getUserList({required GetUserListRequest request}) {
    // TODO: implement getUserList
    throw UnimplementedError();
  }




}
