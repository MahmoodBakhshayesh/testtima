import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/interfaces/result_int.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/screens/login/usecases/get_cons_data_usecase.dart';
import 'package:abds/screens/login/usecases/get_publish_server_usecase.dart';
import 'package:app_device_net_info/app_device_net_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import '../../core/classes/new_version_class.dart';
import '../../core/classes/server_class.dart';
import '../../core/classes/user_class.dart';
import '../../core/interface_implementations/device_info_imp.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/device_info_service_int.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/timatic/src/endpoints.dart';
import '../../core/utils_and_services/url_resolver.dart';
import '../../initialize.dart';
import '../../widgets/MyButton.dart';
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
    if(username.isEmpty || password.isEmpty){
      FailureHandler.handle(ValidationFailure(code: -1, msg: "Username and Password are required!", traceMsg: "Username and Password are required!"));
      return null;
    }
    _log.warning("Logging in");
    getIt<HomeController>().clear();
    ref.read(timaticResultNewProvider.notifier).update((s) => null);

    if (["appleuser", "googleuser"].contains(username.toLowerCase())) {
      String? publishApi = await getPublishServer();
    }
    Map<String,dynamic> firebase = {};
    if(!kIsWeb){
      if(Platform.isAndroid || Platform.isIOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        final fcmToken = await FirebaseMessaging.instance.getToken();

        firebase = {"apnsToken": apnsToken, "fcmToken": fcmToken};
      }
    }
    // DeviceInfoServiceImp deviceInfoService = getIt<DeviceInfoServiceImp>();
    // DeviceInfo deviceInfo = deviceInfoService.getInfo();
    AppDeviceNetworkData adnd = getIt<AppDeviceNetworkData>();
    LoginData? user;
    LoginUseCase loginUseCase = LoginUseCase();
    LoginRequest loginRequest = LoginRequest(firebase: firebase, username: username, password: password, app: adnd.app.toJson(), device: adnd.device.toJson(), network: adnd.network.toJson());
    final fOrR = await loginUseCase(request: loginRequest);

    switch (fOrR) {
      case Ok<LoginResponse>():
        user = fOrR.value.user;
        ref.read(userProvider.notifier).update((s) => user);
        // timaticApi.setToken(user!.token);
        // log("${user.profile.username}");
        final constData = await loadConstantData(user.constDataVersion);
        if (constData == null) {
          return null;
        }
        // return null;

        BasicClass.initialize(user);
        BasicClass.setVersionedConstData(constData);

        ///todo preload basic data tData
        saveLoginData(username: username, password: password);
        ref.read(userProvider.notifier).update((s) => user);
        ref.read(profileProvider.notifier).update((s) => user!.profile);
        initData(user);
        // final tData = await getIt<HomeController>().preloadAll();
        checkNotifCount(user.setting?.refreshInboxTimer);
        final bool canScreenShot = user.permission.hasFlag("user", 64);
        if (canScreenShot) {
          enableScreenshot();
        } else {
          disableScreenshot();
        }
        loadSupervisors();
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
    log(jsonEncode(user.permission.toRootJson()));
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
    final baseUrl = BaseUrlResolver.getBaseUrl();
    log("BaseUrlResolver url $baseUrl");
    String? serverJson = await sharedPref.getVariable(key: "ServerNew");
    log(serverJson ?? '');
    if (serverJson == null) {
      serverSelect(showDialog: false).then((a) {
        if (a.isNotEmpty) {
          Server server = a.firstWhere((a) => a.serverDefault, orElse: () => a.first);
          // server = server.copyWith(apiAddress: "${server!.apiAddress}$apiVersion");
          log("we found default server ${server.toJson()}");

          server = server.copyWith(apiAddress: "${server!.apiAddress}");
          ref.read(selectedServerProvider.notifier).update((s) => server);
          initNetworkManager(server.apiAddress);
        }
      });
    } else {
      Server s = Server.fromJson(jsonDecode(serverJson));

      if (!s.apiAddress.contains("v1")) {
        log("we found saved server ${s.toJson()}");
        saveServer(s);
      } else {
        serverSelect(showDialog: false).then((a) {
          Server server = a.firstWhere((a) => a.serverDefault, orElse: () => a.first);
          // server = server.copyWith(apiAddress: "${server!.apiAddress}$apiVersion");
          log("we found default server ${server.toJson()}");

          server = server.copyWith(apiAddress: "${server!.apiAddress}");
          ref.read(selectedServerProvider.notifier).update((s) => server);
          initNetworkManager(server.apiAddress);
        });
      }
    }
  }

  Future<List<Server>> serverSelect({bool showDialog = true}) async {
    // final d = dio.Dio();
    // final res  = await d.get('https://timatic.multidcs.com/api/v1/server');
    // log(res.toString());
    // return [];
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
    Server? current = servers.firstWhereOrNull((s) => (s.apiAddress).toLowerCase() == (ref.read(selectedServerProvider).apiAddress).toLowerCase());
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

  checkNotifCount(int? refreshInboxTimer) {
    if (refreshInboxTimer == null || kDebugMode) {
      return;
    }
    if (ref.read(userProvider) == null) {
      return;
    }
    // log("refreshInboxTimer $refreshInboxTimer" );
    getIt<HomeController>().getNotifCount().then((a) {
      Future.delayed(Duration(milliseconds: refreshInboxTimer), () {
        checkNotifCount(refreshInboxTimer);
      });
    });
  }

  Future<VersionedConstantData?> loadConstantData(String constantVersion) async {
    VersionedConstantData? cached = await loadCachedConstData();
    cached ??= await getConstantData(constantVersion);
    if (cached == null) return null;
    BasicClass.setVersionedConstData(cached);
    if (constantVersion.compareTo(cached.version) > 0) {
      cached = await getConstantData(constantVersion);
    } else {
      log("no need to get const data");
    }
    return cached;
  }

  Future<VersionedConstantData?> loadCachedConstData() async {
    String key = "${ref.read(selectedServerProvider).id}/${getIt<AppDeviceNetworkData>().app.versionKey}/constantData";
    log("CachedConstData key $key");
    final String? constJson = await sharedPref.getVariable(key: key);
    if (constJson != null) {
      VersionedConstantData constantData = VersionedConstantData.fromJson(jsonDecode(constJson));
      return constantData;
    }
    return null;
  }

  catchConstData(VersionedConstantData data) async {
    String key = "${ref.read(selectedServerProvider).id}/${getIt<AppDeviceNetworkData>().app.versionKey}/constantData";
    log("CachedConstData key $key");
    await sharedPref.setVariable(key: key, value: jsonEncode(data.toJson()));
  }

  Future<VersionedConstantData?> getConstantData(String? consVersion) async {
    VersionedConstantData? constData;
    GetConsDataUseCase getConstantDataUseCase = GetConsDataUseCase();
    GetConsDataRequest getConsDataRequest = GetConsDataRequest(constVersion: consVersion ?? '');
    final result = await getConstantDataUseCase(request: getConsDataRequest);

    switch (result) {
      case Err<GetConsDataResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetConsDataResponse>():
        final r = result.value;
        constData = r.constantData;
        BasicClass.setVersionedConstData(r.constantData);
        catchConstData(r.constantData);
      // await sharedPref.setVariable(key: "constantData", value: jsonEncode(r.constantData.toJson()));
      // log("got and saved constant data version ${constData!.version}");
    }

    return constData;
  }

  Future<void> loadSupervisors() async {
    final supervisors = await getIt<HomeController>().getSupervisors();
    ref.read(supervisorsProvider.notifier).update((s) => supervisors ?? s);
  }

  Future<String?> getPublishServer() async {
    String? apiAddress;
    GetPublishServerUseCase getPublishServerUseCase = GetPublishServerUseCase();
    GetPublishServerRequest getPublishServerRequest = GetPublishServerRequest();
    final result = await getPublishServerUseCase(request: getPublishServerRequest);

    switch (result) {
      case Err<GetPublishServerResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetPublishServerResponse>():
        final r = result.value;
        apiAddress = r.apiAddress;
        String address = apiAddress;
        log("setting address ${address}");
        Server pubServer = Server(id: "100", title: "Publish", apiAddress: address, active: true, serverDefault: false, color: null, name: null);
        initNetworkManager(pubServer.apiAddress);
        ref.read(selectedServerProvider.notifier).update((s) => pubServer);
    }

    return apiAddress;
  }
}
