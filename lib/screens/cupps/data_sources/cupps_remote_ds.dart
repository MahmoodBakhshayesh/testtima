import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/cupps_data_source_interface.dart';
import 'cupps_local_ds.dart';

class CuppsRemoteDataSource implements CuppsDataSourceInterface {
  final CuppsLocalDataSource localDataSource = CuppsLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  CuppsRemoteDataSource();
}
