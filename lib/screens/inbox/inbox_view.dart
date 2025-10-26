import 'inbox_controller.dart';
import 'inbox_state.dart';
import 'inbox_view_phone.dart';
import 'inbox_view_tablet.dart';
import 'inbox_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class InboxView extends ConsumerWidget {
    const InboxView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return InboxViewDesktop();
      }else if(context.isMyTablet){
        return InboxViewPhone();
      }else{
        return InboxViewPhone();
      }
    }
}

