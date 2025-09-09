import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/performance_repository_interface.dart';
import 'data_sources/performance_local_ds.dart';
import 'data_sources/performance_remote_ds.dart';

class PerformanceRepository implements PerformanceRepositoryInterface {
  final PerformanceRemoteDataSource performanceRemoteDataSource = PerformanceRemoteDataSource();
  final PerformanceLocalDataSource performanceLocalDataSource = PerformanceLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  PerformanceRepository();
}
