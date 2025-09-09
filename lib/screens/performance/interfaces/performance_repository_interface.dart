import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/get_report_usecase.dart';


abstract class PerformanceRepositoryInterface {
  Future<Result<GetReportResponse>> getReport(GetReportRequest request);
}