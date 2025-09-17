import 'package:flutter/material.dart';
import 'inbox_controller.dart';
import 'inbox_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class InboxViewTablet extends StatelessWidget {
  static InboxController myInboxController = getIt<InboxController>();
  const InboxViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: InboxAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class InboxAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static InboxController myInboxController = getIt<InboxController>();

const InboxAppBarTablet({super.key});

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
"Inbox",
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
