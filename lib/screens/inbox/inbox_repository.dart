import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/inbox_repository_interface.dart';
import 'data_sources/inbox_local_ds.dart';
import 'data_sources/inbox_remote_ds.dart';
import 'usecases/get_messages_usecase.dart';

class InboxRepository implements InboxRepositoryInterface {
  final InboxRemoteDataSource inboxRemoteDataSource = InboxRemoteDataSource();
  final InboxLocalDataSource inboxLocalDataSource = InboxLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  InboxRepository();

  @override
  Future<Result<GetMessagesResponse>> getMessages(GetMessagesRequest request) async {
    try {
      GetMessagesResponse getMessagesResponse;
      if (await networkInfo.isConnected) {
        getMessagesResponse = await inboxRemoteDataSource.getMessages(request: request);
      } else {
        getMessagesResponse = await inboxLocalDataSource.getMessages(request: request);
      }
      return Result.ok(getMessagesResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
