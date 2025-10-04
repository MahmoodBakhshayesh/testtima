import 'dart:developer';
import 'package:abds/screens/home/usecases/ask_supervisor_usecase.dart';
import 'package:abds/screens/home/usecases/flight_number_history_usecase.dart';
import 'package:abds/screens/home/usecases/get_notif_count_usecase.dart';
import 'package:abds/screens/home/usecases/get_ref_code_log_usecase.dart';
import 'package:abds/screens/home/usecases/get_supervisors_usecase.dart';
import 'package:abds/screens/home/usecases/get_supported_language_usecased.dart';
import 'package:abds/screens/home/usecases/submit_timatic_request_usecase.dart';
import 'package:abds/screens/home/usecases/supervisor_response_usecase.dart';
import 'package:abds/screens/home/usecases/timatic_get_locations_usecase.dart';
import 'package:abds/screens/home/usecases/timatic_get_parameters_usecase.dart';
import 'package:abds/screens/home/usecases/translate_text_usecase.dart';
import 'package:abds/screens/home/usecases/translate_timatic_response_usecase.dart';
import 'package:abds/screens/home/usecases/validate_employee_id_usecase.dart';

import '../../../core/interfaces/local_data_base_int.dart';

import '../../../core/classes/user_class.dart';
import '../../../core/data_base/classes/db_user_class.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/data_base/table_names.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../initialize.dart';
import '../interfaces/home_data_source_interface.dart';
import '../usecases/set_status_response_usecase.dart';

const String userJsonLocalKey = "UserJson";

class HomeLocalDataSource implements HomeDataSourceInterface {
  final LocalDataSourceInterface localDataSource = getIt<LocalDataBase>();
  HomeLocalDataSource();

  @override
  Future<GetRefCodeLogResponse> getRefCodeLog({required GetRefCodeLogRequest request}) {
    // TODO: implement getRefCodeLog
    throw UnimplementedError();
  }

  @override
  Future<GetSupervisorsResponse> getSupervisors({required GetSupervisorsRequest request}) {
    // TODO: implement getSupervisors
    throw UnimplementedError();
  }

  @override
  Future<GetNotifCountResponse> getNotifCount({required GetNotifCountRequest request}) {
    // TODO: implement getNotifCount
    throw UnimplementedError();
  }

  @override
  Future<SubmitTimaticRequestResponse> submitTimaticRequest({required SubmitTimaticRequestRequest request}) {
    // TODO: implement submitTimaticRequest
    throw UnimplementedError();
  }

  @override
  Future<TimaticGetParametersResponse> timaticGetParameters({required TimaticGetParametersRequest request}) {
    // TODO: implement timaticGetParameters
    throw UnimplementedError();
  }

  // @override
  // Future<TimaticGetLocationsResponse> timaticGetLocations({required TimaticGetLocationsRequest request}) {
  //   // TODO: implement timaticGetLocations
  //   throw UnimplementedError();
  // }

  @override
  Future<GetSupportedLanguageResponse> getSupportedLanguage({required GetSupportedLanguageRequest request}) {
    // TODO: implement getSupportedLanguage
    throw UnimplementedError();
  }

  @override
  Future<TranslateTimaticResponseResponse> translateTimaticResponse({required TranslateTimaticResponseRequest request}) {
    // TODO: implement translateTimaticResponse
    throw UnimplementedError();
  }

  @override
  Future<SetStatusResponseResponse> lockUnlockResponse({required SetStatusResponseRequest request}) {
    // TODO: implement lockUnlockResponse
    throw UnimplementedError();
  }

  @override
  Future<AskSupervisorResponse> askSupervisor({required AskSupervisorRequest request}) {
    // TODO: implement askSupervisor
    throw UnimplementedError();
  }

  @override
  Future<SupervisorResponseResponse> supervisorResponse({required SupervisorResponseRequest request}) {
    // TODO: implement supervisorResponse
    throw UnimplementedError();
  }

  @override
  Future<FlightNumberHistoryResponse> flightNumberHistory({required FlightNumberHistoryRequest request}) {
    // TODO: implement flightNumberHistory
    throw UnimplementedError();
  }

  @override
  Future<TranslateTextResponse> translateText({required TranslateTextRequest request}) {
    // TODO: implement translateText
    throw UnimplementedError();
  }

  @override
  Future<ValidateEmployeeIdResponse> validateEmployeeId({required ValidateEmployeeIdRequest request}) {
    // TODO: implement validateEmployeeId
    throw UnimplementedError();
  }




}
