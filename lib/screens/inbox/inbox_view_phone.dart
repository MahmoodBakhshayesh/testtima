import 'package:flutter/material.dart';
import 'inbox_controller.dart';
import 'inbox_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class InboxViewPhone extends StatelessWidget {
  static InboxController myInboxController = getIt<InboxController>();
  const InboxViewPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: InboxAppBar(),
        body: Column(children: [

        ],));
  }
}


class InboxAppBar extends StatelessWidget implements PreferredSizeWidget {
  static InboxController myInboxController = getIt<InboxController>();

  const InboxAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      BackButton(),
                      Text("Inbox", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
