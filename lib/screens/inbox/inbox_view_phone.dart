import 'dart:developer';
import 'package:abds/widgets/AirlineLogo.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/drawer_action.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/classes/inbox_message_class.dart';
import '../../core/constants/ui.dart';
import 'inbox_controller.dart';
import 'inbox_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class InboxViewPhone extends StatefulWidget {
  const InboxViewPhone({super.key});

  @override
  State<InboxViewPhone> createState() => _InboxViewPhoneState();
}

class _InboxViewPhoneState extends State<InboxViewPhone> {
  static InboxController myInboxController = getIt<InboxController>();
  TextEditingController codeC = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((a) {
      myInboxController.getInboxMessages();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InboxAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(child: SizedBox(height:40,child: CupertinoTextField(controller: codeC,keyboardType: TextInputType.numberWithOptions(signed: true),))),
              MyButton(label: "Get",onPressed: () async {
                await myInboxController.goMessageDetails(codeC.text);
              })
            ],),
          ),
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final messages = ref.watch(inboxMessagesProvider);

                return ListView.builder(
                  itemBuilder: (c, i) {
                    final message = messages[i];
                    return InboxMessageWidget(
                      key: Key(message.code!),
                      onTap: () async {
                        await myInboxController.goMessageDetails(message.code!);
                      },
                      message: message,
                      index: i,
                    );
                  },
                  itemCount: messages.length,
                );
              },
            ),
          ),
        ],
      ),
    );
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

class InboxMessageWidget extends StatefulWidget {
  final InboxMessage message;
  final int index;
  final Function? onTap;

  const InboxMessageWidget({Key? key, required this.message, required this.index, this.onTap}) : super(key: key);

  @override
  State<InboxMessageWidget> createState() => _InboxMessageWidgetState();
}

class _InboxMessageWidgetState extends State<InboxMessageWidget> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isOdd = widget.index % 2 != 0;
    const TextStyle headerTextStyle = TextStyle(fontWeight: FontWeight.w600, color: MyColors.black, fontSize: 11);
    return InkWell(
      onTap: () async {
        if(loading){
          return;
        }
        loading = true;
        setState((){});
        await widget.onTap?.call();
        loading = false;
        setState((){});
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: !isOdd ? MyColors.white2 : MyColors.white3),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(widget.message.code ?? '')),
                loading?SpinKitThreeBounce(color: context.mainColor,size: 20,):
                Text("${widget.message.user?.username ?? widget.message?.user?.email}"),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      AirlineLogo(widget.message.airline ?? '--'),
                      Column(
                        children: [
                          Text("${widget.message.airline ?? ''}${widget.message.flightNumber ?? ''}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          Text("${widget.message.from ?? ''}-${widget.message.to ?? ''}", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    // Text("${message.createdAt?.toLocal().format_ddMMM}\n${message.createdAt?.toLocal().format_HHmmss}",style: TextStyle(fontSize: 8),textAlign: TextAlign.center,),
                    Text(
                      "${DateFormat("dd MMM yyyy - hh:mm").format(widget.message.createdAt!.toLocal())}",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
