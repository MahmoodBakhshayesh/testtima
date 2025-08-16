import 'package:abds/screens/add_user/usecases/add_user_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/add_user_data_source_interface.dart';

class AddUserLocalDataSource implements AddUserDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();

  AddUserLocalDataSource();

  @override
  Future<AddUserResponse> addUser({required AddUserRequest request}) {
    // TODO: implement addUser
    throw UnimplementedError();
  }
}
