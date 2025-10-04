import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/outbox_repository_interface.dart';
import 'data_sources/outbox_local_ds.dart';
import 'data_sources/outbox_remote_ds.dart';
import 'usecases/get_outbox_messages_usecase.dart';

class OutboxRepository implements OutboxRepositoryInterface {
  final OutboxRemoteDataSource outboxRemoteDataSource = OutboxRemoteDataSource();
  final OutboxLocalDataSource outboxLocalDataSource = OutboxLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  OutboxRepository();

  @override
  Future<Result<GetOutboxMessagesResponse>> getOutboxMessages(GetOutboxMessagesRequest request) async {
    try {
      GetOutboxMessagesResponse getOutboxMessagesResponse;
      if (await networkInfo.isConnected) {
        getOutboxMessagesResponse = await outboxRemoteDataSource.getOutboxMessages(request: request);
      } else {
        getOutboxMessagesResponse = await outboxLocalDataSource.getOutboxMessages(request: request);
      }
      return Result.ok(getOutboxMessagesResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
