import 'dart:developer';

import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:logging/logging.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import '../../core/classes/basic_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../home/home_state.dart';

class MrzReaderController extends ControllerInterface {
  final _log = Logger('MrzReaderController');
  bool popping = false;

  void onDocScan(OcrMrzResult res) {
    if (popping) return;
    popping = true;
    ParameterValue? docType;
    if (res.isPassport) {
      docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "PASSPORT");
    } else if (res.isVisa) {
      docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "V");
    } else {
      docType = BasicClass.timData.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code.toUpperCase() == "TRAVELCERTIFICATE");
    }

    final nationality = BasicClass.getLocationWithCode(res.nationality);
    final issueCountry = BasicClass.getLocationWithCode(res.countryCode);

    log("nationallity ${nationality?.code3} - ${res.nationality};");
    log("issueCountry ${issueCountry?.code3} - ${res.countryCode};");
    DocumentDetail documentDetail = DocumentDetail(
      documentExpiryDate: res.expiryDate,
      documentIssueCountry: issueCountry,
      documentCode: docType, fullName: "${res.firstName} ${res.lastName}", documentNumber: res.documentNumber, nationality: nationality,);



    final gender = Gender.values.firstWhereOrNull((a)=>a.title.startsWith(res.sex));
    PassengerDetails passengerDetails = PassengerDetails(
      nationality: nationality,
      gender: gender,
      birthDate: res.birthDate,
      birthCountry: nationality
    );
    if(res.isPassport){
      ref.read(passportsProvider.notifier).update((s)=>[documentDetail]);
    }else{
      ref.read(visasProvider.notifier).update((s)=>[documentDetail]);
    }

    ref.read(passengerProvider.notifier).update((s)=>passengerDetails);

    navigation.pop();
  }
}
