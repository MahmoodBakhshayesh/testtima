import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/dynamsoft_mrz_repository_interface.dart';
import 'data_sources/dynamsoft_mrz_local_ds.dart';
import 'data_sources/dynamsoft_mrz_remote_ds.dart';

class DynamsoftMrzRepository implements DynamsoftMrzRepositoryInterface {
  final DynamsoftMrzRemoteDataSource dynamsoftMrzRemoteDataSource = DynamsoftMrzRemoteDataSource();
  final DynamsoftMrzLocalDataSource dynamsoftMrzLocalDataSource = DynamsoftMrzLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  DynamsoftMrzRepository();
}
