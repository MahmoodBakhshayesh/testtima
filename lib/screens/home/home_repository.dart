import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/home_repository_interface.dart';
import 'data_sources/home_local_ds.dart';
import 'data_sources/home_remote_ds.dart';
import 'usecases/get_notif_count_usecase.dart';
import 'usecases/get_ref_code_log_usecase.dart';
import 'usecases/get_supervisors_usecase.dart';
import 'usecases/get_supported_language_usecased.dart';
import 'usecases/lock_unlock_response_usecase.dart';
import 'usecases/submit_timatic_request_usecase.dart';
import 'usecases/timatic_get_locations_usecase.dart';
import 'usecases/timatic_get_parameters_usecase.dart';
import 'usecases/translate_timatic_response_usecase.dart';

class HomeRepository implements HomeRepositoryInterface {
  final HomeRemoteDataSource homeRemoteDataSource = HomeRemoteDataSource();
  final HomeLocalDataSource homeLocalDataSource = HomeLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  HomeRepository();

  @override
  Future<Result<GetRefCodeLogResponse>> getRefCodeLog(GetRefCodeLogRequest request) async {
    try {
      GetRefCodeLogResponse getRefCodeLogResponse;
      if (await networkInfo.isConnected) {
        getRefCodeLogResponse = await homeRemoteDataSource.getRefCodeLog(request: request);
      } else {
        getRefCodeLogResponse = await homeLocalDataSource.getRefCodeLog(request: request);
      }
      return Result.ok(getRefCodeLogResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<GetSupervisorsResponse>> getSupervisors(GetSupervisorsRequest request) async {
    try {
      GetSupervisorsResponse getSupervisorsResponse;
      if (await networkInfo.isConnected) {
        getSupervisorsResponse = await homeRemoteDataSource.getSupervisors(request: request);
      } else {
        getSupervisorsResponse = await homeLocalDataSource.getSupervisors(request: request);
      }
      return Result.ok(getSupervisorsResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<GetNotifCountResponse>> getNotifCount(GetNotifCountRequest request) async {
    try {
      GetNotifCountResponse getNotifCountResponse;
      if (await networkInfo.isConnected) {
        getNotifCountResponse = await homeRemoteDataSource.getNotifCount(request: request);
      } else {
        getNotifCountResponse = await homeLocalDataSource.getNotifCount(request: request);
      }
      return Result.ok(getNotifCountResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<SubmitTimaticRequestResponse>> submitTimaticRequest(SubmitTimaticRequestRequest request) async {
    try {
      SubmitTimaticRequestResponse submitTimaticRequestResponse;
      if (await networkInfo.isConnected) {
        submitTimaticRequestResponse = await homeRemoteDataSource.submitTimaticRequest(request: request);
      } else {
        submitTimaticRequestResponse = await homeLocalDataSource.submitTimaticRequest(request: request);
      }
      return Result.ok(submitTimaticRequestResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<TimaticGetParametersResponse>> timaticGetParameters(TimaticGetParametersRequest request) async {
    try {
      TimaticGetParametersResponse timaticGetParametersResponse;
      if (await networkInfo.isConnected) {
        timaticGetParametersResponse = await homeRemoteDataSource.timaticGetParameters(request: request);
      } else {
        timaticGetParametersResponse = await homeLocalDataSource.timaticGetParameters(request: request);
      }
      return Result.ok(timaticGetParametersResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<TimaticGetLocationsResponse>> timaticGetLocations(TimaticGetLocationsRequest request) async {
    try {
      TimaticGetLocationsResponse timaticGetLocationsResponse;
      if (await networkInfo.isConnected) {
        timaticGetLocationsResponse = await homeRemoteDataSource.timaticGetLocations(request: request);
      } else {
        timaticGetLocationsResponse = await homeLocalDataSource.timaticGetLocations(request: request);
      }
      return Result.ok(timaticGetLocationsResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<GetSupportedLanguageResponse>> getSupportedLanguage(GetSupportedLanguageRequest request) async {
    try {
      GetSupportedLanguageResponse getSupportedLanguageResponse;
      if (await networkInfo.isConnected) {
        getSupportedLanguageResponse = await homeRemoteDataSource.getSupportedLanguage(request: request);
      } else {
        getSupportedLanguageResponse = await homeLocalDataSource.getSupportedLanguage(request: request);
      }
      return Result.ok(getSupportedLanguageResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<TranslateTimaticResponseResponse>> translateTimaticResponse(TranslateTimaticResponseRequest request) async {
    try {
      TranslateTimaticResponseResponse translateTimaticResponseResponse;
      if (await networkInfo.isConnected) {
        translateTimaticResponseResponse = await homeRemoteDataSource.translateTimaticResponse(request: request);
      } else {
        translateTimaticResponseResponse = await homeLocalDataSource.translateTimaticResponse(request: request);
      }
      return Result.ok(translateTimaticResponseResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

    @override
      Future<Result<LockUnlockResponseResponse>> lockUnlockResponse(LockUnlockResponseRequest request) async {
        try {
          LockUnlockResponseResponse lockUnlockResponseResponse;
          if (await networkInfo.isConnected) {
            lockUnlockResponseResponse = await homeRemoteDataSource.lockUnlockResponse(request: request);
          } else {
            lockUnlockResponseResponse = await homeLocalDataSource.lockUnlockResponse(request: request);
          }
          return Result.ok(lockUnlockResponseResponse);
        } on AppException catch (e) {
          return Result.error(ServerFailure.fromAppException(e));
        }
      }
}
