import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../initialize.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../../widgets/MyTextField.dart';
import '../home_controller.dart';
import '../home_view_phone.dart';

class AskSupervisorDialog extends StatefulWidget {
  const AskSupervisorDialog({super.key});

  @override
  State<AskSupervisorDialog> createState() => _AskSupervisorDialogState();
}

class _AskSupervisorDialogState extends State<AskSupervisorDialog> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
      insetPadding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(children: [
                Text("Reference Code History",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
              ],),
            ),
            Divider(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(children: [
                Text("Please insert your reference code!"),
              ],),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoTextField(controller: textEditingController,placeholder: "Code",decoration: BoxDecoration(color: Colors.black.withOpacity(0.08)),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                label: "OK",
                reverse: true,
                borderSide: BorderSide(color: context.mainColor),
                onPressed: () async {
                  await getIt<HomeController>().getRefHistoryLog("8973-9468");

                  // Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

