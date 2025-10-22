import 'package:abds/core/classes/overall_performance_class.dart';
import 'package:abds/core/classes/performance_log_class.dart';
import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../performance_repository.dart';

class GetOverallPerformancesUseCase extends UseCase<GetOverallPerformancesResponse, GetOverallPerformancesRequest> {
  GetOverallPerformancesUseCase();

  @override
  Future<Result<GetOverallPerformancesResponse>> call({required GetOverallPerformancesRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    PerformanceRepository repository = PerformanceRepository();
    return repository.getOverallPerformances(request);
  }
}

class GetOverallPerformancesRequest extends RequestInterface {
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? from;
  final String? to;
  GetOverallPerformancesRequest({
    required this.fromDate,
    required this.toDate,
    required this.from,
    required this.to,
  });

  @override
  Map<String, dynamic> toJson() => {
    "Body": {"Execution": "GetOverallPerformances", "Token": token, "Request": {}},
  };

  Failure? validate() {
    return null;
  }
}

class GetOverallPerformancesResponse extends ResponseInterface {
  // final PerformanceLog performanceLog;
  final List<OverallPerformance> overallPerformances;

  GetOverallPerformancesResponse({required super.status, required super.message, required this.overallPerformances}) : super(body: overallPerformances.map((a) => a.toJson()).toList());

  factory GetOverallPerformancesResponse.fromResponse(ResponseInterface res) =>
      GetOverallPerformancesResponse(status: res.status, message: res.message, overallPerformances: List<OverallPerformance>.from(res.body.map((a) => OverallPerformance.fromJson(a))));
}
