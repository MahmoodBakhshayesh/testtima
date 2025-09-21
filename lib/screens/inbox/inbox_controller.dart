import 'package:abds/core/navigation/routes.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/screens/inbox/inbox_state.dart';
import 'package:abds/screens/inbox/usecases/get_messages_usecase.dart';
import 'package:json_view/json_view.dart';
import 'package:logging/logging.dart';
import '../../core/classes/inbox_message_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../initialize.dart';

class InboxController extends ControllerInterface {
  final _log = Logger('InboxController');

  Future<List<InboxMessage>?> getInboxMessages() async {
    List<InboxMessage>? messages;
    GetMessagesUseCase getInboxMessagesUseCase = GetMessagesUseCase();
    GetMessagesRequest getMessagesRequest = GetMessagesRequest(nextMessageId: ref.read(nextMessageId));
    final result = await getInboxMessagesUseCase(request: getMessagesRequest);

    switch (result) {
      case Err<GetMessagesResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetMessagesResponse>():
        final r = result.value;
        messages = r.messages;
        ref.read(nextMessageId.notifier).update((s)=>r.nextMessageId);
        ref.read(inboxMessagesProvider.notifier).update((s)=>[...r.messages,...s]);

    }

    return messages;
  }

  goMessageDetails(String messageCode) async {
    final refHistory = await getIt<HomeController>().getRefHistoryLog(messageCode);
    if(refHistory!=null){
      // ref.read(inboxMessageDetailsProvider.notifier).update((s)=>refHistory.logs??[]);
      // goNamed(Routes.messageDetails);
      navigation.pop();
    }
  }
}
