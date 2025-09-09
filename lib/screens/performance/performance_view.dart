import 'performance_controller.dart';
import 'performance_state.dart';
import 'performance_view_phone.dart';
import 'performance_view_tablet.dart';
import 'performance_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class PerformanceView extends ConsumerWidget {
    const PerformanceView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return PerformanceViewPhone();
      }else if(context.isMyTablet){
        return PerformanceViewPhone();
      }else{
        return PerformanceViewPhone();
      }
    }
}

