import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/current_status_class.dart';
import 'package:abds/core/classes/header_summary_object_class.dart';
import 'package:abds/core/classes/log_report_detail_class.dart';
import 'package:abds/core/classes/overall_performance_class.dart';
import 'package:abds/core/classes/overall_report_tabel_class.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/navigation/routes.dart';
import 'package:abds/screens/performance/usecases/get_report_usecase.dart';
import 'package:dartx/dartx.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:logging/logging.dart';
import '../../core/classes/basic_class.dart';
import '../../core/classes/constant_data_class.dart';
import '../../core/classes/performance_log_class.dart';
import '../../core/classes/ref_history_log_class.dart';
import '../../core/classes/timatic_response_new_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/timatic/src/models/document_request.dart';
import '../../core/utils_and_services/timatic/src/models/enums.dart';
import '../../initialize.dart';
import '../home/home_controller.dart';
import '../home/usecases/get_ref_code_log_usecase.dart';
import '../result_report/result_report_state.dart';
import 'usecases/get_overall_performances_usecase.dart';

class PerformanceController extends ControllerInterface {
  final _log = Logger('PerformanceController');

  Future<List<LogReportDetail>?> getPerformanceLog({
    int? agentResult,
    int? supervisorResult,
    int? airlineResult,
    int? timaticResult,
    int? totalResult,
    String? totalResultRole,
    DateTime? fromDate,
    DateTime? toDate,
    String? from,
    String? to,
  }) async {
    List<LogReportDetail>? details;
    GetReportUseCase getPerformanceLogUseCase = GetReportUseCase();
    GetReportRequest getReportRequest = GetReportRequest(
      supervisorResult: supervisorResult,
      airlineResult: airlineResult,
      timaticResult: timaticResult,
      totalResult: totalResult,
      totalResultRole: totalResultRole,
      from: from,
      to: to,
      fromDate: fromDate,
      toDate: toDate,
      agentResult: agentResult,
    );
    final result = await getPerformanceLogUseCase(request: getReportRequest);

    switch (result) {
      case Err<GetReportResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetReportResponse>():
        final r = result.value;
        details = r.reportDetails.reversed.toList();
      // details = r.reportDetails.reversed.toList();
      // details = [...r.reportDetails.reversed.toList(),...r.reportDetails.reversed.toList(),...r.reportDetails.reversed.toList()];
    }

    return details;
  }

  Future<OverallReportTable?> getOverallPerformances({DateTime? fromDate, DateTime? toDate, String? from, String? to, String? additionalQuery}) async {
    OverallReportTable? table;
    GetOverallPerformancesUseCase getPerformanceLogUseCase = GetOverallPerformancesUseCase();
    GetOverallPerformancesRequest getReportRequest = GetOverallPerformancesRequest(from: from, to: to, fromDate: fromDate, toDate: toDate, additionalQuery: additionalQuery);
    final result = await getPerformanceLogUseCase(request: getReportRequest);

    switch (result) {
      case Err<GetOverallPerformancesResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetOverallPerformancesResponse>():
        final r = result.value;
        table = r.reportTable;
      // table = r.reportTable.copyWith(data: [...r.reportTable.data,...r.reportTable.data,...r.reportTable.data,...r.reportTable.data,...r.reportTable.data,...r.reportTable.data]);
    }

    return table;
  }

  goMessageDetails(String refCode) async {
    if (navigation.context.isDesktop ) {
      final refHistory = await getIt<PerformanceController>().getRefHistoryLog(showCode: null, code: refCode);
    } else {
      try {
        final refHistory = await getRefHistoryLog(showCode: null, code: refCode);
        if (refHistory != null) {
          goNamed(Routes.resultReport);
        }
      } catch (e) {
        log("$e");
      }
    }
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
        ref.read(reportCurrentStatusProvider.notifier).update((s) => r.currentStatus);

        fillReportWithRefHistory(r.history, code, showCode,r.currentStatus);
    }

    return historyLog;
  }

  fillReportWithRefHistory(RefHistory his, String? code, String? showCode,CurrentStatus currentStatus) {
    final timaticReqLog = (his.logs ?? []).firstWhereOrNull((a) => (a.type ?? '') == ("timaticCheck"));
    final showingLogs = (his.logs ?? []).where((a) => (a.type ?? '') != ("timaticCheck")).toList();
    ref.read(reportShowingLogsProvider.notifier).update((s) => showingLogs);
    if (timaticReqLog != null) {
      bool locked = timaticReqLog.payload?.locked == 1;
      Map<String, dynamic> input = jsonDecode(timaticReqLog.payload?.input ?? "{}");
      Map<String, dynamic> output = jsonDecode(timaticReqLog.payload?.output ?? "{}");
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



      ref.read(reportPassportsProvider.notifier).update((s) => passes);
      ref.read(reportVisasProvider.notifier).update((s) => visas);
      ref.read(reportResidentsProvider.notifier).update((s) => residents);
      ref.read(reportSegmentsProvider.notifier).update((s) => allSegs);
      ref.read(reportPassengerProvider.notifier).update((s) => pd);
      ref.read(reportRefCodeShowProvider.notifier).update((s) => his.showCode);
      ref.read(reportRefCodeProvider.notifier).update((s) => his.refCode);
      TimaticResponseNew result = TimaticResponseNew.fromJson(output);
      ref.read(reportTimaticResultNewProvider.notifier).update((s) => result);

      HeaderSummaryObject headerSummaryObject = HeaderSummaryObject(
        currentStatus: currentStatus,
        airline: allSegs.first.operatingCarrier!.code,
        flnb: allSegs.first.flnb,
        dateTime: allSegs.first.departure.dateTime,
        departure: allSegs.first.departure.point,
        arrival: allSegs.first.arrival.point,
        docNumber: passes.firstOrNull?.documentNumber,
        showCode: showCode,
        employeeId: currentStatus.employeeId,
        nationality: passes.firstOrNull?.nationality?.code3,
        resident:  visas.firstOrNull?.nationality?.code3,
        issuing:  visas.firstOrNull?.documentIssueCountry?.code3,
        segments: result.segments,
      );
      ref.read(reportHeaderSummaryObjectProvider.notifier).update((s)=>headerSummaryObject);
    }
  }
}
