import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/get_receiver_qr_usecase.dart';
import '../usecases/send_to_receiver_usecase.dart';


abstract class ReceiverRepositoryInterface {
  Future<Result<GetReceiverQrResponse>> getReceiverQr(GetReceiverQrRequest request);
  Future<Result<SendToReceiverResponse>> sendToReceiver(SendToReceiverRequest request);
}