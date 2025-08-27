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
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../home/home_state.dart';

class MrzReaderController extends ControllerInterface {
  final _log = Logger('MrzReaderController');
  bool popping = false;

  void docImproving(OcrMrzResult res){
    OcrMrzSetting setting = ref.read(ocrMrzSettingProvider);
    OcrMrzResult? current = ref.read(improvingMrzResultProvider);

    log("docImproving ${current == null}");
    if(current == null){
      ref.read(improvingMrzResultProvider.notifier).update((s)=>res);
      log("setting improvingMrzResultProvider");
    }else{
      log("not setting improvingMrzResultProvider current not null");
    }
    if(res.matchSetting(setting)){
      onDocScan(res);
      return;
    }
    if(current!=null && current.matchSetting(setting)){
      onDocScan(current);
      return;
    }
    if(current == null){
      ref.read(improvingMrzResultProvider.notifier).update((s)=>res);
    }else{
      if(res.valid.personalNumberValid){
        current.personalNumber = res.personalNumber;
        current.valid.personalNumberValid = true;
        // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
      }
      if(res.valid.nationalityValid){
        current.nationality = res.nationality;
        current.valid.nationalityValid = true;
        // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
      }
      if(res.valid.nameValid){
        current.firstName = res.firstName;
        current.lastName = res.lastName;
        current.valid.nameValid = true;
        // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
      }
      if(res.valid.linesLengthValid){
        current.line1 = res.line1;
        current.line2 = res.line2;
        current.line3 = res.line3;
        current.valid.linesLengthValid = true;
        // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
      }
      if(res.valid.finalCheckValid){
        current.valid.finalCheckValid = true;
        // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
      }
      if(res.valid.expiryDateValid){
        current.expiryDate = res.expiryDate;
        current.valid.expiryDateValid = true;
        // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
      }
      if(res.valid.docNumberValid){
        current.documentNumber = res.documentNumber;
        current.valid.docNumberValid = true;
        // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
      }
      if(res.valid.countryValid){
        current.countryCode = res.countryCode;
        current.valid.countryValid = true;
        // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
      }
      if(res.valid.birthDateValid){
        current.birthDate = res.birthDate;
        current.valid.birthDateValid = true;
        // ref.read(improvingMrzResultProvider.notifier).update((s)=>current);
      }
      if(current.matchSetting(setting)){
        onDocScan(current);
      }
    }
  }

  void onDocScan(OcrMrzResult res) {
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
    if(l.rawMrzLines.isEmpty){


      return;
    }
    l.extractedData["improving"] = ref.read(improvingMrzResultProvider)?.toJson();
    final current = ref.read(ocrMrzLogsProvider);

    if (current.length == 60) {
      sendLogs(current);
      ref.read(ocrMrzLogsProvider.notifier).update((s) => [l]);
    } else {
      ref.read(ocrMrzLogsProvider.notifier).update((s) => [...current, l]);
    }
    log("logs count ${current.length}");


  }


  Future<void> sendLogs(List<OcrMrzLog> current) async {
    void msg;
    SendLogsUseCase sendLogsUseCase = SendLogsUseCase();
    SendLogsRequest sendLogsRequest = SendLogsRequest(current: current,improving: ref.read(improvingMrzResultProvider));
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

  void submitCurrent(OcrMrzResult improving) {

    onDocScan(improving);
  }
}
