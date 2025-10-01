import 'dart:io';
import 'dart:developer' as dev;
import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/core/classes/supervisor_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/interfaces/success_int.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/handlers/success_handler.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/core/utils_and_services/recorder/my_player.dart';
import 'package:abds/core/utils_and_services/recorder/my_voice_recorder.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/home/dialogs/ask_supervisor_dialog.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyTextField.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:ferry/typed_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:voice_note_kit/recorder/voice_enums/voice_enums.dart';
import 'package:voice_note_kit/voice_note_kit.dart';

import '../../../core/classes/constant_data_class.dart';
import '../../../core/classes/mrz_agg_class.dart';
import '../../../widgets/numeric_keyboard.dart';

class AskEmployeeIDSheet extends StatefulWidget {
  const AskEmployeeIDSheet({super.key});

  @override
  State<AskEmployeeIDSheet> createState() => _AskEmployeeIDSheetState();
}

class _AskEmployeeIDSheetState extends State<AskEmployeeIDSheet> {
  TextEditingController idC = TextEditingController();

  @override
  void initState() {

    super.initState();
    idC.addListener(()=>setState((){}));
  }
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom > 30;
    return SafeArea(
      bottom: true,
      child: Container(
        constraints: BoxConstraints(maxHeight: (context.height * 0.9)),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // pushes above keyboard
        ),
        // height: context.height*0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 12),
                IcomoonLayeredCss.user_octagon(),
                const SizedBox(width: 4),
                Expanded(child: Text("Employee ID")),
                CloseButton(),
              ],
            ),
            Divider(),
            Container(
              // color: Colors.black.withOpacity(0.02),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    //   child: IgnorePointer(
                    //     child: MyTextFieldNew(
                    //       headerBgColor: Colors.black.withOpacity(0.08),
                    //       bodyBgColor: Colors.black.withOpacity(0.04),
                    //       placeholder: "Enter ID",
                    //       label: "Employee ID",
                    //       controller: idC,
                    //       onSubmit: (a) {
                    //
                    //       },
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CupertinoTextField(
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(8),
                          color: MyColors.lineColor,
                        ),
                        style: TextStyle(fontSize: 40),
                        placeholder: "Employee ID",
                        controller: idC,
                      ),
                    ),
                    CupertinoNumericKeyboard(
                      maxLength: 6,
                      controller: idC,onDone:idC.text.isEmpty?null: (){
                      Navigator.of(context).pop(idC.text);
                    },),
                  ],
                ),
              ),
            ),
            // Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: MyButton(
            //           color: Colors.grey,
            //           borderSide: BorderSide(color: MyColors.lineColor),
            //           reverse: true,
            //           label: "Cancel",
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //       ),
            //       const SizedBox(width: 12),
            //       Expanded(
            //         child: MyButton(
            //           label: "Confirm",
            //           onPressed: () async {
            //             Navigator.of(context).pop(idC);
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
