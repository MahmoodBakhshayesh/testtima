import 'menu_section_controller.dart';
import 'menu_section_state.dart';
import 'menu_section_view_phone.dart';
import 'menu_section_view_tablet.dart';
import 'menu_section_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class MenuSectionView extends ConsumerWidget {
    const MenuSectionView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return MenuSectionViewDesktop();
      }else if(context.isMyTablet){
        return MenuSectionViewTablet();
      }else{
        return MenuSectionViewPhone();
      }
    }
}

