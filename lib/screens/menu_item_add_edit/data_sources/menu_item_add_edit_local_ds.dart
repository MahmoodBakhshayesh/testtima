import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/menu_item_add_edit_data_source_interface.dart';

class MenuItemAddEditLocalDataSource implements MenuItemAddEditDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  MenuItemAddEditLocalDataSource();



}
