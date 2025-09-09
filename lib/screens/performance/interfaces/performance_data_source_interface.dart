import '../usecases/get_report_usecase.dart';

abstract class PerformanceDataSourceInterface {
  Future<GetReportResponse> getReport({required GetReportRequest request});
}