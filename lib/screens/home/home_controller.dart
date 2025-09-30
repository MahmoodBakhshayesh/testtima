import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:abds/core/classes/constant_data_class.dart';
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
import 'package:abds/screens/home/dialogs/translate_language_select_sheet.dart';
import 'package:abds/screens/home/dialogs/translated_response_dialog.dart';
import 'package:abds/screens/home/usecases/get_notif_count_usecase.dart';
import 'package:abds/screens/home/usecases/get_ref_code_log_usecase.dart';
import 'package:abds/screens/home/usecases/get_supervisors_usecase.dart';
import 'package:abds/screens/home/usecases/get_supported_language_usecased.dart';
import 'package:abds/screens/home/usecases/lock_unlock_response_usecase.dart';
import 'package:abds/screens/home/usecases/submit_timatic_request_usecase.dart';
import 'package:abds/screens/home/usecases/timatic_get_locations_usecase.dart';
import 'package:abds/screens/home/usecases/timatic_get_parameters_usecase.dart';
import 'package:abds/screens/home/usecases/translate_timatic_response_usecase.dart';
import 'package:abds/screens/home/widgets/logs_and_attachments.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/users/users_controller.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
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
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../core/utils_and_services/timatic/src/defaults.dart';
import '../../initialize.dart';
import '../../widgets/MyFieldPicker.dart';
import '../mrz_reader/mrz_reader_state.dart';
import 'dialogs/image_pick_method_select_sheet.dart';
import 'dialogs/option_sheet_dialog.dart';
import 'home_state.dart';
import 'usecases/ask_supervisor_usecase.dart';
import 'usecases/flight_number_history_usecase.dart';
import 'usecases/supervisor_response_usecase.dart';

class HomeController extends ControllerInterface {
  final _log = Logger('HomeController');

  // late TimaticApi timaticApi = getIt<TimaticApi>();

  void clear() {
    ref.read(passengerProvider.notifier).update((s) => PassengerDetails());
    ref.read(improvingMrzResultProvider.notifier).update((s) => null);
    // ref.read(visasProvider.notifier).update((s) => [DocumentDetail()]);
    ref.read(passportsProvider.notifier).removeAll();
    ref.read(visasProvider.notifier).removeAll();
    ref.read(residentsProvider.notifier).removeAll();
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

  Future<void> setAirportDialog(BuildContext context) async {
    final current = BasicClass.constData.data.airport.firstWhereOrNull((a) =>
    a.code3 == ref
        .read(userProvider)
        ?.profile
        .defaultAirport);
    final newVal = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          // This moves content above the keyboard
          padding: EdgeInsets.only(bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom),
          child: PickerSheetWidget(value: current,
              hasClear: false,
              searchAutoFocus: false,
              searchBuilder: null,
              items: BasicClass.constData.data.airport,
              label: "Airport",
              itemToWidget: null,
              hasSearch: true),
        );
        // return PickerSheetWidget(items: widget.items, label: widget.placeholder ?? widget.label ?? '', itemToWidget: widget.itemToWidget, hasSearch: widget.hasSearch);
      },
      elevation: 2,
    );

    if (newVal is Country) {
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
        Future(() {
          navigation.openDialog(dialog: ConfirmScannedDocDialog(documentDetail: ref.read(confirmingDocumentProvider)!), barrierDismissible: false).then((v) {
            if (v == true) {
              addConfirmingDocument();
            } else {
              ref.read(confirmingDocumentProvider.notifier).update((s) => null);
            }
          });
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
        if (ref
            .read(passportsProvider)
            .isEmpty) {
          ref.read(passportsProvider.notifier).add(doc);
        } else {
          int lastIndex = ref
              .read(passportsProvider)
              .length - 1;
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
    final XFile? pic = await picker.pickImage(source: source, imageQuality: 30);
    log("returned");
    return pic?.path;
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
    final showingLogs = (his.logs ?? []).where((a) => (a.type ?? '') != ("timaticCheck")).toList();
    ref.read(showingLogsProvider.notifier).update((s) => showingLogs);
    if (timaticReqLog != null) {
      bool locked = timaticReqLog.payload?.locked ?? false;
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
      final passes = allDocs.where((a) =>
      a
          .getMatch()
          ?.type == "P").toList();
      final visas = allDocs.where((a) =>
      a
          .getMatch()
          ?.type == "V").toList();
      final residents = allDocs.where((a) =>
      a
          .getMatch()
          ?.type == "I").toList();

      log("AllDoces ${allDocs.map((a) =>
      a
          .getMatch()
          ?.type)}");
      log("Passes ${passes.length} -- Visas${visas.length} -- Residents${residents.length}");
      final others = allDocs.where((a) =>
      !["V", "I", "P"].contains(a
          .getMatch()
          ?.type)).toList();
      final allSegs = List<ItinerarySegment>.from(
        (input["itineraryDetails"]['segments']).map((s) {
          return ItinerarySegment.regenerateFromJson(s);
          // return ItinerarySegment(departure: ItinPoint.fromJson(s["departure"]), arrival: ItinPoint.fromJson(s["arrival"]), processingEntity: "ABOMIS DOC CHECK", operatingCarrier: BasicClass.getAirlineWithCode(code));
        }),
      );

      ref.read(passportsProvider.notifier).setAll(passes);
      ref.read(visasProvider.notifier).setAll(visas);
      ref.read(residentsProvider.notifier).setAll(residents);
      ref.read(segmentsProvider.notifier).setAll(allSegs);
      ref.read(passengerProvider.notifier).update((s) => pd);

      output["refCode"] = code;
      // output["status"] = locked ? 1 : 0;
      output["status"] = 1;
      // DocumentResponse result = DocumentResponse.fromJson(output);
      TimaticResponseNew result = TimaticResponseNew.fromJson(output);

      ref.read(timaticResultNewProvider.notifier).update((s) => result);
    }
  }

  askSuperVisorDialog() {
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
    final imageFiles = await Future.wait(images.map((path) async =>
    await MultipartFile.fromFile(path, filename: path
        .split('/')
        .last)));
    final formData = FormData.fromMap({
      "images": imageFiles, // multiple images
      "data": jsonEncode({"logNoteType": noteType, "description": desc}),
    });
    String api = "${ref
        .read(selectedServerProvider)
        .apiAddress}/logs/$logId";

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

    final imageFiles = await Future.wait(images.map((path) async =>
    await MultipartFile.fromFile(path, filename: path
        .split('/')
        .last)));
    final voiceFiles = await Future.wait(voices.map((path) async =>
    await MultipartFile.fromFile(path, filename: path
        .split('/')
        .last)));
    final attachings = [...imageFiles, ...voiceFiles];
    log("\n${[...images, ...voices].join("\n")}\n to $logId");
    final formData = FormData.fromMap({
      "attachFiles": attachings, // multiple images
      "data": jsonEncode(data),
    });
    String api = "${ref
        .read(selectedServerProvider)
        .apiAddress}/logs/$logId/attach";
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
      return result;
    } catch (e) {
      log("Error: $e");
      FailureHandler.handle(ServerFailure(code: -1, msg: "$e", traceMsg: "$e"));
      return false;
    }
  }

  Future<bool> airlineApproval({required String logId, required String sign, Map<String, dynamic>? data}) async {
    bool result = false;
    final dio = Dio();

    // final imageFiles = await Future.wait(images.map((path) async => await MultipartFile.fromFile(path, filename: path.split('/').last)));
    final signFile = await MultipartFile.fromFile(sign, filename: sign
        .split('/')
        .last);
    // final voiceFiles = await Future.wait(voices.map((path) async => await MultipartFile.fromFile(path, filename: path.split('/').last)));
    // final attachings = [...imageFiles, ...voiceFiles];
    // log("\n${[...images, ...voices].join("\n")}\n to $logId");
    final formData = FormData.fromMap({
      "sign": signFile, // multiple images
      "data": jsonEncode(data),
    });
    String api = "${ref
        .read(selectedServerProvider)
        .apiAddress}/logs/$logId/airlineApproval";
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
    final String imageName = url
        .split('/')
        .last;

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
        FailureHandler.handle(result.error);

      case Ok<GetNotifCountResponse>():
        final r = result.value;
        count = r.notifCount;
        ref.read(notifCountProvider.notifier).update((s) => r.notifCount);
        log("update notif count =>${r.notifCount}");
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
        log("123 ${result.error}");
        FailureHandler.handle(result.error);

      case Ok<SubmitTimaticRequestResponse>():
        final r = result.value;
        response = r.response;
        ref.read(refCodeProvider.notifier).update((s) => r.refCode);
    }

    return response;
  }

  Future<List<SupportedLanguage>?> getSupportLanguage() async {
    List<SupportedLanguage>? languages;
    GetSupportedLanguageUseCase getSupportLanguageUseCase = GetSupportedLanguageUseCase();
    GetSupportedLanguageRequest getSupportedLanguageRequest = GetSupportedLanguageRequest(logId: ref.read(refCodeProvider) ?? '');
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

  Future<void> translateForPassenger() async {
    List<SupportedLanguage>? langs = await getSupportLanguage();
    if (langs != null) {
      navigation.pop();
      Future(() {
        navigation.openBottomSheet(
          bottomSheet: TranslateLanguageSelectSheet(languages: langs),
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
        );
      });
    }
  }

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

  Future<bool> lockUnlockResponse(bool lock) async {
    bool res = false;
    LockUnlockResponseUseCase lockUnlockResponseUseCase = LockUnlockResponseUseCase();
    LockUnlockResponseRequest lockUnlockResponseRequest = LockUnlockResponseRequest(logId: ref.read(refCodeProvider)!, lock: lock);
    final result = await lockUnlockResponseUseCase(request: lockUnlockResponseRequest);

    switch (result) {
      case Err<LockUnlockResponseResponse>():
        FailureHandler.handle(result.error);

      case Ok<LockUnlockResponseResponse>():
        final r = result.value;
        res = r.isSuccess;
        ref.read(timaticResultNewProvider.notifier).update((s) => s?.setStatus(lock ? 1 : 0));
    }

    return res;
  }

  Future<TimaticResponseNew?> timatic() async {
    final id = await navigation.openBottomSheet(bottomSheet: AskEmployeeIDSheet(), isScrollControlled: true);
    if (id != null) {
      List<DocumentDetail> ddl = [...ref.read(passportsProvider), ...ref.read(visasProvider), ...ref.read(residentsProvider)].where((a) => a.documentCode != null).toList();
      final timResult = await checkTimatic(
          DocumentRequest(
            documentDetails: ddl,
            itineraryDetails: ItineraryDetails(segments: ref.read(segmentsProvider)),
            passengerDetails: ref.read(passengerProvider),
          ),
          employeeId: id
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
        return true;
    }
    return false;
  }

  Future<void> supervisorResponse({required SupervisorResponse response, required String msg, required String logId}) async {
    SupervisorResponseUseCase supervisorResponseUseCase = SupervisorResponseUseCase();
    SupervisorResponseRequest supervisorResponseRequest = SupervisorResponseRequest(logId: logId, msg: msg, supervisorResponse: response);
    final result = await supervisorResponseUseCase(request: supervisorResponseRequest);

    switch (result) {
      case Err<SupervisorResponseResponse>():
        FailureHandler.handle(result.error);

      case Ok<SupervisorResponseResponse>():
        final r = result.value;
        ref.read(showingLogsProvider.notifier).update((s) => [...r.logs, ...s]);
    }
  }

  Future<FlightHistoryData?> getFlightNumberHistory(String flnb,{required int index}) async {
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
        // history = r.historyData;
        if (r.historyData.isNotEmpty) {
          history = r.historyData.last;
          ref.read(segmentsProvider.notifier).updateAt(index, ref.read(segmentsProvider)[index].copyWith(
            arrival: ItinPoint(point: history.to!),
            departure: ItinPoint(point: history.from!),
            operatingCarrier: BasicClass.getAirlineWithCode(history.airline!)
          ));

        }
    }

    return history;
  }

// UseCase UseCase = UseCase(repository: Repository());
}
