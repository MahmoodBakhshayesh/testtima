import 'package:abds/screens/performance/usecases/get_overall_performances_usecase.dart';
import 'package:abds/screens/performance/usecases/get_report_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/performance_data_source_interface.dart';

class PerformanceLocalDataSource implements PerformanceDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  PerformanceLocalDataSource();

  @override
  Future<GetReportResponse> getReport({required GetReportRequest request}) {
    // TODO: implement getReport
    throw UnimplementedError();
  }

  @override
  Future<GetOverallPerformancesResponse> getOverallPerformances({required GetOverallPerformancesRequest request}) {
    // TODO: implement getOverallPerformances
    throw UnimplementedError();
  }



}
