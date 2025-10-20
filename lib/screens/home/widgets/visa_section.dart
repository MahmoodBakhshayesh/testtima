// Row (with its own controller)

import 'dart:developer';

import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/classes/constant_data_class.dart';
import '../../../core/constants/ui.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../core/utils_and_services/icomoon_layered_presets_from_css.dart';
import '../../../core/utils_and_services/operations/confirm_operation.dart';
import '../../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../../widgets/MyTextField.dart';
import '../home_state.dart';
import '../home_view_phone.dart';

class VisaItemRow extends ConsumerStatefulWidget {
  const VisaItemRow({super.key, required this.index, required this.item, required this.isLast, required this.isFirst});

  final bool isFirst;
  final bool isLast;
  final int index;
  final DocumentDetail item;

  @override
  ConsumerState<VisaItemRow> createState() => _VisaItemRowState();
}

class _VisaItemRowState extends ConsumerState<VisaItemRow> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.item.documentNumber);

    controller.addListener(() {
      ref.read(visasProvider.notifier).updateAt(widget.index, widget.item.copyWith(documentNumber: controller.text));
    });
  }

  @override
  void didUpdateWidget(VisaItemRow oldWidget) {
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
    DocumentDetail d = widget.item;
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    final List<DocumentDetail> passports = ref.watch(passportsProvider);
    bool foundPassInVisa = passports.any((p) => (p.documentNumber ?? '').isNotEmpty && (d.ocrText ?? '').contains(p.documentNumber ?? '-------------------'));
    List<String> validCodes = BasicClass.constData.data.documentCode.where((a) => a.type == "V").map((a) => a.code!).toList();
    final requiredFields = BasicClass.constData.data.mandatory!.visa!;

    // bool foundPassInVisa = passports.any((p)=>p.documentNumber!=null && (d.ocrText??'').contains('N97191'));
    // log(d.ocrText??'-');
    final headerBg = Color(0xffFFFFFF);
    final bodyBg = Color(0xffFCF7F0);
    return Container(
      decoration:
      BoxDecoration(borderRadius: BorderRadiusGeometry.circular(20),
          // color: Color(0xffFAF0E3),
          color:d.isExpired?MyColors.mainRed.withOpacity(0.12): Color(0xffFAF0E3),
          border:d.isExpired? Border.all(color: MyColors.mainRed):null

      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(top: 12),
      child: MyExpansionTile(
        tapOnTitleActive: false,

        initiallyExpanded: d.isScanned,
        // backgroundColor: MyColors.scaffoldBg,
        // collapsedBackgroundColor: MyColors.scaffoldBg,
        // backgroundColor: Colors.orange.withOpacity(0.2),
        // collapsedBackgroundColor: Colors.orange.withOpacity(0.2),
        footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
        shape: RoundedRectangleBorder(),
        collapsedShape: RoundedRectangleBorder(),
        tilePadding: EdgeInsets.symmetric(horizontal: 0),
        footerExtra: IndexedStack(
          index: isLast ? 0 : 1,
          children: [
            MyButton(
              height: 30,
              label: "Visa",
              icon: Icons.add_circle_outline,
              onPressed: () {
                ref.read(visasProvider.notifier).add(DocumentDetail.visa());
              },
              textColor: Colors.blueAccent,
              color: Colors.blueAccent.withOpacity(0.1),
            ),
            SizedBox(),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: Text("Visa #${widget.index + 1}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                // DotButton(
                //   icon: ArtemisIcons.eraser_1,
                //   onPressed: () async {
                //     final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                //     if (!confirm) return;
                //     ref.read(visasProvider.notifier).removeAt(widget.index);
                //   },
                //   size: 40,
                //   radius: 8,
                //   flat: true,
                //   iconSize: 20,
                //
                //   border: BorderSide(width: 1, color: context.mainColor),
                // ),
                DotButton(
                  icon: ArtemisIcons.eraser_1,
                  onPressed: () async {
                    final confirm = await ConfirmOperation.getConfirm(
                      Operation(type: OperationType.warning, icon: ArtemisIcons.eraser_1, message: 'You are about to clear ${"Visa #${widget.index + 1}"}. Are you sure?', title: "Clear", actions: ["Cancel", "Confirm"]),
                    );
                    if (!confirm) return;
                    ref.read(visasProvider.notifier).updateAt(index,DocumentDetail());
                  },
                  size: 40,
                  radius: 8,
                  iconSize: 20,
                  color: context.mainColor,
                  flat: true,
                  border: BorderSide(width: 1, color: context.mainColor),
                ),
                DotButton(
                  icon: ArtemisIcons.trash,
                  onPressed: () async {
                    final confirm = await ConfirmOperation.getConfirm(
                      Operation(type: OperationType.error, icon: ArtemisIcons.trash, message: 'You are about to delete ${"Visa #${widget.index + 1}"}. Are you sure?', title: "Delete", actions: ["Cancel", "Confirm"]),
                    );
                    if (!confirm) return;
                    ref.read(visasProvider.notifier).removeAt(index);
                  },
                  size: 40,
                  radius: 8,
                  iconSize: 20,
                  color: Colors.red,
                  flat: true,
                  border: BorderSide(width: 1, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              spacing: 12,
              children: [
                MyFieldPicker<DocumentCode>(
                  label: "Code",
                  required: requiredFields.code,
                  suffixIcon: d.verifiedDocCode?IcomoonLayeredCss.verify(colors: [Colors.green,Colors.white]):null,
                  placeholder: "Code",
                  headerBgColor: headerBg,
                  bodyBgColor: bodyBg,
                  valueToString: (v)=>v.name,

                  // valueToString: docCodeToString,
                  items: BasicClass.constData.data.documentCode.where((a) => validCodes.contains(a.code)).toList(),
                  value: d.documentCode,
                  onChange: (a) {
                    d = d.copyWith(documentCode: a);
                    ref.read(visasProvider.notifier).updateAt(widget.index, d);
                  },
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyFieldPicker<Country>(
                        label: "Issued In",
                        required: requiredFields.issuedIn,
                        rowLabelRatio: [5, 4],
                        placeholder: "Country",
                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
                        searchAutoFocus: true,
                        prefixIcon: countryPrefixBuilder(d.documentIssueCountry?.code3),
                        suggestion: BasicClass.constData.data.country.where((a)=>a.code3 == d.nationality?.code3).toList(),

                        itemToWidget: countryBuilder,
                        searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                        items: BasicClass.constData.data.country,
                        value: d.documentIssueCountry,
                        onChange: (a) {
                          d = d.copyWith(documentIssueCountry: a);
                          ref.read(visasProvider.notifier).updateAt(widget.index, d);
                        },
                      ),
                    ),
                    Expanded(
                      child: MyFieldPicker<Country>(
                        hasSearch: true,
                        searchAutoFocus: true,
                        required: requiredFields.notionality,

                        label: "Nationality",
                        rowLabelRatio: [5, 4],
                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
                        placeholder: "Country",
                        prefixIcon: countryPrefixBuilder(d.nationality?.code3),
                        suggestion: BasicClass.constData.data.country.where((a)=>a.code3 == d.documentIssueCountry?.code3).toList(),

                        searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                        itemToWidget: countryBuilder,
                        items: BasicClass.constData.data.country,
                        value: d.nationality,
                        onChange: (a) {
                          // ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                          d = d.copyWith(nationality: a, documentIssueCountry: d.documentIssueCountry??a);
                          ref.read(visasProvider.notifier).updateAt(widget.index, d);
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: MyDatePicker(
                        label: "Expiry",
                        required: requiredFields.expiryDate,

                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
                        // required: true,
                        validator: (a) => expiryValidator(a, d.documentExpiryDate),
                        validationColor: visaExpiryValidationColor(d.documentExpiryDate),
                        validationIcon: visaExpiryValidationIcon(d.documentExpiryDate),
                        placeholder: "Date",
                        value: d.documentExpiryDate,
                        onChanged: (a) {
                          d = d.copyWith(documentExpiryDate: a);
                          ref.read(visasProvider.notifier).updateAt(widget.index, d);
                        },
                      ),
                    ),
                    // ExpiryInfoWidget(d.documentExpiryDate)
                  ],
                ),
              ],
            ),
          ],
        ),
        childrenPadding: EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 0),
        children: [
          MyDatePicker(
            // required: true,
            headerBgColor: headerBg,
            bodyBgColor: bodyBg,
            label: "Birth Date",
            placeholder: "Birth Date",
            required: requiredFields.birthDate,

            validator: (a) => birthDateValidator(a, d.birthDate),
            validationColor: birthDateValidationColor(d.birthDate),
            validationIcon: ArtemisIcons.user_square,
            value: d.birthDate,
            onChanged: (a) {
              // ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthDate: a));
              d = d.copyWith(birthDate: a);
              ref.read(visasProvider.notifier).updateAt(widget.index, d);
            },
          ),

          const SizedBox(height: 12),

          // const SizedBox(height: 12),
          MyTextFieldNew(
            headerBgColor: headerBg,
            bodyBgColor: bodyBg,
            controller: controller,
            required: requiredFields.documentNumber,
            inputFormatters:d.isScanned? [MaskMiddleFormatter()]:[],
            label: "Document # ${foundPassInVisa ? '✅' : ''}",
            placeholder: "Number",
            labelInRow: true,
            validationIcon: d.verifiedDocNum ? ArtemisIcons.tick_square : null,
            validationColor: d.verifiedDocNum ? Colors.green : null,
            validator: d.verifiedDocNum ? (a) => "Verified" : null,
          ),
          const SizedBox(height: 12),
          d.getMrzWidget,
        ],
      ),
    );
  }
}
