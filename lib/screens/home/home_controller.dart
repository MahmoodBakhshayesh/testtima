import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:abds/core/utils_and_services/stateControllers/residents_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/src/models/converters.dart';
import 'package:abds/screens/home/dialogs/ask_ref_code_dialog.dart';
import 'package:abds/screens/home/dialogs/ask_supervisor_dialog.dart';
import 'package:abds/screens/home/dialogs/confirm_scanned_doc_dialog.dart';
import 'package:abds/screens/home/usecases/get_ref_code_log_usecase.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/users/users_controller.dart';
import 'package:dio/dio.dart';
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
    // ref.read(visasProvider.notifier).removeAll();
    // ref.read(residentsProvider.notifier).removeAll();
    ref.read(segmentsProvider.notifier).removeAll();

    ref.read(showWarningsProvider.notifier).update((s) => true);
    ref.read(passNumberInVisaProvider.notifier).update((s) => false);
    ref.read(attachingPhotoPathProvider.notifier).update((s) => []);
    ref.read(showingLogsProvider.notifier).update((s) => []);
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
            } else {
              ref.read(confirmingDocumentProvider.notifier).update((s) => null);
            }
          });
        });
      }
    });
  }

  addConfirmingDocument() {
    final doc = ref.read(confirmingDocumentProvider)!;
    // if (doc.isPassport) {
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
    // } else if (doc.isVisa) {
    //   int emptyIndex = ref.read(visasProvider).indexWhere((s) => s.isEmpty);
    //   if (emptyIndex == -1) {
    //     ref.read(visasProvider.notifier).add(doc);
    //   } else {
    //     ref.read(visasProvider.notifier).updateAt(emptyIndex, doc);
    //   }
    // } else {
    //   int emptyIndex = ref.read(residentsProvider).indexWhere((s) => s.isEmpty);
    //   if (emptyIndex == -1) {
    //     ref.read(residentsProvider.notifier).add(doc);
    //   } else {
    //     ref.read(residentsProvider.notifier).updateAt(emptyIndex, doc);
    //   }
    // }
    ref.read(confirmingDocumentProvider.notifier).update((s) => null);
  }

  selectPhotoToAttach(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    final XFile? pic = await picker.pickImage(source: source, imageQuality: 30);
    if (pic != null) {
      // Uint8List fileBytes = await pic.readAsBytes();
      String path = pic.path;
      // ref.read(attachingPhotoProvider.notifier).update((s) => [...s, fileBytes]);
      ref.read(attachingPhotoPathProvider.notifier).update((s) => [...s, path]);
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
        fillWithRefHistory(r.history, code);
    }

    return historyLog;
  }

  fillWithRefHistory(RefHistory his, String code) {
    final timaticReqLog = (his.logs ?? []).firstWhereOrNull((a) => (a.type ?? '') == ("timaticCheck"));
    final showingLogs = (his.logs ?? []).where((a) => (a.type ?? '') == ("note")).toList();
    ref.read(showingLogsProvider.notifier).update((s) => showingLogs);
    if (timaticReqLog != null) {
      final tim = BasicClass.timData;
      Map<String, dynamic> input = jsonDecode(timaticReqLog.payload?.input ?? "{}");
      Map<String, dynamic> output = jsonDecode(timaticReqLog.payload?.output ?? "{}");

      PassengerDetails pd = PassengerDetails(
        birthDate: DateTime.tryParse(input["passengerDetails"]["birthDate"] ?? ''),
        nationality: tim.locations.of(LocationType.country).firstWhereOrNull((a) => a.code3 == input["passengerDetails"]["nationality"]),
        birthCountry: tim.locations.of(LocationType.country).firstWhereOrNull((a) => a.code3 == input["passengerDetails"]["birthCountry"]),
        residentCountryCode: tim.locations.of(LocationType.country).firstWhereOrNull((a) => a.code3 == input["passengerDetails"]["residentCountryCode"]),
        gender: GenderDetails.fromValue(input["passengerDetails"]['gender']?.toString()),
      );
      final allDocs = List<DocumentDetail>.from(
        (input["documentDetails"] ?? []).map(
          (d) => DocumentDetail(
            documentCode: tim.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code == d["documentCode"]),
            documentNumber: d["documentNumber"],
            fullName: d["fullName"],
            documentExpiryDate: DateTime.tryParse(d["documentExpiryDate"] ?? ''),
            birthDate: DateTime.tryParse(d["birthDate"] ?? ''),
            documentIssueDate: DateTime.tryParse(d["documentIssueDate"] ?? ''),
            documentIssueCountry: tim.locations.of(LocationType.country).firstWhereOrNull((a) => a.code3 == d["documentIssueCountry"]),
            nationality: tim.locations.of(LocationType.country).firstWhereOrNull((a) => a.code3 == d["nationality"]),
          ),
        ),
      );
      final passes = allDocs;
      // final passes = allDocs.where((a) => (a.documentCode?.code ?? '').contains("PASS")).toList();
      // final visas = allDocs.where((a) => (a.documentCode?.code ?? '').contains("V")).toList();
      // final residents = allDocs.where((a) => !(a.documentCode?.code ?? '').contains("PASS") && !(a.documentCode?.code ?? '').contains("V")).toList();
      final allSegs = List<ItinerarySegment>.from((input["itineraryDetails"]['segments']).map((s) => ItinerarySegment(departure: ItinPoint.fromJson(s["departure"]), arrival: ItinPoint.fromJson(s["arrival"]))));

      ref.read(passportsProvider.notifier).setAll(passes);
      // ref.read(visasProvider.notifier).setAll(visas);
      // ref.read(residentsProvider.notifier).setAll(residents);
      ref.read(segmentsProvider.notifier).setAll(allSegs);
      ref.read(passengerProvider.notifier).update((s) => pd);

      output["refCode"] = code;
      DocumentResponse result = DocumentResponse.fromJson(output);

      ref.read(timaticResultProvider.notifier).update((s) => result);
    }
  }

  askSuperVisorDialog() {
    ref.read(attachingPhotoPathProvider.notifier).update((s) => []);
    navigation.openDialog(dialog: AskSupervisorDialog(logId: ref.read(timaticResultProvider)?.refCode ?? ''));
  }

  Future<bool> uploadDataForSupervision(String? noteType, String desc, String logId) async {
    bool result = false;
    final dio = Dio();

    // Example file path (replace with actual file picker path)

    // Text data (can also be a JSON string)
    final textData = "your text or json here";
    List<String> images = ref.read(attachingPhotoPathProvider);
    final imageFiles = await Future.wait(images.map((path) async => await MultipartFile.fromFile(path, filename: path.split('/').last)));
    final formData = FormData.fromMap({
      "images": imageFiles, // multiple images
      "data": jsonEncode({"logNoteType": noteType, "description": desc}),
    });
    String api = "${ref.read(selectedServerProvider).apiAddress}/logs/$logId";

    try {
      final response = await dio.post(
        api,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data", "Authorization": "Bearer ${ref.read(userProvider)!.token}"}),
      );
      if (response.statusCode == 200) {
        result = true;
        ref.read(attachingPhotoPathProvider.notifier).update((s) => []);
      } else {
        FailureHandler.handle(ServerFailure(code: response.statusCode ?? -1, msg: response.statusMessage ?? 'Unknown Error', traceMsg: response.statusMessage ?? 'Unknown Error'));
      }
      log("Response: ${response.data}");
      return result;
    } catch (e) {
      log("Error: $e");
      FailureHandler.handle(ServerFailure(code: -1, msg: "$e", traceMsg: "$e"));
      return false;
    }
  }

  // UseCase UseCase = UseCase(repository: Repository());
}
