import 'package:abds/core/classes/overall_performance_class.dart';
import 'package:abds/core/classes/performance_log_class.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/log_report_detail_class.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../performance_repository.dart';

class GetReportUseCase extends UseCase<GetReportResponse, GetReportRequest> {
  GetReportUseCase();

  @override
  Future<Result<GetReportResponse>> call({required GetReportRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    PerformanceRepository repository = PerformanceRepository();
    return repository.getReport(request);
  }
}

class GetReportRequest extends RequestInterface {
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? from;
  final String? to;
  final int? timaticResult;
  final int? airlineResult;
  final int? supervisorResult;
  final int? totalResult;
  final int? agentResult;
  final String? totalResultRole;

  GetReportRequest({
    required this.fromDate,
    required this.toDate,
    required this.from,
    required this.to,
    required this.timaticResult,
    required this.airlineResult,
    required this.supervisorResult,
    required this.totalResult,
    required this.agentResult,
    required this.totalResultRole,
  });

  @override
  Map<String, dynamic> toJson() => {
    "Body": {"Execution": "GetReport", "Token": token, "Request": {}},
  };

  Failure? validate() {
    return null;
  }
}

class GetReportResponse extends ResponseInterface {
  // final PerformanceLog performanceLog;
  final List<LogReportDetail> reportDetails;

  GetReportResponse({required super.status, required super.message, required this.reportDetails}) : super(body:{
    "details": reportDetails.map((a) => a.toJson()).toList()
  });

  factory GetReportResponse.fromResponse(ResponseInterface res) =>
      GetReportResponse(status: res.status, message: res.message, reportDetails: List<LogReportDetail>.from(res.body["details"].map((a) => LogReportDetail.fromJson(a))));
}
