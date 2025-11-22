import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
import 'package:abds/screens/offline_scanner/dialog/confirm_offline_scanned_doc_dialog.dart';
import 'package:abds/screens/offline_scanner/dialog/set_timer_dialog.dart';
import 'package:abds/widgets/MyDatePicker.dart';
import 'package:dartx/dartx.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:logging/logging.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import 'package:ocr_mrz/ocr_mrz.dart';
import '../../core/classes/constant_data_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/utils_and_services/timatic/src/models/document_request.dart';
import '../../core/utils_and_services/timatic/src/models/enums.dart';
import '../../widgets/MyFieldPicker.dart';
import 'offline_scanner_state.dart';

class OfflineScannerController extends ControllerInterface {
  final _log = Logger('OfflineScannerController');
  bool scanning = true;
  OcrMrzController ocrMrzController = OcrMrzController();
  VersionedData? constData = VersionedData.offline();

  Future<void> onFoundMrz(OcrMrzResult res) async {
    // if (!scanning) {


    // if (isSame(ref.read(confirmingOfflineDocProvider), res)) {
    //   return;
    // }
    // }


    if(ref.read(offlineScannedDocsProvider).any((d)=>isSame(d, res))){
      // if(ref.read(offlineScannedDocsProvider).length!=1) {
      //   FailureHandler.handle(ValidationFailure(code: -1, msg: "Duplicated Doc", traceMsg: "Duplicated Doc"));
      // }
      return;
    }
    if(res.documentCode.startsWith("P") && ref.read(offlineScannedDocsProvider).isNotEmpty){
      reset();
    }
    constData ??= VersionedData.offline();

    log("found mrz result");
    scanning = false;

    res.nationality = res.nationality;
    res.countryCode = res.countryCode;
    final nationality = constData!.getLocationWithCode(res.nationality);
    final issueCountry = constData!.getLocationWithCode(res.countryCode);
    String short= res.documentCode.startsWith("P")?"P":res.documentCode.startsWith("V")?"V":"I";

    DocumentDetail documentDetail = DocumentDetail(
      shortType: short,
      documentExpiryDate: res.expiryDate,
      documentIssueCountry: issueCountry,
      documentCode: null,
      fullName: "${res.firstName} ${res.lastName}",
      documentNumber: res.documentNumber,
      nationality: nationality,
      documentFeature: DocumentFeature.mrd,
      mrz: res.mrzLines.join("\n"),
      birthDate: res.birthDate,
      ocrText: res.ocrData.text,
      sex: res.sex,
      docCode: res.documentCode,
      verifiedDocNum: false,
    );

    // if (!navigation.isDialogOpen) {
      ref.read(confirmingOfflineDocProvider.notifier).update((s) => documentDetail);
      // Future.delayed(Duration(milliseconds: ref.read(confirmingTimerProvider)),(){
      // Future.delayed(Duration(milliseconds: 500000),(){
      //
      // });


    //   navigation.openBottomSheet(bottomSheet: ConfirmOfflineScannedDocDialog()).then((a) {
    //
    //     scanning = true;
    //   });
    // } else {
    //
    //   ref.read(confirmingOfflineDocProvider.notifier).update((s) => documentDetail);
    // }

    log(jsonEncode(documentDetail.toJson()));
  }

  onDoneConfirming(){
    if(ref.read(offlineScannedDocsProvider).any((a)=>isSame2(a, ref.read(confirmingOfflineDocProvider)))){
    }else{
      ref.read(offlineScannedDocsProvider.notifier).update((s) => [...s, ref.read(confirmingOfflineDocProvider)!]);
    }
    ref.read(confirmingOfflineDocProvider.notifier).update((s)=>null);
  }

  bool isSame(DocumentDetail? res, OcrMrzResult? res2){
    if(res == null || res2 == null){
      return false;
    }
    return res.docCode == res2.documentCode && res.documentExpiryDate?.format_yyMMdd == res2.expiryDate?.format_yyMMdd && res.birthDate?.format_yyMMdd == res2.birthDate?.format_yyMMdd && res.documentNumber == res2.documentNumber;
  }
  bool isSame2(DocumentDetail? res, DocumentDetail? res2){
    if(res == null || res2 == null){
      return false;
    }
    return res.documentCode == res2.documentCode && res.documentExpiryDate?.format_yyMMdd == res2.documentExpiryDate?.format_yyMMdd && res.birthDate?.format_yyMMdd == res2.birthDate?.format_yyMMdd && res.documentNumber == res2.documentNumber;
  }

  void reset() {
    ocrMrzController.resetSession();
    ref.read(offlineScannedDocsProvider.notifier).update((s) => []);
    ref.read(confirmingOfflineDocProvider.notifier).update((s) => null);
  }

  void setTimer() {
    int current = ref.read(confirmingTimerProvider);
    navigation.openDialog(dialog: SetTimerDialog(current: current)).then((a){
      if(a is int){
        ref.read(confirmingTimerProvider.notifier).update((s)=>a);
      }
    });
  }
}
