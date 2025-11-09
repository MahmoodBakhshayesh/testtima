import 'package:abds/core/classes/menu_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuSectionStateProvider = ChangeNotifierProvider<MenuSectionState>((_) => MenuSectionState());

class MenuSectionState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}

final menuSectionProvider = StateProvider<MenuDescriptor?>((ref) => null);
final sectionItemsProvider = StateProvider<List<dynamic>>((ref) => []);
