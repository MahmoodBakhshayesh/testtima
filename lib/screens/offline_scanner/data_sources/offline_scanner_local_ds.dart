import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/offline_scanner_data_source_interface.dart';

class OfflineScannerLocalDataSource implements OfflineScannerDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  OfflineScannerLocalDataSource();



}
