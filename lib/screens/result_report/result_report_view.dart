import 'result_report_controller.dart';
import 'result_report_state.dart';
import 'result_report_view_phone.dart';
import 'result_report_view_tablet.dart';
import 'result_report_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class ResultReportView extends ConsumerWidget {
    const ResultReportView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      return ResultReportViewPhone();
      if(context.isDesktop){
        return ResultReportViewDesktop();
      }else if(context.isMyTablet){
        return ResultReportViewTablet();
      }else{
        return ResultReportViewPhone();
      }
    }
}

