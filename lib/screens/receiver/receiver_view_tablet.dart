import 'package:flutter/material.dart';
import 'receiver_controller.dart';
import 'receiver_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class ReceiverViewTablet extends StatelessWidget {
  static ReceiverController myReceiverController = getIt<ReceiverController>();
  const ReceiverViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: ReceiverAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class ReceiverAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static ReceiverController myReceiverController = getIt<ReceiverController>();

const ReceiverAppBarTablet({super.key});

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
"Receiver",
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
