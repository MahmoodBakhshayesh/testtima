import 'dart:developer';

import 'package:abds/screens/sender/sender_state.dart';
import 'package:abds/screens/sender/usecases/connect_to_receiver_usecase.dart';
import 'package:abds/screens/sender/usecases/disconnect_from_receiver_usecase.dart';
import 'package:logging/logging.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';

class SenderController extends ControllerInterface {
  final _log = Logger('SenderController');
  String? lastScanned;
  DateTime lastScanTime = DateTime.now();

  Future<void> disconnectFromReceiver() async {
    void msg;
    DisconnectFromReceiverUseCase disconnectFromReceiverUseCase = DisconnectFromReceiverUseCase();
    DisconnectFromReceiverRequest disconnectFromReceiverRequest = DisconnectFromReceiverRequest();
    final result = await disconnectFromReceiverUseCase(request: disconnectFromReceiverRequest);

    switch (result) {
      case Err<DisconnectFromReceiverResponse>():
        FailureHandler.handle(result.error);

      case Ok<DisconnectFromReceiverResponse>():
        final r = result.value;
        ref.read(connectedToReceiverProvider.notifier).update((s)=>false);
    }

    return msg;
  }

  void onBarcodeRead(String code) {
    if (code == lastScanned && DateTime.now().difference(lastScanTime).inSeconds < 5) return;
    lastScanned = code;
    lastScanTime = DateTime.now();
    log("$code");
    connectToReceiver(code);
  }

  Future<void> connectToReceiver(String receiverId) async {
    void msg;
    ConnectToReceiverUseCase connectToReceiverUseCase = ConnectToReceiverUseCase();
    ConnectToReceiverRequest connectToReceiverRequest = ConnectToReceiverRequest(receiverId: receiverId);
    final result = await connectToReceiverUseCase(request: connectToReceiverRequest);

    switch (result) {
      case Err<ConnectToReceiverResponse>():
        FailureHandler.handle(result.error);

      case Ok<ConnectToReceiverResponse>():
        final r = result.value;
        ref.read(connectedToReceiverProvider.notifier).update((s)=>true);
    }

    return msg;
  }
}
