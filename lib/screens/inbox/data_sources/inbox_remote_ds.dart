import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/inbox_data_source_interface.dart';
import 'inbox_local_ds.dart';

class InboxRemoteDataSource implements InboxDataSourceInterface {
  final InboxLocalDataSource localDataSource = InboxLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  InboxRemoteDataSource();
}
