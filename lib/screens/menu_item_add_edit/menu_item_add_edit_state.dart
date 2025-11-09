import 'package:abds/core/classes/menu_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuItemAddEditStateProvider = ChangeNotifierProvider<MenuItemAddEditState>((_) => MenuItemAddEditState());

class MenuItemAddEditState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


final editingMenuProvider = StateProvider<Map<String,dynamic>?>((ref) => null);
final editingSchemaProvider = StateProvider<SchemaNode?>((ref) => null);
final editingLabelProvider = StateProvider<String?>((ref) => null);
