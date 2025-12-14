import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/connect_to_receiver_usecase.dart';
import '../usecases/disconnect_from_receiver_usecase.dart';


abstract class SenderRepositoryInterface {
  Future<Result<DisconnectFromReceiverResponse>> disconnectFromReceiver(DisconnectFromReceiverRequest request);
  Future<Result<ConnectToReceiverResponse>> connectToReceiver(ConnectToReceiverRequest request);
}