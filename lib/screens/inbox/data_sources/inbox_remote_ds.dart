import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../interfaces/inbox_data_source_interface.dart';
import '../usecases/get_messages_usecase.dart';
import '../usecases/read_msg_usecase.dart';
import 'inbox_local_ds.dart';

class InboxRemoteDataSource implements InboxDataSourceInterface {
  final InboxLocalDataSource localDataSource = InboxLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  InboxRemoteDataSource();

  @override
  Future<GetMessagesResponse> getMessages({required GetMessagesRequest request}) async {
    String api = "/inbox/detail${request.nextMessageId == null ? '' : "/:${request.nextMessageId}"}";
    ResponseInterface res = await networkManager.get(api);
    GetMessagesResponse response = await Parser().parse(GetMessagesResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<ReadMsgResponse> readMsg({required ReadMsgRequest request}) async {
    String api = "/message/${request.id}";

    ResponseInterface res = await networkManager.get(api);
    ReadMsgResponse response = await Parser().parse(ReadMsgResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
