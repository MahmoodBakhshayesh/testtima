import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/offline_scanner_data_source_interface.dart';
import 'offline_scanner_local_ds.dart';

class OfflineScannerRemoteDataSource implements OfflineScannerDataSourceInterface {
  final OfflineScannerLocalDataSource localDataSource = OfflineScannerLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  OfflineScannerRemoteDataSource();
}
