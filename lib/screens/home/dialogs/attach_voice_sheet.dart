import 'dart:io';
import 'dart:developer' as dev;
import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:voice_note_kit/recorder/voice_enums/voice_enums.dart';
import 'package:voice_note_kit/voice_note_kit.dart';

import '../../../core/classes/mrz_agg_class.dart';
import '../../../core/interfaces/success_int.dart';
import '../../../core/utils_and_services/handlers/success_handler.dart';
import '../../../core/utils_and_services/recorder/my_player.dart';
import '../../../core/utils_and_services/recorder/my_voice_recorder.dart';

class AttachVoiceSheet extends StatefulWidget {
  final String logId;

  const AttachVoiceSheet({super.key, required this.logId});

  @override
  State<AttachVoiceSheet> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<AttachVoiceSheet> {
  List<String> attachingVoices = [];

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
                Expanded(child: Text("Attach Voice")),
                CloseButton(),
              ],
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black.withOpacity(0.02),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !keyboardIsOpen,
                      child: Column(
                        spacing: 12,
                        children: [
                          MyVoiceRecorder(
                            onSubmitRecord: (a) {
                              dev.log("saved to $a");
                              attachingVoices.insert(0, a);
                              setState(() {});
                            },
                          ),
                          Container(
                            constraints: BoxConstraints(maxHeight: 100),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                ...attachingVoices.map((a) {
                                  dev.log(a);
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: MyAudioPlayerWidget(
                                          key: Key(a),
                                          audioPath: a,
                                          backgroundColor: Colors.transparent,
                                          timerTextStyle: TextStyle(color: Colors.blueAccent),
                                          iconColor: Colors.blueAccent,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      DotButton(
                                        color: Colors.red,
                                        icon: ArtemisIcons.trash,
                                        onPressed: () {
                                          attachingVoices.remove(a);
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyButton(
                      color: Colors.grey,
                      borderSide: BorderSide(color: MyColors.lineColor),
                      reverse: true,
                      label: "Cancel",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyButton(
                      label: "Submit",
                      onPressed: attachingVoices.isEmpty?null: () async {
                        final bool = await getIt<HomeController>().attachToResult(logId: widget.logId, voices: attachingVoices, images: [],data: {"action":"attachVoice"});
                        if (bool) {
                          Navigator.of(context).pop(true);
                          Future.delayed(Duration(milliseconds: 300), () {
                            SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
