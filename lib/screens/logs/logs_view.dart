import 'logs_controller.dart';
import 'logs_state.dart';
import 'logs_view_phone.dart';
import 'logs_view_tablet.dart';
import 'logs_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class LogsView extends ConsumerWidget {
    const LogsView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return LogsViewDesktop();
      }else if(context.isMyTablet){
        return LogsViewTablet();
      }else{
        return LogsViewPhone();
      }
    }
}

