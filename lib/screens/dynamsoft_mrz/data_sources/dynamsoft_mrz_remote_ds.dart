import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/dynamsoft_mrz_data_source_interface.dart';
import 'dynamsoft_mrz_local_ds.dart';

class DynamsoftMrzRemoteDataSource implements DynamsoftMrzDataSourceInterface {
  final DynamsoftMrzLocalDataSource localDataSource = DynamsoftMrzLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  DynamsoftMrzRemoteDataSource();
}
