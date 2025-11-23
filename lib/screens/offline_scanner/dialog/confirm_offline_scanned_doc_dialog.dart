import 'dart:async';
import 'dart:developer';

import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/button_keys.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/screens/offline_scanner/offline_scanner_controller.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:abds/widgets/primary_action_widget.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags_pro/country_flags_pro.dart';
import 'package:dartx/dartx_io.dart';
import 'package:ferry/typed_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../core/utils_and_services/country_flag_util.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../home/home_view_desktop.dart';
import '../offline_scanner_state.dart';

class ConfirmOfflineScannedDocDialog extends ConsumerStatefulWidget {
  const ConfirmOfflineScannedDocDialog({super.key});

  @override
  ConsumerState<ConfirmOfflineScannedDocDialog> createState() => _ConfirmOfflineScannedDocDialogState();
}

class _ConfirmOfflineScannedDocDialogState extends ConsumerState<ConfirmOfflineScannedDocDialog> {
  final VersionedData data = VersionedData.offline();
  static OfflineScannerController myOfflineScannerController = getIt<OfflineScannerController>();

  Timer? _autoCloseTimer;

  void _restartTimer() {
    _autoCloseTimer?.cancel();
    _autoCloseTimer = Timer( Duration(milliseconds: myOfflineScannerController.ref.read(confirmingTimerProvider)), () {
      if (!mounted) return;
      myOfflineScannerController.onDoneConfirming();
      // if (Navigator.of(context).canPop()) {
      //   Navigator.of(context).pop(true);
      // }
    });
  }

  @override
  void dispose() {
    _autoCloseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // LISTEN here (legal for ConsumerStatefulWidget)
    ref.listen<DocumentDetail?>(confirmingOfflineDocProvider, (previous, next) {
      if (!ref.read(offlineScannedDocsProvider).any((a) => getIt<OfflineScannerController>().isSame2(a, previous))) {
        ref.read(offlineScannedDocsProvider.notifier).update((s) => [...s, previous!]);
      }
      // Any time the document changes → restart the timer
      if (next != null) {
        _restartTimer();
      }
    });

    // Also start timer once when dialog first builds
    // (guard to start only once)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_autoCloseTimer == null) {
        _restartTimer();
      }
    });

    final documentDetail = ref.watch(confirmingOfflineDocProvider);
    if (documentDetail == null) return const SizedBox();
    bool isExpired = documentDetail.isExpired;
    bool isExpiring = documentDetail.isExpiring;
    final expiringColor = Colors.yellow;
    return Material(
      child: Container(
        decoration: BoxDecoration(color:isExpiring?expiringColor.withOpacity(0.4): isExpired ? Colors.red.withOpacity(0.4) : Colors.white.withOpacity(0.4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ?(isExpired || isExpiring)
                ? Container(
                    // margin: context.getDialogPadding,
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                    decoration: BoxDecoration(
                      color: isExpiring?expiringColor:Colors.red,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IcomoonLayeredCss.warning_2(colors: [Colors.white]),
                          const SizedBox(width: 8),
                          Text("${expiryValidator("", documentDetail.documentExpiryDate)}",style: TextStyle(color:isExpiring?Colors.black: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)]),
                  )
                : null,
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: (documentDetail.isExpiring?expiringColor: documentDetail.isExpired ? MyColors.red : Colors.blueGrey).withOpacity(0.7),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(documentDetail.getMatch(data)?.title ?? '', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                          // child: Text("Document", style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  ConfirmingOfflineItemRow(item: documentDetail, index: 0, isFirst: true, isLast: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmingOfflineItemRow extends ConsumerStatefulWidget {
  const ConfirmingOfflineItemRow({super.key, required this.index, required this.item, required this.isLast, required this.isFirst});

  final bool isFirst;
  final bool isLast;
  final int index;
  final DocumentDetail item;

  @override
  ConsumerState<ConfirmingOfflineItemRow> createState() => _ConfirmingItemRowState();
}

class _ConfirmingItemRowState extends ConsumerState<ConfirmingOfflineItemRow> {
  late final TextEditingController controller;
  final data = VersionedData.offline();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.item.documentNumber);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        Future(() {
          ref.read(confirmingOfflineDocProvider.notifier).update((s) => widget.item.copyWith(documentNumber: controller.text));
        });
      });
    });
  }

  @override
  void didUpdateWidget(ConfirmingOfflineItemRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // log(widget.item.toJson().toString());

    if (controller.text != widget.item.documentNumber) {
      controller.text = widget.item.documentNumber ?? '';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget countryBuilder(dynamic a) => Row(
    children: [
      MyCountryFlagsPro.getFlag(a, width: 22, height: 16, borderRadius: BorderRadius.circular(2)),
      const SizedBox(width: 8),
      Text("$a (${(a as Country).name})"),
    ],
  );

  Widget? countryPrefixBuilder(String? a) {
    log("${a} countryPrefixBuilder");
    if (a != null) {
      return Row(
        children: [
          const SizedBox(width: 4),
          MyCountryFlagsPro.getFlag(a, width: 33, height: 22, borderRadius: BorderRadius.circular(2)),
          // Text(a, style: TextStyle(fontSize: 12)),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLast = widget.isLast;
    bool isFirst = widget.isFirst;
    int index = widget.index;
    DocumentDetail d = ref.watch(confirmingOfflineDocProvider) ?? DocumentDetail();
    final headerBg = Color(0xffFFFFFF);
    final bodyBg = Color(0xffF0F2Fa);
    final expiringColor = Colors.yellow;

    DocumentType? typeMatch = d.getMatch(data);
    List<String> validCodes = data.documentCode.where((a) => a.type == d.shortType).map((a) => a.code!).toList();
    final requiredFields = d.getRequiredFieldsOffline;

    DocumentDetail? firstOfOthers = ref.watch(offlineScannedDocsProvider).length == 1 ? null : ref.watch(offlineScannedDocsProvider).firstOrNull;

    bool natVerified = d.nationality?.code3 != null && d.nationality?.code3 == firstOfOthers?.nationality?.code3;
    bool issuingVerified = d.documentIssueCountry?.code3 != null && d.documentIssueCountry?.code3 == firstOfOthers?.documentIssueCountry?.code3;
    bool birthDateVerified = d.birthDate?.format_yyMMdd != null && d.birthDate?.format_yyMMdd == firstOfOthers?.birthDate?.format_yyMMdd;
    bool genderVerified = d.gender?.value != null && d.gender?.value == firstOfOthers?.gender?.value;
    bool docNoVerified = d.gender?.value != null && d.documentNumber == firstOfOthers?.documentNumber;

    log("birthDateVerified ${birthDateVerified}");


    return SafeArea(
      bottom: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          // color: Color(0xff324073).withOpacity(0.3),
          border: Border(bottom: BorderSide(color: Colors.white)),
        ),
        child: Column(
          spacing: 4,
          children: [
            MyTextFieldNew(required: requiredFields.documentNumber,
                suffixIcon: docNoVerified ? IcomoonLayeredCss.verify(colors: [Colors.green, Colors.white],size: 30) : null,

                headerBgColor: headerBg, bodyBgColor: bodyBg, controller: controller, label: "Document #", placeholder: "Number", labelInRow: true),
            MyDatePicker(
              required: requiredFields.birthDate,
              label: "Birth Date",
              placeholder: "Birth Date",
              suffixIcon: birthDateVerified ? IcomoonLayeredCss.verify(colors: [Colors.green, Colors.white],size: 30) : null,

              headerBgColor: headerBg,
              bodyBgColor: bodyBg,
              validator: (a) => birthDateValidator(a, d.birthDate),
              validationColor: birthDateValidationColor(d.birthDate),
              max: DateTime.now(),
              validationIcon: ArtemisIcons.user_square,
              value: d.birthDate,

              onChanged: (a) {
                // ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthDate: a));
                d = d.copyWith(birthDate: a);
                ref.read(confirmingOfflineDocProvider.notifier).update((s) => d);
              },
            ),
            MyFieldPicker<Country>(
              hasSearch: true,
              required: requiredFields.notionality,
              suffixIcon: natVerified ? IcomoonLayeredCss.verify(colors: [Colors.green, Colors.white],size: 30) : null,
              searchAutoFocus: true,
              // rowLabelRatio: [5, 4],
              headerBgColor: headerBg,
              bodyBgColor: bodyBg,
              label: "Nationality",
              suggestion: data.country.where((a) => a.code3 == d.documentIssueCountry?.code3).toList(),
              // prefix: countryPrefixBuilder(d.nationality?.code3),
              prefixIcon: countryPrefixBuilder(d.nationality?.code3),
              placeholder: "Country",
              searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
              itemToWidget: countryBuilder,
              items: data.country,
              value: d.nationality,
              onChange: (a) {
                // ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                d = d.copyWith(nationality: a, documentIssueCountry: d.documentIssueCountry ?? a);
                ref.read(confirmingOfflineDocProvider.notifier).update((s) => d);
              },
            ),
            MyFieldPicker<Gender>(
              label: "Gender",
              headerBgColor: headerBg,
              suffixIcon: genderVerified ? IcomoonLayeredCss.verify(colors: [Colors.green, Colors.white],size: 30) : null,

              bodyBgColor: bodyBg,
              placeholder: "Gender",
              valueToString: (a) => a.title,
              items: Gender.values,
              hasSearch: false,
              value: d.gender,
              onChange: (a) {
                // var pd = passengerDetails.copyWith(gender: a);
                // ref.read(passengerProvider.notifier).update((s) => pd);
                d = d.copyWith(sex: a?.value);
                ref.read(confirmingOfflineDocProvider.notifier).update((s) => d);
              },
            ),
            MyFieldPicker<Country>(
              label: "Issued In",
              required: requiredFields.issuedIn,

              headerBgColor: headerBg,
              bodyBgColor: bodyBg,
              searchAutoFocus: true,
              // rowLabelRatio: [5, 4],
              placeholder: "Country",
              suggestion: data.country.where((a) => a.code3 == d.nationality?.code3).toList(),
              suffixIcon: issuingVerified ? IcomoonLayeredCss.verify(colors: [Colors.green, Colors.white],size: 30) : null,

              itemToWidget: countryBuilder,
              prefixIcon: countryPrefixBuilder(d.documentIssueCountry?.code3),
              searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
              items: data.country,
              value: d.documentIssueCountry,
              onChange: (a) {
                d = d.copyWith(documentIssueCountry: a);
                ref.read(confirmingOfflineDocProvider.notifier).update((s) => d);
              },
            ),
            MyDatePicker(
              label: "Expiry Date",
              required: requiredFields.expiryDate,

              // validator: (a) => expiryValidator(a, d.documentExpiryDate),
              // validationColor: expiryValidationColor(d.documentExpiryDate),
              // validationIcon: expiryValidationIcon(d.documentExpiryDate),
              placeholder: "Date",
              headerBgColor: headerBg,
              bodyBgColor: bodyBg,
              value: d.documentExpiryDate,
              onChanged: (a) {
                d = d.copyWith(documentExpiryDate: a);
                ref.read(confirmingOfflineDocProvider.notifier).update((s) => d);
              },
            ),
          ],
        ),
        // child: MyExpansionTile(
        //   tapOnTitleActive: false,
        //
        //   initiallyExpanded: true,
        //   showFooter: false,
        //   // backgroundColor: MyColors.scaffoldBg,
        //   // collapsedBackgroundColor: MyColors.scaffoldBg,
        //   backgroundColor: (d.isExpiring?expiringColor: d.isExpired ? MyColors.mainRed : Colors.blueGrey)?.withOpacity(0.2) ?? Colors.blueGrey,
        //   collapsedBackgroundColor: (d.isExpiring?expiringColor:d.isExpired ? MyColors.mainRed : Colors.blueGrey)?.withOpacity(0.2),
        //   footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
        //   shape: RoundedRectangleBorder(),
        //   collapsedShape: RoundedRectangleBorder(),
        //
        //   tilePadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        //   footerExtra: IndexedStack(index: isLast ? 0 : 1, children: [SizedBox()]),
        //
        //   title: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //
        //     ],
        //   ),
        //
        //   childrenPadding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 12),
        //   children: [
        //
        //     d.birthdayWidget,
        //     const SizedBox(height: 12),
        //
        //
        //     // const SizedBox(height: 12),
        //
        //     const SizedBox(height: 12),
        //     d.getMrzWidget,
        //     // MyDatePicker(
        //     //   label: "Issue Date",
        //     //   placeholder: "Issue Date",
        //     //   rowLabelRatio: [3, 7],
        //     //   value: d.documentIssueDate,
        //     //   onChanged: (a) {
        //     //     d = d.copyWith(documentIssueDate: a);
        //     //     ref.read(confirming.notifier).updateAt(widget.index, d);
        //     //   },
        //     // ),
        //     // const SizedBox(height: 12),
        //
        //     // const SizedBox(height: 12),
        //     // Row(
        //     //   children: [
        //     //     // Expanded(
        //     //     //   child: MyFieldPicker<Location>(
        //     //     //     label: "Birth Place",
        //     //     //     rowLabelRatio: [3, 4],
        //     //     //     hasSearch: true,
        //     //     //     placeholder: "Country",
        //     //     //     searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
        //     //     //     items: tim.locations.of(LocationType.country),
        //     //     //     itemToWidget: countryBuilder,
        //     //     //     value: passengerDetails.birthCountry,
        //     //     //     onChange: (a) {
        //     //     //       ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthCountry: a));
        //     //     //     },
        //     //     //   ),
        //     //     // ),
        //     //     // const SizedBox(width: 12),
        //     //     Expanded(
        //     //       child: MyFieldPicker<DocumentFeature>(
        //     //         hasSearch: false,
        //     //         rowLabelRatio: [3, 7],
        //     //         label: "Feature",
        //     //         placeholder: "Feature",
        //     //         items: DocumentFeature.values,
        //     //         value: d.documentFeature,
        //     //         onChange: (a) {
        //     //           d = d.copyWith(documentFeature: a);
        //     //           ref.read(confirming.notifier).updateAt(widget.index, d);
        //     //         },
        //     //       ),
        //     //     ),
        //     //   ],
        //     // ),
        //   ],
        // ),
      ),
    );
  }

  String docCodeToString(DocumentCode p1) {
    final match = data.documentDetailType.firstWhereOrNull((a) => a.code == p1.code);
    if (match != null) {
      return match.title ?? p1.toString();
    }
    return p1.toString();
  }
}
