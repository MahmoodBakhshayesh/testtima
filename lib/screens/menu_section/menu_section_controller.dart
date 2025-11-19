import 'package:abds/core/classes/menu_class.dart';
import 'package:abds/core/navigation/routes.dart';
import 'package:abds/screens/menu_item_add_edit/menu_item_add_edit_state.dart';
import 'package:logging/logging.dart';
import '../../core/interfaces/controller_int.dart';


class MenuSectionController extends ControllerInterface {
  final _log = Logger('MenuSectionController');

  void editItem(SchemaNode schema, dynamic data,String label,bool isDesktop) {
    if(data is List && data.isNotEmpty){
      data = data.first;
    }
    ref.read(editingMenuProvider.notifier).update((s)=>null);
    ref.read(editingSchemaProvider.notifier).update((s)=>null);
    ref.read(editingLabelProvider.notifier).update((s)=>null);
    Future.delayed(Duration(milliseconds: 10),(){
      ref.read(editingMenuProvider.notifier).update((s)=>data);
      ref.read(editingSchemaProvider.notifier).update((s)=>schema);
      ref.read(editingLabelProvider.notifier).update((s)=>label);
    });

    if(!isDesktop) {
      goNamed(Routes.menuItemAddEdit);
    }
  }

  void addItem(schema,String label,bool isDesktop) {
    ref.read(editingMenuProvider.notifier).update((s)=>null);
    ref.read(editingSchemaProvider.notifier).update((s)=>null);
    ref.read(editingLabelProvider.notifier).update((s)=>null);
    Future.delayed(Duration(milliseconds: 10),(){
      ref.read(editingMenuProvider.notifier).update((s)=> {});
      ref.read(editingSchemaProvider.notifier).update((s)=>schema);
      ref.read(editingLabelProvider.notifier).update((s)=>label);
    });


    if(!isDesktop) {
      goNamed(Routes.menuItemAddEdit);
    }
  }


}
