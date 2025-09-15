// Row (with its own controller)
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../../widgets/MyTextField.dart';
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
      Text("$a (${(a as Location).name})"),
    ],
  );
  Widget? countryPrefixBuilder(String? a) {
    if(a != null) {
      return Row(
        children: [
          const SizedBox(width: 4),
          SizedBox(
              width: 15,height: 10,
              child: ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16))),
          const SizedBox(width: 4),
          Text(a,style: TextStyle(fontSize: 12),)
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
    final tim = BasicClass.timData;
    return Container(
      decoration: BoxDecoration(
        // color: Color(0xff324073).withOpacity(0.3),
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),
      child: MyExpansionTile(
        tapOnTitleActive: false,
        initiallyExpanded: d.isScanned,
        // backgroundColor: MyColors.scaffoldBg,
        // collapsedBackgroundColor: MyColors.scaffoldBg,
        backgroundColor: Color(0xff324073).withOpacity(0.2),
        collapsedBackgroundColor: Color(0xff324073).withOpacity(0.2),
        footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
        shape: RoundedRectangleBorder(),
        collapsedShape: RoundedRectangleBorder(),
        tilePadding: EdgeInsets.symmetric(horizontal: 14),
        footerExtra: IndexedStack(
          index: isLast ? 0 : 1,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                height: 30,
                label: "Passport",
                icon: Icons.add_circle_outline,
                onPressed: () {
                  ref.read(passportsProvider.notifier).add(DocumentDetail());
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Text(
            //           "Passport ${index + 1}",
            //           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: MyColors.greyText),
            //         ),
            //       ),
            //       DotButton(
            //         icon: ArtemisIcons.trash,
            //         color: Colors.red,
            //         flat: true,
            //         onPressed: () async {
            //           final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
            //           if (!confirm) return;
            //           ref.read(passportsProvider.notifier).removeAt(index);
            //         },
            //       ),
            //       const SizedBox(width: 8),
            //       DotButton(
            //         border: BorderSide(color: Colors.blueAccent),
            //         icon: Icons.refresh,
            //         flat: true,
            //         onPressed: () async {
            //           final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
            //           if (!confirm) return;
            //           ref.read(passportsProvider.notifier).updateAt(index, DocumentDetail());
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 12),
            Column(
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyFieldPicker<Location>(
                        label: "Issued In",
                        searchAutoFocus: true,
                        rowLabelRatio: [4, 4],
                        placeholder: "Country",
                        itemToWidget: countryBuilder,
                        prefixIcon: countryPrefixBuilder(d.documentIssueCountry?.code3),
                        searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
                        items: tim.locations.of(LocationType.country),
                        value: d.documentIssueCountry,
                        onChange: (a) {
                          d = d.copyWith(documentIssueCountry: a);
                          ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                        },
                      ),
                    ),
                    Expanded(
                      child: MyFieldPicker<Location>(
                        hasSearch: true,
                        searchAutoFocus: true,
                        rowLabelRatio: [4, 4],
                        label: "Nationality",
                        prefixIcon: countryPrefixBuilder(d.nationality?.code3),
                        required: true,
                        placeholder: "Country",
                        searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
                        itemToWidget: countryBuilder,
                        items: tim.locations.of(LocationType.country),
                        value: d.nationality,
                        onChange: (a) {

                          // ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                          d = d.copyWith(nationality: a, documentIssueCountry: a ?? d.documentIssueCountry);
                          ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                        },
                      ),
                    ),
                  ],
                ),
                MyFieldPicker<ParameterValue>(
                  label: "Code",
                  placeholder: "Code",
                  items: tim.params.of(ParameterType.documentCode),
                  // itemToString: docCodeToString,
                  // valueToString: docCodeToString,
                  value: d.documentCode,
                  onChange: (a) {
                    d = d.copyWith(documentCode: a);
                    ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                  },
                ),

                MyDatePicker(
                  rowLabelRatio: [3, 7],
                  label: "Expiry Date",
                  required: true,
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
        
        childrenPadding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 12),
        children: [
          MyDatePicker(
            required: true,
            rowLabelRatio: [3, 7],
            label: "Birth Date",
            placeholder: "Birth Date",
            validator: (a) => birthDateValidator(a, d.birthDate),
            validationColor: birthDateValidationColor(d.birthDate),
            max: DateTime.now(),
            validationIcon: ArtemisIcons.user_square,
            value: d.birthDate,

            onChanged: (a) {
              // ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthDate: a));
              d = d.copyWith(birthDate: a);
              ref.read(passportsProvider.notifier).updateAt(widget.index, d);
            },
          ),

          const SizedBox(height: 12),

          // const SizedBox(height: 12),
          MyTextField(controller: controller, label: "Document #", placeholder: "Number", labelInRow: true),
          const SizedBox(height: 12),
          // MyDatePicker(
          //   label: "Issue Date",
          //   placeholder: "Issue Date",
          //   rowLabelRatio: [3, 7],
          //   value: d.documentIssueDate,
          //   onChanged: (a) {
          //     d = d.copyWith(documentIssueDate: a);
          //     ref.read(passportsProvider.notifier).updateAt(widget.index, d);
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
          //           ref.read(passportsProvider.notifier).updateAt(widget.index, d);
          //         },
          //       ),
          //     ),
          //   ],
          // ),
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