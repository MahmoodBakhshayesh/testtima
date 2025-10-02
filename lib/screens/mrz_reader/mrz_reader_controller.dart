import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/core/extenstions/mrz_res_ext.dart';
import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/uploader.dart';
import 'package:abds/core/utils_and_services/ext/mrz_ext.dart';
import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
import 'package:abds/core/utils_and_services/stateControllers/residents_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/screens/mrz_reader/usecases/send_logs_usecase.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:ocr_mrz/aggregator.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import 'package:ocr_mrz/ocr_mrz.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:ocr_mrz/orc_mrz_log_class.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/classes/basic_class.dart';
import '../../core/classes/constant_data_class.dart';
import '../../core/classes/mrz_agg_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/type_converto.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../home/home_state.dart';
import '../login/login_state.dart';
import 'dialogs/confirm_server_mrz_result_dialog.dart';
import 'dialogs/session_log_history_dialog.dart';
import 'dialogs/support_warning_dialog.dart';

class MrzReaderController extends ControllerInterface {
  final _log = Logger('MrzReaderController');
  bool popping = false;
  bool scanning = true;
  final ocrMrzController = OcrMrzController();

  // void docImproving(OcrMrzResult scanned) {
  //   // log("doc imprving");
  //   // try {
  //   //   OcrMrzLog l = OcrMrzLog(rawText: scanned.ocrData.text,
  //   //       rawMrzLines: scanned.mrzLines,
  //   //       fixedMrzLines: scanned.mrzLines,
  //   //       validation: scanned.valid,
  //   //       extractedData: scanned.toJson());
  //   //   ref.read(lastFrameLogProvider.notifier).update((s) => l);
  //   //   log("updating last frame");
  //   // }catch(e){
  //   //   log("$e");
  //   // }
  //
  //   if (!scanning) {
  //     return;
  //   }
  //
  //   // if(scanned.valid.docCodeValid) {
  //   //   log(jsonEncode(scanned.valid.toString()));
  //   //   log(jsonEncode(scanned.toJson()));
  //   //   log("scanned.toString()");
  //   // }
  //
  //   OcrMrzSetting setting = ref.read(ocrMrzSettingProvider);
  //   // if(scanned.line2.isEmpty){
  //   //   return;
  //   // }
  //
  //   if (setting.algorithm == ParseAlgorithm.method1 || setting.algorithm == ParseAlgorithm.method2) {
  //     agg.add(scanned); // only validated fields contribute
  //     final consensus = agg.build();
  //     final res = consensus.toResult();
  //     res.ocrData = scanned.ocrData;
  //
  //     ref.read(improvingMrzResultProvider.notifier).update((s) => consensus);
  //     if (ref.read(ocrMrzSettingProvider).algorithm != ParseAlgorithm.method3) {
  //       if (res.matchSetting(setting)) {
  //         onDocScan(res);
  //       }
  //     }
  //   } else if (setting.algorithm == ParseAlgorithm.method2) {
  //     if (ref.read(ocrMrzSettingProvider).algorithm != ParseAlgorithm.method3) {
  //       if (scanned.matchSetting(setting)) {
  //         onDocScan(scanned);
  //       }
  //     }
  //   }
  //
  //   return;
  //   //
  //   // // log('Doc No -> ${consensus.documentNumber} (count: ${consensus.documentNumberStat.consensusCount})');
  //   // // log('Country -> ${consensus.countryCode} (hist: ${consensus.countryCodeStat.histogram})');
  //   // // log('Birth   -> ${consensus.birthDate} (hist: ${consensus.birthDateStat.histogram})');
  //   //
  //   // // return;
  //   // try {
  //   //   log(res.valid.toString());
  //   //   // return;
  //   //   OcrMrzResult? current = ref.read(improvingMrzResultProvider);
  //   //
  //   //   // log("docImproving ${current == null}");
  //   //   if (current == null) {
  //   //     ref.read(improvingMrzResultProvider.notifier).update((s) => res);
  //   //     // log("setting improvingMrzResultProvider");
  //   //   } else {
  //   //     // log("not setting improvingMrzResultProvider current not null");
  //   //   }
  //   //   if (res.matchSetting(setting)) {
  //   //     // onDocScan(res);
  //   //     // return;
  //   //   }
  //   //   if (current != null && current.matchSetting(setting)) {
  //   //     // onDocScan(current);
  //   //     // return;
  //   //   }
  //   //   if (current == null) {
  //   //     ref.read(improvingMrzResultProvider.notifier).update((s) => res);
  //   //     log(res.valid.toString());
  //   //     if (res.valid.nationalityValid) {
  //   //       log("valid nationalityValid -> ${res.nationality}");
  //   //     }
  //   //     if (res.valid.countryValid) {
  //   //       log("valid countryValid -> ${res.countryCode}");
  //   //     }
  //   //     if (res.valid.expiryDateValid) {
  //   //       log("valid expiryDate -> ${res.expiryDate}");
  //   //     }
  //   //     if (res.valid.birthDateValid) {
  //   //       log("valid birthDateValid -> ${res.birthDate}");
  //   //     }
  //   //     if (res.valid.docNumberValid) {
  //   //       log("valid docNumberValid -> ${res.documentNumber}");
  //   //     }
  //   //   } else {
  //   //     if (res.valid.personalNumberValid && !current.valid.personalNumberValid) {
  //   //       log("${'✅' * 10} valid persionality -> ${res.passportNumber} ");
  //   //       current.personalNumber = res.personalNumber;
  //   //       current.valid.personalNumberValid = true;
  //   //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
  //   //     }
  //   //     if (res.valid.nationalityValid && !current.valid.nationalityValid) {
  //   //       log("${'✅' * 10} valid nationalityValid -> ${res.nationality}");
  //   //       current.nationality = res.nationality;
  //   //       current.valid.nationalityValid = true;
  //   //
  //   //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
  //   //     }
  //   //     if (res.valid.nameValid && !current.valid.nameValid) {
  //   //       log("${'✅' * 10} valid nameValid -> ${res.firstName} ${res.lastName}");
  //   //
  //   //       current.firstName = res.firstName;
  //   //       current.lastName = res.lastName;
  //   //       current.valid.nameValid = true;
  //   //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
  //   //     }
  //   //     if (res.valid.linesLengthValid && !current.valid.linesLengthValid) {
  //   //       log("${'✅' * 10} valid linesLengthValid -> ");
  //   //
  //   //       current.line1 = res.line1;
  //   //       current.line2 = res.line2;
  //   //       current.line3 = res.line3;
  //   //       current.valid.linesLengthValid = true;
  //   //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
  //   //     }
  //   //     if (res.valid.finalCheckValid && !current.valid.finalCheckValid) {
  //   //       log("${'✅' * 10} valid finalCheckValid -> ");
  //   //
  //   //       current.valid.finalCheckValid = true;
  //   //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
  //   //     }
  //   //     if (res.valid.expiryDateValid && !current.valid.expiryDateValid) {
  //   //       log("${'✅' * 10} valid expiryDateValid -> ${res.expiryDate}");
  //   //       current.expiryDate = res.expiryDate;
  //   //       current.valid.expiryDateValid = true;
  //   //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
  //   //     }
  //   //     if (res.valid.docNumberValid && !current.valid.docNumberValid) {
  //   //       log("${'✅' * 10} valid docNumberValid -> ${res.documentNumber}");
  //   //
  //   //       current.documentNumber = res.documentNumber;
  //   //       current.valid.docNumberValid = true;
  //   //
  //   //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
  //   //     }
  //   //     if (res.valid.countryValid && !current.valid.countryValid) {
  //   //       log("${'✅' * 10} valid countryValid -> ${res.countryCode}");
  //   //
  //   //       current.countryCode = res.countryCode;
  //   //       current.valid.countryValid = true;
  //   //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
  //   //     }
  //   //     if (res.valid.birthDateValid && !current.valid.birthDateValid) {
  //   //       log("${'✅' * 10} valid birthDateValid -> ${res.birthDate}");
  //   //
  //   //       current.birthDate = res.birthDate;
  //   //       current.valid.birthDateValid = true;
  //   //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
  //   //     }
  //   //     ref.read(improvingMrzResultProvider.notifier).update((s) => OcrMrzResult.fromJson(current.toJson()));
  //   //     if (current.matchSetting(setting)) {
  //   //       onDocScan(current);
  //   //     }
  //   //   }
  //   // }catch(e){
  //   //   if(e is Error){
  //   //     log("${e.stackTrace}");
  //   //   }
  //   // }
  // }

  void onReceivedConsensus(OcrMrzConsensus consensus) {
    OcrMrzSetting setting = ref.read(ocrMrzSettingProvider);
    // if(scanned.line2.isEmpty){
    //   return;
    // }

    final res = consensus.toResult();
    bool verified = false;
    List<String> passNumbers = ref.read(passportsProvider).map((a) => a.documentNumber ?? '').where((a) => a.isNotEmpty).toList();
    verified = passNumbers.any((a) => ocrMrzController.getAggregator.sessionScannedData(a));
    if (setting.algorithm == ParseAlgorithm.method1 || setting.algorithm == ParseAlgorithm.method2) {
      // if(ocrMrzController.getAggregator.sessionScannedData(data))
      // res.ocrData = scanned.ocrData;

      ref.read(improvingMrzResultProvider.notifier).update((s) => consensus);
      if (ref.read(ocrMrzSettingProvider).algorithm != ParseAlgorithm.method3) {
        if (res.matchSetting(setting)) {
          onDocScan(res, verified: verified);
        }
      }
    } else if (setting.algorithm == ParseAlgorithm.method2) {
      if (ref.read(ocrMrzSettingProvider).algorithm != ParseAlgorithm.method3) {
        if (consensus.toResult().matchSetting(setting)) {
          onDocScan(consensus.toResult(), verified: verified);
        }
      }
    }

    return;
  }

  void onDocScan(OcrMrzResult res, {bool verified = false}) {
    // return;
    try {
      if (popping) return;

      // if(!(res.isPassport || res.isVisa)){

      //   return;
      // }
      popping = true;
      DocumentCode? docType;
      // log("*"*100);
      // log(jsonEncode(res.toJson()));
      // log("*"*100);

      // docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == mapMrzDocCodeToTimatic(res.documentCode));
      DocumentDetailType? suggest;
      if (BasicClass.constData.data.documentDetailType.isNotEmpty && res.countryCode.length > 1) {
        final match = BasicClass.constData.data.documentDetailType.lastOrNullWhere(
          // (a) => a.type == res.documentCode.characters.first && (a.subType == "*" || a.subType == res.documentCode.characters.last) && (a.country == "*" || a.country == res.countryCode),
          // (a) => a.type == res.documentCode.characters.first && (a.subType == res.documentCode.characters.last || (res.documentCode.characters.last == "<" && a.subType=="*")) && (a.country == "*" || a.country == res.countryCode),
          // (a) => a.type == res.documentCode.characters.first && (a.subType == res.documentCode.characters.last || (res.documentCode.characters.last == "<" && a.subType=="*")) && ( a.country == res.countryCode),
          (a) => a.type == res.documentCode.characters.first && (a.subType == res.documentCode.characters.last) && ( a.country == res.countryCode),
        );
        suggest = BasicClass.constData.data.documentDetailType.lastOrNullWhere(
          (a) => a.type == res.documentCode.characters.first && (a.subType == "*" || a.subType == res.documentCode.characters.last) && (a.country == "*" || a.country == res.countryCode),
          // (a) => a.type == res.documentCode.characters.first && (a.subType == res.documentCode.characters.last || (res.documentCode.characters.last == "<" && a.subType=="*")) && (a.country == "*" || a.country == res.countryCode),
          // (a) => a.type == res.documentCode.characters.first && (a.subType == res.documentCode.characters.last || (res.documentCode.characters.last == "<" && a.subType=="*")) && ( a.country == res.countryCode),
        );

        if (match != null) {
          docType = BasicClass.constData.data.documentCode.firstWhereOrNull((a) => a.code.toUpperCase() == match.code);
        } else {
          log("no mapper match for ${res.documentCode} should type be ${res.documentCode.characters.first} and subtype be ${res.documentCode.characters.last} || ${res.documentCode.characters.last == "<"}");
        }
      } else {
        log("BasicClass.constData.documentTypeMappers is empty");
      }

      log("setting doctype of ${res.documentCode} to ${docType?.code}");
      // docType = mapMrzDocCodeToTimatic()
      // if (res.isPassport) {
      //   // docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "PASSPORT");
      //   if (res.documentCode == "PO") {
      //     // docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "OFFICIALPASSPORT") ?? docType;
      //   }
      //   if (res.documentCode == "PS") {
      //     // docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "SPECIALPASSPORT") ?? docType;
      //   }
      //   if (res.documentCode == "PD") {
      //     // docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "DIPLOMATICPASSPORT") ?? docType;
      //   }
      // } else if (res.isVisa) {
      //   // docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "VVV");
      // } else {
      //   // docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "TRAVELCERTIFICATE");
      // }

      res.nationality = res.nationality;
      res.countryCode = res.countryCode;
      final nationality = BasicClass.getLocationWithCode(res.nationality);
      final issueCountry = BasicClass.getLocationWithCode(res.countryCode);

      // log("res.nationality ${res.nationality}");
      // log("res.countryCode ${res.countryCode}");

      DocumentDetail documentDetail = DocumentDetail(
        shortType: res.getShortType,
        documentExpiryDate: res.expiryDate,
        documentIssueCountry: issueCountry,
        documentCode: docType,
        fullName: "${res.firstName} ${res.lastName}",
        documentNumber: res.documentNumber,
        nationality: nationality,
        documentFeature: DocumentFeature.mrd,
        mrz: res.mrzLines.join("\n"),
        birthDate: res.birthDate,
        ocrText: res.ocrData.text,
        sex: res.sex,
        docCode: res.documentCode,
        verifiedDocNum: verified,
        suggestionCodes: suggest== null?[]:[suggest.code]
      );

      log("*" * 100);
      log(documentDetail.documentCode?.code ?? '--');
      log(docType?.code ?? '--');
      log("*" * 100);

      final gender = Gender.values.firstWhereOrNull((a) => a.title.startsWith(res.sex));

      if (ref.read(passportsProvider).any((a) => a.isSameAs(res)) || ref.read(visasProvider).any((a) => a.isSameAs(res)) || ref.read(residentsProvider).any((a) => a.isSameAs(res))) {
        log("was isSameAs");
        navigation.pop();
        Future.delayed(Duration(seconds: 1), () {
          FailureHandler.handle(ServerFailure(code: -1, msg: 'Duplicate Document', traceMsg: 'Duplicate Document'));
        });
        return;
      } else {
        log("was isSameAs  => not ${res.documentNumber} vs ${ref.read(passportsProvider).map((a) => a.documentNumber)}");
      }

      log("setting confirm ${documentDetail.toJson()}");
      ref.read(confirmingDocumentProvider.notifier).update((s) => documentDetail);

      // if (res.isPassport) {
      //
      //   int emptyIndex = ref.read(passportsProvider).indexWhere((s) => s.isEmpty);
      //   if (emptyIndex == -1) {
      //     if (ref.read(passportsProvider).isEmpty) {
      //       ref.read(passportsProvider.notifier).add(documentDetail);
      //     } else {
      //       int lastIndex = ref.read(passportsProvider).length - 1;
      //       ref.read(passportsProvider.notifier).updateAt(lastIndex, documentDetail);
      //     }
      //   } else {
      //     ref.read(passportsProvider.notifier).updateAt(emptyIndex, documentDetail);
      //   }
      // } else if (res.isVisa) {
      //   int emptyIndex = ref.read(visasProvider).indexWhere((s) => s.isEmpty);
      //   if (emptyIndex == -1) {
      //     ref.read(visasProvider.notifier).add(documentDetail);
      //   } else {
      //     ref.read(visasProvider.notifier).updateAt(emptyIndex, documentDetail);
      //   }
      // } else {
      //   int emptyIndex = ref.read(residentsProvider).indexWhere((s) => s.isEmpty);
      //   if (emptyIndex == -1) {
      //     ref.read(residentsProvider.notifier).add(documentDetail);
      //   } else {
      //     ref.read(residentsProvider.notifier).updateAt(emptyIndex, documentDetail);
      //   }
      // }

      // final currentPax = ref.read(passengerProvider);
      // PassengerDetails passengerDetails = PassengerDetails(
      //   nationality: currentPax.nationality ?? nationality,
      //   gender: gender,
      //   birthDate: res.birthDate,
      //   birthCountry: currentPax.birthCountry,
      //   residentCountryCode: currentPax.residentCountryCode,
      // );
      //
      // if (res.documentCode.startsWith("C") || res.documentCode.startsWith("I")) {
      //   passengerDetails = passengerDetails.copyWith(residentCountryCode: issueCountry);
      // }
      // ref.read(passengerProvider.notifier).update((s) => passengerDetails);

      final current = ref.read(ocrMrzLogsProvider);
      sendLogs(current, confirm: false);

      navigation.pop();
    } catch (e) {
      if (e is Error) {
        log(e.stackTrace.toString());
      }
      // FailureHandler.handle(ServerFailure(code: -1, msg: e.toString(), traceMsg: ""));
    }
  }

  void mrzLogger(OcrMrzLog l) {
    // log("logger");
    if (!scanning) {
      return;
    }
    // return;
    // ref.read(lastFrameLogProvider.notifier).update((s)=>l);
    // if (!l.rawText.contains("<")) {
    //   return;
    // }

    // log("logs count ==> mrzLogger");
    // log(l.validation.toString());
    // log(l.fixedMrzLines.join("\n"));
    l.extractedData["improving"] = ref.read(improvingMrzResultProvider)?.toJson();
    final current = ref.read(ocrMrzLogsProvider);
    // final uniqs = current.map((a)=>a.rawMrzLines.join("\n")).toSet().toList();
    if (current.length == 60) {
      sendLogs(current);
      ref.read(ocrMrzLogsProvider.notifier).update((s) => [l]);
    } else {
      ref.read(ocrMrzLogsProvider.notifier).update((s) => [...current, l]);
    }
    // log("logs count ${current.length}");
  }

  Future<void> sendLogs(List<OcrMrzLog> current, {bool confirm = true}) async {
    void msg;
    String? base64;
    SendLogsUseCase sendLogsUseCase = SendLogsUseCase();
    SendLogsRequest sendLogsRequest = SendLogsRequest(current: current, consensus: ref.read(improvingMrzResultProvider), base64: base64, setting: ref.read(ocrMrzSettingProvider));
    if (ref.read(supportModeProvider)) {
      final imgPath = await ocrMrzController.takePicture();
      if (imgPath != null) {
        // File f = File(imgPath);
        // final newP = await getTemporaryDirectory();
        // final com = await testCompressAndGetFile(f, "${newP.path}/comp.jpg");
        // log("file size = ${f.lengthSync()}--> ${await com?.length()}");
        // if(com!=null){
        //   sendLogs2(com.path);
        // }
        log("send logs2 =>$imgPath");
        sendLogs2(imgPath, sendLogsRequest);
      }
    } else {
      log("send logs =>");
      final fOrR = await sendLogsUseCase(request: sendLogsRequest);

      switch (fOrR) {
        case Err<SendLogsResponse>():
          // fOrR.error;
          log("logs sent error ${fOrR.error.msg}");
        // log("logs sent error ${fOrR.error.runtimeType}");
        // if (fOrR.error is ServerFailure) {
        //   final a = fOrR.error as ServerFailure;
        //   if (a.data is Map<String, dynamic> && (a.data as Map<String, dynamic>).containsKey("type")) {
        //     ServerMrzResult serverMrzResult = ServerMrzResult.fromJson(a.data);
        //     if (confirm) {
        //       askForServerResult(serverMrzResult);
        //     }
        //   }
        // }
        // FailureHandler.handle(result.error);

        case Ok<SendLogsResponse>():
          final r = fOrR.value;
          // final r = fOrR.value;
          // log("logs sent");
          // log("${r.result?.toJson()}");
          if (confirm && r.result != null && ref.read(ocrMrzSettingProvider).algorithm == ParseAlgorithm.method3) {
            askForServerResult(r.result!);
          }
        // final r = result.value;
      }
    }
    return msg;
  }

  void submitCurrent(OcrMrzConsensus improving) {
    onDocScan(improving.toResult());
  }

  Future<void> sendLogs2(String path, SendLogsRequest sendLogsRequest) async {
    final fileName = path.split('/').last;
    File f = File(path);
    String url = "${ref.watch(selectedServerProvider).apiAddress}/mrzlog2";
    final u = Uri.parse(url);
    Uploader().uploadImagesWithLog(url: u, images: [f], log: sendLogsRequest.toJson(), headers: {"Authorization": "Bearer ${ref.read(userProvider)!.token}"});
    return;

    // final formData = FormData.fromMap({
    //   'images': [await MultipartFile.fromFile(
    //     path,
    //     filename: fileName,
    //     contentType: MediaType('image', 'jpg'), // Or 'image', 'webp', etc.
    //   )],
    //   'log': jsonEncode(agg.build().toJson(includeHistograms: true))
    // });
    // log("sending logs 2 ${path}");
    // log("*"*100);
    // log();
    // log(jsonEncode(agg.build().toJson(includeHistograms: true)));
    // final serverAddress = ref.watch(selectedServerProvider)!.apiAddress;
    //
    // String apiAddress = "$serverAddress/mrzlogs2";
    // // log(apiAddress);
    // try {
    //   final dio = Dio(BaseOptions(receiveTimeout: Duration(minutes: 10),sendTimeout: Duration(minutes: 10),connectTimeout: Duration(minutes: 10)));
    //   final response = await dio.put(
    //     apiAddress,
    //     data: formData,
    //     options: Options(headers: {'Content-Type': 'multipart/form-data', "Authorization": "Bearer ${ref.read(userProvider)!.token}"}),
    //   );
    //
    //   if (response.statusCode == 200) {
    //     log('log success: ');
    //   }
    // } catch (e) {
    //   log('log failed: $e');
    //   // FailureHandler.handle(ServerFailure(code: -1, msg: e.toString(), traceMsg:  e.toString()));
    //
    // }
  }

  Future<XFile?> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath, quality: 50, rotate: 0);

    return result;
  }

  askForServerResult(ServerMrzResult result) {
    if (popping) {
      return;
    }
    scanning = false;
    navigation.openDialog(dialog: ConfirmServerMrzResultDialog(result: result)).then((confirm) {
      scanning = true;
      if (confirm is OcrMrzResult) {
        onDocScan(confirm);
      }
    });
  }

  void showMrzSessionLog() {
    final sg = ocrMrzController.getSessionHistory.value;
    navigation.openDialog(dialog: SessionLogHistoryDialog(sl: sg));
  }

  void askActiveSupport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SupportWarningDialog();
      },
      isScrollControlled: true,
    );
  }
}
