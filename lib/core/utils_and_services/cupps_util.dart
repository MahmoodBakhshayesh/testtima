import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/interface_implementations/shared_preferences_imp.dart';
import 'package:abds/core/interfaces/result_int.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/barcode_reader/barcode_reader_controller.dart';
import 'package:artemis_cupps/artemis_cupps.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tree_navigation/tree_navigation.dart';
import '../../initialize.dart';
import '../../screens/home/home_controller.dart';
import '../classes/constant_data_class.dart';
import '../constants/ui.dart';
import '../interfaces/failures_int.dart';
import 'handlers/failure_handler.dart';
import 'version_handler.dart';

final cuppsStatusProvider = StateProvider<PlatformDevices?>((ref) => null);
final cuppsPlatformStatusProvider = StateProvider<CuppsPlatformStatus>((ref) => CuppsPlatformStatus.disconnected);

class CuppsUtils {
  CuppsUtils._();

  static WidgetRef ref = getIt<WidgetRef>();
  static bool bpInit = false;
  static bool btInit = false;
  static bool autoReconnect = false;

  static initCupps({required String ip, required String port}) async {
    try {
      setReadersHandler();

      final packageInfo = await PackageInfo.fromPlatform();
      setStatus(CuppsPlatformStatus.connecting);
      final connection = await CUPPS.connectToPlatform(
        ip: ip,
        port: int.tryParse(port) ?? 0,
        notifier: cuppsNotifier,
        onPlatformConnectionChange: onPlatformConnectionChange,
        onPlatformDisconnect: onPlatformDisconnect,
        onStopCommand: onStopCommand,
        airlineCode: "ZZ",
        applicationVersion: VersionHandler.getVersionKey(packageInfo),
        applicationName: packageInfo.appName,
      );
      if (connection) {
        saveIpPort(ip, port);
        setStatus(CuppsPlatformStatus.authenticating);
        final auth = await CUPPS.authenticate();
        if (auth) {
          log("auth start");
          setStatus(CuppsPlatformStatus.connectingToDevices);
          final deviceConnection = await CUPPS.connectToAvailableNeededDevices();
          log("auth Done");
          CUPPS.setConnectionChecker(
            interval: const Duration(seconds: 45),
            timeout: const Duration(seconds: 12),
            retryFunction: () {
              onPlatformDisconnect();
              initCupps(ip: ip, port: port);
            },
          );
          if (deviceConnection) {
            setStatus(CuppsPlatformStatus.connected);
            await lockAllAvailable();
          }
        } else {
          setStatus(CuppsPlatformStatus.authenticationFailed);
        }
      } else {
        setStatus(CuppsPlatformStatus.disconnected);
      }
    } catch (e) {
      if(e is Error){
        log(e.stackTrace.toString());
      }
      log(e.toString());
    }
  }

  static cuppsNotifier() async {
    ///5892101437267780
    List<String> needs = ['_natural', '_disconnect', '_in'];
    List<String> oks = ['active', 'ready'];

    // if (!bpInit && CUPPS().platformDevices.hasBP && needs.any((n)=>CUPPS().platformDevices.bpDevices.first.icon.contains(n))  && CUPPS().platformDevices.bpDevices.first.modded) {
    //   bpInit = true;
    //   initializeBp();
    // }
    //
    // if (!btInit && CUPPS().platformDevices.hasBT && needs.any((n)=>CUPPS().platformDevices.btDevices.first.icon.contains(n))  && CUPPS().platformDevices.btDevices.first.modded) {
    //   btInit = true;
    //   initializeBt();
    // }

    if (CUPPS().platformDevices.hasBP && needs.any((n) => CUPPS().platformDevices.bpDevices.first.icon.contains(n)) && CUPPS().platformDevices.bpDevices.first.modded) {
      await initializeBp();
    }

    if (CUPPS().platformDevices.hasBT && needs.any((n) => CUPPS().platformDevices.btDevices.first.icon.contains(n)) && CUPPS().platformDevices.btDevices.first.modded) {
      await initializeBt();
    }

    // PlatformDevices cuppsState = CUPPS().platformDevices;
    print("Lastes Status => ${CUPPS().platformDevices.bpDevices.map((a) => a.icon)}");

    ref.read(cuppsStatusProvider.notifier).update((s) => null);
    ref.read(cuppsStatusProvider.notifier).update((s) => CUPPS().platformDevices);
  }

  static void onPlatformConnectionChange(bool connection) {
    if (!connection) {
      ref.read(cuppsStatusProvider.notifier).update((s) => null);
      bpInit = false;
      btInit = false;
      setStatus(CuppsPlatformStatus.disconnected);
    } else {
      setStatus(CuppsPlatformStatus.connected);
    }
  }

  static void onPlatformDisconnect() {
    ref.read(cuppsStatusProvider.notifier).update((s) => null);
  }

  static void onStopCommand({required bool canDefer, required Function onDefer, required Function onForceClose}) {}

  static Future<void> unlockAllAvailable() async {
    log("unlockAllAvailable");
    final platformDevices = ref.read(cuppsStatusProvider);
    if (platformDevices == null) return;
    platformDevices.bcDevices.where((element) => element.isConnected && element.initialized && element.locked).forEach((dev) {
      dev.disableAutoLock();
      dev.unlock().then((value) {
        log("$value");
      });
    });
    platformDevices.ocDevices.where((element) => element.isConnected && element.initialized && element.locked).forEach((dev) {
      dev.disableAutoLock();
      dev.unlock().then((value) {
        log("$value");
      });
    });
    platformDevices.msDevices.where((element) => element.isConnected && element.initialized && element.locked).forEach((dev) {
      dev.disableAutoLock();
      dev.unlock().then((value) {
        log("$value");
      });
    });
    platformDevices.prDevices.where((element) => element.isConnected && element.initialized && element.locked).forEach((dev) {
      dev.disableAutoLock();
      dev.unlock().then((value) {
        log("$value");
      });
    });
  }

  static Future<void> lockAllAvailable() async {
    log("lockAllAvailable");
    final platformDevices = ref.read(cuppsStatusProvider);
    if (platformDevices == null) return;
    platformDevices.bcDevices.where((element) => element.isConnected && element.initialized).forEach((dev) {
      dev.lock().then((value) {
        dev.enableAutoLock();
        log("$value");
      });
    });
    platformDevices.ocDevices.where((element) => element.isConnected && element.initialized).forEach((dev) {
      dev.lock().then((value) {
        dev.enableAutoLock();
        log("$value");
      });
    });
    platformDevices.msDevices.where((element) => element.isConnected && element.initialized).forEach((dev) {
      dev.lock().then((value) {
        dev.enableAutoLock();
        log("$value");
      });
    });
    platformDevices.prDevices.where((element) => element.isConnected && element.initialized).forEach((dev) {
      dev.lock().then((value) {
        dev.enableAutoLock();
        log("$value");
      });
    });
  }

  static setStatus(CuppsPlatformStatus status) {
    ref.read(cuppsPlatformStatusProvider.notifier).update((s) => status);
  }

  static Future<void> initializeBp() async {
    // print("initializeBp");
    // HardwareSettings hardwareSettings = ref.read(flightDetailsProvider)?.hardwareSettings ?? BasicClass.settings.userSettings.hardwareSettings;
    // final platformDevices = ref.read(cuppsStatusProvider);
    // if (platformDevices == null) return;
    // if (platformDevices.bpDevices.where((element) => element.modded).isNotEmpty) {
    //   List<String> bpCommands = hardwareSettings.cuppsConfigs.firstWhere((element) => element.deviceId == 0).data.map((e) => e.replaceAll("\r", "").replaceAll("EP#AIRLINEID=000", "EP#AIRLINEID=999")).toList();
    //   Map<int, String> replacebales = {};
    //   for (String command in bpCommands.where((element) => element.startsWith("*LOGO*"))) {
    //     int index = bpCommands.indexOf(command);
    //     String aeaCommand = await LogoAeaGenerator.generateAea(code: command);
    //     aeaCommand = aeaCommand.replaceAll("EP#AIRLINEID=000", "EP#AIRLINEID=001");
    //     replacebales.putIfAbsent(index, () => aeaCommand);
    //   }
    //   replacebales.forEach((key, value) {
    //     bpCommands.removeAt(key);
    //     bpCommands.insert(key, value);
    //   });
    //   await platformDevices.bpDevices.firstWhereOrNull((element) => element.modded)?.completeConfigure(bpCommands);
    //   PlatformDevices cuppsState = CUPPS().platformDevices;
    //   ref.read(cuppsStatusProvider.notifier).update((s) => cuppsState);
    // }
  }

  static Future<void> initializeBt() async {
    // print("initializeBt");
    // HardwareSettings hardwareSettings = ref.read(flightDetailsProvider)?.hardwareSettings ?? BasicClass.settings.userSettings.hardwareSettings;
    // final platformDevices = ref.read(cuppsStatusProvider);
    // if (platformDevices == null) return;
    // if (platformDevices.btDevices.where((element) => element.modded).isNotEmpty) {
    //   List<String> btCommands = hardwareSettings.cuppsConfigs.firstWhereOrNull((element) => element.deviceId == 1)?.data??[];
    //   Map<int, String> replacebales = {};
    //   for (String command in btCommands.where((element) => element.startsWith("*LOGO*"))) {
    //     int index = btCommands.indexOf(command);
    //     String aeaCommand = await LogoAeaGenerator.generateAea(code: command);
    //     replacebales.putIfAbsent(index, () => aeaCommand);
    //   }
    //
    //   replacebales.forEach((key, value) {
    //     btCommands.removeAt(key);
    //     btCommands.insert(key, value);
    //   });
    //   await platformDevices.btDevices.where((element) => element.modded).first.completeConfigure(btCommands);
    //   PlatformDevices cuppsState = CUPPS().platformDevices;
    //   ref.read(cuppsStatusProvider.notifier).update((s) => cuppsState);
    //
    // }
  }

  static Future<void> setBgInitializers() async {
    // HardwareSettings hardwareSettings = ref.read(flightDetailsProvider)?.hardwareSettings ?? BasicClass.settings.userSettings.hardwareSettings;
    // final platformDevices = ref.read(cuppsStatusProvider);
    // if (platformDevices == null) return;
    // if (platformDevices.bgDevices.where((element) => element.modded).isNotEmpty) {
    //   List<String> bgCommands = hardwareSettings.cuppsConfigs.firstWhere((element) => element.deviceId == 2).data;
    //   await platformDevices.bgDevices.firstWhereOrNull((element) => element.modded)?.completeConfigure(bgCommands);
    // }
  }

  static Future<void> printBps(List<String> bps) async {
    List<String> tmpBps = bps.map((e) => e).toList();
    bool dialogShow = true;
    int responseReceived = 0;
    final platformDevices = ref.read(cuppsStatusProvider);
    if (platformDevices == null) return;
    if (platformDevices.bpDevices.where((element) => element.isConnected && element.initialized).isNotEmpty) {
      for (var bp in bps) {
        CuppsCommandResponse bpPrintRes = await printBP(bp);
        responseReceived++;
        if (bpPrintRes.status) {
          tmpBps.remove(bp);
        }
        if (responseReceived == bps.length && tmpBps.isNotEmpty && dialogShow) {
          dialogShow = false;
        }
      }
    }
  }

  static Future<CuppsCommandResponse> printBP(String bp) async {
    final platformDevices = ref.read(cuppsStatusProvider);
    if (platformDevices == null) return CuppsCommandResponse(status: false, msg: "Boarding pass print is not Ready");
    if (platformDevices.bpDevices.where((element) => element.isConnected && element.initialized).isNotEmpty) {
      CuppsCommandResponse bpPrintRes = await platformDevices.bpDevices.firstWhere((element) => element.isConnected && element.initialized).print(bp);
      if (!bpPrintRes.status && !bpPrintRes.msg.contains("Timeout")) {
        await initializeBp();
        CuppsCommandResponse secondTryRes = await platformDevices.bpDevices.firstWhere((element) => element.isConnected && element.initialized).print(bp);
        if (!secondTryRes.status) {
          Failure f = ServerFailure(code: -1, msg: "Boarding pass print Failed:${secondTryRes.msg}", traceMsg: "Boarding pass print Failed:${secondTryRes.msg}");
          if (!f.msg.contains("Timeout")) {
            FailureHandler.handle(f);
          }
        }
        return secondTryRes;
      } else if (!bpPrintRes.status) {
        Failure f = ServerFailure(code: -1, msg: "Boarding pass print Failed:${bpPrintRes.msg}", traceMsg: "Boarding pass print Failed:${bpPrintRes.msg}");
        if (!f.msg.contains("Timeout")) {
          FailureHandler.handle(f);
        }
        return bpPrintRes;
      } else {
        return bpPrintRes;
      }
    } else {
      return CuppsCommandResponse(status: false, msg: "Boarding pass print is not Ready");
    }
  }

  static Future<void> printBts(List<String> bts) async {
    final platformDevices = ref.read(cuppsStatusProvider);
    if (platformDevices == null) return;
    List<String> tmpBts = bts.map((e) => e).toList();
    bool dialogShow = true;
    int responseReceived = 0;

    if (platformDevices.btDevices.where((element) => element.isConnected && element.initialized).isNotEmpty) {
      for (var bt in bts) {
        CuppsCommandResponse btPrintRes = await printBT(bt);
        responseReceived++;
        if (btPrintRes.status) {
          tmpBts.remove(bt);
        }
        if (responseReceived == bts.length && tmpBts.isNotEmpty && dialogShow) {
          dialogShow = false;
        }
      }
    }
  }

  static Future<CuppsCommandResponse> printBT(String bt) async {
    final platformDevices = ref.read(cuppsStatusProvider);
    if (platformDevices == null) return CuppsCommandResponse(status: false, msg: "BagTag print is not Ready");
    if (platformDevices.btDevices.where((element) => element.isConnected && element.initialized).isNotEmpty) {
      CuppsCommandResponse btPrintRes = await platformDevices.btDevices.firstWhere((element) => element.isConnected && element.initialized).print(bt);
      if (!btPrintRes.status && !btPrintRes.msg.contains("Timeout")) {
        await initializeBt();
        CuppsCommandResponse secondTryRes = await platformDevices.btDevices.firstWhere((element) => element.isConnected && element.initialized).print(bt);
        if (!secondTryRes.status) {
          Failure f = ServerFailure(code: -1, msg: "BagTag print print Failed:${secondTryRes.msg}", traceMsg: "Boarding pass print Failed:${secondTryRes.msg}");

          if (!f.msg.contains("Timeout")) {
            FailureHandler.handle(f);
          }
        }
        return secondTryRes;
      } else if (!btPrintRes.status) {
        Failure f = ServerFailure(code: -1, msg: "BagTag print Failed:${btPrintRes.msg}", traceMsg: "Boarding pass print Failed:${btPrintRes.msg}");
        if (!f.msg.contains("Timeout")) {
          FailureHandler.handle(f);
        }
        return btPrintRes;
      } else {
        return btPrintRes;
      }
    } else {
      return CuppsCommandResponse(status: false, msg: "BagTag print is not Ready");
    }
  }

  static Future<void> printPr(String text) async {
    final platformDevices = ref.read(cuppsStatusProvider);
    if (platformDevices == null) return;
    if (platformDevices.prDevices.isNotEmpty) {
      final res = await platformDevices.prDevices.first.printPr([text], []);
      if (!res.status) {
        Failure f = ServerFailure(code: -1, msg: res.msg, traceMsg: res.msg);
        FailureHandler.handle(f);
      }
    } else {
      Failure f = ServerFailure(code: -1, msg: "Device not Available", traceMsg: "Device not Available");
      FailureHandler.handle(f);
    }
  }

  static disconnectCupps() async {
    await unlockAllAvailable();
    setStatus(CuppsPlatformStatus.disconnected);
    CUPPS.disconnectFromPlatform().then((value) {
      setStatus(CuppsPlatformStatus.disconnected);
    });
  }

  static void activeBG() {
    final platformDevices = ref.read(cuppsStatusProvider);
    if (platformDevices == null) return;
    List<BgDevice> bgs = platformDevices.bgDevices.where((element) => element.isConnected && element.acquired && element.modded).toList();
    if (bgs.isNotEmpty) {
      bgs.first.aeaRequest("CR");
    }
  }

  static void deActiveBG() {
    final platformDevices = ref.read(cuppsStatusProvider);
    if (platformDevices == null) return;
    List<BgDevice> bgs = platformDevices.bgDevices.where((element) => element.isConnected && element.acquired && element.modded).toList();
    if (bgs.isNotEmpty) {
      bgs.first.aeaRequest("CW");
    }
  }

  static void removeUnwantedDeviceHandlers() {
    CUPPS.setBcListener((result) => {});
    CUPPS.setBgListener((data) => Future.value(BgResponse(status: false, message: '')));
    CUPPS.setMsListener((data) => {});
    CUPPS.setOcListener((data) => {});
  }

  static void setReadersHandler() {
    CUPPS.setBcListener(bcDataHandler);
    CUPPS.setBgListener(bgDataHandler);
    CUPPS.setMsListener(msDataHandler);
    CUPPS.setOcListener(ocDataHandler);
  }

  static Future<void> bcDataHandler(List<BcData> result) async {
    String data = result.first.decodedValue;
    RouteInfo currentRoute = getIt<HomeController>().navigation.currentRoute!;
    log("BC Read Data : $data on ${currentRoute.path}");
    getIt<BarcodeReaderController>().onBarcodeRead(data,shouldPop: false);
  }

  static Future<BgResponse> bgDataHandler(BgData result) async {
    String data = result.toString();
    RouteInfo currentRoute = getIt<HomeController>().navigation.currentRoute!;

    log("BG Read Data : $data on ${currentRoute.name}");

    throw Exception("Bg Should be used in Boaridng");
    // if (r == RouteNames.board) {
    //   BoardingPass bp = BoardingPass.fromBarcode(barcode);
    //   BoardController bc = getIt<BoardController>();
    //   BoardState bs = getIt<BoardState>();
    //   Passenger? p = bs.flightDetails!.passengers.firstWhereOrNull((p) => p.seq.toString() == bp.seq);
    //   if (p != null) {
    //     // bool boardRes = await bc.paxBoard(p, bs.flightDetails!.flight, barcode: barcode);
    //     bool boardRes = await bc.paxBoard([p], bs.flightDetails!.flight, barcode: null);
    //     // print("boardRes $boardRes");
    //     if (boardRes) {
    //       return BgResponse(status: true, message: "${p.fullName} Boarded");
    //     } else {
    //       return BgResponse(status: false, message: "Board Failed");
    //     }
    //   } else {
    //     return BgResponse(status: false, message: "Pax Not Found!");
    //   }
    // } else {
    //   throw Exception("Bg Should be used in Boaridng");
    // }

    // BoardingPass
  }

  static void msDataHandler(List<MsData> data) {
    String msD = data.map((e) => e.toString()).toList().join();
    Map<String, dynamic>? cardData = data.first.parseData();
    RouteInfo currentRoute = getIt<HomeController>().navigation.currentRoute!;

    log("MS Read Data : $msD on ${currentRoute.name}");
  }

  static void ocDataHandlerText(String ocD) {
    DocumentDetail dd = parseMrzToDocumentDetail(ocD);

    DocumentDetailType? match;
    // log("*"*100);
    // log(jsonEncode(res.toJson()));
    // log("*"*100);

    // docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == mapMrzDocCodeToTimatic(res.documentCode));
    log(ocD);
    log(jsonEncode(dd.toJson()));

    DocumentDetailType? suggest;
    if (BasicClass.constData.data.documentDetailType.isNotEmpty) {
      match = BasicClass.constData.data.documentDetailType.lastOrNullWhere((a) {
        return a.type == (dd.docCode ?? '  ').characters.first && (a.subType == "-" || a.subType == (dd.docCode ?? '  ').characters.last) && (a.country == "-" || a.country == dd.documentIssueCountry!.code3);
      });

      suggest = BasicClass.constData.data.documentDetailType.lastOrNullWhere(
        (a) => a.type == (dd.docCode ?? '  ').characters.first && (a.subType == "*" || a.subType == (dd.docCode ?? '  ').characters.last) && (a.country == "*" || a.country == dd.documentIssueCountry!.code3),
        // (a) => a.type == res.documentCode.characters.first && (a.subType == res.documentCode.characters.last || (res.documentCode.characters.last == "<" && a.subType=="*")) && (a.country == "*" || a.country == res.countryCode),
        // (a) => a.type == res.documentCode.characters.first && (a.subType == res.documentCode.characters.last || (res.documentCode.characters.last == "<" && a.subType=="*")) && ( a.country == res.countryCode),
      );

      log("match ${match?.code}");
      log("suggest ${suggest?.code}");



      dd = dd.copyWith(docCode: match?.code, suggestionCodes:match!=null ||  suggest == null ? null : [suggest.code],documentCode: BasicClass.constData.data.documentCode.firstWhereOrNull((a)=>a.code == match?.code));
      getIt<HomeController>().handleConfirming(dd);
    }
  }
  static void ocDataHandler(List<OcData> data) {
    RouteInfo currentRoute = getIt<HomeController>().navigation.currentRoute!;

    String ocD = data.map((e) => e.toString()).toList().join("\n");
    ocDataHandlerText(ocD);

  }

  static void saveIpPort(String ip,String port){
    getIt<SharedPreferencesImp>().setVariable(key: "cuppsIp", value: ip);
    getIt<SharedPreferencesImp>().setVariable(key: "cuppsPort", value: port);
  }
  static Future<(String?, String?)> loadIpPort() async {
    String? ip = await getIt<SharedPreferencesImp>().getVariable(key: "cuppsIp");
    String? port = await getIt<SharedPreferencesImp>().getVariable(key: "cuppsPort");
    return (ip,port);
  }
}

enum CuppsPlatformStatus { connected, connecting, disconnected, authenticating, authenticationFailed, authenticated, connectingToDevices }

extension CuppsPlatformStatusDetails on CuppsPlatformStatus {
  Color get getColor {
    switch (this) {
      case CuppsPlatformStatus.connected:
        return MyColors.green;
      case CuppsPlatformStatus.connecting:
        return Colors.yellow;
      case CuppsPlatformStatus.disconnected:
        return Colors.red;
      case CuppsPlatformStatus.authenticating:
        return Colors.orange;
      case CuppsPlatformStatus.authenticationFailed:
        return Colors.red;
      case CuppsPlatformStatus.authenticated:
        return Colors.greenAccent;
      case CuppsPlatformStatus.connectingToDevices:
        return Colors.blueAccent;
      default:
        return Colors.black;
    }
  }

  Color get getConnectColor {
    switch (this) {
      case CuppsPlatformStatus.connected:
        return Colors.red;
      // case CuppsPlatformStatus.connecting:
      //   return Colors.yellow;
      // case CuppsPlatformStatus.disconnected:
      //   return Colors.red;
      // case CuppsPlatformStatus.authenticating:
      //   return Colors.orange;
      // case CuppsPlatformStatus.authenticationFailed:
      //   return Colors.red;
      // case CuppsPlatformStatus.authenticated:
      //   return Colors.greenAccent;
      // case CuppsPlatformStatus.connectingToDevices:
      //   return Colors.blueAccent;
      default:
        return Colors.blueAccent;
    }
  }

  String get label {
    switch (this) {
      case CuppsPlatformStatus.connected:
        return "Connected";
      case CuppsPlatformStatus.connecting:
        return "Connecting";
      case CuppsPlatformStatus.disconnected:
        return "Disconnected";
      case CuppsPlatformStatus.authenticating:
        return "Authenticating";
      case CuppsPlatformStatus.authenticationFailed:
        return "Unauthorized";
      case CuppsPlatformStatus.authenticated:
        return "Authenticated";
      case CuppsPlatformStatus.connectingToDevices:
        return "Fetching Devices";
      default:
        return '';
    }
  }
  String get getConnectLabel {
    switch (this) {
      case CuppsPlatformStatus.connected:
        return "Disconnect";
      default:
        return 'Connect';
    }
  }


}

// ======================= PUBLIC ENTRY =======================

/// Prefer TD1 using the "digits on first line" rule.
/// Removes at most [maxPrefixDrop] leading chars; keeps everything else intact (except \r/\n).
DocumentDetail parseMrzToDocumentDetail(String raw) {
  final td1 = extractTd1Enhanced(raw, maxPrefixDrop: 2);
  if (td1.isNotEmpty) {
    return _parseTD1(td1[0], td1[1], td1[2]); // your TD1 parser from earlier
  }

  // Fallbacks (non-destructive): try TD3 then TD2 from the tail, as usual.
  final cleaned = raw.replaceAll('\r', '').replaceAll('\n', '');
  if (cleaned.length >= 88) {
    final last88 = cleaned.substring(cleaned.length - 88);
    final l1 = last88.substring(0, 44), l2 = last88.substring(44, 88);
    return _parseTD3(l1, l2);
  }
  if (cleaned.length >= 72) {
    final last72 = cleaned.substring(cleaned.length - 72);
    final l1 = last72.substring(0, 36), l2 = last72.substring(36, 72);
    return _parseTD2(l1, l2);
  }

  // Unknown: return as-is so you can inspect
  return DocumentDetail(mrz: raw);
}

/// TD1 extractor that (1) drops ≤2 prefix chars, (2) uses "digit on first line" rule, (3) requires name marker on L3.
List<String> extractTd1Enhanced(String raw, {int maxPrefixDrop = 2}) {
  const docTypeSet = {'I','P','V','A','C','D','R'};

  // try with 0, 1, or 2 chars dropped — nothing more
  final limit = (maxPrefixDrop + 1).clamp(1, 3);
  for (int drop = 0; drop < limit; drop++) {
    if (drop >= raw.length) break;

    // Must start on a plausible doc-type
    final ch = raw[drop].toUpperCase();
    if (!docTypeSet.contains(ch)) continue;

    // Strip only newlines; keep every other character intact
    String s = raw.substring(drop).replaceAll('\r', '').replaceAll('\n', '');
    if (s.length < 90) continue;

    // First 90 chars only (strict TD1)
    s = s.substring(0, 90);
    final l1 = s.substring(0, 30);
    final l2 = s.substring(30, 60);
    final l3 = s.substring(60, 90);

    // Heuristics:
    // 1) First line must contain at least one digit (TD1 has document number on L1).
    if (!_hasDigit(l1)) continue;

    // 2) Third line should contain the MRZ name separator.
    if (!l3.contains('<<')) continue;

    // Looks like TD1
    return [l1, l2, l3];
  }

  // Could not validate TD1 without dropping >2 chars
  return [];
}

bool _hasDigit(String s) {
  for (int i = 0; i < s.length; i++) {
    final c = s.codeUnitAt(i);
    if (c >= 0x30 && c <= 0x39) return true; // '0'..'9'
  }
  return false;
}


// =================== NORMALIZATION HELPERS ===================

/// Keep raw line breaks if present; sanitize per line.
/// Allowed MRZ chars: A–Z, 0–9, '<'
List<String> _normalizeAndSplitLines(String raw) {
  // Split by any newline-like whitespace first.
  final rawLines = raw.split(RegExp(r'[\r\n]+')).where((s) => s.trim().isNotEmpty).toList();
  if (rawLines.isEmpty) return [];

  return rawLines.map(_sanitizeMrz).where((s) => s.isNotEmpty).toList();
}

/// Sanitizes a string into MRZ-safe chars ONLY (A–Z, 0–9, '<'), uppercase.
String _sanitizeMrz(String s) {
  final upper = s.toUpperCase();
  final b = StringBuffer();
  for (final r in upper.runes) {
    final ch = String.fromCharCode(r);
    final c = ch.codeUnitAt(0);
    final isAZ = c >= 0x41 && c <= 0x5A;
    final is09 = c >= 0x30 && c <= 0x39;
    if (isAZ || is09 || ch == '<') b.write(ch);
  }
  return b.toString();
}

/// If the first line has a known extra leading '0' (length = expected+1), strip it.
/// Handles TD3/MRV-A (44), TD2/MRV-B (36), TD1 (30).
List<String> _fixLeadingZeroOnFirstLine(List<String> lines) {
  if (lines.isEmpty) return lines;

  int? expectedFirstLen;
  if (lines.length == 2) {
    // Could be 2x44 (TD3/MRV-A) or 2x36 (TD2/MRV-B)
    if (lines[1].length == 44 || lines[0].length == 44) {
      expectedFirstLen = 44;
    } else if (lines[1].length == 36 || lines[0].length == 36) {
      expectedFirstLen = 36;
    }
  } else if (lines.length == 3) {
    expectedFirstLen = 30; // TD1
  }

  if (expectedFirstLen != null &&
      lines[0].length == expectedFirstLen + 1 &&
      lines[0].startsWith('0')) {
    final fixed0 = lines[0].substring(1);
    final copy = List<String>.from(lines);
    copy[0] = fixed0;
    return copy;
  }

  return lines;
}

/// If we have a flat sanitized string (no newlines), try to reconstruct likely shapes.
List<String> _reconstructFromFlat(String s) {
  // Prefer TD3/MRV-A (2x44) from end (common when leading junk was present).
  if (s.length >= 88) {
    final last88 = s.substring(s.length - 88);
    return [last88.substring(0, 44), last88.substring(44, 88)];
  }
  // TD2/MRV-B (2x36)
  if (s.length >= 72) {
    final last72 = s.substring(s.length - 72);
    return [last72.substring(0, 36), last72.substring(36, 72)];
  }
  // TD1 (3x30)
  if (s.length >= 90) {
    final last90 = s.substring(s.length - 90);
    return [
      last90.substring(0, 30),
      last90.substring(30, 60),
      last90.substring(60, 90),
    ];
  }

  // Exact lengths
  if (s.length == 88) return [s.substring(0, 44), s.substring(44, 88)];
  if (s.length == 72) return [s.substring(0, 36), s.substring(36, 72)];
  if (s.length == 90) return [s.substring(0, 30), s.substring(30, 60), s.substring(60, 90)];

  // Unknown
  return [s];
}

// =================== SHAPE DISPATCH & PARSERS ===================

DocumentDetail _parseByShapeOrFallback(List<String> lines) {
  if (lines.length == 2) {
    final l1 = lines[0], l2 = lines[1];

    // TD3 / MRV-A: 2 × 44
    if (l1.length == 44 && l2.length == 44) {
      return _parseTD3(l1, l2);
    }
    // TD2 / MRV-B: 2 × 36
    if (l1.length == 36 && l2.length == 36) {
      return _parseTD2(l1, l2);
    }
  } else if (lines.length == 3) {
    final l1 = lines[0], l2 = lines[1], l3 = lines[2];
    // TD1: 3 × 30
    if (l1.length == 30 && l2.length == 30 && l3.length == 30) {
      return _parseTD1(l1, l2, l3);
    }
  }

  // Could be raw with minor corruption: try to trim a single leading '0' on first line then re-check.
  final alt = _fixLeadingZeroOnFirstLine(lines);
  if (alt != lines) return _parseByShapeOrFallback(alt);

  // Fallback: just attach MRZ text.
  return DocumentDetail(mrz: lines.join('\n'));
}

/// TD3 / MRV-A (2×44). Works for Passports 'P<' and Visas 'V<' in 2x44 layout.
DocumentDetail _parseTD3(String l1, String l2) {
  log("_parseTD3");

  final docCode = l1.substring(0, 2);           // 'P<' or 'V<'
  final issuing = l1.substring(2, 5);
  final namesField = l1.substring(5);

  final documentNumber = l2.substring(0, 9).replaceAll('<', '');
  final nationality = l2.substring(10, 13);
  final birthYYMMDD = l2.substring(13, 19);
  final sex = l2.substring(20, 21).replaceAll('<', '');
  final expiryYYMMDD = l2.substring(21, 27);

  return DocumentDetail(
    documentNumber: _nz(documentNumber),
    fullName: _nz(_fullNameFromNamesField(namesField)),
    documentIssueCountry: BasicClass.getLocationWithCode(issuing),
    nationality: BasicClass.getLocationWithCode(nationality),
    birthDate: _parseMrzDate(birthYYMMDD),
    documentExpiryDate: parseMrzExpiryDate(expiryYYMMDD),
    sex: _nz(sex),
    shortType: _shortTypeFromDocCode(docCode), // 'P' (passport) or 'V' (visa)
    docCode: docCode,
    mrz: '$l1\n$l2',
  );
}

/// TD2 / MRV-B (2×36)
DocumentDetail _parseTD2(String l1, String l2) {
  log("_parseTD2");
  final docCode = l1.substring(0, 2);          // 'I<', 'V<', 'P<', etc.
  final issuing = l1.substring(2, 5);
  final namesField = l1.substring(5, 36);

  final documentNumber = l2.substring(0, 9).replaceAll('<', '');
  final nationality = l2.substring(10, 13);
  final birthYYMMDD = l2.substring(13, 19);
  final sex = l2.substring(20, 21).replaceAll('<', '');
  final expiryYYMMDD = l2.substring(21, 27);

  return DocumentDetail(
    documentNumber: _nz(documentNumber),
    fullName: _nz(_fullNameFromNamesField(namesField)),
    documentIssueCountry: BasicClass.getLocationWithCode(issuing),
    nationality: BasicClass.getLocationWithCode(nationality),
    birthDate: _parseMrzDate(birthYYMMDD),
    documentExpiryDate: parseMrzExpiryDate(expiryYYMMDD),
    sex: _nz(sex),
    shortType: _shortTypeFromDocCode(docCode),
    docCode: docCode,
    mrz: '$l1\n$l2',
  );
}

/// TD1 (3×30)
/// TD1 (3×30) — set docCode from the *first char only* and read name from last line.
DocumentDetail _parseTD1(String l1, String l2, String l3) {
  final shortType = l1.substring(0, 1);          // "I"
  final docCode   = shortType;                   // per your rule: just "I"
  final issuing   = l1.substring(2, 5);          // e.g., "FRA"
  final docNum    = l1.substring(5, 14).replaceAll('<', '');

  final birthYYMMDD   = l2.substring(0, 6);
  final birthCheck    = l2.substring(6, 7);      // unused here
  final sex           = l2.substring(7, 8).replaceAll('<', '');
  final expiryYYMMDD  = l2.substring(8, 14);     // <-- correct slice
  final expiryCheck   = l2.substring(14, 15);    // unused here
  final nationality   = l2.substring(15, 18);

  final namesField = l3.substring(0, 30);
  final fullName   = _fullNameFromNamesField(namesField);

  return DocumentDetail(
    documentNumber: _nz(docNum),
    fullName: _nz(fullName),
    documentIssueCountry: BasicClass.getLocationWithCode(issuing),
    nationality: BasicClass.getLocationWithCode(nationality),
    birthDate: _parseMrzDate(birthYYMMDD),
    documentExpiryDate: parseMrzExpiryDate(expiryYYMMDD),
    sex: _nz(sex),
    shortType: shortType,
    docCode: docCode,
    mrz: '$l1\n$l2\n$l3',
  );
}



// ========================= HELPERS =========================

String _fullNameFromNamesField(String field) {
  final parts = field.split('<<');
  final surname = parts.isNotEmpty ? parts.first.replaceAll('<', ' ').trim() : '';
  final given = parts.length > 1 ? parts[1].replaceAll('<', ' ').trim() : '';
  return [surname, given].where((s) => s.isNotEmpty).join(' ');
}

String? _shortTypeFromDocCode(String docCode) {
  if (docCode.isEmpty) return null;
  return docCode[0]; // 'P', 'V', 'I', …
}

/// YYMMDD → DateTime with a practical century rule:
/// 00..24 => 2000..2024, 25..99 => 1925..1999
DateTime? _parseMrzDate(String yymmdd) {
  if (yymmdd.length != 6 || yymmdd.contains('<')) return null;
  final yy = int.tryParse(yymmdd.substring(0, 2));
  final mm = int.tryParse(yymmdd.substring(2, 4));
  final dd = int.tryParse(yymmdd.substring(4, 6));
  if (yy == null || mm == null || dd == null) return null;
  final century = (yy <= 24) ? 2000 : 1900;
  try {
    return DateTime(century + yy, mm, dd);
  } catch (_) {
    return null;
  }
}

String? _nz(String s) => s.isEmpty ? null : s;


/// Parses MRZ date (YYMMDD) as a birth date:
/// - Valid window: now-120y .. now
/// - Chooses the candidate in range; if both are in range, picks the one closer to "now"
DateTime? parseMrzBirthDate(String yymmdd, {DateTime? now}) {
  return _parseMrzDateWindowed(
    yymmdd,
    now: now??DateTime.now(),
    min: _yearsAgo(120, now: now),
    max: (now ?? DateTime.now()),
    preferFuture: false, // never prefer future for birth
  );
}

/// Parses MRZ date (YYMMDD) as an expiry date:
/// - Valid window: now-20y .. now+20y
/// - Prefers future dates (>= now) if both candidates are valid
DateTime? parseMrzExpiryDate(String yymmdd, {DateTime? now}) {
  final n = now ?? DateTime.now();
  return _parseMrzDateWindowed(
    yymmdd,
    now: n,
    min: _yearsAgo(20, now: n),
    max: _yearsFromNow(20, now: n),
    preferFuture: true, // lean to future for expiry
  );
}

/// -------------- Internals --------------

DateTime? _parseMrzDateWindowed(
    String yymmdd, {
      required DateTime min,
      required DateTime max,
      required DateTime now,
      required bool preferFuture,
    }) {
  if (yymmdd.length != 6 || yymmdd.contains('<')) return null;

  final yy = int.tryParse(yymmdd.substring(0, 2));
  final mm = int.tryParse(yymmdd.substring(2, 4));
  final dd = int.tryParse(yymmdd.substring(4, 6));
  if (yy == null || mm == null || dd == null) return null;

  // Build two century candidates: 19yy and 20yy
  final cand1900 = _safeDate(1900 + yy, mm, dd);
  final cand2000 = _safeDate(2000 + yy, mm, dd);

  DateTime? best;

  bool inRange(DateTime d) => !d.isBefore(min) && !d.isAfter(max);

  final c1Valid = cand1900 != null && inRange(cand1900);
  final c2Valid = cand2000 != null && inRange(cand2000);

  if (c1Valid && !c2Valid) return cand1900;
  if (!c1Valid && c2Valid) return cand2000;

  if (c1Valid && c2Valid) {
    // Both in range: choose by preference
    final c1IsFuture = !cand1900!.isBefore(now);
    final c2IsFuture = !cand2000!.isBefore(now);

    if (preferFuture) {
      if (c2IsFuture && !c1IsFuture) return cand2000;
      if (c1IsFuture && !c2IsFuture) return cand1900;
    } else {
      if (!c1IsFuture && c2IsFuture) return cand1900;
      if (!c2IsFuture && c1IsFuture) return cand2000;
    }

    // Otherwise, pick the closer to now
    final d1 = (cand1900.difference(now)).abs();
    final d2 = (cand2000.difference(now)).abs();
    best = d1 <= d2 ? cand1900 : cand2000;
    return best;
  }

  // Neither candidate in window → null
  return null;
}

DateTime? _safeDate(int y, int m, int d) {
  // Reject impossible month/day early
  if (m < 1 || m > 12 || d < 1 || d > 31) return null;
  try {
    final dt = DateTime(y, m, d);
    // Guard against overflow like 2025-02-30 rolling into March
    if (dt.year == y && dt.month == m && dt.day == d) return dt;
  } catch (_) {}
  return null;
}

DateTime _yearsAgo(int years, {DateTime? now}) {
  final n = now ?? DateTime.now();
  return DateTime(n.year - years, n.month, n.day);
}

DateTime _yearsFromNow(int years, {DateTime? now}) {
  final n = now ?? DateTime.now();
  return DateTime(n.year + years, n.month, n.day);
}


