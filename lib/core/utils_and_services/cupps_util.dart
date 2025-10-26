import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/interface_implementations/shared_preferences_imp.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
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
          setStatus(CuppsPlatformStatus.connectingToDevices);
          final deviceConnection = await CUPPS.connectToAvailableNeededDevices();
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

    String ocD = data.map((e) => e.toString()).toList().join();
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
        return "Disconnected";
      default:
        return 'Connect';
    }
  }


}

/// ======================= PUBLIC ENTRY =======================

DocumentDetail parseMrzToDocumentDetail(String raw) {
  final cleaned = _sanitizeMrz(raw);
  final lines = _reconstructMrzLines(cleaned);

  // TD3: 2 × 44 (passports)
  if (lines.length == 2 && lines[0].length == 44 && lines[1].length == 44) {
    return _parseTD3(lines[0], lines[1]);
  }

  // TD2: 2 × 36 (some ID cards / visas)
  if (lines.length == 2 && lines[0].length == 36 && lines[1].length == 36) {
    return _parseTD2(lines[0], lines[1]);
  }

  // TD1: 3 × 30 (most ID cards)
  if (lines.length == 3 && lines[0].length == 30 && lines[1].length == 30 && lines[2].length == 30) {
    return _parseTD1(lines[0], lines[1], lines[2]);
  }

  // Fallback: unknown form; still return sanitized MRZ
  return DocumentDetail(mrz: lines.join('\n'));
}

/// =================== SANITIZE & RECONSTRUCT ===================

/// Keep only allowed MRZ characters (A–Z, 0–9, '<'), uppercase.
String _sanitizeMrz(String raw) {
  final upper = raw.toUpperCase();
  final buf = StringBuffer();
  for (final r in upper.runes) {
    final ch = String.fromCharCode(r);
    final c = ch.codeUnitAt(0);
    final isAZ = c >= 0x41 && c <= 0x5A;
    final is09 = c >= 0x30 && c <= 0x39;
    if (isAZ || is09 || ch == '<') buf.write(ch);
  }
  return buf.toString();
}

/// Try to split a flat string into TD3/TD2/TD1 lines; tolerate leading/trailing junk.
/// Preference order: TD3, then TD2, then TD1.
List<String> _reconstructMrzLines(String s) {
  // If exact or longer, try from the end (common when junk prefixes MRZ).
  if (s.length >= 88) {
    final last88 = s.substring(s.length - 88);
    if (last88.length == 88) return [last88.substring(0, 44), last88.substring(44, 88)];
  }
  if (s.length >= 72) {
    final last72 = s.substring(s.length - 72);
    if (last72.length == 72) return [last72.substring(0, 36), last72.substring(36, 72)];
  }
  if (s.length >= 90) {
    final last90 = s.substring(s.length - 90);
    if (last90.length == 90) {
      return [last90.substring(0, 30), last90.substring(30, 60), last90.substring(60, 90)];
    }
  }

  // If it happens to be exactly the right lengths:
  if (s.length == 88) return [s.substring(0, 44), s.substring(44, 88)];
  if (s.length == 72) return [s.substring(0, 36), s.substring(36, 72)];
  if (s.length == 90) return [s.substring(0, 30), s.substring(30, 60), s.substring(60, 90)];

  // Give up and return as a single "line".
  return [s];
}

/// ========================= TD3 (2×44) =========================
/// ICAO 9303 TD3 (passports)
DocumentDetail _parseTD3(String l1, String l2) {
  final docCode = l1.substring(0, 2); // e.g., 'P<'
  final issuing = l1.substring(2, 5); // e.g., 'BRA'
  final namesField = l1.substring(5); // SURNAME<<GIVEN<NAMES

  final documentNumber = l2.substring(0, 9).replaceAll('<', '');
  // l2[9] check digit
  final nationality = l2.substring(10, 13); // e.g., 'BRA'
  final birthYYMMDD = l2.substring(13, 19);
  // l2[19] check digit
  final sex = l2.substring(20, 21).replaceAll('<', '');
  final expiryYYMMDD = l2.substring(21, 27);
  // l2[27] check digit
  // l2[28..42] optional
  // l2[43] final check digit

  final fullName = _fullNameFromNamesField(namesField);
  final birthDate = _parseMrzDate(birthYYMMDD);
  final expiryDate = _parseMrzDate(expiryYYMMDD);

  return DocumentDetail(
    documentNumber: _nz(documentNumber),
    fullName: _nz(fullName),
    documentIssueCountry: BasicClass.getLocationWithCode(issuing),
    nationality: BasicClass.getLocationWithCode(nationality),
    birthDate: birthDate,
    documentExpiryDate: expiryDate,
    sex: _nz(sex),
    shortType: _shortTypeFromDocCode(docCode),
    docCode: docCode,
    mrz: '$l1\n$l2',
  );
}

/// ========================= TD2 (2×36) =========================
/// ICAO 9303 TD2 (ID/visas)
DocumentDetail _parseTD2(String l1, String l2) {
  final docCode = l1.substring(0, 2); // e.g., 'I<', 'V<', 'P<'
  final issuing = l1.substring(2, 5); // e.g., 'IRN'
  final namesField = l1.substring(5, 36); // SURNAME<<GIVEN<NAMES

  final documentNumber = l2.substring(0, 9).replaceAll('<', '');
  // l2[9] check digit
  final nationality = l2.substring(10, 13);
  final birthYYMMDD = l2.substring(13, 19);
  // l2[19] check
  final sex = l2.substring(20, 21).replaceAll('<', '');
  final expiryYYMMDD = l2.substring(21, 27);
  // l2[27] check
  // l2[28..35] optional + final check at [35] (varies; we ignore checks here)

  final fullName = _fullNameFromNamesField(namesField);
  final birthDate = _parseMrzDate(birthYYMMDD);
  final expiryDate = _parseMrzDate(expiryYYMMDD);

  return DocumentDetail(
    documentNumber: _nz(documentNumber),
    fullName: _nz(fullName),
    documentIssueCountry: BasicClass.getLocationWithCode(issuing),
    nationality: BasicClass.getLocationWithCode(nationality),
    birthDate: birthDate,
    documentExpiryDate: expiryDate,
    sex: _nz(sex),
    shortType: _shortTypeFromDocCode(docCode),
    docCode: docCode,
    mrz: '$l1\n$l2',
  );
}

/// ========================= TD1 (3×30) =========================
/// ICAO 9303 TD1 (most ID cards)
DocumentDetail _parseTD1(String l1, String l2, String l3) {
  // Line 1
  final docCode = l1.substring(0, 2); // e.g., 'I<'
  final issuing = l1.substring(2, 5); // e.g., 'DEU'
  final docNumRaw = l1.substring(5, 14); // 9 chars
  final docNum = docNumRaw.replaceAll('<', '');
  // l1[14] check
  // l1[15..29] optional

  // Line 2
  final birthYYMMDD = l2.substring(0, 6);
  // l2[6] check
  final expiryYYMMDD = l2.substring(7, 13);
  // l2[13] check
  final nationality = l2.substring(14, 17);
  // l2[17..29] optional

  // Line 3
  final namesField = l3.substring(0, 30); // SURNAME<<GIVEN<NAMES

  final fullName = _fullNameFromNamesField(namesField);
  final birthDate = _parseMrzDate(birthYYMMDD);
  final expiryDate = _parseMrzDate(expiryYYMMDD);

  return DocumentDetail(
    documentNumber: _nz(docNum),
    fullName: _nz(fullName),
    documentIssueCountry: BasicClass.getLocationWithCode(issuing),
    nationality: BasicClass.getLocationWithCode(nationality),
    birthDate: birthDate,
    documentExpiryDate: expiryDate,
    shortType: _shortTypeFromDocCode(docCode),
    docCode: docCode,
    mrz: '$l1\n$l2\n$l3',
  );
}

/// ========================= HELPERS =========================

/// Convert "SURNAME<<GIVEN<NAMES" -> "SURNAME GIVEN NAMES"
String _fullNameFromNamesField(String field) {
  final parts = field.split('<<');
  final surname = parts.isNotEmpty ? parts.first.replaceAll('<', ' ').trim() : '';
  final given = parts.length > 1 ? parts[1].replaceAll('<', ' ').trim() : '';
  return [surname, given].where((s) => s.isNotEmpty).join(' ');
}

/// Map first char of doc code to short type ("P", "V", "I", etc.)
String? _shortTypeFromDocCode(String docCode) {
  if (docCode.isEmpty) return null;
  return docCode[0]; // 'P' from 'P<', 'I' from 'I<', etc.
}

/// Parse YYMMDD to DateTime with century inference:
/// 00..24 => 2000..2024, 25..99 => 1925..1999 (adjust if you prefer a rolling window)
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

/// Null-if-empty helper
String? _nz(String s) => s.isEmpty ? null : s;
