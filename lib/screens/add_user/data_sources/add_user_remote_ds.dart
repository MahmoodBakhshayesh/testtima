import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/add_user_data_source_interface.dart';
import 'add_user_local_ds.dart';

class AddUserRemoteDataSource implements AddUserDataSourceInterface {
  final AddUserLocalDataSource localDataSource = AddUserLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  AddUserRemoteDataSource();
}
