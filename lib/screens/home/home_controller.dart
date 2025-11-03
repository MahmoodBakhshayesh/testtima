import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/classes/current_status_class.dart';
import 'package:abds/core/classes/flight_history_data_class.dart';
import 'package:abds/core/classes/timatic_response_new_class.dart';
import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:abds/core/utils_and_services/stateControllers/residents_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/src/models/converters.dart';
import 'package:abds/screens/home/dialogs/ask_emploee_id_sheet.dart';
import 'package:abds/screens/home/dialogs/ask_ref_code_dialog.dart';
import 'package:abds/screens/home/dialogs/ask_supervisor_dialog.dart';
import 'package:abds/screens/home/dialogs/confirm_scanned_doc_dialog.dart';
import 'package:abds/screens/home/dialogs/manul_add_doc_sheet.dart';
import 'package:abds/screens/home/dialogs/translate_language_select_sheet.dart';
import 'package:abds/screens/home/dialogs/translated_response_dialog.dart';
import 'package:abds/screens/home/usecases/get_notif_count_usecase.dart';
import 'package:abds/screens/home/usecases/get_ref_code_log_usecase.dart';
import 'package:abds/screens/home/usecases/get_supervisors_usecase.dart';
import 'package:abds/screens/home/usecases/get_supported_language_usecased.dart';
import 'package:abds/screens/home/usecases/submit_timatic_request_usecase.dart';
import 'package:abds/screens/home/usecases/timatic_get_locations_usecase.dart';
import 'package:abds/screens/home/usecases/timatic_get_parameters_usecase.dart';
import 'package:abds/screens/home/usecases/translate_text_usecase.dart';
import 'package:abds/screens/home/usecases/translate_timatic_response_usecase.dart';
import 'package:abds/screens/home/usecases/validate_employee_id_usecase.dart';
import 'package:abds/screens/home/widgets/logs_and_attachments.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/users/users_controller.dart';
import 'package:abds/widgets/number_input_sheet.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/classes/basic_class.dart';
import '../../core/classes/ref_history_log_class.dart';
import '../../core/classes/supervisor_class.dart';
import '../../core/classes/supported_language_class.dart';
import '../../core/interfaces/controller_int.dart';
import 'package:logging/logging.dart';

import '../../core/interfaces/result_int.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils_and_services/cross_helpers/build_formdata.dart';
import '../../core/utils_and_services/cross_helpers/form_file.dart';
import '../../core/utils_and_services/cross_helpers/web_path_to_bytes.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../core/utils_and_services/timatic/src/defaults.dart';
import '../../initialize.dart';
import '../../widgets/MyFieldPicker.dart';
import '../mrz_reader/mrz_reader_state.dart';
import 'dialogs/ask_supervisor_sheet.dart';
import 'dialogs/image_pick_method_select_sheet.dart';
import 'dialogs/option_sheet_dialog.dart';
import 'home_state.dart';
import 'usecases/ask_supervisor_usecase.dart';
import 'usecases/flight_number_history_usecase.dart';
import 'usecases/set_status_response_usecase.dart';
import 'usecases/supervisor_response_usecase.dart';

class HomeController extends ControllerInterface {
  final _log = Logger('HomeController');

  // late TimaticApi timaticApi = getIt<TimaticApi>();

  void clear() {
    ref.read(currentStatusProvider.notifier).update((s) => CurrentStatus());
    ref.read(passengerProvider.notifier).update((s) => PassengerDetails());
    ref.read(improvingMrzResultProvider.notifier).update((s) => null);
    // ref.read(visasProvider.notifier).update((s) => [DocumentDetail()]);
    ref.read(passportsProvider.notifier).removeAll();
    ref.read(visasProvider.notifier).removeAll();
    ref.read(residentsProvider.notifier).removeAll();
    ref.read(segmentsProvider.notifier).resetFirst();
    // ref.read(segmentsProvider.notifier).removeAll();

    ref.read(showWarningsProvider.notifier).update((s) => true);
    ref.read(passNumberInVisaProvider.notifier).update((s) => false);
    ref.read(attachingPhotoPathProvider.notifier).update((s) => []);
    ref.read(showingLogsProvider.notifier).update((s) => []);
    ref.read(timaticResultNewProvider.notifier).update((s) => null);
    // ref.read(timaticResultProvider.notifier).update((s) => null);
    // ref.read(lastVisaOcrProvider.notifier).update((s)=>null);
    // ref.read(lastPassportOcrProvider.notifier).update((s)=>null);

    // ref.read(segmentsProvider.notifier).update((s) => [ItinerarySegment.empty()]);
  }

  // Future<void> setAirportDialog(BuildContext context) async {
  //   final current = BasicClass.constData.data.airport.firstWhereOrNull((a) => a.code3 == ref.read(userProvider)?.profile.defaultAirport);
  //   final newVal = await showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         // This moves content above the keyboard
  //         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //         child: PickerSheetWidget(value: current, hasClear: false, searchAutoFocus: false, searchBuilder: null, items: BasicClass.constData.data.airport, label: "Airport", itemToWidget: null, hasSearch: true),
  //       );
  //       // return PickerSheetWidget(items: widget.items, label: widget.placeholder ?? widget.label ?? '', itemToWidget: widget.itemToWidget, hasSearch: widget.hasSearch);
  //     },
  //     elevation: 2,
  //   );
  //
  //   if (newVal is Country) {
  //     log("set new to $newVal");
  //     await getIt<UsersController>().updateUserStation(newVal.code3);
  //   }
  // }

  void goMrzReadr() {
    ref.read(ocrMrzLogsProvider.notifier).update((s) => []);
    ref.read(improvingMrzResultProvider.notifier).update((s) => null);
    ref.read(showDynamsoftProvider.notifier).update((s) => false);
    ref.read(confirmingDocumentProvider.notifier).update((s) => null);
    goNamed(Routes.mrzReader).then((a) {
      if (ref.read(confirmingDocumentProvider) != null) {
        Future(() {
          handleConfirming(ref.read(confirmingDocumentProvider)!);
          // navigation.openDialog(dialog: ConfirmScannedDocDialog(), barrierDismissible: false).then((v) {
          //   if (v == true) {
          //     handleConfirming(ref.read(confirmingDocumentProvider)!);
          //   } else {
          //     ref.read(confirmingDocumentProvider.notifier).update((s) => null);
          //   }
          // });
        });
        // Future.delayed(Duration(milliseconds: 500), () {
        //   navigation.openDialog(dialog: ConfirmScannedDocDialog(documentDetail: ref.read(confirmingDocumentProvider)!)).then((v) {
        //     if (v == true) {
        //       addConfirmingDocument();
        //     } else {
        //       ref.read(confirmingDocumentProvider.notifier).update((s) => null);
        //     }
        //   });
        // });
      }
    });
  }

  addConfirmingDocument() {
    final doc = ref.read(confirmingDocumentProvider)!;
    if (doc.isPassport) {
      int emptyIndex = ref.read(passportsProvider).indexWhere((s) => s.isEmpty);
      if (emptyIndex == -1) {
        // if (ref.read(passportsProvider).isEmpty) {
        ref.read(passportsProvider.notifier).add(doc);
        // } else {
        //   int lastIndex = ref.read(passportsProvider).length - 1;
        //   ref.read(passportsProvider.notifier).updateAt(lastIndex, doc);
        // }
      } else {
        ref.read(passportsProvider.notifier).removeAt(emptyIndex);
        Future(() {
          ref.read(passportsProvider.notifier).add(doc);
        });
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
    final currentPax = ref.read(passengerProvider);
    final gender = Gender.values.firstWhereOrNull((a) => a.title.startsWith(doc.sex ?? ''));

    PassengerDetails passengerDetails = PassengerDetails(
      nationality: currentPax.nationality ?? doc.nationality,
      gender: gender,
      birthDate: currentPax.birthDate ?? doc.birthDate,
      birthCountry: currentPax.birthCountry,
      residentCountryCode: currentPax.residentCountryCode,
    );

    if ((doc.docCode ?? '').startsWith("C") || (doc.docCode ?? '').startsWith("I")) {
      log("we should set resident ${doc.docCode}");
      passengerDetails = passengerDetails.copyWith(residentCountryCode: doc.documentIssueCountry);
    } else {
      log("we should not set resident ${doc.docCode}");
    }
    ref.read(passengerProvider.notifier).update((s) => passengerDetails);
    ref.read(confirmingDocumentProvider.notifier).update((s) => null);
  }

  Future<String?> selectPhotoToAttach(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    try {
      final XFile? pic = await picker.pickImage(source: source, imageQuality: 30);
      log("returned");
      return pic?.path;
    }catch(e){
      log("$e");
    }
    // if (pic != null) {
    //   // Uint8List fileBytes = await pic.readAsBytes();
    //   String path = pic.path;
    //   // ref.read(attachingPhotoProvider.notifier).update((s) => [...s, fileBytes]);
    //   ref.read(attachingPhotoPathProvider.notifier).update((s) => [...s, path]);
    // }
  }

  Future<String?> selectPhotoToAttachMethodDialog() async {
    final source = await navigation.openBottomSheet(bottomSheet: ImagePickMethodSelectSheet());
    if (source == 1) {
      return selectPhotoToAttach(ImageSource.gallery);
    } else if (source == 2) {
      return selectPhotoToAttach(ImageSource.camera);
    }
    return null;
    //     .then((a) {
    //   if (a == 1) {
    //     selectPhotoToAttach(ImageSource.gallery);
    //   }
    //   if (a == 2) {
    //     selectPhotoToAttach(ImageSource.camera);
    //   }
    // });
  }

  Future<void> askRefCodeDialog(BuildContext context) async {
    navigation.openDialog(dialog: AskRefCodeDialog());
  }

  Future<RefHistory?> getRefHistoryLog({required String? code, required String? showCode}) async {
    RefHistory? historyLog;
    GetRefCodeLogUseCase getRefHistoryLogUseCase = GetRefCodeLogUseCase();
    GetRefCodeLogRequest getRefCodeLogRequest = GetRefCodeLogRequest(code: code, showCode: showCode);
    final result = await getRefHistoryLogUseCase(request: getRefCodeLogRequest);

    switch (result) {
      case Err<GetRefCodeLogResponse>():
        Future.delayed(Duration(milliseconds: 300), () {
          FailureHandler.handle(result.error);
        });
        return null;

      case Ok<GetRefCodeLogResponse>():
        final r = result.value;
        historyLog = r.history;
        ref.read(currentStatusProvider.notifier).update((s) => r.currentStatus);
        fillWithRefHistory(r.history, code, showCode);
    }

    return historyLog;
  }

  fillWithRefHistory(RefHistory his, String? code, String? showCode) {
    final timaticReqLog = (his.logs ?? []).firstWhereOrNull((a) => (a.type ?? '') == ("timaticCheck"));
    final showingLogs = (his.logs ?? []).where((a) => (a.type ?? '') != ("timaticCheck")).toList();
    ref.read(showingLogsProvider.notifier).update((s) => showingLogs);
    if (timaticReqLog != null) {
      bool locked = timaticReqLog.payload?.locked == 1;
      Map<String, dynamic> input = jsonDecode(timaticReqLog.payload?.input ?? "{}");
      Map<String, dynamic> output = jsonDecode(timaticReqLog.payload?.output ?? "{}");
      log("is Locked ==>${locked}");
      PassengerDetails pd = PassengerDetails(
        birthDate: DateTime.tryParse(input["passengerDetails"]["birthDate"] ?? ''),
        nationality: BasicClass.constData.data.country.firstWhereOrNull((a) => a.code3 == input["passengerDetails"]["nationality"]),
        birthCountry: BasicClass.constData.data.country.firstWhereOrNull((a) => a.code3 == input["passengerDetails"]["birthCountry"]),
        residentCountryCode: BasicClass.constData.data.country.firstWhereOrNull((a) => a.code3 == input["passengerDetails"]["residentCountryCode"]),
        gender: GenderDetails.fromValue(input["passengerDetails"]['gender']?.toString()),
      );

      List<DocumentDetailType> detailsMapperList = BasicClass.constData.data.documentDetailType;
      final allDocs = List<DocumentDetail>.from(
        (input["documentDetails"] ?? []).map((d) {
          DocumentDetailType? detailsMapper = detailsMapperList.lastOrNullWhere((a) => a.code == d["documentCode"]);
          log("setting docCode =    ${d["documentCode"]}${detailsMapper?.code} ${"${detailsMapper?.type ?? ''}${detailsMapper?.subType}"} ");
          return DocumentDetail(
            documentCode: BasicClass.constData.data.documentCode.firstWhereOrNull((a) => a.code == d["documentCode"]),
            docCode: "${detailsMapper?.type ?? ''}${detailsMapper?.subType}",

            // documentCode: tim.params.of(ParameterType.documentCode).firstWhereOrNull((a) => a.code == detailsMapper.firstWhereOrNull((a)=>a.code ==  d["documentCode"])?.code),
            documentNumber: d["documentNumber"],
            fullName: d["fullName"],
            documentExpiryDate: DateTime.tryParse(d["documentExpiryDate"] ?? ''),
            birthDate: DateTime.tryParse(d["birthDate"] ?? ''),
            documentIssueDate: DateTime.tryParse(d["documentIssueDate"] ?? ''),
            documentIssueCountry: BasicClass.constData.data.country.firstWhereOrNull((a) => a.code3 == d["documentIssueCountry"]),
            nationality: BasicClass.constData.data.country.firstWhereOrNull((a) => a.code3 == d["nationality"]),
          );
        }),
      );
      // final passes = allDocs;

      // final passes = allDocs.where((a) {
      //   log("*" * 20);
      //   log("${a.getMatch()?.type} ${a.docCode}");
      //   return a.getMatch()?.type == "P";
      // }).toList();
      final passes = allDocs.where((a) => a.getMatch()?.type == "P").toList();
      final visas = allDocs.where((a) => a.getMatch()?.type == "V").toList();
      final residents = allDocs.where((a) => a.getMatch()?.type == "I").toList();

      final others = allDocs.where((a) => !["V", "I", "P"].contains(a.getMatch()?.type)).toList();
      final allSegs = List<ItinerarySegment>.from(
        (input["itineraryDetails"]['segments']).map((s) {
          return ItinerarySegment.regenerateFromJson(s);
          // return ItinerarySegment(departure: ItinPoint.fromJson(s["departure"]), arrival: ItinPoint.fromJson(s["arrival"]), processingEntity: "ABOMIS DOC CHECK", operatingCarrier: BasicClass.getAirlineWithCode(code));
        }),
      );

      if (passes.isNotEmpty) {
        passes[0] = passes[0].copyWith(sex: pd.gender?.value);
      }
      ref.read(passportsProvider.notifier).setAll(passes);
      ref.read(visasProvider.notifier).setAll(visas);
      ref.read(residentsProvider.notifier).setAll(residents);
      ref.read(segmentsProvider.notifier).setAll(allSegs);
      ref.read(passengerProvider.notifier).update((s) => pd);

      ref.read(refCodeProvider.notifier).update((s) => his.refCode);
      ref.read(refCodeShowProvider.notifier).update((s) => his.showCode);

      // output["refCode"] = code;
      // output["status"] = locked ? 1 : 0;
      // output["status"] = 1;
      // DocumentResponse result = DocumentResponse.fromJson(output);
      TimaticResponseNew result = TimaticResponseNew.fromJson(output);

      ref.read(timaticResultNewProvider.notifier).update((s) => result);
    }
  }

  askSuperVisorDialog() async {
    List<Supervisor>? supervisors = await getIt<HomeController>().getSupervisors();
    if (supervisors == null) return;


    String? logId = getIt<HomeController>().ref.read(refCodeProvider);
    if (logId != null) {
      navigation.openDialog(dialog: AskSupervisorSheet(logId: logId, supervisors: supervisors));
      // Navigator.pop(context);
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AskSupervisorSheet(logId: logId, supervisors: supervisors);
      //   },
      //   // isScrollControlled: true,
      //   // shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
      // );
    }
    // ref.read(attachingPhotoPathProvider.notifier).update((s) => []);
    // navigation.openDialog(dialog: AskSupervisorDialog(logId: ref.read(timaticResultProvider)?.refCode ?? ''));
  }

  Future<bool> uploadDataForSupervision(String? noteType, String desc, String logId) async {
    bool result = false;
    final dio = Dio();

    // Example file path (replace with actual file picker path)

    // Text data (can also be a JSON string)
    final textData = "your text or json here";
    List<String> images = ref.read(attachingPhotoPathProvider);

    final formData = buildFormDataFromPaths(images: images, voices: [], data: {"logNoteType": noteType, "description": desc});
    // final imageFiles = await Future.wait(images.map((path) async => await MultipartFile.fromFile(path, filename: path.split('/').last)));
    // final formData = FormData.fromMap({
    //   "images": imageFiles, // multiple images
    //   "data": jsonEncode({"logNoteType": noteType, "description": desc}),
    // });
    String api = "${ref.read(selectedServerProvider).apiAddress}/v1/logs/$logId";

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
      final currentStatus = CurrentStatus.fromJson(response.data["response"]["result"]);
      ref.read(currentStatusProvider.notifier).update((s) => currentStatus);
      log("Response: ${response.data}");
      return result;
    } catch (e) {
      log("Error: $e");
      FailureHandler.handle(ServerFailure(code: -1, msg: "$e", traceMsg: "$e"));
      return false;
    }
  }

  void showOptionSheet() {
    navigation.openBottomSheet(
      bottomSheet: OptionSheetDialog(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      isScrollControlled: true,
    );
  }

  Future<bool> attachToResult({required String logId, List<String> images = const [], List<String> voices = const [], Map<String, dynamic>? data}) async {
    bool result = false;
    final dio = Dio();

    final formData = await buildFormDataFromPaths(
      images: images,
      voices: voices,
      data: data??{},
    );




    // log("${images.length} images.length");
    // log(formData.files.);
    String api = "${ref.read(selectedServerProvider).apiAddress}/v1/logs/$logId/attach";
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
      final logs = List<RefHistoryLog>.from((response.data["response"]["logs"].map((a) => RefHistoryLog.fromJson(a))));
      ref.read(showingLogsProvider.notifier).update((s) => [...logs, ...s]);
      final currentStatus = CurrentStatus.fromJson(response.data["response"]["result"]);
      ref.read(currentStatusProvider.notifier).update((s) => currentStatus);
      return result;
    } catch (e) {
      log("Error: $e");
      FailureHandler.handle(ServerFailure(code: -1, msg: "$e", traceMsg: "$e"));
      return false;
    }
  }

  Future<bool> agentDecision({required String logId, List<String> images = const [], List<String> voices = const [], Map<String, dynamic>? data}) async {
    bool result = false;
    final dio = Dio();

    final formData = await buildFormDataFromPaths(
      images: images,
      voices: voices,
      data: data??{},
    );


    // if(kIsWeb){
    //   formData = buildFormDataUniversal(images: [], voices: [], data: {});
    // }else {
    //   final imageFiles = await Future.wait(images.map((path) async => await MultipartFile.fromFile(path, filename: path.split('/').last)));
    //   final voiceFiles = await Future.wait(voices.map((path) async => await MultipartFile.fromFile(path, filename: path.split('/').last)));
    //   final attachings = [...imageFiles, ...voiceFiles];
    //   formData = FormData.fromMap({
    //     "attachFiles": attachings, // multiple images
    //     "data": jsonEncode(data),
    //   });
    // }
    String api = "${ref.read(selectedServerProvider).apiAddress}/v1/logs/$logId/agentDecision";
    try {
      final response = await dio.post(
        api,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data", "Authorization": "Bearer ${ref.read(userProvider)!.token}"}),
      );
      if (response.statusCode == 200) {
        if (response.data["success"] == true) {
          result = true;
          ref.read(attachingPhotoPathProvider.notifier).update((s) => []);
        } else {
          FailureHandler.handle(ServerFailure(code: response.statusCode ?? -1, msg: response.data["message"] ?? 'Unknown Error', traceMsg: response.statusMessage ?? 'Unknown Error'));
          return false;
        }
      } else {
        FailureHandler.handle(ServerFailure(code: response.statusCode ?? -1, msg: response.statusMessage ?? 'Unknown Error', traceMsg: response.statusMessage ?? 'Unknown Error'));
        return false;
      }
      log("Response: ${response.data}");
      final logs = List<RefHistoryLog>.from((response.data["response"]["logs"].map((a) => RefHistoryLog.fromJson(a))));
      ref.read(showingLogsProvider.notifier).update((s) => [...logs, ...s]);
      final currentStatus = CurrentStatus.fromJson(response.data["response"]["result"]);
      ref.read(currentStatusProvider.notifier).update((s) => currentStatus);
      return result;
    } catch (e) {
      log("Error: $e");
      FailureHandler.handle(ServerFailure(code: -1, msg: "$e", traceMsg: "$e"));
      return false;
    }
  }

  Future<bool> airlineApproval({required String logId, required ByteData sign, Map<String, dynamic>? data}) async {
    bool result = false;
    final dio = Dio();
    // final imageFiles = await Future.wait(images.map((path) async => await MultipartFile.fromFile(path, filename: path.split('/').last)));
    // final signFile = await MultipartFile.fromFile(sign, filename: sign.split('/').last);
    // final voiceFiles = await Future.wait(voices.map((path) async => await MultipartFile.fromFile(path, filename: path.split('/').last)));
    // final attachings = [...imageFiles, ...voiceFiles];
    // log("\n${[...images, ...voices].join("\n")}\n to $logId");
    // final formData = buildFormDataFromPaths(images: [sign], voices: [], data: data??{},imgKey: "sign");
    final bytes = sign.buffer.asUint8List();
    // Wrap in MultipartFile
    final multipart = MultipartFile.fromBytes(bytes, filename: "sign.png");
    final formData = FormData.fromMap({
      'sign': multipart,
      'data': jsonEncode(data),
    });
    // final formData2 = FormData.fromMap({
    //
    //   "sign": signFile, // multiple images
    //   "data": jsonEncode(data),
    // });
    log("calling to api");
    String api = "${ref.read(selectedServerProvider).apiAddress}/v1/logs/$logId/airlineApproval";
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
      final logs = List<RefHistoryLog>.from((response.data["response"]["logs"].map((a) => RefHistoryLog.fromJson(a))));
      ref.read(showingLogsProvider.notifier).update((s) => [...logs, ...s]);
      final currentStatus = CurrentStatus.fromJson(response.data["response"]["result"]);
      ref.read(currentStatusProvider.notifier).update((s) => currentStatus);
      return result;
    } catch (e) {
      log("Error: $e");
      FailureHandler.handle(ServerFailure(code: -1, msg: "$e", traceMsg: "$e"));
      return false;
    }
  }

  Future<File> getFile({required String url}) async {
    /// Get Image from server
    final Response res = await Dio().get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes, headers: {"Authorization": "Bearer ${ref.read(userProvider)!.token}"}),
    );

    /// Get App local storage
    final Directory appDir = await getApplicationDocumentsDirectory();

    /// Generate Image Name
    final String imageName = url.split('/').last;

    /// Create Empty File in app dir & fill with new image
    final File file = File(appDir.path + "/${imageName.replaceAll(".enc", ".m4a")}");

    file.writeAsBytesSync(res.data as List<int>);

    return file;
  }

  Future<List<Supervisor>?> getSupervisors() async {
    List<Supervisor>? supervisors;
    GetSupervisorsUseCase getSupervisorsUseCase = GetSupervisorsUseCase();
    GetSupervisorsRequest getSupervisorsRequest = GetSupervisorsRequest();
    final result = await getSupervisorsUseCase(request: getSupervisorsRequest);

    switch (result) {
      case Err<GetSupervisorsResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetSupervisorsResponse>():
        final r = result.value;
        supervisors = r.supervisors;
    }

    return supervisors;
  }

  Future<int?> getNotifCount() async {
    int? count;
    GetNotifCountUseCase getNotifCountUseCase = GetNotifCountUseCase();
    GetNotifCountRequest getNotifCountRequest = GetNotifCountRequest();
    final result = await getNotifCountUseCase(request: getNotifCountRequest);

    switch (result) {
      case Err<GetNotifCountResponse>():
        // FailureHandler.handle(result.error);
        return null;

      case Ok<GetNotifCountResponse>():
        final r = result.value;
        count = r.notifCount;
        ref.read(notifCountProvider.notifier).update((s) => r.notifCount);
    }

    return count;
  }

  Future<TimaticResponseNew?> checkTimatic(DocumentRequest req, {required String? employeeId}) async {
    TimaticResponseNew? response;
    SubmitTimaticRequestUseCase checkTimaticUseCase = SubmitTimaticRequestUseCase();
    SubmitTimaticRequestRequest submitTimaticRequestRequestRequest = SubmitTimaticRequestRequest(documentRequest: req, employeeId: employeeId);
    final result = await checkTimaticUseCase(request: submitTimaticRequestRequestRequest);

    switch (result) {
      case Err<SubmitTimaticRequestResponse>():
        FailureHandler.handle(result.error);

      case Ok<SubmitTimaticRequestResponse>():
        final r = result.value;
        response = r.response;
        ref.read(refCodeProvider.notifier).update((s) => r.refCode);
        ref.read(refCodeShowProvider.notifier).update((s) => r.showCode);
        ref.read(currentStatusProvider.notifier).update((s) => r.currentStatus);
    }

    return response;
  }

  Future<List<SupportedLanguage>?> getSupportLanguage(String refCode) async {
    List<SupportedLanguage>? languages;
    GetSupportedLanguageUseCase getSupportLanguageUseCase = GetSupportedLanguageUseCase();
    GetSupportedLanguageRequest getSupportedLanguageRequest = GetSupportedLanguageRequest(logId: refCode) ;
    final result = await getSupportLanguageUseCase(request: getSupportedLanguageRequest);

    switch (result) {
      case Err<GetSupportedLanguageResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetSupportedLanguageResponse>():
        final r = result.value;
        languages = r.languages;
    }

    return languages;
  }

  // Future<void> translateForPassenger() async {
  //   List<SupportedLanguage>? langs = await getSupportLanguage();
  //   if (langs != null) {
  //     navigation.pop();
  //     Future(() {
  //       navigation.openBottomSheet(
  //         bottomSheet: TranslateLanguageSelectSheet(languages: langs),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
  //       );
  //     });
  //   }
  // }

  Future<TimaticResponseNew?> translateTimaticResponse({required String language, required String logId}) async {
    TimaticResponseNew? translated;

    TranslateTimaticResponseUseCase translateTimaticResponseUseCase = TranslateTimaticResponseUseCase();
    TranslateTimaticResponseRequest timaticResponseRequest = TranslateTimaticResponseRequest(language: language, logId: logId);
    final result = await translateTimaticResponseUseCase(request: timaticResponseRequest);

    switch (result) {
      case Err<TranslateTimaticResponseResponse>():
        FailureHandler.handle(result.error);

      case Ok<TranslateTimaticResponseResponse>():
        final r = result.value;
        translated = r.translated;
        // translated.refCode = logId;
        // translated.status = ref.read(timaticResultProvider)?.status;
        ref.read(timaticResultNewProvider.notifier).update((s) => translated!.setStatus(1));
        navigation.pop();
      // navigation.openDialog(dialog: TranslatedResponseDialog(translated: r.translated));
    }

    return translated;
  }

  Future<bool> setStatus(int status) async {
    bool res = false;
    SetStatusResponseUseCase lockUnlockResponseUseCase = SetStatusResponseUseCase();
    SetStatusResponseRequest lockUnlockResponseRequest = SetStatusResponseRequest(logId: ref.read(refCodeProvider)!, status: status);
    final result = await lockUnlockResponseUseCase(request: lockUnlockResponseRequest);

    switch (result) {
      case Err<SetStatusResponseResponse>():
        FailureHandler.handle(result.error);

      case Ok<SetStatusResponseResponse>():
        final r = result.value;
        res = r.isSuccess;
        ref.read(currentStatusProvider.notifier).update((s) => r.currentStatus);
      // ref.read(timaticResultNewProvider.notifier).update((s) => s?.setStatus(1));
    }

    return res;
  }

  Future<TimaticResponseNew?> timatic() async {
    String? userEmployeeId = ref.read(userProvider)?.attributes["employeeId"];
    String? id = ref.watch(currentStatusProvider).employeeId;
    id ??= userEmployeeId;
    id ??= await navigation.openBottomSheet(bottomSheet: AskEmployeeIDSheet(), isScrollControlled: true);
    if (id != null) {
      List<DocumentDetail> ddl = [...ref.read(passportsProvider), ...ref.read(visasProvider), ...ref.read(residentsProvider)].where((a) => a.documentCode != null).toList();
      final timResult = await checkTimatic(
        DocumentRequest(
          documentDetails: ddl,
          itineraryDetails: ItineraryDetails(segments: ref.read(segmentsProvider)),
          passengerDetails: ref
              .read(passengerProvider)
              .copyWith(gender: ref.read(passportsProvider).firstOrNull?.gender, nationality: ref.read(passportsProvider).firstOrNull?.nationality ?? ref.read(passengerProvider).nationality),
        ),
        employeeId: id,
      );
      return timResult;
    } else {
      return null;
    }
  }

  Future<bool> askSupervisor({required String logId, required String msg, required String supervisorId}) async {
    AskSupervisorUseCase askSupervisorUseCase = AskSupervisorUseCase();
    AskSupervisorRequest askSupervisorRequest = AskSupervisorRequest(logId: logId, supervisorId: supervisorId, message: msg);
    final result = await askSupervisorUseCase(request: askSupervisorRequest);

    switch (result) {
      case Err<AskSupervisorResponse>():
        FailureHandler.handle(result.error);

      case Ok<AskSupervisorResponse>():
        final r = result.value;
        ref.read(showingLogsProvider.notifier).update((s) => [...r.logs, ...s]);
        ref.read(currentStatusProvider.notifier).update((s) => r.currentStatus);
        return true;
    }
    return false;
  }

  Future<void> supervisorResponse({required SupervisorResponse response, required String msg, required String logId, required String askId}) async {
    SupervisorResponseUseCase supervisorResponseUseCase = SupervisorResponseUseCase();
    SupervisorResponseRequest supervisorResponseRequest = SupervisorResponseRequest(logId: logId, msg: msg, supervisorResponse: response, askId: askId);
    final result = await supervisorResponseUseCase(request: supervisorResponseRequest);

    switch (result) {
      case Err<SupervisorResponseResponse>():
        FailureHandler.handle(result.error);

      case Ok<SupervisorResponseResponse>():
        final r = result.value;
        ref.read(showingLogsProvider.notifier).update((s) => [...r.logs, ...s]);
    }
  }

  Future<FlightHistoryData?> getFlightNumberHistory(String flnb, {required int index}) async {
    if(index !=0){
      return null;
    }
    FlightHistoryData? history;
    FlightNumberHistoryUseCase getFlightNumberHistoryUseCase = FlightNumberHistoryUseCase();
    FlightNumberHistoryRequest flightNumberHistoryRequest = FlightNumberHistoryRequest(flnb: flnb);
    final result = await getFlightNumberHistoryUseCase(request: flightNumberHistoryRequest);

    switch (result) {
      case Err<FlightNumberHistoryResponse>():
        // FailureHandler.handle(result.error);
        return null;
      case Ok<FlightNumberHistoryResponse>():
        final r = result.value;
        final currentSeg = ref.read(segmentsProvider)[index];
        // history = r.historyData;
        if (r.historyData.isNotEmpty) {
          history = r.historyData.last;
          ref
              .read(segmentsProvider.notifier)
              .updateAt(
                index,
                currentSeg.copyWith(
                  arrival: ItinPoint(point: history.to!, dateTime: currentSeg.arrival.dateTime ?? DateTime.now()),
                  departure: ItinPoint(point: history.from!, dateTime: currentSeg.departure.dateTime ?? DateTime.now()),
                  operatingCarrier: BasicClass.getAirlineWithCode(history.airline!),
                ),
              );
        }
    }

    return history;
  }

  void addManualDoc() async {
    final added = await navigation.openBottomSheet(bottomSheet: ManualAddDocumentSheet());
    if (added is DocumentDetail) {
      handleConfirming(added);
    }
  }

  handleConfirming(DocumentDetail added) async {
    ref.read(confirmingDocumentProvider.notifier).update((s) => added);
    if(navigation.isDialogOpen || navigation.isBottomSheetOpen){
      return;
    }
    if (added.documentCode == null) {
      navigation.popAllBottomSheets();
      navigation.popAllDialogs();
      final code = await navigation.openBottomSheet(
        isScrollControlled: true,
        bottomSheet: PickerSheetWidget(
          // headerWidget: added.mrz!=null?added.getMrzWidget:null,
          suggestion: BasicClass.constData.data.documentCode.where((a) => added.suggestionCodes.contains(a.code)).toList(),
          value: null,
          searchAutoFocus: true,
          hasClear: false,
          items: BasicClass.constData.data.documentCode.where((a) => added.shortType == null || a.type == added.shortType).toList(),
          label: "Type",
          hasSearch: true,
        ),
      );
      if (code is DocumentCode) {
        log("code ${code.code}");
        String shortType = added.shortType ?? BasicClass.constData.data.documentDetailType.firstWhereOrNull((a) => a.code == code.code)?.type ?? "P";
        ref.read(confirmingDocumentProvider.notifier).update((s) => added.copyWith(documentCode: code, verifiedDocCode: true, shortType: shortType));
        log(ref.read(confirmingDocumentProvider)!.documentCode.toString());
        final addRes = await navigation.openDialog(dialog: ConfirmScannedDocDialog(), barrierDismissible: false);
        if (addRes == true) {
          addConfirmingDocument();
        } else {
          ref.read(confirmingDocumentProvider.notifier).update((s) => null);
        }
      }
    } else {
      navigation.popAllBottomSheets();
      navigation.popAllDialogs();
      final addRes = await navigation.openDialog(dialog: ConfirmScannedDocDialog(), barrierDismissible: false);
      if (addRes == true) {
        addConfirmingDocument();
      } else {
        ref.read(confirmingDocumentProvider.notifier).update((s) => null);
      }
    }
  }

  Future<String?> translateText({required String lang, required List<String> texts}) async {
    String? translated;
    TranslateTextUseCase translateTextUseCase = TranslateTextUseCase();
    TranslateTextRequest translateTextRequest = TranslateTextRequest(lang: lang, texts: texts);
    final result = await translateTextUseCase(request: translateTextRequest);

    switch (result) {
      case Err<TranslateTextResponse>():
        FailureHandler.handle(result.error);

      case Ok<TranslateTextResponse>():
        final r = result.value;
        translated = r.translate;
    }

    return translated;
  }

  Future<bool> validateEmployeeId(String id) async {
    bool valid = false;
    ValidateEmployeeIdUseCase validateEmployeeIdUseCase = ValidateEmployeeIdUseCase();
    ValidateEmployeeIdRequest validateEmployeeIdRequest = ValidateEmployeeIdRequest(id: id);
    final result = await validateEmployeeIdUseCase(request: validateEmployeeIdRequest);

    switch (result) {
      case Err<ValidateEmployeeIdResponse>():
        return false;
        FailureHandler.handle(result.error);

      case Ok<ValidateEmployeeIdResponse>():
        final r = result.value;
        valid = r.valid;
    }

    return valid;
  }

  refreshResults() {
    String? refCode = ref.read(refCodeProvider);
    log("refreshResults");

    if (refCode == null) {
      return;
    }
    getRefHistoryLog(code: refCode, showCode: null);
  }

  Future<void> searchTrackId() async {
    final code = await navigation.openBottomSheet(
      bottomSheet: NumericInputSheet(
        label: "Track ID",
        onDone: (a) async {
          if (a is String && a.isNotEmpty) {
            await getRefHistoryLog(code: null, showCode: a);
          }
        },
      ),
      isScrollControlled: true,
    );
    log("");
  }

  // UseCase UseCase = UseCase(repository: Repository());
}
