import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/menu_item_add_edit_data_source_interface.dart';
import 'menu_item_add_edit_local_ds.dart';

class MenuItemAddEditRemoteDataSource implements MenuItemAddEditDataSourceInterface {
  final MenuItemAddEditLocalDataSource localDataSource = MenuItemAddEditLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  MenuItemAddEditRemoteDataSource();
}
