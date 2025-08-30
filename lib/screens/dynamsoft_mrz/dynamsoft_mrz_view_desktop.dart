import 'package:flutter/material.dart';
import 'dynamsoft_mrz_controller.dart';
import 'dynamsoft_mrz_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class DynamsoftMrzViewDesktop extends StatelessWidget {
  static DynamsoftMrzController myDynamsoftMrzController = getIt<DynamsoftMrzController>();
  const DynamsoftMrzViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DynamsoftMrzAppBarDesktop(),
        body: Column(children: [

        ],));
  }
}

class DynamsoftMrzAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
static DynamsoftMrzController myDynamsoftMrzController = getIt<DynamsoftMrzController>();

const DynamsoftMrzAppBarDesktop({super.key});

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
"DynamsoftMrz",
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
