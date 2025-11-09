import 'package:abds/screens/setting_menu/usecases/add_section_menu_usecase.dart';
import 'package:abds/screens/setting_menu/usecases/get_menu_usecase.dart';
import 'package:abds/screens/setting_menu/usecases/load_section_menu_usecase.dart';
import 'package:abds/screens/setting_menu/usecases/save_section_menu_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/setting_menu_data_source_interface.dart';

class SettingMenuLocalDataSource implements SettingMenuDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  SettingMenuLocalDataSource();

  @override
  Future<GetMenuResponse> getMenu({required GetMenuRequest request}) {
    // TODO: implement getMenu
    throw UnimplementedError();
  }

  @override
  Future<LoadSectionMenuResponse> loadSectionMenu({required LoadSectionMenuRequest request}) {
    // TODO: implement loadSectionMenu
    throw UnimplementedError();
  }

  @override
  Future<SaveSectionMenuResponse> saveSectionMenu({required SaveSectionMenuRequest request}) {
    // TODO: implement saveSectionMenu
    throw UnimplementedError();
  }

  @override
  Future<AddSectionMenuResponse> addSectionMenu({required AddSectionMenuRequest request}) {
    // TODO: implement addSectionMenu
    throw UnimplementedError();
  }



}
