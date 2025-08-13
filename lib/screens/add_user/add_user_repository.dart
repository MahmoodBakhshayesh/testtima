import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/add_user_repository_interface.dart';
import 'data_sources/add_user_local_ds.dart';
import 'data_sources/add_user_remote_ds.dart';

class AddUserRepository implements AddUserRepositoryInterface {
  final AddUserRemoteDataSource addUserRemoteDataSource = AddUserRemoteDataSource();
  final AddUserLocalDataSource addUserLocalDataSource = AddUserLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  AddUserRepository();
}
