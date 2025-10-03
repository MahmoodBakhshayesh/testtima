// Row (with its own controller)
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:country_flags/country_flags.dart';
import 'package:ferry/typed_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/classes/constant_data_class.dart';
import '../../../core/constants/ui.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../core/utils_and_services/icomoon_layered_presets_from_css.dart';
import '../../../core/utils_and_services/operations/confirm_operation.dart';
import '../../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../../widgets/MyTextField.dart';
import '../../../widgets/MyTextFieldNew.dart';
import '../home_state.dart';
import '../home_view_phone.dart';

class PassportItemRow extends ConsumerStatefulWidget {
  const PassportItemRow({super.key, required this.index, required this.item, required this.isLast, required this.isFirst});

  final bool isFirst;
  final bool isLast;
  final int index;
  final DocumentDetail item;

  @override
  ConsumerState<PassportItemRow> createState() => _PassportItemRowState();
}

class _PassportItemRowState extends ConsumerState<PassportItemRow> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.item.documentNumber);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        ref.read(passportsProvider.notifier).updateAt(widget.index, widget.item.copyWith(documentNumber: controller.text));
      });
    });
  }

  @override
  void didUpdateWidget(PassportItemRow oldWidget) {
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
            child: ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode(a, width: 22, height: 16)),
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
    final headerBg = Color(0xffFFFFFF);
    final bodyBg = Color(0xffF0F2Fa);
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    List<String> validCodes = BasicClass.constData.data.documentCode.where((a) => a.type == "P").map((a) => a.code!).toList();
    final requiredFields = BasicClass.constData.data.mandatory!.passport!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(20),
        color: d.isExpired ? MyColors.mainRed.withOpacity(0.12) : Color(0xffE2E7F5),
        border: d.isExpired ? Border.all(color: MyColors.mainRed) : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(top: 12),
      child: MyExpansionTile(
        tapOnTitleActive: false,
        initiallyExpanded: d.isScanned,
        // backgroundColor: MyColors.scaffoldBg,
        // collapsedBackgroundColor: MyColors.scaffoldBg,
        // backgroundColor: Color(0xff324073).withOpacity(0.2),
        // collapsedBackgroundColor: Color(0xff324073).withOpacity(0.2),
        footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
        shape: RoundedRectangleBorder(),
        collapsedShape: RoundedRectangleBorder(),
        tilePadding: EdgeInsets.symmetric(horizontal: 0),

        footerExtra: IndexedStack(
          index: isLast ? 0 : 1,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: MyButton(
                height: 30,
                label: "Passport",
                icon: Icons.add_circle_outline,
                onPressed: () {
                  ref.read(passportsProvider.notifier).add(DocumentDetail.passport());
                },
                textColor: Colors.blueAccent,
                color: Colors.blueAccent.withOpacity(0.1),
              ),
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
                  child: Text("Passport #${widget.index + 1}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                DotButton(
                  icon: ArtemisIcons.eraser_1,
                  onPressed: () async {
                    final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                    if (!confirm) return;
                    ref.read(passportsProvider.notifier).updateAt(index, DocumentDetail());
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
                    final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                    if (!confirm) return;
                    ref.read(passportsProvider.notifier).removeAt(index);
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
                  placeholder: "Code",
                  required: requiredFields.code,
                  suffixIcon: d.verifiedDocCode?IcomoonLayeredCss.verify(colors: [Colors.green,Colors.white]):null,
                  rowLabelRatio: [12, 33],
                  headerBgColor: headerBg,
                  bodyBgColor: bodyBg,
                  valueToString: (v)=>v.name,
                  items: BasicClass.constData.data.documentCode.where((a) => validCodes.contains(a.code)).toList(),
                  value: d.documentCode,
                  onChange: (a) {
                    d = d.copyWith(documentCode: a);
                    ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                  },
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyFieldPicker<Country>(
                        label: "Issued In",
                        required: requiredFields.issuedIn,
                        searchAutoFocus: true,
                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
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
                          ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                          // ref.read(passengerProvider.notifier).update((s) => s.copyWith(residentCountryCode: s.residentCountryCode ?? a));
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
                        prefixIcon: countryPrefixBuilder(d.nationality?.code3),
                        suggestion: BasicClass.constData.data.country.where((a)=>a.code3 == d.documentIssueCountry?.code3).toList(),
                        placeholder: "Country",
                        searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                        itemToWidget: countryBuilder,
                        items: BasicClass.constData.data.country,
                        value: d.nationality,
                        onChange: (a) {
                          // ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                          d = d.copyWith(nationality: a, documentIssueCountry: d.documentIssueCountry??a);
                          ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                          ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: s.nationality ?? a));
                        },
                      ),
                    ),
                  ],
                ),

                MyDatePicker(
                  label: "Expiry Date",
                  headerBgColor: headerBg,
                  bodyBgColor: bodyBg,
                  required: requiredFields.expiryDate,

                  validator: (a) => expiryValidator(a, d.documentExpiryDate),
                  validationColor: expiryValidationColor(d.documentExpiryDate),
                  validationIcon: expiryValidationIcon(d.documentExpiryDate),
                  placeholder: "Date",
                  value: d.documentExpiryDate,
                  onChanged: (a) {
                    d = d.copyWith(documentExpiryDate: a);
                    ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                  },
                ),
              ],
            ),
          ],
        ),
        childrenPadding: EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 0),
        children: [

          MyDatePicker(
            // required: true,
            // rowLabelRatio: [3, 7],
            label: "Birth Date",
            required: requiredFields.birthDate,

            headerBgColor: headerBg,
            bodyBgColor: bodyBg,
            placeholder: "Birth Date",
            validator: (a) => birthDateValidator(a, d.birthDate),
            validationColor: birthDateValidationColor(d.birthDate),
            max: DateTime.now(),
            validationIcon: ArtemisIcons.user_square,
            value: d.birthDate,
            onChanged: (a) {
              d = d.copyWith(birthDate: a);
              ref.read(passportsProvider.notifier).updateAt(widget.index, d);
            },
          ),
          const SizedBox(height: 12),
          MyFieldPicker<Gender>(
            label: "Gender",
            headerBgColor: headerBg,
            bodyBgColor: bodyBg,
            placeholder: "Gender",
            valueToString: (a)=>a.title,
            items: Gender.values,
            hasSearch: false,
            value: passengerDetails.gender,
            onChange: (a) {
              var pd = passengerDetails.copyWith(gender: a);
              ref.read(passengerProvider.notifier).update((s) => pd);
              // d = d.copyWith(birthDate: a);
              // ref.read(confirmingDocumentProvider.notifier).update((s) => d);
            },
          ),
          const SizedBox(height: 12),
          MyTextFieldNew(required: requiredFields.documentNumber, controller: controller, label: "Document #", placeholder: "Number", labelInRow: true, headerBgColor: headerBg, bodyBgColor: bodyBg),
          const SizedBox(height: 12),
          d.getMrzWidget,
        ],
      ),
    );
  }
}
