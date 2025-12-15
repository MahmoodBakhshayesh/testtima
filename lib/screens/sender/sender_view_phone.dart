import 'package:abds/widgets/MyButton.dart';
import 'package:camera_kit_plus/camera_kit_ocr_plus_view.dart';
import 'package:camera_kit_plus/camera_kit_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'sender_controller.dart';
import 'sender_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class SenderViewPhone extends ConsumerStatefulWidget {
  const SenderViewPhone({super.key});

  @override
  ConsumerState<SenderViewPhone> createState() => _SenderViewPhoneState();
}

class _SenderViewPhoneState extends ConsumerState<SenderViewPhone> {
  static SenderController mySenderController = getIt<SenderController>();

  @override
  Widget build(BuildContext context) {
    bool connected = ref.watch(connectedToReceiverProvider);
    return Scaffold(
      appBar: SettingMenuAppBarPhone(),
      body: Column(
        children: [
          connected
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyButton(
                              width: 200,
                              height: 200,
                              fontSize: 16,
                              color: Colors.red,
                              label: "Disconnect",
                              onPressed: () async {
                                await mySenderController.disconnectFromReceiver();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Expanded(child: Column(
                children: [
                  Padding(padding: EdgeInsetsGeometry.all(12),child: Row(children: [Expanded(child: Center(child: Text("Scan receiver QR to connect!")))],),),
                  Expanded(child: CameraKitPlusView(onBarcodeRead: mySenderController.onBarcodeRead)),
                ],
              )),
        ],
      ),
    );
  }
}

class SettingMenuAppBarPhone extends StatelessWidget implements PreferredSizeWidget {
  static SenderController mySenderController = getIt<SenderController>();

  const SettingMenuAppBarPhone({super.key});

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
                      Text("Sender", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
