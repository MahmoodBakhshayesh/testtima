import 'sender_controller.dart';
import 'sender_state.dart';
import 'sender_view_phone.dart';
import 'sender_view_tablet.dart';
import 'sender_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class SenderView extends ConsumerWidget {
    const SenderView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return SenderViewDesktop();
      }else if(context.isMyTablet){
        return SenderViewTablet();
      }else{
        return SenderViewPhone();
      }
    }
}

