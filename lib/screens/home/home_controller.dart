import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:abds/core/utils_and_services/stateControllers/residents_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/screens/home/dialogs/ask_ref_code_dialog.dart';
import 'package:abds/screens/home/dialogs/confirm_scanned_doc_dialog.dart';
import 'package:abds/screens/home/usecases/get_ref_code_log_usecase.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/classes/basic_class.dart';
import '../../core/classes/ref_history_log_class.dart';
import '../../core/interfaces/controller_int.dart';
import 'package:logging/logging.dart';

import '../../core/interfaces/result_int.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../initialize.dart';
import '../../widgets/MyFieldPicker.dart';
import '../mrz_reader/mrz_reader_state.dart';
import 'dialogs/image_pick_method_select_sheet.dart';
import 'home_state.dart';

class HomeController extends ControllerInterface {
  final _log = Logger('HomeController');
  late TimaticApi timaticApi = getIt<TimaticApi>();

  void clear() {
    ref.read(passengerProvider.notifier).update((s) => PassengerDetails());
    ref.read(improvingMrzResultProvider.notifier).update((s) => null);
    // ref.read(visasProvider.notifier).update((s) => [DocumentDetail()]);
    ref.read(passportsProvider.notifier).removeAll();
    ref.read(visasProvider.notifier).removeAll();
    ref.read(residentsProvider.notifier).removeAll();
    ref.read(segmentsProvider.notifier).removeAll();

    ref.read(showWarningsProvider.notifier).update((s) => true);
    ref.read(passNumberInVisaProvider.notifier).update((s) => false);
    // ref.read(lastVisaOcrProvider.notifier).update((s)=>null);
    // ref.read(lastPassportOcrProvider.notifier).update((s)=>null);

    // ref.read(segmentsProvider.notifier).update((s) => [ItinerarySegment.empty()]);
  }

  Future<void> setAirportDialog(BuildContext context) async {
    final current = BasicClass.timData.locations.of(LocationType.airport).firstWhereOrNull((a) => a.code3 == ref.read(userProvider)?.profile.defaultAirport);
    final newVal = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          // This moves content above the keyboard
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: PickerSheetWidget(value: current, hasClear: false, searchAutoFocus: false, searchBuilder: null, items: BasicClass.timData.locations.of(LocationType.airport), label: "Airport", itemToWidget: null, hasSearch: true),
        );
        // return PickerSheetWidget(items: widget.items, label: widget.placeholder ?? widget.label ?? '', itemToWidget: widget.itemToWidget, hasSearch: widget.hasSearch);
      },
      elevation: 2,
    );

    if (newVal is Location) {
      log("set new to $newVal");
      await getIt<UsersController>().updateUserStation(newVal.code3);
    }
  }

  void goMrzReadr() {
    ref.read(ocrMrzLogsProvider.notifier).update((s) => []);
    ref.read(improvingMrzResultProvider.notifier).update((s) => null);
    ref.read(showDynamsoftProvider.notifier).update((s) => false);
    ref.read(confirmingDocumentProvider.notifier).update((s) => null);
    goNamed(Routes.mrzReader).then((a) {
      if (ref.read(confirmingDocumentProvider) != null) {
        Future.delayed(Duration(milliseconds: 500), () {
          navigation.openDialog(dialog: ConfirmScannedDocDialog(documentDetail: ref.read(confirmingDocumentProvider)!)).then((v) {
            if (v == true) {
              addConfirmingDocument();
            }else{
              ref.read(confirmingDocumentProvider.notifier).update((s)=>null);
            }
          });
        });
      }
    });
  }

  addConfirmingDocument() {
    final doc = ref.read(confirmingDocumentProvider)!;
    if (doc.isPassport) {
      int emptyIndex = ref.read(passportsProvider).indexWhere((s) => s.isEmpty);
      if (emptyIndex == -1) {
        if (ref.read(passportsProvider).isEmpty) {
          ref.read(passportsProvider.notifier).add(doc);
        } else {
          int lastIndex = ref.read(passportsProvider).length - 1;
          ref.read(passportsProvider.notifier).updateAt(lastIndex, doc);
        }
      } else {
        ref.read(passportsProvider.notifier).updateAt(emptyIndex, doc);
      }
    } else if (doc.isVisa) {
      int emptyIndex = ref.read(visasProvider).indexWhere((s) => s.isEmpty);
      if (emptyIndex == -1) {
        ref.read(visasProvider.notifier).add(doc);
      } else {
        ref.read(visasProvider.notifier).updateAt(emptyIndex, doc);
      }
    } else {
      int emptyIndex = ref.read(residentsProvider).indexWhere((s) => s.isEmpty);
      if (emptyIndex == -1) {
        ref.read(residentsProvider.notifier).add(doc);
      } else {
        ref.read(residentsProvider.notifier).updateAt(emptyIndex, doc);
      }
    }
    ref.read(confirmingDocumentProvider.notifier).update((s)=>null);

  }

  selectPhotoToAttach(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    final XFile? pic = await picker.pickImage(source: source);
    if (pic != null) {
      Uint8List fileBytes = await pic.readAsBytes();
      ref.read(attachingPhotoProvider.notifier).update((s) => [...s, fileBytes]);
    }
  }

  selectPhotoToAttachMethodDialog() {
    navigation.openBottomSheet(bottomSheet: ImagePickMethodSelectSheet()).then((a) {
      if (a == 1) {
        selectPhotoToAttach(ImageSource.gallery);
      }
      if (a == 2) {
        selectPhotoToAttach(ImageSource.camera);
      }
    });
  }

  Future<void> askRefCodeDialog(BuildContext context) async {
    navigation.openDialog(dialog: AskRefCodeDialog());
  }

  Future<RefHistory?> getRefHistoryLog(String code) async {
    RefHistory? historyLog;
    GetRefCodeLogUseCase getRefHistoryLogUseCase = GetRefCodeLogUseCase();
    GetRefCodeLogRequest getRefCodeLogRequest = GetRefCodeLogRequest(code: code);
    final result = await getRefHistoryLogUseCase(request: getRefCodeLogRequest);

    switch (result) {
      case Err<GetRefCodeLogResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetRefCodeLogResponse>():
        final r = result.value;
        historyLog = r.history;
        fillWithRefHistory(r.history);

    }

    return historyLog;
  }

  fillWithRefHistory(RefHistory his){
    final timaticReqLog = (his.logs??[]).firstWhereOrNull((a)=>(a.url??'').endsWith("documentRequest"));
    if(timaticReqLog != null){
      Map<String,dynamic> input = jsonDecode(jsonDecode(timaticReqLog.input??"{}")??"{}");

      PassengerDetails pd = PassengerDetails.fromJson(input["passengerDetails"]);
      final allDocs = List<DocumentDetail>.from((input["documentDetails"]??[]).map((a)=>DocumentDetail.fromJson(a)));
      final passes = allDocs.where((a)=>(a.documentCode?.code??'').contains("PASS")).toList();
      final visas = allDocs.where((a)=>(a.documentCode?.code??'').contains("V")).toList();
      final residents = allDocs.where((a)=>!(a.documentCode?.code??'').contains("PASS") && !(a.documentCode?.code??'').contains("V")).toList();
      final allSegs= List<ItinerarySegment>.from((input["itineraryDetails"]['segments']).map((a)=>ItinerarySegment.fromJson(a)));

      ref.read(passportsProvider.notifier).setAll(passes);
      ref.read(visasProvider.notifier).setAll(visas);
      ref.read(residentsProvider.notifier).setAll(residents);
      ref.read(segmentsProvider.notifier).setAll(allSegs);
      ref.read(passengerProvider.notifier).update((s)=>pd);
    }
  }

  askSuperVisorDialog(){

  }

  // UseCase UseCase = UseCase(repository: Repository());
}
