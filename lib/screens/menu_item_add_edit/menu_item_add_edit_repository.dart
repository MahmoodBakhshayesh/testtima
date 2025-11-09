import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/menu_item_add_edit_repository_interface.dart';
import 'data_sources/menu_item_add_edit_local_ds.dart';
import 'data_sources/menu_item_add_edit_remote_ds.dart';

class MenuItemAddEditRepository implements MenuItemAddEditRepositoryInterface {
  final MenuItemAddEditRemoteDataSource menuItemAddEditRemoteDataSource = MenuItemAddEditRemoteDataSource();
  final MenuItemAddEditLocalDataSource menuItemAddEditLocalDataSource = MenuItemAddEditLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  MenuItemAddEditRepository();
}
