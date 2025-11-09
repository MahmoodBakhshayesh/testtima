import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/menu_section_repository_interface.dart';
import 'data_sources/menu_section_local_ds.dart';
import 'data_sources/menu_section_remote_ds.dart';

class MenuSectionRepository implements MenuSectionRepositoryInterface {
  final MenuSectionRemoteDataSource menuSectionRemoteDataSource = MenuSectionRemoteDataSource();
  final MenuSectionLocalDataSource menuSectionLocalDataSource = MenuSectionLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  MenuSectionRepository();
}
