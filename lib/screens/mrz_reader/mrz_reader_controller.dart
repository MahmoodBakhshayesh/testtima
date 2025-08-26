import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:logging/logging.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import '../../core/classes/basic_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../home/home_state.dart';

class MrzReaderController extends ControllerInterface {
  final _log = Logger('MrzReaderController');
  bool popping = false;

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
        birthDate: res.birthDate
      );

      final gender = Gender.values.firstWhereOrNull((a) => a.title.startsWith(res.sex));
      if (res.isPassport) {
        int emptyIndex = ref.read(passportsProvider).indexWhere((s) => s.isEmpty);
        if (emptyIndex == -1) {
          if(ref.read(passportsProvider).isEmpty){
            ref.read(passportsProvider.notifier).add(documentDetail);
          }else{
            int lastIndex = ref.read(passportsProvider).length-1;
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
}
