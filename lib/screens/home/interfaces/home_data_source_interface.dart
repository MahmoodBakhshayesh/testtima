import '../usecases/get_notif_count_usecase.dart';
import '../usecases/get_ref_code_log_usecase.dart';
import '../usecases/get_supervisors_usecase.dart';
import '../usecases/submit_timatic_request_usecase.dart';
import '../usecases/timatic_get_locations_usecase.dart';
import '../usecases/timatic_get_parameters_usecase.dart';

abstract class HomeDataSourceInterface {
  Future<GetRefCodeLogResponse> getRefCodeLog({required GetRefCodeLogRequest request});
  Future<GetSupervisorsResponse> getSupervisors({required GetSupervisorsRequest request});
  Future<GetNotifCountResponse> getNotifCount({required GetNotifCountRequest request});
  Future<SubmitTimaticRequestResponse> submitTimaticRequest({required SubmitTimaticRequestRequest request});
  Future<TimaticGetParametersResponse> timaticGetParameters({required TimaticGetParametersRequest request});
  Future<TimaticGetLocationsResponse> timaticGetLocations({required TimaticGetLocationsRequest request});
}