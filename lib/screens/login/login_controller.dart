import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/interfaces/result_int.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:app_device_net_info/app_device_net_info.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/classes/new_version_class.dart';
import '../../core/classes/server_class.dart';
import '../../core/classes/user_class.dart';
import '../../core/interface_implementations/device_info_imp.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/device_info_service_int.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/timatic/src/endpoints.dart';
import '../../initialize.dart';
import 'dialogs/server_picker_dialog.dart';
import 'dialogs/set_first_password_dialog.dart';
import 'dialogs/update_version_dialog.dart';
import 'login_state.dart';
import 'usecases/login_usecase.dart';
import 'package:logging/logging.dart';

import 'usecases/reset_password_usecase.dart';
import 'usecases/send_forget_password_code_usecase.dart';
import 'usecases/server_select_usecase.dart';
import 'usecases/set_first_password_usecase.dart';

class LoginController extends ControllerInterface {
  late LoginState loginState = ref.read(loginProvider);
  // late TimaticApi timaticApi = getIt<TimaticApi>();
  final _log = Logger('LoginController');

  @override
  void onInit() {
    loadPrefs();
    super.onInit();
  }

  Future<LoginData?> login(String username, String password) async {
    _log.warning("Logging in");
    getIt<HomeController>().clear();
    ref.read(timaticResultProvider.notifier).update((s) => null);
    // DeviceInfoServiceImp deviceInfoService = getIt<DeviceInfoServiceImp>();
    // DeviceInfo deviceInfo = deviceInfoService.getInfo();
    AppDeviceNetworkData adnd = getIt<AppDeviceNetworkData>();
    LoginData? user;
    LoginUseCase loginUseCase = LoginUseCase();
    LoginRequest loginRequest = LoginRequest(username: username, password: password, app: adnd.app.toJson(), device: adnd.device.toJson(), network: adnd.network.toJson());
    final fOrR = await loginUseCase(request: loginRequest);

    switch (fOrR) {
      case Ok<LoginResponse>():
        user = fOrR.value.user;
        // timaticApi.setToken(user!.token);
        // log("${user.profile.username}");


        ///todo preload basic data tData
        saveLoginData(username: username, password: password);
        ref.read(userProvider.notifier).update((s) => user);
        ref.read(profileProvider.notifier).update((s) => user!.profile);
        initData(user);
        final tData = await getIt<HomeController>().preloadAll();
        BasicClass.initialize(user, tData);
        checkNotifCount();
        getIt<HomeController>().clear();
        if (user.setPassword) {
          navigation.openDialog(
            dialog: SetFirstPasswordDialog(user: user, oldPassword: password),
            barrierDismissible: false,
          );
        } else {
          askUpdate(user);
        }
      case Err<LoginResponse>():
        FailureHandler.handle(fOrR.error);
    }

    // navigation.goNamed(Routes.home);
    return user;
  }

  askUpdate(LoginData user) async {
    log(jsonEncode(user.permission.toJson()));
    // return;
    if (user.versionCheck == null) {
      proceedToApp(user);
    } else {
      final updateRes = await navigation.openDialog(barrierDismissible: false, dialog: UpdateVersionDialog(versionCheck: user.versionCheck!));
      if (updateRes == 0) {
        proceedToApp(user);
      } else if (updateRes == 1) {
        String? updateLink;
        if (Platform.isAndroid) {
          updateLink = user.versionCheck!.downloadLink!.firstWhere((a) => a.name == "google play").url;
        } else {
          updateLink = user.versionCheck!.downloadLink!.firstWhere((a) => a.name == "app store").url;
        }
        if (updateLink != null) {
          final Uri uu = Uri.tryParse(updateLink)!;
          launchUrl(uu);
        } else {
          proceedToApp(user);
        }
      }
    }
  }

  Future<void> proceedToApp(LoginData user, {bool recall = false}) async {
    log("proceedToApp");
    try {
      ref.read(userProvider.notifier).update((state) => user);
      goNamed(Routes.home);
    } catch (e) {
      if (e is Error) {
        log(e.stackTrace.toString());
      }
    }
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

  Future<void> initServer() async {
    String? serverJson = await sharedPref.getVariable(key: "ServerNew");
    log(serverJson ?? '');
    if (serverJson == null) {
      serverSelect(showDialog: false).then((a) {
        log("we found default server ${a.map((s) => s.toJson())}");
        Server server = a.firstWhere((a) => a.active, orElse: () => a.first);
        // server = server.copyWith(apiAddress: "${server!.apiAddress}$apiVersion");

        server = server.copyWith(apiAddress: "${server!.apiAddress}$apiVersion");
        ref.read(selectedServerProvider.notifier).update((s) => server);
        initNetworkManager(server.apiAddress);
      });
    } else {
      Server s = Server.fromJson(jsonDecode(serverJson));
      log("we found saved server ${s.toJson()}");
      saveServer(s);
    }
  }

  Future<List<Server>> serverSelect({bool showDialog = true}) async {
    List<Server> servers = [];
    ServerSelectUseCase serverSelectUsecase = ServerSelectUseCase();
    ServerSelectRequest serverSelectRequest = ServerSelectRequest();
    final fOrR = await serverSelectUsecase(request: serverSelectRequest);

    switch (fOrR) {
      case Ok<ServerSelectResponse>():
        final r = fOrR.value;
        servers = r.servers;
        ref.read(serverListProvider.notifier).update((s) => r.servers);
        if (showDialog) {
          navigation.popAllBottomSheets();
          serverSelectDialog(r.servers);
        }
      case Err<ServerSelectResponse>():
        FailureHandler.handle(fOrR.error);
    }

    return servers;
  }

  serverSelectDialog(List<Server> servers) {
    Server? current = servers.firstWhereOrNull((s) => (s.apiAddress + apiVersion).toLowerCase() == (ref.read(selectedServerProvider).apiAddress).toLowerCase());
    log("ser ${(ref.read(selectedServerProvider).apiAddress).toLowerCase()}");
    log("current ${current?.toJson()}");
    navigation
        .openBottomSheet(
          bottomSheet: ServerPickerDialog(servers: servers, currentServer: current),
        )
        .then((ser) {
          if (ser is Server) {
            saveServer(ser);
            initNetworkManager(ser.apiAddress);
          }
        });
  }

  void saveServer(Server current) {
    ref.read(selectedServerProvider.notifier).update((s) => current);
    sharedPref.setVariable(key: "ServerNew", value: jsonEncode(current.toJson()));

    // final client = TimaticClient(TimaticClientOptions(baseUrl: current.apiAddress));
    // final api = TimaticApi(client);
    // getIt.registerLazySingleton(() => api);
    //
    // TimaticApi timaticApi = getIt<TimaticApi>();
    // timaticApi.setUrl(current.apiAddress);

    initNetworkManager(current.apiAddress);
  }

  void initLogin() {
    initServer();
  }

  Future<bool> setFirstPassword({required String oldPass, required String newPass}) async {
    bool res = false;
    SetFirstPasswordUseCase setFirstPasswordUseCase = SetFirstPasswordUseCase();
    SetFirstPasswordRequest setFirstPasswordRequest = SetFirstPasswordRequest(oldPass: oldPass, newPass: newPass);
    final result = await setFirstPasswordUseCase(request: setFirstPasswordRequest);

    switch (result) {
      case Err<SetFirstPasswordResponse>():
        FailureHandler.handle(result.error);

      case Ok<SetFirstPasswordResponse>():
        final r = result.value;
        res = true;
    }

    return res;
  }

  Future<String?> sendForgetPasswordCode(String email) async {
    String? msg;
    SendForgetPasswordCodeUseCase sendForgetPasswordCodeUseCase = SendForgetPasswordCodeUseCase();
    SendForgetPasswordCodeRequest sendForgetPasswordCodeRequest = SendForgetPasswordCodeRequest(email: email);
    final result = await sendForgetPasswordCodeUseCase(request: sendForgetPasswordCodeRequest);

    switch (result) {
      case Err<SendForgetPasswordCodeResponse>():
        FailureHandler.handle(result.error);

      case Ok<SendForgetPasswordCodeResponse>():
        final r = result.value;
        msg = r.msg;
    }

    return msg;
  }

  Future<String?> resetPassword({required String email, required String newPass, required String code}) async {
    String? msg;
    ResetPasswordUseCase resetPasswordUseCase = ResetPasswordUseCase();
    ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest(email: email, newPassword: newPass, code: code);
    final result = await resetPasswordUseCase(request: resetPasswordRequest);

    switch (result) {
      case Err<ResetPasswordResponse>():
        FailureHandler.handle(result.error);

      case Ok<ResetPasswordResponse>():
        final r = result.value;
        msg = r.msg;
    }

    return msg;
  }

  void initData(LoginData data) {
    // var segment = ref.read(segmentsProvider).first;
    // segment = segment.copyWith(departure: ItinPoint(point: data.profile.defaultAirport??'', type: LocationType.airport));
    final seg = ItinerarySegment.empty();

    log("initData");
    log("${BasicClass.user?.profile.toJson()}");
    log("${ref.read(userProvider)?.profile.toJson()}");
    log("${seg.departure.point} seg dep point");
    // ref.read(segmentsProvider.notifier).updateAt(0, ItinerarySegment.empty());
    ref.read(segmentsProvider.notifier).removeAll();
  }

  checkNotifCount() {
    return;
    if (ref.read(userProvider) == null) {
      return;
    }
    getIt<HomeController>().getNotifCount().then((a) {
      Future.delayed(Duration(seconds: 10), () {
        checkNotifCount();
      });
    });
  }
}
