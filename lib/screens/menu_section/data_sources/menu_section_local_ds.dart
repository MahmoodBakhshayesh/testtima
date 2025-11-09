import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/menu_section_data_source_interface.dart';

class MenuSectionLocalDataSource implements MenuSectionDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  MenuSectionLocalDataSource();



}
