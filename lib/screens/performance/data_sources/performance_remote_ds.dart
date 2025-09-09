import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/performance_data_source_interface.dart';
import 'performance_local_ds.dart';

class PerformanceRemoteDataSource implements PerformanceDataSourceInterface {
  final PerformanceLocalDataSource localDataSource = PerformanceLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  PerformanceRemoteDataSource();
}
