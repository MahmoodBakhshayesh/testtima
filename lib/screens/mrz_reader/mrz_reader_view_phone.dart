import 'package:abds/core/constants/ui.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  // OcrMrzSetting setting = OcrMrzSetting(validateNames: false, validatePersonalNumberValid: false,validateFinalCheckValid: false);

  bool showLogs = false;

  @override
  void initState() {
    myMrzReaderController.popping = false;
    super.initState();
  }

  changeSetting() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OcrSettingDialog(current: myMrzReaderController.ref.read(ocrMrzSettingProvider));
      },
    ).then((sett) {
      if (sett is OcrMrzSetting) {
        myMrzReaderController.ref.read(ocrMrzSettingProvider.notifier).update((s) => sett);
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
            onLongPress: () {
              showLogs = !showLogs;
              setState(() {});
            },
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
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final lastLog = ref.watch(ocrMrzLogsProvider).lastOrNull;
                final improving = ref.watch(improvingMrzResultProvider);
                return Stack(
                  children: [
                    OcrMrzReader(
                      mrzLogger: myMrzReaderController.mrzLogger,
                      onFoundMrz: myMrzReaderController.docImproving,
                      setting: OcrMrzSetting(
                        validatePersonalNumberValid: false,
                        validateNames: false,
                        validateLinesLength: false,
                        validateFinalCheckValid: false,
                        validateExpiryDateValid: false,
                        validateDocNumberValid: false,
                        validateBirthDateValid: false,
                        validateCountry: false,
                        validateNationality: false,
                      ),
                    ),
                    Positioned(top: 0, left: 0, right: 0, child: ImprovingResultWidget()),
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: lastLog == null || !showLogs
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [Expanded(child: FittedBox(child: Text(lastLog.rawMrzLines.join("\n"))))],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [Expanded(child: FittedBox(child: Text(lastLog.fixedMrzLines.join("\n"))))],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [Expanded(child: FittedBox(child: Text(lastLog.validation.toString())))],
                                  ),
                                  Divider(),
                                  improving == null
                                      ? SizedBox()
                                      : Row(
                                          children: [Expanded(child: FittedBox(child: Text(improving.valid.toString())))],
                                        ),
                                ],
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
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

class ImprovingResultWidget extends ConsumerWidget {
  const ImprovingResultWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OcrMrzSetting setting = ref.watch(ocrMrzSettingProvider);
    OcrMrzResult? improving = ref.watch(improvingMrzResultProvider);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      child: Column(
        children: [
          Wrap(
            runSpacing: 4,
            direction: Axis.horizontal,
            spacing: 12,

            children: [
              ?setting.validateNationality ? SingularValidationWidget(label: 'Nationality', valid: improving?.valid.nationalityValid ?? false,value: improving?.nationality,) : null,
              ?setting.validateCountry ? SingularValidationWidget(label: 'Issuing', valid: improving?.valid.countryValid ?? false,value: improving?.countryCode,) : null,
              ?setting.validateExpiryDateValid ? SingularValidationWidget(label: 'Expiry Date', valid: improving?.valid.expiryDateValid ?? false,value: improving?.expiryDate?.format_yyyyMMdd,) : null,
              ?setting.validateBirthDateValid ? SingularValidationWidget(label: 'Birth Date', valid: improving?.valid.birthDateValid ?? false,value: improving?.birthDate?.format_yyyyMMdd,) : null,
              ?setting.validateDocNumberValid ? SingularValidationWidget(label: 'Doc NO.', valid: improving?.valid.docNumberValid ?? false,value: improving?.documentNumber,) : null,
              ?setting.validateFinalCheckValid ? SingularValidationWidget(label: 'Final Check', valid: improving?.valid.finalCheckValid ?? false,value:(improving?.valid.finalCheckValid??false)?"Yes":"No",) : null,
              ?setting.validateNames ? SingularValidationWidget(label: 'Name', valid: improving?.valid.nationalityValid ?? false,value: "${improving?.firstName??''} ${improving?.lastName}",) : null,
              ?setting.validatePersonalNumberValid ? SingularValidationWidget(label: 'Personal NO.', valid: improving?.valid.personalNumberValid ?? false,value: improving?.personalNumber,) : null,
              ?setting.validateLinesLength ? SingularValidationWidget(label: 'Lines Length', valid: improving?.valid.linesLengthValid ?? false,value:(improving?.valid.linesLengthValid??false)?"Yes":"No",) : null,
            ],
          ),
          const SizedBox(height: 12),
          Visibility(
            visible: improving!=null,
            child: Row(
              children: [
                Expanded(
                  child: MyButton(
                    label: "Submit",
                    onPressed: () {
                      getIt<MrzReaderController>().submitCurrent(improving!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SingularValidationWidget extends StatelessWidget {
  final String label;
  final String? value;
  final bool valid;

  const SingularValidationWidget({super.key, required this.label, required this.value,required this.valid});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color color = valid ? MyColors.green2 : Colors.grey;
    return Container(
      width: (context.width - 60) * 0.25,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1),
        color: color.withOpacity(.3),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12,height: 1),

          ),
          Text(
            value??'',
            style: TextStyle(color: color,fontSize: 11,height: 1),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
