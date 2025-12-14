import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../initialize.dart';
import '../interfaces/receiver_data_source_interface.dart';
import '../usecases/get_receiver_qr_usecase.dart';
import '../usecases/send_to_receiver_usecase.dart';
import 'receiver_local_ds.dart';

class ReceiverRemoteDataSource implements ReceiverDataSourceInterface {
  final ReceiverLocalDataSource localDataSource = ReceiverLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  ReceiverRemoteDataSource();

  @override
  Future<GetReceiverQrResponse> getReceiverQr({required GetReceiverQrRequest request}) async {
    String api = '$apiVersion/shareData';
    ResponseInterface res = await networkManager.get(api);
    GetReceiverQrResponse response = await Parser().parse(GetReceiverQrResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<SendToReceiverResponse> sendToReceiver({required SendToReceiverRequest request}) async {
    String api = '$apiVersion/shareData';
    ResponseInterface res = await networkManager.post(request,api: api);
    SendToReceiverResponse response = await Parser().parse(SendToReceiverResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
