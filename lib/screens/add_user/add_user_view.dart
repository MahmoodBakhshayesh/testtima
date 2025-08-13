import 'add_user_controller.dart';
import 'add_user_state.dart';
import 'add_user_view_phone.dart';
import 'add_user_view_tablet.dart';
import 'add_user_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class AddUserView extends ConsumerWidget {
    const AddUserView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return AddUserViewDesktop();
      }else if(context.isMyTablet){
        return AddUserViewTablet();
      }else{
        return AddUserViewPhone();
      }
    }
}

