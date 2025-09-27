import 'dart:developer';
import 'package:abds/core/interfaces/result_int.dart';
import 'package:dartz/dartz.dart';
import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../initialize.dart';
import 'interfaces/login_repository_interface.dart';
import 'data_sources/login_local_ds.dart';
import 'data_sources/login_remote_ds.dart';
import 'usecases/get_cons_data_usecase.dart';
import 'usecases/login_usecase.dart';
import 'usecases/reset_password_usecase.dart';
import 'usecases/send_forget_password_code_usecase.dart';
import 'usecases/server_select_usecase.dart';
import 'usecases/set_first_password_usecase.dart';

class LoginRepository implements LoginRepositoryInterface {
  final LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSource();
  final LoginLocalDataSource loginLocalDataSource = LoginLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  LoginRepository();

  @override
  Future<Result<LoginResponse>> login(LoginRequest request) async {
    try {
      LoginResponse loginResponse;
      if (await networkInfo.isConnected) {
        loginResponse = await loginRemoteDataSource.login(request: request);
      } else {
        loginResponse = await loginLocalDataSource.login(request: request);
      }
      return Result.ok(loginResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<ServerSelectResponse>> serverSelect(ServerSelectRequest request) async {
    try {
      ServerSelectResponse serverSelectResponse;
      if (await networkInfo.isConnected) {
        serverSelectResponse = await loginRemoteDataSource.serverSelect(request: request);
      } else {
        serverSelectResponse = await loginLocalDataSource.serverSelect(request: request);
      }
      return Result.ok(serverSelectResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<SetFirstPasswordResponse>> setFirstPassword(SetFirstPasswordRequest request) async {
    try {
      SetFirstPasswordResponse setFirstPasswordResponse;
      if (await networkInfo.isConnected) {
        setFirstPasswordResponse = await loginRemoteDataSource.setFirstPassword(request: request);
      } else {
        setFirstPasswordResponse = await loginLocalDataSource.setFirstPassword(request: request);
      }
      return Result.ok(setFirstPasswordResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<SendForgetPasswordCodeResponse>> sendForgetPasswordCode(SendForgetPasswordCodeRequest request) async {
    try {
      SendForgetPasswordCodeResponse sendForgetPasswordCodeResponse;
      if (await networkInfo.isConnected) {
        sendForgetPasswordCodeResponse = await loginRemoteDataSource.sendForgetPasswordCode(request: request);
      } else {
        sendForgetPasswordCodeResponse = await loginLocalDataSource.sendForgetPasswordCode(request: request);
      }
      return Result.ok(sendForgetPasswordCodeResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<ResetPasswordResponse>> resetPassword(ResetPasswordRequest request) async {
    try {
      ResetPasswordResponse resetPasswordResponse;
      if (await networkInfo.isConnected) {
        resetPasswordResponse = await loginRemoteDataSource.resetPassword(request: request);
      } else {
        resetPasswordResponse = await loginLocalDataSource.resetPassword(request: request);
      }
      return Result.ok(resetPasswordResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<GetConsDataResponse>> getConsData(GetConsDataRequest request) async {
    try {
      GetConsDataResponse getConsDataResponse;
      if (await networkInfo.isConnected) {
        getConsDataResponse = await loginRemoteDataSource.getConsData(request: request);
      } else {
        getConsDataResponse = await loginLocalDataSource.getConsData(request: request);
      }
      return Result.ok(getConsDataResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
