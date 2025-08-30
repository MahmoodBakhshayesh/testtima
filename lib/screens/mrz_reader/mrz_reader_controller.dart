import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/utils_and_services/ext/mrz_ext.dart';
import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/screens/mrz_reader/usecases/send_logs_usecase.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:logging/logging.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:ocr_mrz/orc_mrz_log_class.dart';
import '../../core/classes/basic_class.dart';
import '../../core/classes/mrz_agg_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../home/home_state.dart';

class MrzReaderController extends ControllerInterface {
  final _log = Logger('MrzReaderController');
  bool popping = false;
  final agg = OcrMrzAggregator();

  void docImproving(OcrMrzResult scanned) {
    log(scanned.toString());
    log("scanned.toString()");

    OcrMrzSetting setting = ref.read(ocrMrzSettingProvider);

    agg.add(scanned); // only validated fields contribute
    final consensus = agg.build();
    // log(jsonEncode(consensus.toJson(includeHistograms: true)));
    final res = consensus.toResult();
    ref.read(improvingMrzResultProvider.notifier).update((s) => consensus);
    if (res.matchSetting(setting)) {
      onDocScan(res);
    } else {}
    return;
    //
    // // log('Doc No -> ${consensus.documentNumber} (count: ${consensus.documentNumberStat.consensusCount})');
    // // log('Country -> ${consensus.countryCode} (hist: ${consensus.countryCodeStat.histogram})');
    // // log('Birth   -> ${consensus.birthDate} (hist: ${consensus.birthDateStat.histogram})');
    //
    // // return;
    // try {
    //   log(res.valid.toString());
    //   // return;
    //   OcrMrzResult? current = ref.read(improvingMrzResultProvider);
    //
    //   // log("docImproving ${current == null}");
    //   if (current == null) {
    //     ref.read(improvingMrzResultProvider.notifier).update((s) => res);
    //     // log("setting improvingMrzResultProvider");
    //   } else {
    //     // log("not setting improvingMrzResultProvider current not null");
    //   }
    //   if (res.matchSetting(setting)) {
    //     // onDocScan(res);
    //     // return;
    //   }
    //   if (current != null && current.matchSetting(setting)) {
    //     // onDocScan(current);
    //     // return;
    //   }
    //   if (current == null) {
    //     ref.read(improvingMrzResultProvider.notifier).update((s) => res);
    //     log(res.valid.toString());
    //     if (res.valid.nationalityValid) {
    //       log("valid nationalityValid -> ${res.nationality}");
    //     }
    //     if (res.valid.countryValid) {
    //       log("valid countryValid -> ${res.countryCode}");
    //     }
    //     if (res.valid.expiryDateValid) {
    //       log("valid expiryDate -> ${res.expiryDate}");
    //     }
    //     if (res.valid.birthDateValid) {
    //       log("valid birthDateValid -> ${res.birthDate}");
    //     }
    //     if (res.valid.docNumberValid) {
    //       log("valid docNumberValid -> ${res.documentNumber}");
    //     }
    //   } else {
    //     if (res.valid.personalNumberValid && !current.valid.personalNumberValid) {
    //       log("${'✅' * 10} valid persionality -> ${res.passportNumber} ");
    //       current.personalNumber = res.personalNumber;
    //       current.valid.personalNumberValid = true;
    //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
    //     }
    //     if (res.valid.nationalityValid && !current.valid.nationalityValid) {
    //       log("${'✅' * 10} valid nationalityValid -> ${res.nationality}");
    //       current.nationality = res.nationality;
    //       current.valid.nationalityValid = true;
    //
    //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
    //     }
    //     if (res.valid.nameValid && !current.valid.nameValid) {
    //       log("${'✅' * 10} valid nameValid -> ${res.firstName} ${res.lastName}");
    //
    //       current.firstName = res.firstName;
    //       current.lastName = res.lastName;
    //       current.valid.nameValid = true;
    //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
    //     }
    //     if (res.valid.linesLengthValid && !current.valid.linesLengthValid) {
    //       log("${'✅' * 10} valid linesLengthValid -> ");
    //
    //       current.line1 = res.line1;
    //       current.line2 = res.line2;
    //       current.line3 = res.line3;
    //       current.valid.linesLengthValid = true;
    //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
    //     }
    //     if (res.valid.finalCheckValid && !current.valid.finalCheckValid) {
    //       log("${'✅' * 10} valid finalCheckValid -> ");
    //
    //       current.valid.finalCheckValid = true;
    //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
    //     }
    //     if (res.valid.expiryDateValid && !current.valid.expiryDateValid) {
    //       log("${'✅' * 10} valid expiryDateValid -> ${res.expiryDate}");
    //       current.expiryDate = res.expiryDate;
    //       current.valid.expiryDateValid = true;
    //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
    //     }
    //     if (res.valid.docNumberValid && !current.valid.docNumberValid) {
    //       log("${'✅' * 10} valid docNumberValid -> ${res.documentNumber}");
    //
    //       current.documentNumber = res.documentNumber;
    //       current.valid.docNumberValid = true;
    //
    //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
    //     }
    //     if (res.valid.countryValid && !current.valid.countryValid) {
    //       log("${'✅' * 10} valid countryValid -> ${res.countryCode}");
    //
    //       current.countryCode = res.countryCode;
    //       current.valid.countryValid = true;
    //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
    //     }
    //     if (res.valid.birthDateValid && !current.valid.birthDateValid) {
    //       log("${'✅' * 10} valid birthDateValid -> ${res.birthDate}");
    //
    //       current.birthDate = res.birthDate;
    //       current.valid.birthDateValid = true;
    //       // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
    //     }
    //     ref.read(improvingMrzResultProvider.notifier).update((s) => OcrMrzResult.fromJson(current.toJson()));
    //     if (current.matchSetting(setting)) {
    //       onDocScan(current);
    //     }
    //   }
    // }catch(e){
    //   if(e is Error){
    //     log("${e.stackTrace}");
    //   }
    // }
  }

  void onDocScan(OcrMrzResult res) {
    // return;
    try {
      if (popping) return;

      // if(!(res.isPassport || res.isVisa)){

      //   return;
      // }
      popping = true;
      ParameterValue? docType;
      if (res.isPassport) {
        docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "PASSPORT");
      } else if (res.isVisa) {
        docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "VVV");
      } else {
        docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "TRAVELCERTIFICATE");
      }

      res.nationality = res.nationality;
      res.countryCode = res.countryCode;
      final nationality = BasicClass.getLocationWithCode(res.nationality);
      final issueCountry = BasicClass.getLocationWithCode(res.countryCode);

      log("res.nationality ${res.nationality}");
      log("res.countryCode ${res.countryCode}");

      DocumentDetail documentDetail = DocumentDetail(
        documentExpiryDate: res.expiryDate,
        documentIssueCountry: issueCountry,
        documentCode: docType,
        fullName: "${res.firstName} ${res.lastName}",
        documentNumber: res.documentNumber,
        nationality: nationality,
        documentFeature: DocumentFeature.mrd,
        mrz: res.mrzLines.join("\n"),
        birthDate: res.birthDate,
      );

      final gender = Gender.values.firstWhereOrNull((a) => a.title.startsWith(res.sex));
      if (res.isPassport) {
        int emptyIndex = ref.read(passportsProvider).indexWhere((s) => s.isEmpty);
        if (emptyIndex == -1) {
          if (ref.read(passportsProvider).isEmpty) {
            ref.read(passportsProvider.notifier).add(documentDetail);
          } else {
            int lastIndex = ref.read(passportsProvider).length - 1;
            ref.read(passportsProvider.notifier).updateAt(lastIndex, documentDetail);
          }
        } else {
          ref.read(passportsProvider.notifier).updateAt(emptyIndex, documentDetail);
        }
      } else {
        int emptyIndex = ref.read(visasProvider).indexWhere((s) => s.isEmpty);
        if (emptyIndex == -1) {
          ref.read(visasProvider.notifier).add(documentDetail);
        } else {
          ref.read(visasProvider.notifier).updateAt(emptyIndex, documentDetail);
        }
      }

      PassengerDetails passengerDetails = PassengerDetails(nationality: nationality, gender: gender, birthDate: res.birthDate, birthCountry: nationality);
      ref.read(passengerProvider.notifier).update((s) => passengerDetails);

      navigation.pop();
    } catch (e) {
      if (e is Error) {
        log(e.stackTrace.toString());
      }
      // FailureHandler.handle(ServerFailure(code: -1, msg: e.toString(), traceMsg: ""));
    }
  }

  void mrzLogger(OcrMrzLog l) {
    // return;
    if (l.rawMrzLines.isEmpty) {
      return;
    }
    log(l.validation.toString());
    log(l.fixedMrzLines.join("\n"));
    l.extractedData["improving"] = ref.read(improvingMrzResultProvider)?.toJson();
    final current = ref.read(ocrMrzLogsProvider);

    if (current.length == 60) {
      sendLogs(current);
      ref.read(ocrMrzLogsProvider.notifier).update((s) => [l]);
    } else {
      ref.read(ocrMrzLogsProvider.notifier).update((s) => [...current, l]);
    }
    // log("logs count ${current.length}");
  }

  Future<void> sendLogs(List<OcrMrzLog> current) async {
    void msg;
    SendLogsUseCase sendLogsUseCase = SendLogsUseCase();
    SendLogsRequest sendLogsRequest = SendLogsRequest(current: current, consensus: agg.build());
    final result = await sendLogsUseCase(request: sendLogsRequest);

    switch (result) {
      case Err<SendLogsResponse>():
      // FailureHandler.handle(result.error);

      case Ok<SendLogsResponse>():
        log("logs sent");
      // final r = result.value;
    }

    return msg;
  }

  void submitCurrent(OcrMrzConsensus improving) {
    onDocScan(improving.toResult());
  }
}
