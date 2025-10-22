import '../usecases/get_overall_performances_usecase.dart';
import '../usecases/get_report_usecase.dart';

abstract class PerformanceDataSourceInterface {
  Future<GetReportResponse> getReport({required GetReportRequest request});
  Future<GetOverallPerformancesResponse> getOverallPerformances({required GetOverallPerformancesRequest request});
}