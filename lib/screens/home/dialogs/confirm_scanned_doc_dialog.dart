import 'dart:developer';

import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
import 'package:dartx/dartx_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../../widgets/MyTextField.dart';
import '../../../widgets/auto_link_text.dart';
import '../home_view_phone.dart';

class ConfirmScannedDocDialog extends ConsumerWidget {

  const ConfirmScannedDocDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentDetail= ref.watch(confirmingDocumentProvider);
    if(documentDetail== null){
      return SizedBox();
    }
    log(documentDetail.shortType?? '');
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
      insetPadding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                // color: MyColors.scaffoldHeader,
                color: (documentDetail.isExpired?MyColors.red: documentDetail.getMatch()?.getColor)?.withOpacity(0.4),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      documentDetail.getMatch()?.title??'',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            ConfirmingItemRow(item: documentDetail, index: 0, isFirst: true, isLast: true),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                spacing: 12,
                children: [
                  MyButton(
                    label: "Cancel",
                    color: Colors.grey,
                    reverse: true,
                    borderSide: BorderSide(color: Colors.grey),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: MyButton(
                      label: "Confirm",
                      // reverse: true,
                      borderSide: BorderSide(color: context.mainColor),
                      onPressed:!documentDetail.hasAllRequired()?null: () {

                        // log(documentDetail.docCode??'');
                        Navigator.of(context).pop(true);
                      },
                    ),
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

class ConfirmingItemRow extends ConsumerStatefulWidget {
  const ConfirmingItemRow({super.key, required this.index, required this.item, required this.isLast, required this.isFirst});

  final bool isFirst;
  final bool isLast;
  final int index;
  final DocumentDetail item;

  @override
  ConsumerState<ConfirmingItemRow> createState() => _ConfirmingItemRowState();
}

class _ConfirmingItemRowState extends ConsumerState<ConfirmingItemRow> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.item.documentNumber);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        ref.read(confirmingDocumentProvider.notifier).update((s) => widget.item.copyWith(documentNumber: controller.text));
      });
    });
  }

  @override
  void didUpdateWidget(ConfirmingItemRow oldWidget) {
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
      ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
      const SizedBox(width: 8),
      Text("$a (${(a as Country).name})"),
    ],
  );

  Widget? countryPrefixBuilder(String? a) {
    if (a != null) {
      return Row(
        children: [
          const SizedBox(width: 4),
          SizedBox(
            width: 15,
            height: 10,
            child: ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
          ),
          const SizedBox(width: 4),
          Text(a, style: TextStyle(fontSize: 12)),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLast = widget.isLast;
    bool isFirst = widget.isFirst;
    int index = widget.index;
    DocumentDetail d = ref.watch(confirmingDocumentProvider) ?? DocumentDetail();
    final headerBg = Color(0xffFFFFFF);
    final bodyBg = Color(0xffF0F2Fa);

    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    // final tim = BasicClass.timData;
    String? docCode = d.docCode;
    DocumentDetailType? match = d.getTypeDetailsMatch();
    DocumentType? typeMatch = d.getMatch();
    List<String> validCodes = BasicClass.constData.data.documentCode.where((a) => a.type == d.shortType).map((a) => a.code!).toList();
    final requiredFields = d.getRequiredFields;

    return Container(
      decoration: BoxDecoration(
        // color: Color(0xff324073).withOpacity(0.3),
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),
      child: MyExpansionTile(
        tapOnTitleActive: false,

        initiallyExpanded: true,
        showFooter: false,
        // backgroundColor: MyColors.scaffoldBg,
        // collapsedBackgroundColor: MyColors.scaffoldBg,
        backgroundColor: (d.isExpired?MyColors.mainRed: typeMatch?.getColor)?.withOpacity(0.2),
        collapsedBackgroundColor:  (d.isExpired?MyColors.mainRed: typeMatch?.getColor)?.withOpacity(0.2),
        footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
        shape: RoundedRectangleBorder(),
        collapsedShape: RoundedRectangleBorder(),

        tilePadding: EdgeInsets.symmetric(horizontal: 14),
        footerExtra: IndexedStack(index: isLast ? 0 : 1, children: [SizedBox()]),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Column(
              spacing: 12,
              children: [
                MyFieldPicker<DocumentCode>(
                  label: "Code",
                  required: requiredFields.code,
                  locked: d.verifiedDocCode,
                  suffixIcon: d.verifiedDocCode?IcomoonLayeredCss.verify(colors: [Colors.green,Colors.white]):null,
                  // suggestion: BasicClass.constData.data.documentCode.where((a) => validCodes.contains(a.code)).toList().sublist(1,3),
                  placeholder: "Code",
                  headerBgColor: headerBg,
                  bodyBgColor: bodyBg,
                  items: BasicClass.constData.data.documentCode.where((a) => validCodes.contains(a.code)).toList(),
                  // itemToString: docCodeToString,
                  valueToString: docCodeToString,
                  value: d.documentCode,
                  onChange: (a) {
                    d = d.copyWith(documentCode: a);
                    ref.read(confirmingDocumentProvider.notifier).update((s) => d);
                  },
                ),
                ?(match?.note != null)
                    ? Container(
                  decoration: BoxDecoration(color: Color(0xff2A5Cff).withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(ArtemisIcons.note_2, color: Color(0xff2A5Cff)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: HtmlWidget(match!.note!, onTapUrl: (p0) => launch(p0), textStyle: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                )
                    : null,
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyFieldPicker<Country>(
                        label: "Issued In",
                        required: requiredFields.issuedIn,

                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
                        searchAutoFocus: true,
                        rowLabelRatio: [5, 4],
                        placeholder: "Country",
                        suggestion: BasicClass.constData.data.country.where((a)=>a.code3 == d.nationality?.code3).toList(),

                        itemToWidget: countryBuilder,
                        prefixIcon: countryPrefixBuilder(d.documentIssueCountry?.code3),
                        searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                        items: BasicClass.constData.data.country,
                        value: d.documentIssueCountry,
                        onChange: (a) {
                          d = d.copyWith(documentIssueCountry: a);
                          ref.read(confirmingDocumentProvider.notifier).update((s) => d);
                        },
                      ),
                    ),
                    Expanded(
                      child: MyFieldPicker<Country>(
                        hasSearch: true,
                        required: requiredFields.notionality,

                        searchAutoFocus: true,
                        rowLabelRatio: [5, 4],
                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
                        label: "Nationality",
                        suggestion: BasicClass.constData.data.country.where((a)=>a.code3 == d.documentIssueCountry?.code3).toList(),

                        prefixIcon: countryPrefixBuilder(d.nationality?.code3),
                        placeholder: "Country",
                        searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                        itemToWidget: countryBuilder,
                        items: BasicClass.constData.data.country,
                        value: d.nationality,
                        onChange: (a) {
                          // ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                          d = d.copyWith(nationality: a, documentIssueCountry:  d.documentIssueCountry??a);
                          ref.read(confirmingDocumentProvider.notifier).update((s) => d);
                        },
                      ),
                    ),
                  ],
                ),




                MyDatePicker(
                  label: "Expiry Date",
                  required: requiredFields.expiryDate,
                  validator: (a) => expiryValidator(a, d.documentExpiryDate),
                  validationColor: expiryValidationColor(d.documentExpiryDate),
                  validationIcon: expiryValidationIcon(d.documentExpiryDate),
                  placeholder: "Date",
                  headerBgColor: headerBg,
                  bodyBgColor: bodyBg,
                  value: d.documentExpiryDate,
                  onChanged: (a) {
                    d = d.copyWith(documentExpiryDate: a);
                    ref.read(confirmingDocumentProvider.notifier).update((s) => d);
                  },
                ),
              ],
            ),
          ],
        ),

        childrenPadding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 12),
        children: [

          MyDatePicker(
            required: requiredFields.birthDate,
            label: "Birth Date",
            placeholder: "Birth Date",

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
              ref.read(confirmingDocumentProvider.notifier).update((s) => d);
            },
          ),

          const SizedBox(height: 12),
          ?d.shortType =="P"?
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MyFieldPicker<Gender>(
              label: "Gender",
              headerBgColor: headerBg,
              bodyBgColor: bodyBg,
              placeholder: "Gender",
              valueToString: (a)=>a.title,
              items: Gender.values,
              hasSearch: false,
              value: d.gender,
              onChange: (a) {
                // var pd = passengerDetails.copyWith(gender: a);
                // ref.read(passengerProvider.notifier).update((s) => pd);
                d = d.copyWith(sex: a?.value);
                ref.read(confirmingDocumentProvider.notifier).update((s) => d);
              },
            ),
          ):null,

          // const SizedBox(height: 12),
          MyTextFieldNew(
              required: requiredFields.documentNumber,

              headerBgColor: headerBg, bodyBgColor: bodyBg, controller: controller, label: "Document #", placeholder: "Number", labelInRow: true),
          const SizedBox(height: 12),
          d.getMrzWidget,
          // MyDatePicker(
          //   label: "Issue Date",
          //   placeholder: "Issue Date",
          //   rowLabelRatio: [3, 7],
          //   value: d.documentIssueDate,
          //   onChanged: (a) {
          //     d = d.copyWith(documentIssueDate: a);
          //     ref.read(confirming.notifier).updateAt(widget.index, d);
          //   },
          // ),
          // const SizedBox(height: 12),

          // const SizedBox(height: 12),
          // Row(
          //   children: [
          //     // Expanded(
          //     //   child: MyFieldPicker<Location>(
          //     //     label: "Birth Place",
          //     //     rowLabelRatio: [3, 4],
          //     //     hasSearch: true,
          //     //     placeholder: "Country",
          //     //     searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
          //     //     items: tim.locations.of(LocationType.country),
          //     //     itemToWidget: countryBuilder,
          //     //     value: passengerDetails.birthCountry,
          //     //     onChange: (a) {
          //     //       ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthCountry: a));
          //     //     },
          //     //   ),
          //     // ),
          //     // const SizedBox(width: 12),
          //     Expanded(
          //       child: MyFieldPicker<DocumentFeature>(
          //         hasSearch: false,
          //         rowLabelRatio: [3, 7],
          //         label: "Feature",
          //         placeholder: "Feature",
          //         items: DocumentFeature.values,
          //         value: d.documentFeature,
          //         onChange: (a) {
          //           d = d.copyWith(documentFeature: a);
          //           ref.read(confirming.notifier).updateAt(widget.index, d);
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  String docCodeToString(DocumentCode p1) {
    final match = BasicClass.constData.data.documentDetailType.firstWhereOrNull((a) => a.code == p1.code);
    if (match != null) {
      return match.title ?? p1.toString();
    }
    return p1.toString();
  }
}
