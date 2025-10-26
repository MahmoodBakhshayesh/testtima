import 'package:flutter/material.dart';
import 'cupps_controller.dart';
import 'cupps_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class CuppsViewTablet extends StatelessWidget {
  static CuppsController myCuppsController = getIt<CuppsController>();
  const CuppsViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CuppsAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class CuppsAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static CuppsController myCuppsController = getIt<CuppsController>();

const CuppsAppBarTablet({super.key});

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
"Cupps",
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
