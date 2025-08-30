import 'package:flutter/material.dart';
import 'dynamsoft_mrz_controller.dart';
import 'dynamsoft_mrz_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class DynamsoftMrzViewTablet extends StatelessWidget {
  static DynamsoftMrzController myDynamsoftMrzController = getIt<DynamsoftMrzController>();
  const DynamsoftMrzViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: DynamsoftMrzAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class DynamsoftMrzAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static DynamsoftMrzController myDynamsoftMrzController = getIt<DynamsoftMrzController>();

const DynamsoftMrzAppBarTablet({super.key});

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
