import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/mrz_reader_data_source_interface.dart';
import 'mrz_reader_local_ds.dart';

class MrzReaderRemoteDataSource implements MrzReaderDataSourceInterface {
  final MrzReaderLocalDataSource localDataSource = MrzReaderLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  MrzReaderRemoteDataSource();
}
