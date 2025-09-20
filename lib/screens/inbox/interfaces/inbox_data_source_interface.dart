import '../usecases/get_messages_usecase.dart';

abstract class InboxDataSourceInterface {
  Future<GetMessagesResponse> getMessages({required GetMessagesRequest request});
}