import 'dart:developer';

import 'package:artemis_utils/artemis_utils.dart';

import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../initialize.dart';
import '../interfaces/performance_data_source_interface.dart';
import '../usecases/get_overall_performances_usecase.dart';
import '../usecases/get_report_usecase.dart';
import 'performance_local_ds.dart';

class PerformanceRemoteDataSource implements PerformanceDataSourceInterface {
  final PerformanceLocalDataSource localDataSource = PerformanceLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  PerformanceRemoteDataSource();

  @override
  Future<GetReportResponse> getReport({required GetReportRequest request}) async {
    final api = Uri.parse("$apiVersion2/report")
        .replace(
      queryParameters: {
        "startDT": request.fromDate?.format_yyyyMMdd,
        "endDT": request.toDate?.format_yyyyMMdd,
        "from": request.from,
        "to": request.to,
        "adminReport": "false",
        "timaticResult": request.timaticResult?.toString(),
        "totalResult": request.totalResult?.toString(),
        "totalResultRole": request.totalResultRole?.toString(),
        "agentDecision": request.agentResult?.toString(),
        "airlineResult": request.airlineResult?.toString(),
      }..removeWhere((_, v) => v == null),
    )
        .toString();

    log(api);
    // String api = "$apiVersion2/report?${request.fromDate==null?'':'startDT=${request.fromDate.format_yyyyMMdd}&'}${request.toDate==null?'':'endDT=${request.toDate.format_yyyyMMdd}&'}${request.from==null?'':'from=${request.from}&'}${request.to==null?'':'to=${request.to}'}";
    // log(api);
    ResponseInterface res = await networkManager.get(api);
    GetReportResponse response = await Parser().parse(GetReportResponse.fromResponse, res, executionReq: request);
    return response;
  }

  @override
  Future<GetOverallPerformancesResponse> getOverallPerformances({required GetOverallPerformancesRequest request}) async {
    final api = Uri.parse("$apiVersion2/report")
        .replace(
          queryParameters: {
            "startDT": request.fromDate?.format_yyyyMMdd,
            "endDT": request.toDate?.format_yyyyMMdd,
            "from": request.from,
            "to": request.to,
            "adminReport": "true",

          },
        )
        .toString();

    log(api);
    // String api = "$apiVersion2/report?${request.fromDate==null?'':'startDT=${request.fromDate.format_yyyyMMdd}&'}${request.toDate==null?'':'endDT=${request.toDate.format_yyyyMMdd}&'}${request.from==null?'':'from=${request.from}&'}${request.to==null?'':'to=${request.to}'}";
    // log(api);
    ResponseInterface res = await networkManager.get(api);
    GetOverallPerformancesResponse response = await Parser().parse(GetOverallPerformancesResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
