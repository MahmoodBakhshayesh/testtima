import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/navigation/routes.dart';
import 'package:abds/screens/mrz_reader/dialogs/field_stat_dialog.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:camera_kit_plus/camera_kit_ocr_plus_view.dart';
import 'package:dynamsoft_mrz_scanner_bundle_flutter/dynamsoft_mrz_scanner_bundle_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import 'package:ocr_mrz/ocr_mrz.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:ocr_mrz/ocr_setting_dialog.dart';
import '../../core/classes/mrz_agg_class.dart';
import 'dialogs/my_ocr_setting.dart';
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

  // bool showLogs = false;

  @override
  void initState() {
    myMrzReaderController.popping = false;
    myMrzReaderController.agg.reset();
    myMrzReaderController.ocrMrzController.resetSession();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        myMrzReaderController.ref.read(showDynamsoftProvider.notifier).update((s) => true);
      });
    });
    super.initState();
  }

  String _displayString = "";

  void _launchMrzScanner() async {
    var config = MRZScannerConfig(
        license: "t0108HAEAAFuUUCZglgo8GwMcHSsS/hmoftYbPmdVszqv7y1geIXhILFWDVmCFQRhpWo42ThAPDayTfo9K9kcXy4WPiDm2mTiAnAaYIqd7dvc9IE7euZHjWOPs8PxzNUpKv879dKW6qbSfQNgRTmN;t0111HAEAAFvgiyPmMNjwq1eLJlZIdaEzDmgK5UM4LRntJnTyHIbt8PDY5nkFJz5R8m+cQjIjQX2YYdhZHh9nHUvq1MeRWpl6QVwKnAQYIks9zUUz3Kun7Ajezy3evoxfXZnCec7UH3b0Zhpr2wBrvDmZ");
    MRZScanResult mrzScanResult = await MRZScanner.launch(config);

    setState(() {
      if (mrzScanResult.status == EnumResultStatus.canceled) {
        _displayString = "Scan canceled";
      } else if (mrzScanResult.status == EnumResultStatus.exception) {
        _displayString = "ErrorCode: ${mrzScanResult.errorCode}\n\nErrorString: ${mrzScanResult.errorMessage}";
      } else {
        //EnumResultStatus.finished
        MRZData data = mrzScanResult.mrzData!;
        _displayString =
        "Name:\t${data.firstName} ${data.lastName}\n\n"
            "Sex: ${data.sex.substring(0, 1).toUpperCase() + data.sex.substring(1)}\n\n"
            "Age: ${data.age}\n\n"
            "Document Type: ${data.documentType}\n\n"
            "Document Number: ${data.documentNumber}\n\n"
            "Issuing State: ${data.issuingState}\n\n"
            "Nationality: ${data.nationality}\n\n"
            "Date of Birth(YYYY-MM-DD): ${data.dateOfBirth}\n\n"
            "Date of Expiry(YYYY-MM-DD): ${data.dateOfExpire}";
        List<String> lines = data.mrzText.split("\n");
        lines.addAll(["", "", ""]);
        OcrMrzResult res = OcrMrzResult(
          line1: lines[0],
          line2: lines[1],
          format: MrzFormat.unknown,
          documentType: data.documentType,
          documentCode: data.documentType,
          mrzFormat: MrzFormat.unknown,
          countryCode: data.nationality,
          issuingState: data.issuingState,
          lastName: data.firstName,
          firstName: data.lastName,
          documentNumber: data.documentNumber,
          nationality: data.nationality,
          birthDate: DateTime.tryParse(data.dateOfBirth),
          expiryDate: DateTime.tryParse(data.dateOfExpire),
          sex: data.sex,
          personalNumber: "",
          optionalData: "",
          valid: OcrMrzValidation(
            docNumberValid: true,
            personalNumberValid: true,
            countryValid: true,
            nationalityValid: true,
            birthDateValid: true,
            expiryDateValid: true,
            linesLengthValid: true,
            hasFinalCheck: true,
            nameValid: true,
            finalCheckValid: true,
          ),
          checkDigits: CheckDigits(document: true, birth: true, expiry: true, optional: true),
          ocrData: OcrData(text: "", lines: []),
        );
        myMrzReaderController.onDocScan(res);
      }

      log("${_displayString}");
    });
  }

  changeSetting() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyOcrSettingDialog(current: myMrzReaderController.ref.read(ocrMrzSettingProvider));
      },
    ).then((sett) {
      if (sett is OcrMrzSetting) {
        log(jsonEncode(sett.toJson()));
        myMrzReaderController.ref.read(ocrMrzSettingProvider.notifier).update((s) => OcrMrzSetting.fromJson(sett.toJson()));
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
              // myMrzReaderController.sendLogs([]);
              // return;
              myMrzReaderController.ref.read(showLogProvider.notifier).update((s) => !s);
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
                final lastLog = ref
                    .watch(ocrMrzLogsProvider)
                    .lastOrNull;
                final improving = ref.watch(improvingMrzResultProvider);
                final showLog = ref.watch(showLogProvider);
                final lastFrameLog = ref.watch(lastFrameLogProvider);
                log(lastFrameLog?.fixedMrzLines.join("\n")??'');
                // log("show log ${showLog}");
                return Stack(
                  children: [
                    OcrMrzReader(
                      // filterTypes: [DocumentType.passport, DocumentType.visa],
                      controller: myMrzReaderController.ocrMrzController,
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
                        rotation: ref
                            .watch(ocrMrzSettingProvider)
                            .rotation,
                        macro: ref
                            .watch(ocrMrzSettingProvider)
                            .macro,
                        algorithm: ref
                            .watch(ocrMrzSettingProvider)
                            .algorithm,
                      ),
                    ),
                    Positioned(top: 0, left: 0, right: 0, child: ImprovingResultWidget(_launchMrzScanner)),
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: lastLog == null || !showLog
                          ? SizedBox()
                          : Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        color: Colors.white,
                        child: Column(
                          children: [
                            lastFrameLog == null?SizedBox():
                            Row(
                              children: [
                                Expanded(
                                  child: FittedBox(child: Text(lastFrameLog.rawMrzLines.join("\n"), style: GoogleFonts.robotoMono())),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: FittedBox(child: Text(lastLog.fixedMrzLines.join("\n"), style: GoogleFonts.robotoMono())),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [Expanded(child: FittedBox(child: Text(lastLog.validation.toString())))],
                            ),
                            Divider(),
                            improving == null
                                ? SizedBox()
                                : Row(
                              children: [
                                Expanded(
                                  child: FittedBox(child: Text(improving.valid.toString(), style: GoogleFonts.robotoMono())),
                                ),
                              ],
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
                      const SizedBox(width: 8),
                      Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        return Text("Method ${ref.watch(ocrMrzSettingProvider).algorithm.toString()}");
                      },),
                      const SizedBox(width: 8),
                      Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        if(ref.watch(showLogProvider)){
                          return GestureDetector(
                              onTap: (){
                                myMrzReaderController.showMrzSessionLog();
                              },
                              child: Icon(Icons.bug_report,color: Colors.orange,));
                        }
                        return SizedBox();
                      },),
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
  final void Function() luncher;

  const ImprovingResultWidget(this.luncher, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OcrMrzSetting setting = ref.watch(ocrMrzSettingProvider);
    OcrMrzConsensus? improving = ref.watch(improvingMrzResultProvider);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Wrap(
            runSpacing: 4,
            direction: Axis.horizontal,
            spacing: 12,

            children: [
              ?setting.validateNationality
                  ? SingularValidationWidget(
                state: improving?.nationalityStat,
                label: 'Nationality',
                valid: improving?.valid.nationalityValid ?? false,
                value: improving?.nationality,
                count: improving?.nationalityStat.consensusCount,
              )
                  : null,
              ?setting.validationDocumentCode
                  ? SingularValidationWidget(state: improving?.docCodeStat,
                  label: 'Doc Type',
                  valid: improving?.valid.docCodeValid ?? false,
                  value: improving?.docCode,
                  count: improving?.docCodeStat.consensusCount)
                  : null,
              ?setting.validateCountry
                  ? SingularValidationWidget(state: improving?.countryCodeStat,
                  label: 'Issuing',
                  valid: improving?.valid.countryValid ?? false,
                  value: improving?.countryCode,
                  count: improving?.countryCodeStat.consensusCount)
                  : null,
              ?setting.validateExpiryDateValid
                  ? SingularValidationWidget(
                state: improving?.expiryDateStat,
                label: 'Expiry Date',
                valid: improving?.valid.expiryDateValid ?? false,
                value: improving?.expiryDate?.format_yyyyMMdd,
                count: improving?.expiryDateStat.consensusCount,
              )
                  : null,
              ?setting.validateBirthDateValid
                  ? SingularValidationWidget(
                state: improving?.birthDateStat,
                label: 'Birth Date',
                valid: improving?.valid.birthDateValid ?? false,
                value: improving?.birthDate?.format_yyyyMMdd,
                count: improving?.birthDateStat.consensusCount,
              )
                  : null,
              ?setting.validateDocNumberValid
                  ? SingularValidationWidget(
                state: improving?.documentNumberStat,
                label: 'Doc NO.',
                valid: improving?.valid.docNumberValid ?? false,
                value: improving?.documentNumber,
                count: improving?.documentNumberStat.consensusCount,
              )
                  : null,
              ?setting.validateFinalCheckValid
                  ? SingularValidationWidget(
                state: improving?.firstNameStat,
                label: 'Final Check',
                valid: improving?.valid.finalCheckValid ?? false,
                value: (improving?.valid.finalCheckValid ?? false) ? "Yes" : "No",
                count: improving?.firstNameStat.consensusCount,
              )
                  : null,
              ?setting.validateNames
                  ? SingularValidationWidget(
                state: improving?.firstNameStat,
                label: 'Name',
                valid: improving?.valid.nationalityValid ?? false,
                value: "${improving?.firstName ?? ''} ${improving?.lastName}",
                count: improving?.firstNameStat.consensusCount,
              )
                  : null,
              ?setting.validatePersonalNumberValid
                  ? SingularValidationWidget(
                state: improving?.personalNumberStat,
                label: 'Personal NO.',
                valid: improving?.valid.personalNumberValid ?? false,
                value: improving?.personalNumber,
                count: improving?.personalNumberStat.consensusCount,
              )
                  : null,
              ?setting.validateLinesLength
                  ? SingularValidationWidget(
                state: improving?.line1Stat,
                label: 'Lines Length',
                valid: improving?.valid.linesLengthValid ?? false,
                value: (improving?.valid.linesLengthValid ?? false) ? "Yes" : "No",
                count: improving?.line1Stat.consensusCount,
              )
                  : null,
            ],
          ),
          const SizedBox(height: 12),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Visibility(
                  visible: improving != null,
                  child: MyButton(
                    label: "Submit",
                    onPressed: () {
                      getIt<MrzReaderController>().submitCurrent(improving!);
                    },
                  ),
                ),
              ),
              Visibility(
                visible: improving != null || ref.watch(showDynamsoftProvider),
                child: MyButton(
                  label: "Dynamsoft",
                  onPressed: () {
                    luncher.call();
                    // getIt<MrzReaderController>().goNamed(Routes.dynamsoft);
                  },
                ),
              ),
            ],
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
  final FieldStat? state;
  final int? count;

  const SingularValidationWidget({super.key, required this.label, required this.value, required this.valid, required this.count, required this.state});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    Color color = valid ? MyColors.green2 : Colors.grey;
    return GestureDetector(
      onTap: () {
        if (state == null) {
          return;
        }
        showDialog(context: context, builder: (BuildContext context) {
          return FieldStatDialog(stat: state!, label: label,);
        });
      },
      child: Stack(
        children: [
          Container(
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
                  // "${label} (${count??0})",
                  "${label}",
                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10, height: 1),
                ),
                Text(
                  value ?? '',
                  style: TextStyle(color: color, fontSize: 11, height: 1),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: Text(
              '${count?.toString() ?? ''}',
              style: TextStyle(color: Colors.black, fontSize: 9, height: 1, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
