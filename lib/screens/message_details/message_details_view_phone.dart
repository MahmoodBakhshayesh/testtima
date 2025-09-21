import 'dart:developer';

import 'package:abds/core/classes/ref_history_log_class.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../inbox/inbox_state.dart';
import 'message_details_controller.dart';
import 'message_details_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class MessageDetailsViewPhone extends ConsumerStatefulWidget {
  static MessageDetailsController myMessageDetailsController = getIt<MessageDetailsController>();

  const MessageDetailsViewPhone({super.key});

  @override
  ConsumerState<MessageDetailsViewPhone> createState() => _MessageDetailsViewPhoneState();
}

class _MessageDetailsViewPhoneState extends ConsumerState<MessageDetailsViewPhone> {
  @override
  Widget build(BuildContext context) {
    final logs = ref.watch(inboxMessageDetailsProvider);
    return Scaffold(
      appBar: MessageDetailsAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (c, i) {
                final log = logs[i];
                return LogWidget(logHistory: log);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MessageDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  static MessageDetailsController myMessageDetailsController = getIt<MessageDetailsController>();

  const MessageDetailsAppBar({super.key});

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
                      Text("Message Details", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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

class LogWidget extends StatelessWidget {
  final RefHistoryLog logHistory;

  const LogWidget({super.key, required this.logHistory});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        log(logHistory.payload?.input??'');
      },
      child: Container(
        margin: EdgeInsets.only(left: 8,right: 8,top: 8),
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(children: [Text(logHistory.type ?? '')]),
      ),
    );
  }
}
