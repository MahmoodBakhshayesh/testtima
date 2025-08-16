import 'package:abds/core/interfaces/result_int.dart';

import 'package:abds/screens/add_user/usecases/add_user_usecase.dart';

import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../initialize.dart';
import 'interfaces/add_user_repository_interface.dart';
import 'data_sources/add_user_local_ds.dart';
import 'data_sources/add_user_remote_ds.dart';

class AddUserRepository implements AddUserRepositoryInterface {
  final AddUserRemoteDataSource addUserRemoteDataSource = AddUserRemoteDataSource();
  final AddUserLocalDataSource addUserLocalDataSource = AddUserLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  AddUserRepository();

  @override
  Future<Result<AddUserResponse>> addUser(AddUserRequest request) async {
    try {
      AddUserResponse addUserResponse;
      if (await networkInfo.isConnected) {
        addUserResponse = await addUserRemoteDataSource.addUser(request: request);
      } else {
        addUserResponse = await addUserLocalDataSource.addUser(request: request);
      }
      return Result.ok(addUserResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
