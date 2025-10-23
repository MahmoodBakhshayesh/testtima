import 'package:flutter/material.dart';
import 'result_report_controller.dart';
import 'result_report_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class ResultReportViewTablet extends StatelessWidget {
  static ResultReportController myResultReportController = getIt<ResultReportController>();
  const ResultReportViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: ResultReportAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class ResultReportAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static ResultReportController myResultReportController = getIt<ResultReportController>();

const ResultReportAppBarTablet({super.key});

@override
Size get preferredSize => const Size.fromHeight(108);

@override
Widget build(BuildContext context) {
return Container(
height: preferredSize.height,
color: context.mainColor,
alignment: Alignment.center,
child: const SafeArea(
child: Row(
children: [
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Row(
children: [
Text(
"ResultReport",
style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),
),
Spacer(),
SizedBox(width: 8),
],
),
],
),
),
],
),
),
);
}
}
