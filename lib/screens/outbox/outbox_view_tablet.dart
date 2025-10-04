import 'package:flutter/material.dart';
import 'outbox_controller.dart';
import 'outbox_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class OutboxViewTablet extends StatelessWidget {
  static OutboxController myOutboxController = getIt<OutboxController>();
  const OutboxViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: OutboxAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class OutboxAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static OutboxController myOutboxController = getIt<OutboxController>();

const OutboxAppBarTablet({super.key});

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
"Outbox",
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
