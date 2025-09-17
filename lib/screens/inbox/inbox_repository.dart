import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/inbox_repository_interface.dart';
import 'data_sources/inbox_local_ds.dart';
import 'data_sources/inbox_remote_ds.dart';

class InboxRepository implements InboxRepositoryInterface {
  final InboxRemoteDataSource inboxRemoteDataSource = InboxRemoteDataSource();
  final InboxLocalDataSource inboxLocalDataSource = InboxLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  InboxRepository();
}
