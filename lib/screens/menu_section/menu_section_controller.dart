import 'package:abds/core/classes/menu_class.dart';
import 'package:abds/core/navigation/routes.dart';
import 'package:abds/screens/menu_item_add_edit/menu_item_add_edit_state.dart';
import 'package:logging/logging.dart';
import '../../core/interfaces/controller_int.dart';


class MenuSectionController extends ControllerInterface {
  final _log = Logger('MenuSectionController');

  void editItem(SchemaNode schema, dynamic data,String label) {
    ref.read(editingMenuProvider.notifier).update((s)=>data);
    ref.read(editingSchemaProvider.notifier).update((s)=>schema);
    ref.read(editingLabelProvider.notifier).update((s)=>label);
    goNamed(Routes.menuItemAddEdit);
  }

  void addItem(schema,String label) {
    ref.read(editingMenuProvider.notifier).update((s)=> {});
    ref.read(editingSchemaProvider.notifier).update((s)=>schema);
    ref.read(editingLabelProvider.notifier).update((s)=>label);
    goNamed(Routes.menuItemAddEdit);
  }


}
