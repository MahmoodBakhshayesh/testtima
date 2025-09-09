import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../interfaces/home_data_source_interface.dart';
import '../usecases/get_ref_code_log_usecase.dart';
import 'home_local_ds.dart';

class HomeRemoteDataSource implements HomeDataSourceInterface {
  final HomeLocalDataSource localDataSource = HomeLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  HomeRemoteDataSource();

  @override
  Future<GetRefCodeLogResponse> getRefCodeLog({required GetRefCodeLogRequest request}) async {
    String api = '/logs/${request.code}';
    ResponseInterface res = await networkManager.get(api);
    GetRefCodeLogResponse response = await Parser().parse(GetRefCodeLogResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
