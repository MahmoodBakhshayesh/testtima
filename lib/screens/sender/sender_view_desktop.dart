import 'package:flutter/material.dart';
import 'sender_controller.dart';
import 'sender_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class SenderViewDesktop extends StatelessWidget {
  static SenderController mySenderController = getIt<SenderController>();
  const SenderViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SenderAppBarDesktop(),
        body: Column(children: [

        ],));
  }
}

class SenderAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
static SenderController mySenderController = getIt<SenderController>();

const SenderAppBarDesktop({super.key});

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
"Sender",
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
