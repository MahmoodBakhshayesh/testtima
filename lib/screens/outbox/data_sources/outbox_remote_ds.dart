import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../initialize.dart';
import '../interfaces/outbox_data_source_interface.dart';
import '../usecases/get_outbox_messages_usecase.dart';
import 'outbox_local_ds.dart';

class OutboxRemoteDataSource implements OutboxDataSourceInterface {
  final OutboxLocalDataSource localDataSource = OutboxLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  OutboxRemoteDataSource();

  @override
  Future<GetOutboxMessagesResponse> getOutboxMessages({required GetOutboxMessagesRequest request}) async {
    String api = "$apiVersion/outbox/detail${request.nextMessageId == null ? '' : "/:${request.nextMessageId}"}";

    ResponseInterface res = await networkManager.get(api);
    GetOutboxMessagesResponse response = await Parser().parse(GetOutboxMessagesResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
