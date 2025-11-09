import 'package:abds/core/classes/menu_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingMenuStateProvider = ChangeNotifierProvider<SettingMenuState>((_) => SettingMenuState());

class SettingMenuState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


final settingMenuProvider = StateProvider<SettingMenu?>((ref) => null);
final menuValuesProvider = StateProvider<Map<String,dynamic>>((ref) => {});
final menuLoadingProvider = StateProvider<bool>((ref) => false);
