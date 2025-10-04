import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interface_implementations/response_imp.dart';
import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../initialize.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../../core/constants/apis.dart';
import '../../../core/interfaces/network_manager_int.dart';
import '../../../core/interfaces/parser_int.dart';
import '../interfaces/login_data_source_interface.dart';
import '../usecases/get_cons_data_usecase.dart';
import '../usecases/get_publish_server_usecase.dart';
import '../usecases/login_usecase.dart';
import '../usecases/reset_password_usecase.dart';
import '../usecases/send_forget_password_code_usecase.dart';
import '../usecases/server_select_usecase.dart';
import '../usecases/set_first_password_usecase.dart';
import 'login_local_ds.dart';

class LoginRemoteDataSource implements LoginDataSourceInterface {
  LoginRemoteDataSource();

  final NetworkManagerImp networkManager = getIt<NetworkManagerImp>();
  final ParserInterface parser = getIt<ParserInterface>();

  @override
  Future<LoginResponse> login({required LoginRequest request}) async {
    String api = "/user/login";
    ResponseImplementation res = await networkManager.post(request, api: api);
    LoginResponse loginResponse = await parser.parse(LoginResponse.fromResponse, res, executionReq: request);
    return loginResponse;
  }

  @override
  Future<ServerSelectResponse> serverSelect({required ServerSelectRequest request}) async {
    String api = "/server";
    ResponseImplementation res = await networkManager.get(api);
    ServerSelectResponse serverSelectResponse = await parser.parse(ServerSelectResponse.fromResponse, res, executionReq: request);
    return serverSelectResponse;
  }

  @override
  Future<SetFirstPasswordResponse> setFirstPassword({required SetFirstPasswordRequest request}) async {
    String api = "/user";
    ResponseInterface res = await networkManager.put(request, api: api);
    SetFirstPasswordResponse response = await Parser().parse(SetFirstPasswordResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<SendForgetPasswordCodeResponse> sendForgetPasswordCode({required SendForgetPasswordCodeRequest request}) async {
    String api = "/user/forget";
    ResponseInterface res = await networkManager.post(request, api: api);
    SendForgetPasswordCodeResponse response = await Parser().parse(SendForgetPasswordCodeResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<ResetPasswordResponse> resetPassword({required ResetPasswordRequest request}) async {
    String api = "/user/forget";
    ResponseInterface res = await networkManager.put(request, api: api);
    ResetPasswordResponse response = await Parser().parse(ResetPasswordResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<GetConsDataResponse> getConsData({required GetConsDataRequest request}) async {
    String api = "/constant/${request.constVersion}";
    ResponseInterface res = await networkManager.get(api);
    GetConsDataResponse response = await Parser().parse(GetConsDataResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<GetPublishServerResponse> getPublishServer({required GetPublishServerRequest request}) async {
    String api = "/server/publish";
    ResponseInterface res = await networkManager.get(api);
    GetPublishServerResponse response = await Parser().parse(GetPublishServerResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
