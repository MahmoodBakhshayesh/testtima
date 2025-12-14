import 'package:abds/screens/receiver/receiver_view_desktop.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widgets/MyButton.dart';
import 'receiver_controller.dart';
import 'receiver_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class ReceiverViewPhone extends StatelessWidget {
  static ReceiverController myReceiverController = getIt<ReceiverController>();
  const ReceiverViewPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReceiverAppBarDesktop(),
      body: Column(
        children: [
          MyButton(
            label: "Get Data",
            onPressed: () {
              myReceiverController.getReceiverData();
            },
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final receiverData = ref.watch(receiverDataProvider);
              if (receiverData != null) {
                return Column(
                  children: [
                    Padding(padding: const EdgeInsets.all(8.0), child: Text("Scan Qr to Connect")),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: BarcodeWidget(data: receiverData.yourId, barcode: Barcode.aztec()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyButton(
                        label: "Start Listen",
                        onPressed: () async {
                          await myReceiverController.initReceiver();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyButton(
                        label: "Send",
                        onPressed: () async {
                          await myReceiverController.sendToReceiver(receiverId: receiverData.yourId);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyButton(
                        label: "Call it",
                        onPressed: () async {
                          await myReceiverController.sendToReceiver(receiverId: receiverData.yourId);
                        },
                      ),
                    ),
                  ],
                );
              }
              return Column();
            },
          ),
        ],
      ),
    );
  }
}


class ReceiverAppBar extends StatelessWidget implements PreferredSizeWidget {
    static ReceiverController myReceiverController = getIt<ReceiverController>();

const ReceiverAppBar({super.key});

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
