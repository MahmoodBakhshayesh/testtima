import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../interfaces/home_data_source_interface.dart';
import '../usecases/get_notif_count_usecase.dart';
import '../usecases/get_ref_code_log_usecase.dart';
import '../usecases/get_supervisors_usecase.dart';
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

  @override
  Future<GetSupervisorsResponse> getSupervisors({required GetSupervisorsRequest request}) async {
    String api = '/supervisor';
    ResponseInterface res = await networkManager.get(api);
    GetSupervisorsResponse response = await Parser().parse(GetSupervisorsResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<GetNotifCountResponse> getNotifCount({required GetNotifCountRequest request}) async {
    String api = '/inbox';
    ResponseInterface res = await networkManager.get(api);
    GetNotifCountResponse response = await Parser().parse(GetNotifCountResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
