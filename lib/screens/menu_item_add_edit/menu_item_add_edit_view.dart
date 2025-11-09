import 'menu_item_add_edit_controller.dart';
import 'menu_item_add_edit_state.dart';
import 'menu_item_add_edit_view_phone.dart';
import 'menu_item_add_edit_view_tablet.dart';
import 'menu_item_add_edit_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class MenuItemAddEditView extends ConsumerWidget {
    const MenuItemAddEditView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return MenuItemAddEditViewDesktop();
      }else if(context.isMyTablet){
        return MenuItemAddEditViewTablet();
      }else{
        return MenuItemAddEditViewPhone();
      }
    }
}

