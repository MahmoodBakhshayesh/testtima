import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/performance_data_source_interface.dart';

class PerformanceLocalDataSource implements PerformanceDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  PerformanceLocalDataSource();



}
