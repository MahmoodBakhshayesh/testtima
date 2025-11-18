import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/utils_and_services/country_flag_util.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/widgets/MyDatePicker.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import '../../core/constants/ui.dart';
import '../../widgets/DotButton.dart';
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
                    itemBuilder: (c, i) => ScannedDocsWidget(scanned: scanned[i]),
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

  ScannedDocsWidget({super.key, required this.scanned});

  @override
  Widget build(BuildContext context) {
    final color = (scanned.isExpired ? MyColors.red : scanned.getMatch(data)?.getColor)?.withOpacity(0.4);
    final type = scanned.documentCode;
    final TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 12);
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            spacing: 8,
            children: [

              Expanded(
                flex: 2,
                child: Row(
                  spacing: 4,
                  children: [
                    MyCountryFlagsPro.getFlag(scanned.documentIssueCountry?.code3, borderRadius: BorderRadius.circular(2)),
                    Text("${scanned.documentIssueCountry?.code3 ?? ''}", style: textStyle),
                    Text("# ${scanned.documentNumber ?? ''}", style: textStyle),
                    Text("${scanned.gender?.title ?? ''}", style: textStyle),
                  ],
                ),
              ),
              Text(" ${scanned.birthDate.format_yyMMddSlash}", style: textStyle),
              Text("${scanned.documentExpiryDate.format_yyMMddSlash}", style: textStyle),
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
              Expanded(child: Text("${scanned.documentCode?.name ?? ''}", style: textStyle)),
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
                    Text("${scanned.documentIssueCountry?.code3 ?? ''}", style: textStyle),
                    Text("# ${scanned.documentNumber ?? ''}", style: textStyle),
                    Text("${scanned.gender?.title ?? ''}", style: textStyle),
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
