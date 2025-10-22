import 'dart:developer';

import 'package:abds/core/classes/log_report_detail_class.dart';
import 'package:abds/core/classes/overall_performance_class.dart';
import 'package:abds/screens/performance/usecases/get_report_usecase.dart';
import 'package:logging/logging.dart';
import '../../core/classes/performance_log_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../initialize.dart';
import '../home/home_controller.dart';
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
    }

    return details;
  }

  Future<List<OverallPerformance>?> getOverallPerformances({DateTime? fromDate, DateTime? toDate, String? from, String? to}) async {
    List<OverallPerformance>? overalls;
    GetOverallPerformancesUseCase getPerformanceLogUseCase = GetOverallPerformancesUseCase();
    GetOverallPerformancesRequest getReportRequest = GetOverallPerformancesRequest(from: from, to: to, fromDate: fromDate, toDate: toDate);
    final result = await getPerformanceLogUseCase(request: getReportRequest);

    switch (result) {
      case Err<GetOverallPerformancesResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetOverallPerformancesResponse>():
        final r = result.value;
        overalls = r.overallPerformances;
    }

    return overalls;
  }

  goMessageDetails(String messageCode) async {
    try {
      final refHistory = await getIt<HomeController>().getRefHistoryLog(showCode: messageCode, code: null);
      if (refHistory != null) {
        navigation.pop();
      }
    }catch(e){
      log("$e");
    }
  }
}
