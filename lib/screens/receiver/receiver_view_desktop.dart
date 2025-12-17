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

class ReceiverViewDesktop extends ConsumerStatefulWidget {
  const ReceiverViewDesktop({super.key});

  @override
  ConsumerState<ReceiverViewDesktop> createState() => _ReceiverViewDesktopState();
}

class _ReceiverViewDesktopState extends ConsumerState<ReceiverViewDesktop> {
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
    log("${WebSocketConnectionState.values.map((a)=>"${a.name} - ${a.index}").join("\n")}");
    log("${ref.watch(receiverStatusProvider)} == ${ref.watch(receiverStatusProvider).index}");
    if (ref.watch(receiverDataProvider) == null) {
      index = 0;
    } else {
      index = ref.watch(receiverStatusProvider).index+1;
    }
    return Scaffold(
      appBar: ReceiverAppBarDesktop(),
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
                        onPressed: () async {
                          await myReceiverController.disconnect();
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
                      onPressed: () async {
                        await myReceiverController.disconnect();
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
          // Expanded(
          //   child: Column(
          //     children: [
          //       MyButton(
          //         label: "Get Data",
          //         onPressed: () {
          //           ReceiverViewDesktop.myReceiverController.getReceiverData();
          //         },
          //       ),
          //
          //       Consumer(
          //         builder: (BuildContext context, WidgetRef ref, Widget? child) {
          //           final receiverData = ref.watch(receiverDataProvider);
          //           if (receiverData != null) {
          //             return Column(
          //               children: [
          //                 Padding(padding: const EdgeInsets.all(8.0), child: Text("Scan Qr to Connect")),
          //                 Text("${ref.watch(receiverStatusProvider).name}"),
          //                 SizedBox(
          //                   width: 200,
          //                   height: 200,
          //                   child: BarcodeWidget(data: receiverData.yourId, barcode: Barcode.aztec()),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: MyButton(
          //                     label: "Start Listen",
          //                     onPressed: () async {
          //                       await ReceiverViewDesktop.myReceiverController.initReceiver();
          //                     },
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: MyButton(
          //                     label: "Send",
          //                     onPressed: () async {
          //                       await ReceiverViewDesktop.myReceiverController.sendToReceiver(receiverId: receiverData.yourId);
          //                     },
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: MyButton(
          //                     label: "Call it",
          //                     onPressed: () async {
          //                       await ReceiverViewDesktop.myReceiverController.callIt(receiverId: receiverData.yourId);
          //                     },
          //                   ),
          //                 ),
          //               ],
          //             );
          //           }
          //           return Column();
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            flex: 3,
            child: Visibility(
              visible: ref.read(reportTimaticResultNewProvider) != null,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    LogsAndAttachmentsWidget(report: true),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: MyExpansionTile(
                        initiallyExpanded: true,
                        backgroundColor: Colors.white.withOpacity(0.5),
                        collapsedBackgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(28),
                          side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(28),
                          side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                        ),
                        childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                        tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        showTrailingIcon: true,
                        title: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(children: []),
                        ),
                        showFooter: false,
                        children: [FlightWidget(report: true), PassengerWidget(report: true), PassportWidget(report: true), VisaWidget(report: true), ResidentWidget(report: true)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: timaticRes == null
                ? SizedBox()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MyExpansionTile(
                        initiallyExpanded: true,
                        showTrailingIcon: true,
                        backgroundColor: timaticRes!.getRes.getColor.withOpacity(0.08),
                        collapsedBackgroundColor: timaticRes!.getRes.getColor.withOpacity(0.08),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(28),
                          side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(28),
                          side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                        ),
                        childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                        tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text("TIMATIC ${ref.watch(reportRefCodeShowProvider)} ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                              resultMode
                                  ? Row(
                                      children: [
                                        timaticRes.getRes.getIconWidget,
                                        Text(timaticRes!.getRes.title, style: TextStyle(color: timaticRes.getRes.getColor)),
                                        // Text("${ref.watch(timaticResultProvider)!.refCode}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        showFooter: false,
                        children: resultMode
                            ? [
                                Consumer(
                                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                    final result = ref.watch(reportTimaticResultNewProvider);
                                    final refCode = ref.watch(reportRefCodeProvider);
                                    if (result == null) {
                                      return SizedBox();
                                    }
                                    // return SizedBox(height: 100);
                                    return Column(
                                      children: [
                                        TimaticTrueResultWidgetNew(res: result, refCode: refCode!),
                                        const SizedBox(height: 12),
                                      ],
                                    );
                                  },
                                ),
                              ]
                            : [
                                Column(
                                  children: [
                                    const SizedBox(height: 300),
                                    Text("After filling out data, Click on"),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Spacer(),
                                        Expanded(flex: 2, child: SizedBox()),
                                        Spacer(),
                                      ],
                                    ),
                                    const SizedBox(height: 300),
                                  ],
                                ),
                              ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class ReceiverAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
  static ReceiverController myReceiverController = getIt<ReceiverController>();

  const ReceiverAppBarDesktop({super.key});

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
