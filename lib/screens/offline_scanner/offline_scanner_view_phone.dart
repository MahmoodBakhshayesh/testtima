import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/utils_and_services/country_flag_util.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/offline_scanner/dialog/set_timer_dialog.dart';
import 'package:abds/widgets/MyDatePicker.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import '../../core/constants/ui.dart';
import '../../widgets/DotButton.dart';
import 'dialog/confirm_offline_scanned_doc_dialog.dart';
import 'offline_scanner_controller.dart';
import 'offline_scanner_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class OfflineScannerViewPhone extends ConsumerStatefulWidget {
  static OfflineScannerController myOfflineScannerController = getIt<OfflineScannerController>();

  const OfflineScannerViewPhone({super.key});

  @override
  ConsumerState<OfflineScannerViewPhone> createState() => _OfflineScannerViewPhoneState();
}

class _OfflineScannerViewPhoneState extends ConsumerState<OfflineScannerViewPhone> {
  OcrMrzSetting setting = OcrMrzSetting(
    validateBirthDateValid: true,
    macro: true,
    validationDocumentCode: true,
    validateNationality: true,
    validateCountry: true,
    validateLinesLength: false,
    validateDocNumberValid: true,
    validateNames: false,
    validatePersonalNumberValid: false,
    validateFinalCheckValid: false,
    algorithm: ParseAlgorithm.method2,
  );

  @override
  Widget build(BuildContext context) {
    final scanned = ref.watch(offlineScannedDocsProvider);
    final confirming = ref.watch(confirmingOfflineDocProvider);
    return Scaffold(
      appBar: OfflineScannerAppBarPhone(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                OcrMrzReader(showFrame: false, setting: setting, controller: OfflineScannerViewPhone.myOfflineScannerController.ocrMrzController, onFoundMrz: OfflineScannerViewPhone.myOfflineScannerController.onFoundMrz),
                Container(
                  constraints: BoxConstraints(maxHeight: context.height * .4),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: scanned.length,
                    itemBuilder: (c, i) {
                      final doc = scanned[i];

                      String? validDateStr = scanned.isEmpty ? null : scanned.firstWhere((a) => a.docCode?.characters.firstOrNull == "P", orElse: () => scanned.first).birthDate?.format_yyMMdd;
                      bool dateValid = doc.birthDate.format_yyMMdd == validDateStr;

                      String? validDocNo = scanned.isEmpty ? null : scanned.firstWhere((a) => a.docCode?.characters.firstOrNull == "P", orElse: () => scanned.first).documentNumber;
                      bool docNoValid = doc.documentNumber == validDocNo;
                      return ScannedDocsWidget(scanned: scanned[i], isDateConfirmed: dateValid, showDateValidation: i != 0, isNumberValid: docNoValid);
                    },
                  ),
                ),
                ?confirming != null ? Positioned(left: 0, right: 0, bottom: 0, child: ConfirmOfflineScannedDocDialog()) : null,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OfflineScannerAppBarPhone extends StatelessWidget implements PreferredSizeWidget {
  static OfflineScannerController mySettingMenuController = getIt<OfflineScannerController>();

  const OfflineScannerAppBarPhone({super.key});

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
                      Text("Offline Scanner", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      Spacer(),
                      DotButton(
                        icon: Icons.settings,
                        onPressed: () async {
                          mySettingMenuController.setTimer();
                        },
                      ),
                      SizedBox(width: 8),
                      DotButton(
                        icon: Icons.refresh,
                        onPressed: () async {
                          mySettingMenuController.reset();
                        },
                      ),
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

class ScannedDocsWidget extends StatelessWidget {
  final VersionedData data = VersionedData.offline();
  final DocumentDetail scanned;
  final bool isDateConfirmed;
  final bool isNumberValid;
  final bool showDateValidation;

  ScannedDocsWidget({super.key, required this.scanned, required this.isDateConfirmed, required this.isNumberValid, required this.showDateValidation});

  @override
  Widget build(BuildContext context) {
    final color = (scanned.isExpired ? MyColors.red : scanned.getMatch(data)?.getColor)?.withOpacity(0.4);
    final type = scanned.documentCode;
    final TextStyle textStyle = GoogleFonts.chivoMono(color: Colors.white, fontSize: 11.5, letterSpacing: 0);
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            spacing: 4,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  spacing: 2,
                  children: [
                    Text((scanned.docCode?.characters.firstOrNull ?? '').toUpperCase(), style: textStyle),
                    MyCountryFlagsPro.getFlag(scanned.documentIssueCountry?.code3, borderRadius: BorderRadius.circular(2)),
                    Text(scanned.documentIssueCountry?.code3 ?? '', style: textStyle),
                    IndexedStack(
                      index: !showDateValidation
                          ? 0
                          : isNumberValid
                          ? 1
                          : 2,
                      children: [SizedBox(), VerifyIcon(size: 20,), SizedBox()],
                    ),
                    Text((scanned.documentNumber ?? '').padRight(9, " "), style: textStyle),
                    Text(scanned.gender?.value ?? '', style: textStyle),
                  ],
                ),
              ),
              Row(
                children: [
                  !showDateValidation
                      ? SizedBox()
                      : isDateConfirmed
                      ? VerifyIcon(size: 20,)
                      : ErrorIcon(size: 20,),
                  Text(" ${scanned.birthDate.format_yyMMddSlash}", style: textStyle),
                ],
              ),
              Icon(Icons.circle,size: 5,),
              Text(scanned.documentExpiryDate.format_yyMMddSlash, style: textStyle),
            ],
          ),
        ],
      ),
    );
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(scanned.documentCode?.name ?? '', style: textStyle)),
              Text("Expiry ${scanned.documentExpiryDate.format_yyMMddSlash}", style: textStyle),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  spacing: 8,
                  children: [
                    MyCountryFlagsPro.getFlag(scanned.documentIssueCountry?.code3, borderRadius: BorderRadius.circular(2)),
                    Text(scanned.documentIssueCountry?.code3 ?? '', style: textStyle),
                    Text("# ${scanned.documentNumber ?? ''}", style: textStyle),
                    Text(scanned.gender?.title ?? '', style: textStyle),
                  ],
                ),
              ),
              Text("Birth ${scanned.birthDate.format_yyMMddSlash}", style: textStyle),
            ],
          ),
        ],
      ),
    );
  }
}
