import 'dart:developer';

import 'package:abds/core/classes/basic_class.dart';

import '../../core/classes/new_version_class.dart';
import '../../core/classes/user_class.dart';
import '../../core/interface_implementations/device_info_imp.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/device_info_service_int.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/timatic/src/endpoints.dart';
import '../../core/utils_and_services/timatic/src/models/auth_request.dart';
import '../../initialize.dart';
import 'login_state.dart';
import 'usecases/login_usecase.dart' hide LoginRequest;
import 'package:logging/logging.dart';


class LoginController extends ControllerInterface {
  late LoginState loginState = ref.read(loginProvider);
  late TimaticApi timaticApi = getIt<TimaticApi>();
  final _log = Logger('LoginController');

  @override
  void onInit() {
    loadPrefs();
    super.onInit();
  }

  Future<User?> login(String username,String password) async {
    _log.warning("Logging in");

    User? user;
    DeviceInfoServiceImp deviceInfoService = getIt<DeviceInfoServiceImp>();
    DeviceInfo deviceInfo = deviceInfoService.getInfo();

    final logRes = await timaticApi.login(LoginRequest(username: username, password: password, app: {}, device: {}, network: {}));

    User fakeUser = User(id: 1, username: username, password: password, token: "token");

    log("${logRes.profile.username}");
    final tData = await timaticApi.preloadAll();
    BasicClass.initialize(fakeUser, tData);
    saveLoginData(username: username,password: password);
    ref.read(userProvider.notifier).update((s)=>logRes);
    ref.read(profileProvider.notifier).update((s)=>logRes.profile);
    navigation.goNamed(Routes.home);
    return fakeUser;
  }

  void downloadNewVersion(NewVersion newVersion) {}

  Future<void> loadPrefs() async {
    String? username = await sharedPref.getVariable(key: "Username");
    String? password = await sharedPref.getVariable(key: "Password");

    ref.read(usernameProvider.notifier).update((s) => username ?? '');
    ref.read(passwordProvider.notifier).update((s) => password ?? '');

  }

  Future<void> logout({bool isTokenExpire = false}) async {
    ref.read(userProvider.notifier).update((s) => null);
    if (!isTokenExpire) {
      clearLoginData();
    }
    goNamed(Routes.login);
  }

  void saveLoginData({required String username, required String password}) {
    sharedPref.setVariable(key: "Username", value: username);
    sharedPref.setVariable(key: "Password", value: password);
    log("saved ${username} - $password");
  }

  void clearLoginData() {
    sharedPref.setVariable(key: "Username", value: null);
    sharedPref.setVariable(key: "Password", value: null);
  }
}
