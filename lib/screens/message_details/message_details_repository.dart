import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/message_details_repository_interface.dart';
import 'data_sources/message_details_local_ds.dart';
import 'data_sources/message_details_remote_ds.dart';

class MessageDetailsRepository implements MessageDetailsRepositoryInterface {
  final MessageDetailsRemoteDataSource messageDetailsRemoteDataSource = MessageDetailsRemoteDataSource();
  final MessageDetailsLocalDataSource messageDetailsLocalDataSource = MessageDetailsLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  MessageDetailsRepository();
}
