import 'dart:developer';

import 'package:abds/core/classes/menu_class.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/menu_item_add_edit/menu_item_add_edit_state.dart';
import 'package:abds/screens/setting_menu/setting_menu_controller.dart';
import 'package:logging/logging.dart';
import '../../core/interfaces/controller_int.dart';
import '../menu_section/menu_section_state.dart';

class MenuItemAddEditController extends ControllerInterface {
  final _log = Logger('MenuItemAddEditController');

  Future<void> saveItem(SchemaNode schema, changed) async {
    String id = changed["_id"];
    log("saving menu item $id");
    bool success = await getIt<SettingMenuController>().saveMenuSection(ref.read(menuSectionProvider)!, changed, id);
    if (success) {
      var current = ref.read(sectionItemsProvider);
      int settingIndex = current.indexWhere((a) => a["_id"] == id);
      if (settingIndex != -1) {
        current[settingIndex] = changed;
        ref.read(sectionItemsProvider.notifier).update((s) => [...current]);
        navigation.pop();
      }
    }
  }

  Future<void> addItem(SchemaNode schema, changed) async {
    log("adding menu item");

    bool success = await getIt<SettingMenuController>().addMenuSection(ref.read(menuSectionProvider)!, changed);
    if (success) {
      var current = ref.read(sectionItemsProvider);
      ref.read(sectionItemsProvider.notifier).update((s) => [...current, changed]);
      navigation.pop();
    }
  }
}
