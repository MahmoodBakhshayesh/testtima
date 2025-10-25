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
import '../../../core/utils_and_services/stateControllers/residents_state_controller.dart';
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

class ResidentItemRow extends ConsumerStatefulWidget {
  const ResidentItemRow({super.key, required this.index, required this.item, required this.isLast, required this.isFirst});

  final bool isFirst;
  final bool isLast;
  final int index;
  final DocumentDetail item;

  @override
  ConsumerState<ResidentItemRow> createState() => _ResidentItemRowState();
}

class _ResidentItemRowState extends ConsumerState<ResidentItemRow> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.item.documentNumber);

    controller.addListener(() {
      ref.read(residentsProvider.notifier).updateAt(widget.index, widget.item.copyWith(documentNumber: controller.text));
    });
  }

  @override
  void didUpdateWidget(ResidentItemRow oldWidget) {
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
    final headerBg = Color(0xffFFFFFF);
    final bodyBg = Color(0xffF4F8F7);
    List<String> validCodes = BasicClass.constData.data.documentCode.where((a) => a.type == "I").map((a) => a.code!).toList();
    final requiredFields = BasicClass.constData.data.mandatory!.idCard!;
    if(context.isDesktop){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(20),
          // color: Color(0xffE9F2EF),
          color: d.isExpired ? MyColors.mainRed.withOpacity(0.12) : Color(0xffE9F2EF),
          border: d.isExpired ? Border.all(color: MyColors.mainRed) : null,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.only(top: 12),
        child: MyExpansionTile(
          tapOnTitleActive: false,

          initiallyExpanded: d.isScanned,
          // backgroundColor: MyColors.scaffoldBg,
          // collapsedBackgroundColor: MyColors.scaffoldBg,
          // backgroundColor: Colors.green.withOpacity(0.2),
          // collapsedBackgroundColor: Colors.green.withOpacity(0.2),
          footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
          shape: RoundedRectangleBorder(),
          collapsedShape: RoundedRectangleBorder(),
          tilePadding: EdgeInsets.symmetric(horizontal: 0),
          footerExtra: IndexedStack(
            index: isLast ? 0 : 1,
            children: [
              MyButton(
                height: 30,
                label: "Resident",
                icon: Icons.add_circle_outline,
                onPressed: () {
                  ref.read(residentsProvider.notifier).add(DocumentDetail.resident());
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
                    child: Text("ID / Residency Card #${widget.index + 1}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  DotButton(
                    icon: ArtemisIcons.eraser_1,
                    onPressed: () async {
                      final confirm = await ConfirmOperation.getConfirm(
                        Operation(
                          type: OperationType.warning,
                          icon: ArtemisIcons.eraser_1,
                          message: 'You are about to delete ${"ID / Residency Card #${widget.index + 1}"}. Are you sure?',
                          title: "Clear",
                          actions: ["Cancel", "Confirm"],
                        ),
                      );
                      if (!confirm) return;
                      ref.read(residentsProvider.notifier).updateAt(index, DocumentDetail());
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
                        Operation(
                          type: OperationType.error,
                          icon: ArtemisIcons.trash,
                          message: 'You are about to delete ${"ID / Residency Card #${widget.index + 1}"}. Are you sure?',
                          title: "Delete",
                          actions: ["Cancel", "Confirm"],
                        ),
                      );
                      if (!confirm) return;
                      ref.read(residentsProvider.notifier).removeAt(index);
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
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: MyFieldPicker<DocumentCode>(
                      label: "Code",
                      placeholder: "Code",
                      required: requiredFields.code,
                      suffixIcon: d.verifiedDocCode ? IcomoonLayeredCss.verify(colors: [Colors.green, Colors.white]) : null,

                      // valueToString: docCodeToString,
                      headerBgColor: headerBg,
                      bodyBgColor: bodyBg,
                      valueToString: (v) => v.name,
                      items: BasicClass.constData.data.documentCode.where((a) => validCodes.contains(a.code)).toList(),
                      value: d.documentCode,
                      onChange: (a) {
                        d = d.copyWith(documentCode: a);
                        ref.read(residentsProvider.notifier).updateAt(widget.index, d);
                      },
                    ),
                  ),
                  Expanded(
                    child: MyFieldPicker<Country>(
                      label: "Issued In",
                      required: requiredFields.issuedIn,

                      headerBgColor: headerBg,
                      bodyBgColor: bodyBg,
                      placeholder: "Country",
                      itemToWidget: countryBuilder,
                      prefixIcon: countryPrefixBuilder(d.documentIssueCountry?.code3),
                      suggestion: BasicClass.constData.data.country.where((a) => a.code3 == d.nationality?.code3).toList(),

                      searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                      items: BasicClass.constData.data.country,
                      value: d.documentIssueCountry,
                      onChange: (a) {
                        d = d.copyWith(documentIssueCountry: a);
                        ref.read(residentsProvider.notifier).updateAt(widget.index, d);
                      },
                    ),
                  ),
                  Expanded(
                    child: MyFieldPicker<Country>(
                      hasSearch: true,
                      required: requiredFields.notionality,
                      label: "Nationality",
                      headerBgColor: headerBg,
                      bodyBgColor: bodyBg,
                      placeholder: "Country",
                      prefixIcon: countryPrefixBuilder(d.nationality?.code3),
                      suggestion: BasicClass.constData.data.country.where((a) => a.code3 == d.documentIssueCountry?.code3).toList(),
                      searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                      itemToWidget: countryBuilder,
                      items: BasicClass.constData.data.country,
                      value: d.nationality,
                      onChange: (a) {
                        // ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                        d = d.copyWith(nationality: a, documentIssueCountry: d.documentIssueCountry ?? a);
                        ref.read(residentsProvider.notifier).updateAt(widget.index, d);
                      },
                    ),
                  ),
                  Expanded(
                    child: MyDatePicker(
                      label: "Expiry",
                      required: requiredFields.expiryDate,

                      // rowLabelRatio: [3, 7],
                      // required: true,
                      headerBgColor: headerBg,
                      bodyBgColor: bodyBg,
                      validator: (a) => expiryValidator(a, d.documentExpiryDate),
                      validationColor: expiryValidationColor(d.documentExpiryDate),
                      validationIcon: expiryValidationIcon(d.documentExpiryDate),
                      placeholder: "Date",
                      value: d.documentExpiryDate,
                      onChanged: (a) {
                        d = d.copyWith(documentExpiryDate: a);
                        ref.read(residentsProvider.notifier).updateAt(widget.index, d);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          childrenPadding: EdgeInsets.only(left: 0, right: 0, top: 4, bottom: 0),
          children: [
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: MyTextFieldNew(
                    required: requiredFields.documentNumber,
                    inputFormatters:d.isScanned? [MaskMiddleFormatter()]:[],
                    headerBgColor: headerBg,
                    bodyBgColor: bodyBg,
                    controller: controller,
                    label: "Document #",
                    placeholder: "Number",
                    labelInRow: true,
                  ),
                ),
              Expanded(
                child: MyDatePicker(
                  // required: true,
                  label: "Birth Date",
                  required: requiredFields.birthDate,

                  placeholder: "Birth Date",
                  headerBgColor: headerBg,
                  bodyBgColor: bodyBg,
                  validator: (a) => birthDateValidator(a, d.birthDate),
                  validationColor: birthDateValidationColor(d.birthDate),
                  validationIcon: ArtemisIcons.user_square,
                  value: d.birthDate,
                  onChanged: (a) {
                    // ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthDate: a));
                    d = d.copyWith(birthDate: a);
                    ref.read(residentsProvider.notifier).updateAt(widget.index, d);
                  },
                ),
              ),

            ],)

          ],
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(20),
        // color: Color(0xffE9F2EF),
        color: d.isExpired ? MyColors.mainRed.withOpacity(0.12) : Color(0xffE9F2EF),
        border: d.isExpired ? Border.all(color: MyColors.mainRed) : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: EdgeInsets.only(top: 12),
      child: MyExpansionTile(
        tapOnTitleActive: false,

        initiallyExpanded: d.isScanned,
        // backgroundColor: MyColors.scaffoldBg,
        // collapsedBackgroundColor: MyColors.scaffoldBg,
        // backgroundColor: Colors.green.withOpacity(0.2),
        // collapsedBackgroundColor: Colors.green.withOpacity(0.2),
        footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
        shape: RoundedRectangleBorder(),
        collapsedShape: RoundedRectangleBorder(),
        tilePadding: EdgeInsets.symmetric(horizontal: 0),
        footerExtra: IndexedStack(
          index: isLast ? 0 : 1,
          children: [
            MyButton(
              height: 30,
              label: "Resident",
              icon: Icons.add_circle_outline,
              onPressed: () {
                ref.read(residentsProvider.notifier).add(DocumentDetail.resident());
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
                  child: Text("ID / Residency Card #${widget.index + 1}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                DotButton(
                  icon: ArtemisIcons.eraser_1,
                  onPressed: () async {
                    final confirm = await ConfirmOperation.getConfirm(
                      Operation(
                        type: OperationType.warning,
                        icon: ArtemisIcons.eraser_1,
                        message: 'You are about to delete ${"ID / Residency Card #${widget.index + 1}"}. Are you sure?',
                        title: "Clear",
                        actions: ["Cancel", "Confirm"],
                      ),
                    );
                    if (!confirm) return;
                    ref.read(residentsProvider.notifier).updateAt(index, DocumentDetail());
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
                      Operation(
                        type: OperationType.error,
                        icon: ArtemisIcons.trash,
                        message: 'You are about to delete ${"ID / Residency Card #${widget.index + 1}"}. Are you sure?',
                        title: "Delete",
                        actions: ["Cancel", "Confirm"],
                      ),
                    );
                    if (!confirm) return;
                    ref.read(residentsProvider.notifier).removeAt(index);
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
                  suffixIcon: d.verifiedDocCode ? IcomoonLayeredCss.verify(colors: [Colors.green, Colors.white]) : null,

                  // valueToString: docCodeToString,
                  headerBgColor: headerBg,
                  bodyBgColor: bodyBg,
                  valueToString: (v) => v.name,
                  items: BasicClass.constData.data.documentCode.where((a) => validCodes.contains(a.code)).toList(),
                  value: d.documentCode,
                  onChange: (a) {
                    d = d.copyWith(documentCode: a);
                    ref.read(residentsProvider.notifier).updateAt(widget.index, d);
                  },
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyFieldPicker<Country>(
                        label: "Issued In",
                        required: requiredFields.issuedIn,

                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
                        rowLabelRatio: [5, 4],
                        placeholder: "Country",
                        itemToWidget: countryBuilder,
                        prefixIcon: countryPrefixBuilder(d.documentIssueCountry?.code3),
                        suggestion: BasicClass.constData.data.country.where((a) => a.code3 == d.nationality?.code3).toList(),

                        searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                        items: BasicClass.constData.data.country,
                        value: d.documentIssueCountry,
                        onChange: (a) {
                          d = d.copyWith(documentIssueCountry: a);
                          ref.read(residentsProvider.notifier).updateAt(widget.index, d);
                        },
                      ),
                    ),
                    Expanded(
                      child: MyFieldPicker<Country>(
                        hasSearch: true,
                        required: requiredFields.notionality,

                        label: "Nationality",
                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
                        placeholder: "Country",
                        prefixIcon: countryPrefixBuilder(d.nationality?.code3),
                        suggestion: BasicClass.constData.data.country.where((a) => a.code3 == d.documentIssueCountry?.code3).toList(),

                        rowLabelRatio: [5, 4],
                        searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                        itemToWidget: countryBuilder,
                        items: BasicClass.constData.data.country,
                        value: d.nationality,
                        onChange: (a) {
                          // ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                          d = d.copyWith(nationality: a, documentIssueCountry: d.documentIssueCountry ?? a);
                          ref.read(residentsProvider.notifier).updateAt(widget.index, d);
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

                        // rowLabelRatio: [3, 7],
                        // required: true,
                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
                        validator: (a) => expiryValidator(a, d.documentExpiryDate),
                        validationColor: expiryValidationColor(d.documentExpiryDate),
                        validationIcon: expiryValidationIcon(d.documentExpiryDate),
                        placeholder: "Date",
                        value: d.documentExpiryDate,
                        onChanged: (a) {
                          d = d.copyWith(documentExpiryDate: a);
                          ref.read(residentsProvider.notifier).updateAt(widget.index, d);
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
            label: "Birth Date",
            required: requiredFields.birthDate,

            placeholder: "Birth Date",
            headerBgColor: headerBg,
            bodyBgColor: bodyBg,
            validator: (a) => birthDateValidator(a, d.birthDate),
            validationColor: birthDateValidationColor(d.birthDate),
            validationIcon: ArtemisIcons.user_square,
            value: d.birthDate,
            onChanged: (a) {
              // ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthDate: a));
              d = d.copyWith(birthDate: a);
              ref.read(residentsProvider.notifier).updateAt(widget.index, d);
            },
          ),

          const SizedBox(height: 12),
          MyTextFieldNew(
            required: requiredFields.documentNumber,
            inputFormatters:d.isScanned? [MaskMiddleFormatter()]:[],
            headerBgColor: headerBg,
            bodyBgColor: bodyBg,
            controller: controller,
            label: "Document #",
            placeholder: "Number",
            labelInRow: true,
          ),
          const SizedBox(height: 12),
          d.getMrzWidget,
        ],
      ),
    );
  }

  // String docCodeToString(ParameterValue p1) {
  //   final match = BasicClass.constData.documentTypeMappers.firstWhereOrNull((a)=>a.code == p1.code);
  //   if(match != null){
  //     return match.title??p1.toString();
  //   }
  //   return p1.toString();
  // }
}
