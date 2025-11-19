import 'dart:developer';

import 'package:abds/screens/setting_menu/setting_menu_state.dart';
import 'package:abds/screens/setting_menu/usecases/get_menu_usecase.dart';
import 'package:abds/screens/setting_menu/usecases/load_section_menu_usecase.dart';
import 'package:abds/screens/setting_menu/usecases/save_section_menu_usecase.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import '../../core/classes/menu_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../menu_item_add_edit/menu_item_add_edit_state.dart';
import '../menu_section/menu_section_state.dart';
import 'usecases/add_section_menu_usecase.dart';

class SettingMenuController extends ControllerInterface {
  final _log = Logger('SettingMenuController');

  Future<SettingMenu?> getMenu() async {
    SettingMenu? menuSetting;
    GetMenuUseCase getMenuUseCase = GetMenuUseCase();
    GetMenuRequest getMenuRequest = GetMenuRequest();
    ref.read(settingMenuProvider.notifier).update((s) => null);
    ref.read(menuSectionProvider.notifier).update((s) => null);
    ref.read(editingMenuProvider.notifier).update((s) => null);
    ref.read(editingSchemaProvider.notifier).update((s) => null);
    ref.read(editingLabelProvider.notifier).update((s) => null);
    ref.read(sectionItemsProvider.notifier).update((s) => []);

    // final menuSectionProvider = StateProvider<MenuDescriptor?>((ref) => null);
    // final sectionItemsProvider = StateProvider<List<dynamic>>((ref) => []);
    //
    // final editingMenuProvider = StateProvider<Map<String,dynamic>?>((ref) => null);
    // final editingSchemaProvider = StateProvider<SchemaNode?>((ref) => null);
    // final editingLabelProvider = StateProvider<String?>((ref) => null);


    ref.read(menuLoadingProvider.notifier).update((s) => true);
    final result = await getMenuUseCase(request: getMenuRequest);
    ref.read(menuLoadingProvider.notifier).update((s) => false);

    switch (result) {
      case Err<GetMenuResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetMenuResponse>():
        final r = result.value;
        ref.read(settingMenuProvider.notifier).update((s) => r.settingMenu);
    }

    return menuSetting;
  }

  // Future<void> saveMenu(MenuDescriptor section, data) async {
  //   // log(data.toString());
  //   log("${(section.getValue(data) as List).length}");
  //   log("${(data as List).length}");
  //   var current = ref.read(menuValuesProvider);
  //   current[section.endpoint] = data;
  //   ref.read(menuValuesProvider.notifier).update((s)=>current);
  // }

  // loadData(MenuDescriptor section) {
  //   log("load data ${section.title}");
  // }
  //

  Future<List<dynamic>?> loadData(MenuDescriptor section) async {
    List<dynamic>? menu;
    LoadSectionMenuUseCase loadDataUseCase = LoadSectionMenuUseCase();
    LoadSectionMenuRequest loadSectionMenuRequest = LoadSectionMenuRequest(endPoint: section.endpoint);
    ref.read(menuLoadingProvider.notifier).update((s) => true);
    final result = await loadDataUseCase(request: loadSectionMenuRequest);

    ref.read(menuLoadingProvider.notifier).update((s) => false);

    switch (result) {
      case Err<LoadSectionMenuResponse>():
        FailureHandler.handle(result.error);

      case Ok<LoadSectionMenuResponse>():
        final r = result.value;
        Map<String, dynamic> current = {};
        current[section.endpoint] = r.menus;
        menu = r.menus;
        ref.read(menuValuesProvider.notifier).update((s) => current);
        ref.read(menuSectionProvider.notifier).update((s) => section);
        ref.read(sectionItemsProvider.notifier).update((s) => r.menus);
        log("setting menuSectionProvider");
        log("setting menuValuesProvider ${current.length}");
    }

    return menu;
  }

  Future<bool> saveMenuSection(MenuDescriptor section, data, String id) async {
    SaveSectionMenuUseCase saveMenuSectionUseCase = SaveSectionMenuUseCase();
    SaveSectionMenuRequest saveSectionMenuRequest = SaveSectionMenuRequest(endPoint: section.endpoint, data: data, id: id);
    final result = await saveMenuSectionUseCase(request: saveSectionMenuRequest);

    switch (result) {
      case Err<SaveSectionMenuResponse>():
        FailureHandler.handle(result.error);
        return false;

      case Ok<SaveSectionMenuResponse>():
        final r = result.value;
        return true;
    }
  }

  Future<bool> addMenuSection(MenuDescriptor section, data) async {
    AddSectionMenuUseCase addMenuSectionUseCase = AddSectionMenuUseCase();
    AddSectionMenuRequest addSectionMenuRequest = AddSectionMenuRequest(endPoint: section.endpoint, data: data);
    final result = await addMenuSectionUseCase(request: addSectionMenuRequest);

    switch (result) {
      case Err<AddSectionMenuResponse>():
        FailureHandler.handle(result.error);
        return false;

      case Ok<AddSectionMenuResponse>():
        final r = result.value;
        return true;
    }
  }
}
