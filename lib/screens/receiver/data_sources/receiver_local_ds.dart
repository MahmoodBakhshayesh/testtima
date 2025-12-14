import 'package:abds/screens/receiver/usecases/get_receiver_qr_usecase.dart';
import 'package:abds/screens/receiver/usecases/send_to_receiver_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/receiver_data_source_interface.dart';

class ReceiverLocalDataSource implements ReceiverDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  ReceiverLocalDataSource();

  @override
  Future<GetReceiverQrResponse> getReceiverQr({required GetReceiverQrRequest request}) {
    // TODO: implement getReceiverQr
    throw UnimplementedError();
  }

  @override
  Future<SendToReceiverResponse> sendToReceiver({required SendToReceiverRequest request}) {
    // TODO: implement sendToReceiver
    throw UnimplementedError();
  }



}
