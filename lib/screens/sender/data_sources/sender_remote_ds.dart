import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../initialize.dart';
import '../interfaces/sender_data_source_interface.dart';
import '../usecases/connect_to_receiver_usecase.dart';
import '../usecases/disconnect_from_receiver_usecase.dart';
import 'sender_local_ds.dart';

class SenderRemoteDataSource implements SenderDataSourceInterface {
  final SenderLocalDataSource localDataSource = SenderLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  SenderRemoteDataSource();

  @override
  Future<DisconnectFromReceiverResponse> disconnectFromReceiver({required DisconnectFromReceiverRequest request}) async {
    String api = '$apiVersion/shareData';
    ResponseInterface res = await networkManager.delete(request,api: api);
    DisconnectFromReceiverResponse response = await Parser().parse(DisconnectFromReceiverResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<ConnectToReceiverResponse> connectToReceiver({required ConnectToReceiverRequest request}) async {
    String api = '$apiVersion/shareData';

    ResponseInterface res = await networkManager.post(request,api: api);
    ConnectToReceiverResponse response = await Parser().parse(ConnectToReceiverResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
