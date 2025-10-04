import 'outbox_controller.dart';
import 'outbox_state.dart';
import 'outbox_view_phone.dart';
import 'outbox_view_tablet.dart';
import 'outbox_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class OutboxView extends ConsumerWidget {
    const OutboxView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return OutboxViewDesktop();
      }else if(context.isMyTablet){
        return OutboxViewTablet();
      }else{
        return OutboxViewPhone();
      }
    }
}

