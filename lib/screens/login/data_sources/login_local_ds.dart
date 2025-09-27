import 'package:abds/screens/login/usecases/get_cons_data_usecase.dart';
import 'package:abds/screens/login/usecases/reset_password_usecase.dart';

import 'package:abds/screens/login/usecases/send_forget_password_code_usecase.dart';

import 'package:abds/screens/login/usecases/set_first_password_usecase.dart';

import '../../../core/interfaces/exception_int.dart';
import '../../../core/interfaces/local_data_base_int.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/classes/user_class.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/data_base/table_names.dart';
import '../../../core/interface_implementations/exceptions_imp.dart';
import '../../../core/interfaces/parser_int.dart';
import '../../../initialize.dart';
import '../interfaces/login_data_source_interface.dart';
import '../usecases/login_usecase.dart';
import '../usecases/server_select_usecase.dart';

const String userJsonLocalKey = "UserJson";

class LoginLocalDataSource implements LoginDataSourceInterface {
  final LocalDataSourceInterface localDataSource = getIt<LocalDataBase>();
  final ParserInterface parser = GetIt.instance<ParserInterface>();

  final SharedPreferences sharedPreferences = getIt<SharedPreferences>();

  LoginLocalDataSource();

  @override
  Future<LoginResponse> login({required LoginRequest request}) async {
    throw UnimplementedError();
  }

  @override
  Future<ServerSelectResponse> serverSelect({required ServerSelectRequest request}) {
    // TODO: implement serverSelect
    throw UnimplementedError();
  }

  @override
  Future<ResetPasswordResponse> resetPassword({required ResetPasswordRequest request}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<SendForgetPasswordCodeResponse> sendForgetPasswordCode({required SendForgetPasswordCodeRequest request}) {
    // TODO: implement sendForgetPasswordCode
    throw UnimplementedError();
  }

  @override
  Future<SetFirstPasswordResponse> setFirstPassword({required SetFirstPasswordRequest request}) {
    // TODO: implement setFirstPassword
    throw UnimplementedError();
  }

  @override
  Future<GetConsDataResponse> getConsData({required GetConsDataRequest request}) {
    // TODO: implement getConsData
    throw UnimplementedError();
  }
}
