import 'package:flutter/material.dart';
import 'logs_controller.dart';
import 'logs_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class LogsViewTablet extends StatelessWidget {
  static LogsController myLogsController = getIt<LogsController>();
  const LogsViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: LogsAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class LogsAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static LogsController myLogsController = getIt<LogsController>();

const LogsAppBarTablet({super.key});

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
"Logs",
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
