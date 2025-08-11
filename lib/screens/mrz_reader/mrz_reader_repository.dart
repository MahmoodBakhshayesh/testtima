import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/mrz_reader_repository_interface.dart';
import 'data_sources/mrz_reader_local_ds.dart';
import 'data_sources/mrz_reader_remote_ds.dart';

class MrzReaderRepository implements MrzReaderRepositoryInterface {
  final MrzReaderRemoteDataSource mrzReaderRemoteDataSource = MrzReaderRemoteDataSource();
  final MrzReaderLocalDataSource mrzReaderLocalDataSource = MrzReaderLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  MrzReaderRepository();
}
