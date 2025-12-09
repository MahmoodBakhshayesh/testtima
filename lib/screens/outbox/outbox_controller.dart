import 'package:abds/screens/outbox/usecases/get_outbox_messages_usecase.dart';
import 'package:abds/screens/performance/performance_controller.dart';
import 'package:logging/logging.dart';
import '../../core/classes/outbox_message_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../initialize.dart';
import '../home/home_controller.dart';
import '../home/home_state.dart';
import '../inbox/usecases/get_messages_usecase.dart';
import '../inbox/usecases/read_msg_usecase.dart';
import 'outbox_state.dart';


class OutboxController extends ControllerInterface {
  final _log = Logger('OutboxController');
  Future<List<OutboxMessage>?> getOutboxMessages() async {
    List<OutboxMessage>? messages;
    GetOutboxMessagesUseCase getOutboxMessagesUseCase = GetOutboxMessagesUseCase();
    GetOutboxMessagesRequest getOutboxMessagesRequest = GetOutboxMessagesRequest(nextMessageId: ref.read(outboxNextMessageId));
    final result = await getOutboxMessagesUseCase(request: getOutboxMessagesRequest);

    switch (result) {
      case Err<GetOutboxMessagesResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetOutboxMessagesResponse>():
        final r = result.value;
        messages = r.messages;
        ref.read(outboxNextMessageId.notifier).update((s)=>r.nextMessageId);
        ref.read(outboxMessagesProvider.notifier).update((s)=>[...r.messages,...s]);

    }

    return messages;
  }

  Future<bool> readMsg(OutboxMessage msg) async {
    bool read = false;
    ReadMsgUseCase readMsgUseCase = ReadMsgUseCase();
    ReadMsgRequest readMsgRequest = ReadMsgRequest(id: msg.id);
    final result = await readMsgUseCase(request: readMsgRequest);

    switch (result) {
      case Err<ReadMsgResponse>():
        FailureHandler.handle(result.error);

      case Ok<ReadMsgResponse>():
        final r = result.value;
        ref.read(currentStatusProvider.notifier).update((s)=>r.currentStatus);
        getIt<HomeController>().fillWithRefHistory(r.history, null, msg.showCode);
        navigation.pop();
    }

    return read;
  }

  // goMessageDetails(String messageCode) async {
  //   final refHistory = await getIt<HomeController>().getRefHistoryLog(showCode: messageCode,code: null);
  //   if(refHistory!=null){
  //     // ref.read(refCodeProvider.notifier).update((s)=>messageCode);
  //     navigation.pop();
  //   }
  // }
  // load(String messageCode) async {
  //   final refHistory = await getIt<PerformanceController>().getRefHistoryLog(showCode: messageCode,code: null);
  // }

  Future<void> load(String messageCode) async {
    final refHistory = await getIt<PerformanceController>().getRefHistoryLog(showCode: messageCode,code: null);

  }
}
