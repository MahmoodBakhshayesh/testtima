import '../usecases/ask_supervisor_usecase.dart';
import '../usecases/flight_number_history_usecase.dart';
import '../usecases/get_notif_count_usecase.dart';
import '../usecases/get_ref_code_log_usecase.dart';
import '../usecases/get_supervisors_usecase.dart';
import '../usecases/get_supported_language_usecased.dart';
import '../usecases/set_status_response_usecase.dart';
import '../usecases/submit_timatic_request_usecase.dart';
import '../usecases/supervisor_response_usecase.dart';
import '../usecases/timatic_get_locations_usecase.dart';
import '../usecases/timatic_get_parameters_usecase.dart';
import '../usecases/translate_timatic_response_usecase.dart';

abstract class HomeDataSourceInterface {
  Future<GetRefCodeLogResponse> getRefCodeLog({required GetRefCodeLogRequest request});
  Future<GetSupervisorsResponse> getSupervisors({required GetSupervisorsRequest request});
  Future<GetNotifCountResponse> getNotifCount({required GetNotifCountRequest request});
  Future<SubmitTimaticRequestResponse> submitTimaticRequest({required SubmitTimaticRequestRequest request});
  Future<TimaticGetParametersResponse> timaticGetParameters({required TimaticGetParametersRequest request});
  // Future<TimaticGetLocationsResponse> timaticGetLocations({required TimaticGetLocationsRequest request});
  Future<GetSupportedLanguageResponse> getSupportedLanguage({required GetSupportedLanguageRequest request});
  Future<TranslateTimaticResponseResponse> translateTimaticResponse({required TranslateTimaticResponseRequest request});
  Future<SetStatusResponseResponse> lockUnlockResponse({required SetStatusResponseRequest request});
  Future<AskSupervisorResponse> askSupervisor({required AskSupervisorRequest request});
  Future<SupervisorResponseResponse> supervisorResponse({required SupervisorResponseRequest request});
  Future<FlightNumberHistoryResponse> flightNumberHistory({required FlightNumberHistoryRequest request});
}