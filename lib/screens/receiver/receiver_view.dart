import 'receiver_controller.dart';
import 'receiver_state.dart';
import 'receiver_view_phone.dart';
import 'receiver_view_tablet.dart';
import 'receiver_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class ReceiverView extends ConsumerWidget {
    const ReceiverView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return ReceiverViewDesktop();
      }else if(context.isMyTablet){
        return ReceiverViewTablet();
      }else{
        return ReceiverViewPhone();
      }
    }
}

