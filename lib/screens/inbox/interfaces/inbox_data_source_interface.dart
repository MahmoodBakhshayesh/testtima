import '../usecases/get_messages_usecase.dart';
import '../usecases/read_msg_usecase.dart';

abstract class InboxDataSourceInterface {
  Future<GetMessagesResponse> getMessages({required GetMessagesRequest request});
  Future<ReadMsgResponse> readMsg({required ReadMsgRequest request});
}