import '../usecases/get_cons_data_usecase.dart';
import '../usecases/login_usecase.dart';
import '../usecases/reset_password_usecase.dart';
import '../usecases/send_forget_password_code_usecase.dart';
import '../usecases/server_select_usecase.dart';
import '../usecases/set_first_password_usecase.dart';

abstract class LoginDataSourceInterface {
  Future<LoginResponse> login({required LoginRequest request});
  Future<ServerSelectResponse> serverSelect({required ServerSelectRequest request});
  Future<SetFirstPasswordResponse> setFirstPassword({required SetFirstPasswordRequest request});
  Future<SendForgetPasswordCodeResponse> sendForgetPasswordCode({required SendForgetPasswordCodeRequest request});
  Future<ResetPasswordResponse> resetPassword({required ResetPasswordRequest request});
  Future<GetConsDataResponse> getConsData({required GetConsDataRequest request});
}