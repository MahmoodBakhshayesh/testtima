import 'package:abds/screens/sender/usecases/connect_to_receiver_usecase.dart';
import 'package:abds/screens/sender/usecases/disconnect_from_receiver_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/sender_data_source_interface.dart';

class SenderLocalDataSource implements SenderDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  SenderLocalDataSource();

  @override
  Future<DisconnectFromReceiverResponse> disconnectFromReceiver({required DisconnectFromReceiverRequest request}) {
    // TODO: implement disconnectFromReceiver
    throw UnimplementedError();
  }

  @override
  Future<ConnectToReceiverResponse> connectToReceiver({required ConnectToReceiverRequest request}) {
    // TODO: implement connectToReceiver
    throw UnimplementedError();
  }



}
