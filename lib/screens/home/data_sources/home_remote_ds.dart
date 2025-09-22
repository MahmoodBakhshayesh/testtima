import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../interfaces/home_data_source_interface.dart';
import '../usecases/get_notif_count_usecase.dart';
import '../usecases/get_ref_code_log_usecase.dart';
import '../usecases/get_supervisors_usecase.dart';
import '../usecases/submit_timatic_request_usecase.dart';
import '../usecases/timatic_get_locations_usecase.dart';
import '../usecases/timatic_get_parameters_usecase.dart';
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

  @override
  Future<SubmitTimaticRequestResponse> submitTimaticRequest({required SubmitTimaticRequestRequest request}) async {
    String api = "/documentRequest";
    ResponseInterface res = await networkManager.post(request,api:  api);
    SubmitTimaticRequestResponse response = await Parser().parse(SubmitTimaticRequestResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<TimaticGetParametersResponse> timaticGetParameters({required TimaticGetParametersRequest request}) async {
    final qp = <String, dynamic>{
      if (request.codes.isNotEmpty) 'code': request.codes, // Dio repeats query for lists
      if (request.name != null && request.name!.isNotEmpty) 'name': request.name,
    };

    final api = Uri.parse("/parameters").replace(queryParameters: qp).toString();
    // String api = "/parameters";
    ResponseInterface res = await networkManager.get(api);
    TimaticGetParametersResponse response = await Parser().parse(TimaticGetParametersResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<TimaticGetLocationsResponse> timaticGetLocations({required TimaticGetLocationsRequest request}) async {
    final qp = <String, dynamic>{if (request.code != null && request.code!.isNotEmpty) 'code': request.code, if (request.name != null && request.name!.isNotEmpty) 'name': request.name};

    final api = Uri.parse("/locations/${request.type.name}").replace(queryParameters: qp).toString();

    ResponseInterface res = await networkManager.get(api);
    TimaticGetLocationsResponse response = await Parser().parse(TimaticGetLocationsResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
