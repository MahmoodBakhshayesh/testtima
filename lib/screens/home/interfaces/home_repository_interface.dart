import 'package:dartz/dartz.dart';
import '../../../core/interfaces/result_int.dart';
import '../usecases/ask_supervisor_usecase.dart';
import '../usecases/get_notif_count_usecase.dart';
import '../usecases/get_ref_code_log_usecase.dart';
import '../usecases/get_supervisors_usecase.dart';
import '../usecases/get_supported_language_usecased.dart';
import '../usecases/lock_unlock_response_usecase.dart';
import '../usecases/submit_timatic_request_usecase.dart';
import '../usecases/supervisor_response_usecase.dart';
import '../usecases/timatic_get_locations_usecase.dart';
import '../usecases/timatic_get_parameters_usecase.dart';
import '../usecases/translate_timatic_response_usecase.dart';

abstract class HomeRepositoryInterface {
  Future<Result<GetRefCodeLogResponse>> getRefCodeLog(GetRefCodeLogRequest request);
  Future<Result<GetSupervisorsResponse>> getSupervisors(GetSupervisorsRequest request);
  Future<Result<GetNotifCountResponse>> getNotifCount(GetNotifCountRequest request);
  Future<Result<SubmitTimaticRequestResponse>> submitTimaticRequest(SubmitTimaticRequestRequest request);
  Future<Result<TimaticGetParametersResponse>> timaticGetParameters(TimaticGetParametersRequest request);
  // Future<Result<TimaticGetLocationsResponse>> timaticGetLocations(TimaticGetLocationsRequest request);
  Future<Result<GetSupportedLanguageResponse>> getSupportedLanguage(GetSupportedLanguageRequest request);
  Future<Result<TranslateTimaticResponseResponse>> translateTimaticResponse(TranslateTimaticResponseRequest request);
  Future<Result<LockUnlockResponseResponse>>lockUnlockResponse(LockUnlockResponseRequest request);
  Future<Result<AskSupervisorResponse>> askSupervisor(AskSupervisorRequest request);
  Future<Result<SupervisorResponseResponse>> supervisorResponse(SupervisorResponseRequest request);
}