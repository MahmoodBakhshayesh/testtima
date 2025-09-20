import 'package:flutter/material.dart';
import 'message_details_controller.dart';
import 'message_details_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class MessageDetailsViewPhone extends StatelessWidget {
  static MessageDetailsController myMessageDetailsController = getIt<MessageDetailsController>();
  const MessageDetailsViewPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MessageDetailsAppBar(),
        body: Column(children: [

        ],));
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
                                        SizedBox(width: 16),
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
