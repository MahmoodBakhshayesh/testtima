import 'package:flutter/material.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import 'package:ocr_mrz/ocr_mrz.dart';
import 'mrz_reader_controller.dart';
import 'mrz_reader_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class MrzReaderViewPhone extends StatefulWidget {
  const MrzReaderViewPhone({super.key});

  @override
  State<MrzReaderViewPhone> createState() => _MrzReaderViewPhoneState();
}

class _MrzReaderViewPhoneState extends State<MrzReaderViewPhone> {
  static MrzReaderController myMrzReaderController = getIt<MrzReaderController>();


  @override
  void initState() {
    myMrzReaderController.popping = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MrzReaderAppBar(),
      body: Column(
        children: [Expanded(child: OcrMrzReader(onFoundMrz: myMrzReaderController.onDocScan))],
      ),
    );
  }
}

class MrzReaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  static MrzReaderController myMrzReaderController = getIt<MrzReaderController>();

  const MrzReaderAppBar({super.key});

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
                        "Mrz Reader",
                        style: TextStyle( fontWeight: FontWeight.w700, fontSize: 18),
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
