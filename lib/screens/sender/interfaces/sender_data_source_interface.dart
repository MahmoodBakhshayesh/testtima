import '../usecases/connect_to_receiver_usecase.dart';
import '../usecases/disconnect_from_receiver_usecase.dart';

abstract class SenderDataSourceInterface {
  Future<DisconnectFromReceiverResponse> disconnectFromReceiver({required DisconnectFromReceiverRequest request});
  Future<ConnectToReceiverResponse> connectToReceiver({required ConnectToReceiverRequest request});
}