import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/cupps_repository_interface.dart';
import 'data_sources/cupps_local_ds.dart';
import 'data_sources/cupps_remote_ds.dart';

class CuppsRepository implements CuppsRepositoryInterface {
  final CuppsRemoteDataSource cuppsRemoteDataSource = CuppsRemoteDataSource();
  final CuppsLocalDataSource cuppsLocalDataSource = CuppsLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  CuppsRepository();
}
