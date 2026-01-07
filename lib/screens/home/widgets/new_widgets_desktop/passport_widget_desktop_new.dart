import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/classes/basic_class.dart';
import '../../../../core/classes/constant_data_class.dart';
import '../../../../core/constants/ui.dart';
import '../../../../core/extenstions/context_exp.dart';
import '../../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../../core/utils_and_services/country_flag_util.dart';
import '../../../../core/utils_and_services/icomoon_layered_presets_from_css.dart';
import '../../../../core/utils_and_services/operations/confirm_operation.dart';
import '../../../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../../../core/utils_and_services/timatic/src/models/document_request.dart';
import '../../../../core/utils_and_services/timatic/src/models/enums.dart';
import '../../../../widgets/DotButton.dart';
import '../../../../widgets/MyDatePicker.dart';
import '../../../../widgets/MyFieldPicker.dart';
import '../../../../widgets/MyTextField.dart';
import '../../../../widgets/MyTextFieldNew.dart';
import '../../home_state.dart';
import '../../home_view_desktop.dart';

class PassportsWidgetDesktop extends ConsumerWidget {
  const PassportsWidgetDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passports = ref.watch(passportsProvider);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusGeometry.circular(12)),
      child: Column(
        spacing: 8,
        children: passports.map((pass) {
          int index = passports.indexOf(pass);
          bool isLast = index == passports.length - 1;
          bool isFirst = index == 0;
          return ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Container(
              color: Color(0xffE2E7F5),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Passport ${index + 1}",
                        ),
                      ),
                    ),
                    VerticalDivider(width: 2, color: MyColors.black3),
                    Expanded(
                      child: PassportWidgetDesktop(
                        document: pass,
                        index: index,
                        isFirst: isFirst,
                        isLast: isLast,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class PassportWidgetDesktop extends ConsumerStatefulWidget {
  final DocumentDetail document;
  final int index;
  final bool isFirst;
  final bool isLast;

  const PassportWidgetDesktop({super.key, required this.document, required this.index, required this.isFirst, required this.isLast});

  @override
  ConsumerState<PassportWidgetDesktop> createState() => _PassportWidgetDesktopState();
}

class _PassportWidgetDesktopState extends ConsumerState<PassportWidgetDesktop> {
  final mandatories = BasicClass.constData.data.mandatory!.flight;
  late final TextEditingController controller;
  ExpansibleController expansibleController = ExpansibleController();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.document.documentNumber);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        Future(() {
          ref.read(passportsProvider.notifier).updateAt(widget.index, widget.document.copyWith(documentNumber: controller.text));
        });
      });
    });
  }

  @override
  void didUpdateWidget(PassportWidgetDesktop oldWidget) {
    super.didUpdateWidget(oldWidget);
    // log(widget.item.toJson().toString());

    if (controller.text != widget.document.documentNumber) {
      controller.text = widget.document.documentNumber ?? '';
    }
    if (widget.document.isScanned) {
      expansibleController.expand();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget countryBuilder(dynamic a) => Row(
    children: [
      MyCountryFlagsPro.getFlag("$a",width: 22,height: 16,borderRadius: BorderRadius.circular(2)),

      const SizedBox(width: 8),
      Expanded(child: Text("$a (${(a as Country).name})",overflow: TextOverflow.ellipsis,)),
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
            child:  MyCountryFlagsPro.getFlag(a,width: 15,height: 10,borderRadius: BorderRadius.circular(2)),
          ),
          // const SizedBox(width: 4),
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
    DocumentDetail d = ref.watch(passportsProvider)[widget.index];
    final headerBg =null;
    final bodyBg = Colors.white;
    final mainStyle = TextStyle(fontSize: 20,fontWeight: FontWeight.w200);
    final radius = BorderRadius.circular(12);
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
      child:Column(children: [
        Column(
          children: [
            Row(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: MyFieldPicker<DocumentCode>(
                    label: "Code",
                    placeholder: "Code",
                    required: requiredFields.code,
                    hasSearch: true,
                    height: 60,
                    labelInRow: false,
                    searchAutoFocus: true,
                    style: mainStyle,
                    radius: radius,
                    suffixIcon: d.verifiedDocCode ? IcomoonLayeredCss.verify(colors: [Colors.green, Colors.white]) : null,
                    headerBgColor: headerBg,
                    bodyBgColor: bodyBg,
                    valueToString: (v) => v.name,
                    items: BasicClass.constData.data.documentCode.where((a) => validCodes.contains(a.code)).toList(),
                    value: d.documentCode,
                    onChange: (a) {
                      d = d.copyWith(documentCode: a);
                      ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                    },
                  ),
                ),

                DotButton(
                  icon: ArtemisIcons.eraser_1,
                  onPressed: () async {
                    final confirm = await ConfirmOperation.getConfirm(
                      Operation(type: OperationType.warning, icon: ArtemisIcons.eraser_1, message: 'You are about to clear ${"Passport #${widget.index + 1}"}. Are you sure?', title: "Clear", actions: ["Cancel", "Confirm"]),
                    );
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
                ?widget.index == 0
                    ? null
                    : DotButton(
                  icon: ArtemisIcons.trash,
                  onPressed: () async {
                    final confirm = await ConfirmOperation.getConfirm(
                      Operation(type: OperationType.error, icon: ArtemisIcons.trash, message: 'You are about to delete ${"Passport #${widget.index + 1}"}. Are you sure?', title: "Delete", actions: ["Cancel", "Confirm"]),
                    );
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
            Row(
              spacing: 12,
              children: [

                Expanded(
                  child: MyFieldPicker<Country>(
                    label: "Issued In",
                    required: requiredFields.issuedIn,
                    searchAutoFocus: true,
                    height: 60,
                    style: mainStyle,
                    radius: radius,
                    labelInRow: false,
                    headerBgColor: headerBg,
                    bodyBgColor: bodyBg,
                    placeholder: "Country",
                    suggestion: BasicClass.constData.data.country.where((a) => a.code3 == d.nationality?.code3).toList(),

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
                    height: 60,
                    style: mainStyle,
                    radius: radius,
                    labelInRow: false,
                    headerBgColor: headerBg,
                    bodyBgColor: bodyBg,
                    label: "Nationality",
                    prefixIcon: countryPrefixBuilder(d.nationality?.code3),
                    suggestion: BasicClass.constData.data.country.where((a) => a.code3 == d.documentIssueCountry?.code3).toList(),
                    placeholder: "Country",
                    searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                    itemToWidget: countryBuilder,
                    items: BasicClass.constData.data.country,
                    value: d.nationality,
                    onChange: (a) {
                      // ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                      d = d.copyWith(nationality: a, documentIssueCountry: d.documentIssueCountry ?? a);
                      ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                      ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                    },
                  ),
                ),
                Expanded(
                  child: MyDatePicker(
                    label: "Expiry Date",
                    headerBgColor: headerBg,
                    bodyBgColor: bodyBg,
                    required: requiredFields.expiryDate,
                    validator: (a) => expiryValidator(a, d.documentExpiryDate),
                    validationColor: expiryValidationColor(d.documentExpiryDate),
                    validationIcon: expiryValidationIcon(d.documentExpiryDate),
                    placeholder: "Date",
                    height: 60,
                    style: mainStyle,
                    radius: radius,

                    labelInRow: false,
                    value: d.documentExpiryDate,
                    onChanged: (a) {
                      d = d.copyWith(documentExpiryDate: a);
                      ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                    },
                  ),
                ),
                Expanded(
                  child: MyTextFieldNew(
                    inputFormatters: d.isScanned ? [MaskMiddleFormatter()] : [],
                    required: requiredFields.documentNumber,
                    controller: controller,
                    label: "Document #",
                    placeholder: "Number",
                    height: 60,
                    style: mainStyle,
                    radius: radius,
                    labelInRow: false,
                    headerBgColor: headerBg,
                    bodyBgColor: bodyBg,
                  ),
                ),
                Expanded(
                  child: MyFieldPicker<Gender>(
                    label: "Gender",
                    headerBgColor: headerBg,
                    bodyBgColor: bodyBg,
                    style: mainStyle,
                    radius: radius,
                    placeholder: "Gender",
                    labelStyle: TextStyle(fontSize: 9),
                    valueToString: (a) => a.title,
                    items: Gender.values,
                    hasSearch: false,
                    height: 60,
                    labelInRow: false,
                    value: d.gender,
                    onChange: (a) {
                      // var pd = d.copyWith(sex: a?.value);
                      // ref.read(passengerProvider.notifier).update((s) => pd);
                      d = d.copyWith(sex: a?.value);
                      ref.read(passportsProvider.notifier).updateAt(widget.index, d);

                      // ref.read(confirmingDocumentProvider.notifier).update((s) => d);
                    },
                  ),
                ),
                Expanded(
                  child: MyDatePicker(
                    // required: true,
                    // rowLabelRatio: [3, 7],
                    label: "Birth Date",
                    required: requiredFields.birthDate,
                    // rowLabelRatio: [5, 4],
                    headerBgColor: headerBg,
                    height: 60,
                    style: mainStyle,
                    radius: radius,
                    labelInRow: false,
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
                      ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthDate: a));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],),

    );
  }
}