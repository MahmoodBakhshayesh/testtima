import 'package:flutter/material.dart';
import 'message_details_controller.dart';
import 'message_details_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class MessageDetailsViewDesktop extends StatelessWidget {
  static MessageDetailsController myMessageDetailsController = getIt<MessageDetailsController>();
  const MessageDetailsViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MessageDetailsAppBarDesktop(),
        body: Column(children: [

        ],));
  }
}

class MessageDetailsAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
static MessageDetailsController myMessageDetailsController = getIt<MessageDetailsController>();

const MessageDetailsAppBarDesktop({super.key});

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
"MessageDetails",
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
