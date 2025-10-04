import '../../../core/interfaces/failures_int.dart';
import '../usecases/get_cons_data_usecase.dart';
import '../usecases/get_publish_server_usecase.dart';
import '../usecases/login_usecase.dart';
import '../usecases/reset_password_usecase.dart';
import '../usecases/send_forget_password_code_usecase.dart';
import '../usecases/server_select_usecase.dart';
import '../../../core/interfaces/result_int.dart';
import '../usecases/set_first_password_usecase.dart';


abstract class LoginRepositoryInterface {
  Future<Result<LoginResponse>> login(LoginRequest request);
  Future<Result<ServerSelectResponse>> serverSelect(ServerSelectRequest request);
  Future<Result<SetFirstPasswordResponse>> setFirstPassword(SetFirstPasswordRequest request);
  Future<Result<SendForgetPasswordCodeResponse>> sendForgetPasswordCode(SendForgetPasswordCodeRequest request);
  Future<Result<ResetPasswordResponse>> resetPassword(ResetPasswordRequest request);
  Future<Result<GetConsDataResponse>> getConsData(GetConsDataRequest request);
  Future<Result<GetPublishServerResponse>> getPublishServer(GetPublishServerRequest request);
}