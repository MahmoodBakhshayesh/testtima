import 'package:flutter/material.dart';
import 'barcode_reader_controller.dart';
import 'barcode_reader_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class BarcodeReaderViewDesktop extends StatelessWidget {
  static BarcodeReaderController myBarcodeReaderController = getIt<BarcodeReaderController>();
  const BarcodeReaderViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BarcodeReaderAppBarDesktop(),
        body: Column(children: [

        ],));
  }
}

class BarcodeReaderAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
static BarcodeReaderController myBarcodeReaderController = getIt<BarcodeReaderController>();

const BarcodeReaderAppBarDesktop({super.key});

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
"BarcodeReader",
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
