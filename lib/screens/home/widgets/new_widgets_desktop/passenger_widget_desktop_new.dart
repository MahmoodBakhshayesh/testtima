import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/classes/basic_class.dart';
import '../../../../core/classes/constant_data_class.dart';
import '../../../../core/constants/ui.dart';
import '../../../../core/extenstions/context_exp.dart';
import '../../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../../core/utils_and_services/country_flag_util.dart';
import '../../../../core/utils_and_services/operations/confirm_operation.dart';
import '../../../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../../../widgets/DotButton.dart';
import '../../../../widgets/MyFieldPicker.dart';
import '../../home_state.dart';

class PaxWidgetDesktop extends ConsumerWidget {
  const PaxWidgetDesktop({super.key});

  Widget? countryPrefixBuilder(String? a) {
    if (a != null) {
      return Row(
        children: [
          const SizedBox(width: 4),
          SizedBox(
            width: 15,
            height: 10,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(2),
              // child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)
              child: MyCountryFlagsPro.getFlag(a),
            ),
          ),
          // const SizedBox(width: 4),
          // Text(a, style: TextStyle(fontSize: 12)),
        ],
      );
    }
  }

  Widget countryBuilder(dynamic a) => Row(
    children: [
      MyCountryFlagsPro.getFlag("$a", width: 22, height: 16, borderRadius: BorderRadius.circular(2)),
      const SizedBox(width: 8),
      Text("$a (${(a as Country).name})",style: TextStyle(fontSize: 20,color: MyColors.mainBlue),),
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextStyle mainsStyle = TextStyle(fontSize: 20, color: MyColors.mainBlue);
    TextStyle secondaryStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w200);
    PassengerDetails details = ref.watch(passengerProvider);
    final headerBgColor = Color(0xffECECEC);
    final bodyBgColor = Colors.white;
    final passNat = ref.watch(passportsProvider).firstOrNull?.nationality;
    final mandatories = BasicClass.constData.data.mandatory?.passenger;
    return Container(

      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusGeometry.circular(12)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  "Pax",
                ),
              ),
            ),
            VerticalDivider(width: 2, color: MyColors.black3),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyFieldPicker<Country>(
                        hasSearch: true,
                        labelInRow: false,
                        searchAutoFocus: true,
                        radius: BorderRadius.circular(12),
                        label: "Resident",
                        height: 60,
                        required: mandatories?.resident ?? false,
                        borderSide: BoxBorder.all(color: MyColors.lineColor),
                        bodyBgColor: bodyBgColor,
                        placeholder: "Country",
                        prefixIcon: countryPrefixBuilder(details.residentCountryCode?.code3),
                        suggestion: BasicClass.constData.data.country.where((a) => a.code3 == passNat?.code3).toList(),
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
                    Expanded(
                      child: MyFieldPicker<Country>(
                        label: "Birth Place",
                        hasSearch: true,
                        height: 60,
                        labelInRow: false,
                        borderSide: BoxBorder.all(color: MyColors.lineColor),
                        radius: BorderRadius.circular(12),
                        required: mandatories?.birthPlace ?? false,
                        suggestion: BasicClass.constData.data.country.where((a) => a.code3 == passNat?.code3).toList(),
                        searchAutoFocus: true,
                        placeholder: "Country",
                        bodyBgColor: bodyBgColor,
                        prefixIcon: countryPrefixBuilder(details.birthCountry?.code3),
                        searchBuilder: (dynamic a) => "$a ${(a as Country).name}",
                        items: BasicClass.constData.data.country,
                        itemToWidget: countryBuilder,
                        value: details.birthCountry,
                        onChange: (a) {
                          ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthCountry: a));
                        },
                      ),
                    ),
                    DotButton(
                      icon: ArtemisIcons.eraser_1,
                      onPressed: () async {
                        final confirm = await ConfirmOperation.getConfirm(
                          Operation(type: OperationType.warning, icon: ArtemisIcons.eraser_1, message: 'You are about to clear passenger information. Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]),
                        );
                        if (!confirm) return;
                        ref.read(passengerProvider.notifier).update((s) => PassengerDetails());
                      },
                      size: 40,
                      iconSize: 20,
                      radius: 8,
                      flat: true,
                      border: BorderSide(width: 1, color: context.mainColor),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}