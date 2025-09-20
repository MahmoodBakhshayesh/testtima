import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/message_details_data_source_interface.dart';
import 'message_details_local_ds.dart';

class MessageDetailsRemoteDataSource implements MessageDetailsDataSourceInterface {
  final MessageDetailsLocalDataSource localDataSource = MessageDetailsLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  MessageDetailsRemoteDataSource();
}
