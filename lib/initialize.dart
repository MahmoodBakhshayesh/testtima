import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
import 'package:abds/screens/add_user/add_user_controller.dart';
import 'package:abds/screens/barcode_reader/barcode_reader_controller.dart';
import 'package:abds/screens/cupps/cupps_controller.dart';
import 'package:abds/screens/dynamsoft_mrz/dynamsoft_mrz_controller.dart';
import 'package:abds/screens/inbox/inbox_controller.dart';
import 'package:abds/screens/logs/logs_controller.dart';
import 'package:abds/screens/menu_item_add_edit/menu_item_add_edit_controller.dart';
import 'package:abds/screens/menu_section/menu_section_controller.dart';
import 'package:abds/screens/message_details/message_details_controller.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_controller.dart';
import 'package:abds/screens/outbox/outbox_controller.dart';
import 'package:abds/screens/profile/profile_controller.dart';
import 'package:abds/screens/result_report/result_report_controller.dart';
import 'package:abds/screens/result_report/result_report_view.dart';
import 'package:abds/screens/setting_menu/setting_menu_controller.dart';
import 'package:abds/screens/users/users_controller.dart';
import 'package:app_device_net_info/app_device_net_info.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:no_screenshot/no_screenshot.dart';
// import 'package:wakelock_fixed/wakelock_fixed.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
import '../../core/interfaces/network_info_int.dart';
import '../../core/utils_and_services/app_config.dart';
import '../../core/utils_and_services/app_data.dart';
import 'package:tree_navigation/tree_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/classes/config_class.dart';
import 'core/data_base/classes/db_user_class.dart';
import 'core/data_base/local_data_base.dart';
import 'core/interface_implementations/device_info_imp.dart';
import 'core/interface_implementations/network_info_imp.dart';
import 'package:network_manager/network_manager.dart';
import 'core/interface_implementations/parser_imp.dart';
import 'core/interface_implementations/shared_preferences_imp.dart';
import 'core/interfaces/parser_int.dart';
import 'core/interfaces/shared_preferences_int.dart';
import 'core/navigation/routes.dart';
import 'core/utils_and_services/route_tracker.dart';
import 'core/utils_and_services/timatic/artemis_timatic.dart';
import 'core/utils_and_services/timatic/src/timatic_client.dart';
import 'screens/home/home_controller.dart';
import 'screens/login/login_controller.dart';
import 'core/interface_implementations/network_manager_imp.dart';
import 'screens/performance/performance_controller.dart';

final getIt = GetIt.instance;
final String apiVersion = "/v1";
final String apiVersion2 = "/v2";
final _noScreenshot = NoScreenshot.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.allowReassignment = true;

  WidgetsFlutterBinding.ensureInitialized();
  final spi = await SharedPreferences.getInstance();
  SharedPreferencesImp sp = SharedPreferencesImp(spi);
  getIt.registerFactory(() => sp);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  await _initDataBase();
  await _initConfig();
  await _initPackages();
}

// initControllers() {
//   LoginController loginController = LoginController();
//   HomeController homeController = HomeController();
//   LogsController logsController = LogsController();
//
//   getIt.registerSingleton(loginController);
//   getIt.registerSingleton(homeController);
//   getIt.registerSingleton(logsController);
// }

void initFullScreen() async {}

initNetworkManager([String? baseUrl]) {
  String base = baseUrl ?? AppData.config!.baseUrl;
  // log("Setting Base URL to $baseUrl");
  NetworkOption.initialize(
    timeout: const Duration(minutes: 3),

    baseUrl: base,
    headers: {"content-type": 'application/json'},

    successCheck: (NetworkRequest req, NetworkResponse res) {
      if (res.responseCode < 200 || res.responseCode > 300) return false;
      if ((res.responseBody["Successful"]??false) == true) {
        return true;
      }
      if (res.responseBody?["response"] is Map) {
        log("res.responseBody is Map");
        if (res.responseBody["response"]?["bags"] is List) {
          log("${res.responseBody["response"]?["bags"].runtimeType} is List");
          List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(res.responseBody["response"]["bags"]);
          log("items check bags${items.length}");
          List<Map<String, dynamic>> errorItems = items.where((a) => a.containsKey("result") && a["result"] == false).toList();
          if (errorItems.isNotEmpty) {
            return false;
          }
        }
        if (res.responseBody["response"]?["passengers"] is List) {
          log("${res.responseBody["response"]?["passengers"].runtimeType} is List");
          List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(res.responseBody["response"]["passengers"]);
          List<Map<String, dynamic>> errorItems = items.where((a) => a.containsKey("result") && a["result"] == false).toList();
          log("items check passengers${items.length}");
          if (errorItems.isNotEmpty) {
            return false;
          }
        }
      } else if (res.responseBody?["response"] is List && (res.responseBody?["response"] as List).isNotEmpty) {
        if(res.responseBody?["response"][0] is String){
          return true;
        }
        List<Map<String, dynamic>> respList = List<Map<String, dynamic>>.from(res.responseBody["response"]);
        for (Map<String, dynamic> resp in respList) {
          if (resp["bags"] is List) {
            log("${resp["bags"].runtimeType} is List");
            List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(resp["bags"]);
            log("items check bags${items.length}");
            List<Map<String, dynamic>> errorItems = items.where((a) => a.containsKey("result") && a["result"] == false).toList();
            List<int> indexes = errorItems.asMap().entries.where((a) => a.value.containsKey("result") && a.value["result"] == false).map((entry) => entry.key).toList();
            if (errorItems.isNotEmpty) {
              res.extractedMessage = "Operation Failed on ${indexes.map((a) => (a + 1)).join(",")}";
              return false;
            }
          }
          if (resp["passengers"] is List) {
            log("${resp["passengers"].runtimeType} is List");
            List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(resp["passengers"]);
            List<Map<String, dynamic>> errorItems = items.where((a) => a.containsKey("result") && a["result"] == false).toList();
            log("items check passengers${items.length}");
            List<int> indexes = errorItems.asMap().entries.where((a) => a.value.containsKey("result") && a.value["result"] == false).map((entry) => entry.key).toList();
            if (errorItems.isNotEmpty) {
              res.extractedMessage = "Operation Failed on ${indexes.map((a) => (a + 1)).join(",")}";
              return false;
            }
          }
        }
      }
      final bool? isSuccess = res.responseBody["success"];
      if (isSuccess != null) {
        return isSuccess;
      }
      int statusCode = int.parse((res.responseBody["Status"]?.toString() ?? res.responseBody["ResultCode"]?.toString() ?? "0"));
      return (res.responseCode >= 200 && res.responseCode < 300) && statusCode > 0;
    },
    onStartDefault: (_) {},
    msgExtractor: (data) {
      // log("msgExtractorv ${data}");
      return (data["message"] ?? data["Message"] ?? data["ResultText"] ?? "Done").toString();
    },
    tokenExpireCheck: (NetworkRequest req, NetworkResponse res) {
      if (res.responseCode == 401) {
        return true;
      }
      if (res.responseBody is Map && res.responseBody["Body"] != null) {
        return res.extractedMessage?.contains("Token Expired") ?? false;
      } else {
        return false;
      }
    },
    onTokenExpire: (NetworkRequest req, NetworkResponse res) {
      LoginController homeController = getIt<LoginController>();
      homeController.logout(isTokenExpire: true);
    },
  );
}

Future<void> _initConfig() async {
  if(kIsWeb){
    AppData.setConfig(Config.def());
    initNetworkManager(Config.def().baseUrl);
    return;
  }
  String? directory = (await getApplicationDocumentsDirectory()).path;
  final File file = File('$directory/config/config.json');
  if (file.existsSync() && false) {
    final jsonStr = file.readAsStringSync();
    try {
      Config config = Config.fromJson(jsonDecode(jsonStr));
      AppData.setConfig(config);
      initNetworkManager(config.baseUrl);
      log("Config read from config.json");
    } catch (e) {
      await file.create(recursive: true);
      file.writeAsStringSync(json.encode(Config.def().toJson()), mode: FileMode.write);
      AppData.setConfig(Config.def());
      initNetworkManager(Config.def().baseUrl);
      log("Config read from config.default with exception $e");
    }
  } else {
    await file.create(recursive: true);
    file.writeAsStringSync(json.encode(Config.def().toJson()));
    AppData.setConfig(Config.def());
    initNetworkManager(Config.def().baseUrl);
    log("Config read from config.default");
  }
}

Future<void> _initDataBase() async {}

Future<void> initNavigation() async {
  TreeNavigation.init(
    globalKeyList: [topKey, shellKey],
    routeInfoList: Routes.allRoutes,
    useNavigationOne: true,
    routeTreeDefaultPageBuilder: (_, state, child, name) => MyCustomTransitionPage(
      key: state.pageKey,
      child: child,
      name: name,
      transitionsBuilder: (_, animation, ___, widget) {
        return FadeTransition(opacity: animation, child: widget);
      },
    ),
    routeTreeDefaultShellPageBuilder: (_, state, parent, child) => MyCustomTransitionPage(
      key: state.pageKey,
      child: parent(child),
      transitionsBuilder: (_, animation, ___, widget) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: widget);
      },
    ),
  );
  NavigationInterface ns = TreeNavigation.navigator;
  GetIt.instance.registerSingleton(() => ns);
  LoginController loginController = LoginController();
  HomeController homeController = HomeController();
  BarcodeReaderController barcodeReaderController = BarcodeReaderController();
  MrzReaderController mrzReaderController = MrzReaderController();
  UsersController usersController = UsersController();
  AddUserController addUserController = AddUserController();
  LogsController logsController = LogsController();
  ProfileController profileController = ProfileController();
  DynamsoftMrzController dynamsoftMrzController = DynamsoftMrzController();
  PerformanceController performanceController = PerformanceController();
  InboxController inboxController = InboxController();
  MessageDetailsController messageDetailsController = MessageDetailsController();
  OutboxController outboxController = OutboxController();
  ResultReportController resultReportController = ResultReportController();
  CuppsController cuppsController = CuppsController();
  SettingMenuController settingMenuController = SettingMenuController();
  MenuSectionController menuSectionController = MenuSectionController();
  MenuItemAddEditController menuItemAddEditController = MenuItemAddEditController();

  getIt.registerSingleton(loginController);
  getIt.registerSingleton(homeController);
  getIt.registerSingleton(barcodeReaderController);
  getIt.registerSingleton(mrzReaderController);
  getIt.registerSingleton(usersController);
  getIt.registerSingleton(addUserController);
  getIt.registerSingleton(logsController);
  getIt.registerSingleton(profileController);
  getIt.registerSingleton(dynamsoftMrzController);
  getIt.registerSingleton(performanceController);
  getIt.registerSingleton(inboxController);
  getIt.registerSingleton(messageDetailsController);
  getIt.registerSingleton(outboxController);
  getIt.registerSingleton(resultReportController);
  getIt.registerSingleton(cuppsController);
  getIt.registerSingleton(settingMenuController);
  getIt.registerSingleton(menuSectionController);
  getIt.registerSingleton(menuItemAddEditController);

  TreeNavigation.navigator.registerAllControllers({
    Routes.login: loginController,
    Routes.home: homeController,
    Routes.mrzReader: mrzReaderController,
    Routes.barcodeReader: barcodeReaderController,
    Routes.performance: performanceController,
  });

  // print("registerAllControllers");
}

Future<void> _initPackages() async {
  Connectivity connectivity = Connectivity();
  NetworkInfoImp networkInfo = NetworkInfoImp(connectivity);
  getIt.registerSingleton(networkInfo);

  NetworkManagerImp networkManager = NetworkManagerImp();
  getIt.registerSingleton(networkManager);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPreferences);

  LocalDataBase localDataBase = LocalDataBase();
  getIt.registerSingleton(localDataBase);

  MyDeviceInfo deviceInfo = await DeviceUtility.getInfo();
  DeviceInfoServiceImp deviceInfoService = DeviceInfoServiceImp(deviceInfo);
  getIt.registerSingleton(deviceInfoService);

  ParserInterface parser = Parser();
  getIt.registerSingleton(parser);

  // if(!kIsWeb) {
    AppDeviceNetworkData adnd = await AppDeviceNetworkInfo.getAll();
    getIt.registerSingleton(adnd);
  // }else{
  //   AppDeviceNetworkData adnd = AppDeviceNetworkData(app: AppInfoData(name: "TimaCheck", id: "1",versionKey: "0",versionNumber: "0"), device: DeviceInfoData(type: DeviceType.desktop, id: "id", os: OSType.other), network: NetworkInfoData(type: NetworkType.other));
  //   getIt.registerSingleton(adnd);
  //
  // }

  // final client = TimaticClient(const TimaticClientOptions(baseUrl: 'https://timatic.multidcs.com/api/v1'));
  // final api = TimaticApi(client);
  // getIt.registerLazySingleton(() => api);

  await FastCachedImageConfig.init();
  await WakelockPlus.enable();
  // await disableScreenshot();
  // await Wakelock.enable();

}


Future<void> disableScreenshot() async {
  if(kIsWeb) return;

  if(Platform.isAndroid || Platform.isIOS) {
    bool result = await _noScreenshot.screenshotOff();
    // listenForScreenshot();
    debugPrint('Screenshot Off: $result');
  }
}

Future<void> enableScreenshot() async {
  if(kIsWeb) return;
  if(Platform.isAndroid || Platform.isIOS) {
    bool result = await _noScreenshot.screenshotOn();
    // listenForScreenshot();
    debugPrint('Screenshot Off: $result');
  }
}

void listenForScreenshot() {
  if(Platform.isAndroid || Platform.isIOS) {
    _noScreenshot.screenshotStream.listen((value) {
      if (value.wasScreenshotTaken) showAlert(value.screenshotPath);
    });
  }
}

void showAlert(String screenshotPath) {
  log("screenshot token");
  // FailureHandler.handle(ServerFailure(code: -1, msg: msg, traceMsg: traceMsg))
}
