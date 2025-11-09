import 'setting_menu_controller.dart';
import 'setting_menu_state.dart';
import 'setting_menu_view_phone.dart';
import 'setting_menu_view_tablet.dart';
import 'setting_menu_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class SettingMenuView extends ConsumerWidget {
    const SettingMenuView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return SettingMenuViewDesktop();
      }else if(context.isMyTablet){
        return SettingMenuViewPhone();
      }else{
        return SettingMenuViewPhone();
      }
    }
}

