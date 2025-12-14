import '../usecases/get_receiver_qr_usecase.dart';
import '../usecases/send_to_receiver_usecase.dart';

abstract class ReceiverDataSourceInterface {
  Future<GetReceiverQrResponse> getReceiverQr({required GetReceiverQrRequest request});
  Future<SendToReceiverResponse> sendToReceiver({required SendToReceiverRequest request});
}