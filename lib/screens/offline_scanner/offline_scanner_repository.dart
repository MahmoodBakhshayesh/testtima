import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/offline_scanner_repository_interface.dart';
import 'data_sources/offline_scanner_local_ds.dart';
import 'data_sources/offline_scanner_remote_ds.dart';

class OfflineScannerRepository implements OfflineScannerRepositoryInterface {
  final OfflineScannerRemoteDataSource offlineScannerRemoteDataSource = OfflineScannerRemoteDataSource();
  final OfflineScannerLocalDataSource offlineScannerLocalDataSource = OfflineScannerLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  OfflineScannerRepository();
}
