import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/my_icons.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
import 'package:abds/screens/home/widgets/locked_passenger_widget.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/constants/ui.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../core/utils_and_services/operations/confirm_operation.dart';
import '../../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../../core/utils_and_services/string_utility.dart';
import '../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/DurationOfStayPicker.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../../widgets/MySwitchButton.dart';
import '../../../widgets/MyTextField.dart';
import '../../../widgets/MyTextFieldNew.dart';
import '../../../widgets/MyTimePicker.dart';
import '../home_state.dart';
import '../home_view_phone.dart';

class PassengerWidget extends ConsumerWidget {
  const PassengerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    // final bool locked = ref.watch(timaticResultProvider)?.status == 1;
    final bool locked = ref.watch(currentStatusProvider).isLocked;
    if(locked){
      return Column(
        children: [
          LockedPassengerRow(passengerDetails: passengerDetails, tileColor: Colors.black.withOpacity(0.08)),
          const SizedBox(height: 12),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Text("Passenger", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              DotButton(
                icon: ArtemisIcons.eraser_1,
                iconSize: 20,

                onPressed: () async {
                  final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                  if (!confirm) return;
                  ref.read(passengerProvider.notifier).update((s) => PassengerDetails());
                },
                size: 40,
                radius: 8,
                flat: true,
                border: BorderSide(width: 1, color: context.mainColor),
              ),
            ],
          ),
          PassengerDetailsRow(index: 0, isLast: true, isFirst: false, details: passengerDetails),
        ],
      ),
    );
    return MyExpansionTile(
      title: Column(
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Text("Passenger", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              DotButton(
                icon: ArtemisIcons.eraser_1,
                iconSize: 20,

                onPressed: () async {
                  final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                  if (!confirm) return;
                  ref.read(passengerProvider.notifier).update((s) => PassengerDetails());
                },
                size: 40,
                radius: 8,
                flat: true,
                border: BorderSide(width: 1, color: context.mainColor),
              ),
            ],
          ),
          PassengerDetailsRow(index: 0, isLast: true, isFirst: false, details: passengerDetails),
        ],
      ),
      showFooter: false,
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class PassengerDetailsRow extends ConsumerStatefulWidget {
  const PassengerDetailsRow({super.key, required this.index, required this.details, required this.isLast, required this.isFirst});

  final bool isFirst;
  final bool isLast;
  final int index;
  final PassengerDetails details;

  @override
  ConsumerState<PassengerDetailsRow> createState() => _PassengerDetailsRowState();
}

class _PassengerDetailsRowState extends ConsumerState<PassengerDetailsRow> {
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
    PassengerDetails details = ref.watch(passengerProvider);
    final headerBgColor = Color(0xffECECEC);
    final bodyBgColor = Color(0xffE9E9E9).withOpacity(0.48);
    final passNat = ref.watch(passportsProvider).firstOrNull?.nationality;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        // Row(
        //   spacing: 12,
        //   children: [
        //     Expanded(
        //       child: MyFieldPicker<Country>(
        //         hasSearch: true,
        //         searchAutoFocus: true,
        //         label: "Nationality",
        //         required: true,
        //         headerBgColor: headerBgColor,
        //         bodyBgColor: bodyBgColor,
        //         placeholder: "Country",
        //         prefixIcon: countryPrefixBuilder(details.nationality?.code3),
        //
        //         rowLabelRatio: [5, 4],
        //         searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
        //         itemToWidget: countryBuilder,
        //         items: BasicClass.constData.data.country,
        //         value: details.nationality,
        //         onChange: (a) {
        //           details = details.copyWith(nationality: a);
        //           ref.read(passengerProvider.notifier).update((s) => details);
        //         },
        //       ),
        //     ),
        //     Expanded(
        //       child: MyFieldPicker<Country>(
        //         hasSearch: true,
        //         searchAutoFocus: true,
        //         label: "Resident",
        //         required: true,
        //         headerBgColor: headerBgColor,
        //         bodyBgColor: bodyBgColor,
        //         rowLabelRatio: [5, 4],
        //         placeholder: "Country",
        //         prefixIcon: countryPrefixBuilder(details.residentCountryCode?.code3),
        //
        //         searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
        //         itemToWidget: countryBuilder,
        //         items: BasicClass.constData.data.country,
        //         value: details.residentCountryCode,
        //         onChange: (a) {
        //           details = details.copyWith(residentCountryCode: a);
        //           ref.read(passengerProvider.notifier).update((s) => details);
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 12),
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: MyFieldPicker<Country>(
                hasSearch: true,
                searchAutoFocus: true,
                label: "Resident",
                required: true,
                headerBgColor: headerBgColor,
                bodyBgColor: bodyBgColor,
                rowLabelRatio: [5, 4],
                placeholder: "Country",
                prefixIcon: countryPrefixBuilder(details.residentCountryCode?.code3),
                suggestion:  BasicClass.constData.data.country.where((a)=>a.code3 == passNat?.code3).toList(),
                searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                itemToWidget: countryBuilder,
                items: BasicClass.constData.data.country,
                value: details.residentCountryCode,
                onChange: (a) {
                  details = details.copyWith(residentCountryCode: a);
                  ref.read(passengerProvider.notifier).update((s) => details);
                },
              ),
            ),
            // Expanded(
            //   child: MyFieldPicker<Gender>(
            //     label: "Gender",
            //     headerBgColor: headerBgColor,
            //     bodyBgColor: bodyBgColor,
            //     placeholder: "Gender",
            //     valueToString: (a)=>a.title,
            //     rowLabelRatio: [5, 4],
            //     items: Gender.values,
            //     hasSearch: false,
            //     value: details.gender,
            //     onChange: (a) {
            //       details = details.copyWith(gender: a);
            //       ref.read(passengerProvider.notifier).update((s) => details);
            //     },
            //   ),
            // ),
            // const SizedBox(width: 12),
            Expanded(child:   MyFieldPicker<Country>(
              label: "Birth Place",
              hasSearch: true,
              rowLabelRatio: [5, 4],
              suggestion:  BasicClass.constData.data.country.where((a)=>a.code3 == passNat?.code3).toList(),
              searchAutoFocus: true,
              placeholder: "Country",
              headerBgColor: headerBgColor,
              bodyBgColor: bodyBgColor,
              prefixIcon: countryPrefixBuilder(details.birthCountry?.code3),

              searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
              items: BasicClass.constData.data.country,
              itemToWidget: countryBuilder,
              value: details.birthCountry,
              onChange: (a) {
                ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthCountry: a));
              },
            ),)
          ],
        ),
        // const SizedBox(height: 12),
        // MyDatePicker(
        //   required: true,
        //   label: "Birth Date",
        //   placeholder: "Birth Date",
        //   headerBgColor: headerBgColor,
        //   bodyBgColor: bodyBgColor,
        //   validator: (a) => birthDateValidator(a, details.birthDate),
        //   validationColor: birthDateValidationColor(details.birthDate),
        //   max: DateTime.now(),
        //   validationIcon: ArtemisIcons.user_square,
        //   value: details.birthDate,
        //   onChanged: (a) {
        //     ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthDate: a));
        //   },
        // ),

      ],
    );
  }
}

// String? birthDateValidator(String v, DateTime? bDate) {
//   if (bDate == null) return null;
//   int years = (bDate.difference(DateTime.now()).inDays / 365).floor().abs();
//   String s = StringUtility.formatDaysToAge(bDate.difference(DateTime.now()).inDays.abs());
//   return s;
// }

// Color? birthDateValidationColor(DateTime? bDate) {
//   if (bDate == null) return null;
//   int years = (bDate.difference(DateTime.now()).inDays / 365).floor().abs();
//   double realYears = (bDate.difference(DateTime.now()).inDays / 365).abs();
//   // log("realYears $realYears");
//   if (realYears < 2) {
//     return Colors.orange;
//   }
//   if (realYears <= 12) {
//     return Colors.orange;
//   }
//   return MyColors.green2;
// }

