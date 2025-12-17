import '../usecases/add_section_menu_usecase.dart';
import '../usecases/get_menu_usecase.dart';
import '../usecases/load_section_menu_usecase.dart';
import '../usecases/menu_get_template_usecase.dart';
import '../usecases/save_section_menu_usecase.dart';

abstract class SettingMenuDataSourceInterface {
  Future<GetMenuResponse> getMenu({required GetMenuRequest request});
  Future<LoadSectionMenuResponse> loadSectionMenu({required LoadSectionMenuRequest request});
  Future<SaveSectionMenuResponse> saveSectionMenu({required SaveSectionMenuRequest request});
  Future<AddSectionMenuResponse> addSectionMenu({required AddSectionMenuRequest request});
  Future<MenuGetTemplateResponse> menuGetTemplate({required MenuGetTemplateRequest request});
}