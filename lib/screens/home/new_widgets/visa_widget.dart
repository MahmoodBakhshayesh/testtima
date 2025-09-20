import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/my_icons.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/screens/home/widgets/visa_section.dart';
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
import '../widgets/passport_section.dart';

class VisaWidget extends ConsumerWidget {
  const VisaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DocumentDetail> visas = ref.watch(visasProvider);

    return MyExpansionTile(

      title: Column(
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Text("Visa", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              DotButton(
                icon: ArtemisIcons.eraser_1,
                onPressed: () {},
                size: 40,
                radius: 8,
                flat: true,
                iconSize: 20,

                border: BorderSide(width: 1, color: context.mainColor),
              ),
            ],
          ),
          Column(
            children: visas.map((d) {
              int index = visas.indexOf(d);
              bool isLast = visas.length == index + 1;
              bool isFirst = index == 0;
              return VisaItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst);
            }).toList(),
          )
        ],
      ),
      showFooter: false,
      backgroundColor: Color(0xffFAF0E3),
      collapsedBackgroundColor:Color(0xffFAF0E3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
