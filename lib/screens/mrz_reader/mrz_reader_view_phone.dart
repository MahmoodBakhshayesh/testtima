import 'package:abds/widgets/DotButton.dart';
import 'package:flutter/material.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import 'package:ocr_mrz/ocr_mrz.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:ocr_mrz/ocr_setting_dialog.dart';
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
  OcrMrzSetting setting = OcrMrzSetting(validateNames: false, validatePersonalNumberValid: false,validateFinalCheckValid: false);

  @override
  void initState() {
    myMrzReaderController.popping = false;
    super.initState();
  }

  changeSetting() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OcrSettingDialog(current: setting);
      },
    ).then((s) {
      if (s is OcrMrzSetting) {
        setting = s;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MrzReaderAppBar(
        actions: [
          DotButton(
            icon: Icons.settings,
            onPressed: () {
              changeSetting();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: OcrMrzReader(onFoundMrz: myMrzReaderController.onDocScan, setting: setting),
          ),
        ],
      ),
    );
  }
}

class MrzReaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  static MrzReaderController myMrzReaderController = getIt<MrzReaderController>();

  const MrzReaderAppBar({super.key, this.actions = const []});

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
                      Text("MRZ Reader", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      Spacer(),
                      ...actions,
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
