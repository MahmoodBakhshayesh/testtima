import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/performance_repository_interface.dart';
import 'data_sources/performance_local_ds.dart';
import 'data_sources/performance_remote_ds.dart';
import 'usecases/get_overall_performances_usecase.dart';
import 'usecases/get_report_usecase.dart';

class PerformanceRepository implements PerformanceRepositoryInterface {
  final PerformanceRemoteDataSource performanceRemoteDataSource = PerformanceRemoteDataSource();
  final PerformanceLocalDataSource performanceLocalDataSource = PerformanceLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  PerformanceRepository();

  @override
  Future<Result<GetReportResponse>> getReport(GetReportRequest request) async {
    try {
      GetReportResponse getReportResponse;
      if (await networkInfo.isConnected) {
        getReportResponse = await performanceRemoteDataSource.getReport(request: request);
      } else {
        getReportResponse = await performanceLocalDataSource.getReport(request: request);
      }
      return Result.ok(getReportResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<GetOverallPerformancesResponse>> getOverallPerformances(GetOverallPerformancesRequest request) async {
    try {
      GetOverallPerformancesResponse getOverallPerformancesResponse;
      if (await networkInfo.isConnected) {
        getOverallPerformancesResponse = await performanceRemoteDataSource.getOverallPerformances(request: request);
      } else {
        getOverallPerformancesResponse = await performanceLocalDataSource.getOverallPerformances(request: request);
      }
      return Result.ok(getOverallPerformancesResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
