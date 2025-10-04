import '../usecases/get_outbox_messages_usecase.dart';

abstract class OutboxDataSourceInterface {
  Future<GetOutboxMessagesResponse> getOutboxMessages({required GetOutboxMessagesRequest request});
}