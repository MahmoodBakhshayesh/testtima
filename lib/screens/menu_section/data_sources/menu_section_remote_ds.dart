import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/menu_section_data_source_interface.dart';
import 'menu_section_local_ds.dart';

class MenuSectionRemoteDataSource implements MenuSectionDataSourceInterface {
  final MenuSectionLocalDataSource localDataSource = MenuSectionLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  MenuSectionRemoteDataSource();
}
