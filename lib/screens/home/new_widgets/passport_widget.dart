import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/my_icons.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
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
import '../../result_report/result_report_state.dart';
import '../home_state.dart';
import '../widgets/locked_document_widget.dart';
import '../widgets/passport_section.dart';

class PassportWidget extends ConsumerWidget {
  final bool report;
  const PassportWidget({super.key,this.report = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(report){
      final List<DocumentDetail> passports = ref.watch(reportPassportsProvider);
      return Column(
        children: [
          Column(
            children: passports.map((d) {
              return LockedDocumentItemRow(d: d, tileColor:  Color(0xffE2E7F5),);
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],
      );
    }
    final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final bool locked = ref.watch(currentStatusProvider).isLocked;
    if(locked){
      return Column(
        children: [
          Column(
            children: passports.map((d) {
              return LockedDocumentItemRow(d: d, tileColor:  Color(0xffE2E7F5),);
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],
      );
    }
    if(passports.isEmpty){
      if(context.isDesktop){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          decoration: BoxDecoration(
              color: BasicClass.constData.data.documentType[0].getColor.withOpacity(0.12),
              borderRadius: BorderRadiusGeometry.circular(10)
          ),
          child: Row(
            children: [
              DotButton(icon: Icons.add,onPressed: (){},),
              const SizedBox(width: 12),
              BasicClass.constData.data.documentType[0].getIconBiger,
              const SizedBox(width: 12),
              Expanded(child: Text( BasicClass.constData.data.documentType[0].title,style: TextStyle(),)),
            ],
          ),
        );
      }
      return SizedBox();
    }

    return  Column(
      children: passports.map((d) {
        int index = passports.indexOf(d);
        bool isLast = passports.length == index + 1;
        bool isFirst = index == 0;
        bool isLocked = true;
        return  PassportItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst);
      }).toList(),
    );

  }
}
