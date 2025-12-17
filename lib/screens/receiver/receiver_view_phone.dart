import 'dart:developer';

import 'package:abds/core/constants/assest.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/utils_and_services/recevier_socket_new.dart';
import '../../widgets/MyExpansionTile.dart';
import '../home/new_widgets/flight_widget.dart';
import '../home/new_widgets/passenger_widget.dart';
import '../home/new_widgets/passport_widget.dart';
import '../home/new_widgets/resident_widget.dart';
import '../home/new_widgets/visa_widget.dart';
import '../home/widgets/logs_and_attachments.dart';
import '../home/widgets/timatic_response_widget.dart';
import '../result_report/result_report_state.dart';
import 'receiver_controller.dart';
import 'receiver_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class ReceiverViewPhone extends ConsumerStatefulWidget {
  const ReceiverViewPhone({super.key});

  @override
  ConsumerState<ReceiverViewPhone> createState() => _ReceiverViewPhoneState();
}

class _ReceiverViewPhoneState extends ConsumerState<ReceiverViewPhone> {
  static ReceiverController myReceiverController = getIt<ReceiverController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myReceiverController.getReceiverData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timaticRes = ref.watch(reportTimaticResultNewProvider);
    final receiverData = ref.watch(receiverDataProvider);
    final senderData= ref.watch(senderDataProvider);
    bool resultMode = timaticRes != null;
    int index = 0;
    if (ref.watch(receiverDataProvider) == null) {
      index = 0;
    } else {
      index = ref.watch(receiverStatusProvider).index;
    }
    return Scaffold(
      appBar: ReceiverAppBarPhone(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IndexedStack(
                index: index,
                alignment: Alignment.center,
                children: [
                  receiverData == null
                      ? Column(
                    children: [
                      Text("Getting Data..."),
                      SpinKitChasingDots(color: context.mainColor, size: 50),
                    ],
                  )
                      : Column(
                    children: [
                      MyButton(
                        label: "Connect",
                        onPressed: () async {
                          await myReceiverController.initReceiver();
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Connecting..."),
                      SpinKitChasingDots(color: context.mainColor, size: 50),
                    ],
                  ),
                  senderData==null?
                  Column(
                    children: [
                      Text("No Sender Connected"),
                      Text("Scan Qr from Sender to Connect..."),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: BarcodeWidget(data: receiverData?.yourId ?? '', barcode: Barcode.aztec()),
                      ),
                      const SizedBox(height: 12),
                      MyButton(
                        label: "Disconnect",
                        color: Colors.red,
                        onPressed: () {
                          myReceiverController.disconnect();
                        },
                      ),
                    ],
                  ):Column(children: [
                    Text("${senderData.response.sender.username} Connected"),
                    const SizedBox(height: 12),
                    Image.asset(AssetImages.mobileSender),
                    const SizedBox(height: 12),
                    MyButton(
                      label: "Disconnect",
                      color: Colors.red,
                      onPressed: () {
                        myReceiverController.disconnect();
                      },
                    ),
                  ],),
                  Column(
                    children: [
                      MyButton(
                        label: "Reconnect",
                        onPressed: () async {
                          await myReceiverController.initReceiver();
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MyButton(
                        label: "Retry Connection",
                        onPressed: () async {
                          await myReceiverController.initReceiver();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceiverAppBarPhone extends StatelessWidget implements PreferredSizeWidget {
  static ReceiverController myReceiverController = getIt<ReceiverController>();

  const ReceiverAppBarPhone({super.key});

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
                      Text("Receiver", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
