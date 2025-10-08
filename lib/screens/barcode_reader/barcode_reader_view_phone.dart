import 'package:camera_kit_plus/camera_kit_plus.dart';
import 'package:flutter/material.dart';
import 'barcode_reader_controller.dart';
import 'barcode_reader_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class BarcodeReaderViewPhone extends StatelessWidget {
  static BarcodeReaderController myBarcodeReaderController = getIt<BarcodeReaderController>();

  const BarcodeReaderViewPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarcodeReaderAppBar(),
      body: Column(
        children: [Expanded(child: CameraKitPlusView(
            showZoomSlider: true,
            onBarcodeRead: myBarcodeReaderController.onBarcodeRead))],
      ),
    );
  }
}

class BarcodeReaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  static BarcodeReaderController myBarcodeReaderController = getIt<BarcodeReaderController>();

  const BarcodeReaderAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
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
                      BackButton(),
                      Text(
                        "Barcode Reader",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
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
