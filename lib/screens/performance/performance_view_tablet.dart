import 'package:flutter/material.dart';
import 'performance_controller.dart';
import 'performance_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class PerformanceViewTablet extends StatelessWidget {
  static PerformanceController myPerformanceController = getIt<PerformanceController>();
  const PerformanceViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PerformanceAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class PerformanceAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static PerformanceController myPerformanceController = getIt<PerformanceController>();

const PerformanceAppBarTablet({super.key});

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
"Performance",
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
