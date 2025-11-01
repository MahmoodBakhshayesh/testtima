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
import 'package:abds/core/utils_and_services/recorder/my_player.dart';
import 'package:abds/core/utils_and_services/recorder/my_voice_recorder.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
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
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
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

class AskSupervisorSheet extends StatefulWidget {
  final String logId;
  final List<Supervisor> supervisors;

  const AskSupervisorSheet({super.key, required this.logId, required this.supervisors});

  @override
  State<AskSupervisorSheet> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<AskSupervisorSheet> {
  File? recordedSound;
  List<String> attachingPhotos = [];
  List<String> attachingVoices = [];
  TextEditingController flnbC = TextEditingController();
  TextEditingController messageC = TextEditingController();
  ParameterValue? airline;
  Supervisor? supervisor;

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom > 30;

    if(context.isDesktop){
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(child: Text("Ask Supervisor")),
                CloseButton(),
              ],
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.02)),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyFieldPicker<Supervisor?>(
                      label: 'Select Supervisor',
                      items: widget.supervisors,
                      rowLabelRatio: [3, 7],
                      headerBgColor: Colors.white,
                      bodyBgColor: Color(0xffF4F4f4),
                      placeholder: "Select",
                      onChange: (a) {
                        supervisor = a;
                        setState(() {});
                      },
                    ),

                    // MyFieldPicker<ParameterValue?>(
                    //   onChange: (a) {
                    //     airline = a;
                    //     setState(() {});
                    //   },
                    //   value: airline,
                    //   label: 'Airline Code',
                    //   items: BasicClass.timData.params.of(ParameterType.carrier),
                    //   backgroundColor: Colors.white,
                    //   placeholder: "Select",
                    // ),
                    // MyTextField(labelInRow: true, label: "Flight Number", backgroundColor: Colors.white, placeholder: "Flight Number", controller: flnbC, keyboardType: TextInputType.numberWithOptions(signed: true)),
                    SizedBox(
                      height: 100,
                      child: CupertinoTextField(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                        ),
                        controller: messageC,
                        // minLines: 5,
                        // maxLines: 5,
                        placeholder: "Enter your message",
                      ),
                    ),
                    // Visibility(
                    //   visible: !keyboardIsOpen,
                    //   child: Column(
                    //     spacing: 12,
                    //     children: [
                    //       Container(
                    //         width: double.infinity,
                    //         padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    //         child: Wrap(
                    //           alignment: WrapAlignment.start,
                    //           spacing: 12,
                    //           children: [
                    //             ...attachingPhotos.map(
                    //               (p) => SizedBox(
                    //                 width: 54,
                    //                 height: 54,
                    //                 child: Stack(
                    //                   children: [
                    //                     SizedBox(
                    //                       width: 62,
                    //                       height: 62,
                    //                       child: ClipRRect(
                    //                         borderRadius: BorderRadius.circular(8),
                    //                         child: Image.file(File(p), fit: BoxFit.fill),
                    //                       ),
                    //                     ),
                    //                     Positioned(
                    //                       right: 2,
                    //                       top: 2,
                    //                       child: DotButton(
                    //                         icon: Icons.delete,
                    //                         color: Colors.red,
                    //                         onPressed: () {
                    //                           // ref.read(attachingPhotoPathProvider.notifier).update((s) => [...s.where((a) => a != p)]);
                    //                           attachingPhotos.remove(p);
                    //                           setState(() {});
                    //                         },
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //             DotButton(
                    //               size: 54,
                    //               icon: Icons.image,
                    //               onPressed: () async {
                    //                 final path = await getIt<HomeController>().selectPhotoToAttachMethodDialog();
                    //                 if (path != null) {
                    //                   attachingPhotos.add(path);
                    //                   setState(() {});
                    //                 }
                    //               },
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       MyVoiceRecorder(
                    //         onSubmitRecord: (a) {
                    //           dev.log("saved to $a");
                    //           attachingVoices.insert(0, a);
                    //           setState(() {});
                    //         },
                    //       ),
                    //       Container(
                    //         constraints: BoxConstraints(maxHeight: 100),
                    //         child: ListView(
                    //           shrinkWrap: true,
                    //           children: [
                    //             ...attachingVoices.map((a) {
                    //               dev.log(a);
                    //               return Row(
                    //                 children: [
                    //                   Expanded(
                    //                     child: MyAudioPlayerWidget(
                    //                       key: Key(a),
                    //                       audioPath: a,
                    //                       backgroundColor: Colors.transparent,
                    //                       timerTextStyle: TextStyle(color: Colors.blueAccent),
                    //                       iconColor: Colors.blueAccent,
                    //                     ),
                    //                   ),
                    //                   const SizedBox(width: 8),
                    //                   DotButton(
                    //                     color: Colors.red,
                    //                     icon: ArtemisIcons.trash,
                    //                     onPressed: () {
                    //                       attachingVoices.remove(a);
                    //                       setState(() {});
                    //                     },
                    //                   ),
                    //                 ],
                    //               );
                    //             }),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                      radius: 12,
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
                      label: "Send",
                      radius: 12,
                      icon: ArtemisIcons.send_2,
                      iconInRight: true,
                      onPressed:supervisor==null?null: () async {
                        // final bool = await getIt<HomeController>().attachToResult(
                        //   logId: widget.logId,
                        //   images: attachingPhotos,
                        //   voices: attachingVoices,
                        //   data: {'airline': airline?.code, 'message': messageC.text, 'flightNumber': flnbC.text, 'supervisorId': supervisor?.id, 'action': 'askSupervisor'},
                        // );
                        final bool = await getIt<HomeController>().askSupervisor(logId: widget.logId, supervisorId: supervisor!.id!, msg: messageC.text);
                        if (bool) {
                          Navigator.of(context).pop(true);
                          Future.delayed(Duration(milliseconds: 300), () {
                            SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
                          });
                        }
                        // Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Material(
      child: SafeArea(
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
                  Expanded(child: Text("Ask Supervisor")),
                  CloseButton(),
                ],
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.02)),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 12,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyFieldPicker<Supervisor?>(
                        label: 'Select Supervisor',
                        items: widget.supervisors,
                        rowLabelRatio: [3, 7],
                        headerBgColor: Colors.white,
                        bodyBgColor: Color(0xffF4F4f4),
                        placeholder: "Select",
                        onChange: (a) {
                          supervisor = a;
                          setState(() {});
                        },
                      ),
      
                      // MyFieldPicker<ParameterValue?>(
                      //   onChange: (a) {
                      //     airline = a;
                      //     setState(() {});
                      //   },
                      //   value: airline,
                      //   label: 'Airline Code',
                      //   items: BasicClass.timData.params.of(ParameterType.carrier),
                      //   backgroundColor: Colors.white,
                      //   placeholder: "Select",
                      // ),
                      // MyTextField(labelInRow: true, label: "Flight Number", backgroundColor: Colors.white, placeholder: "Flight Number", controller: flnbC, keyboardType: TextInputType.numberWithOptions(signed: true)),
                      SizedBox(
                        height: 100,
                        child: CupertinoTextField(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            border: Border.all(color: Colors.white),
                            color: Colors.white,
                          ),
                          controller: messageC,
                          // minLines: 5,
                          // maxLines: 5,
                          placeholder: "Enter your message",
                        ),
                      ),
                      // Visibility(
                      //   visible: !keyboardIsOpen,
                      //   child: Column(
                      //     spacing: 12,
                      //     children: [
                      //       Container(
                      //         width: double.infinity,
                      //         padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      //         child: Wrap(
                      //           alignment: WrapAlignment.start,
                      //           spacing: 12,
                      //           children: [
                      //             ...attachingPhotos.map(
                      //               (p) => SizedBox(
                      //                 width: 54,
                      //                 height: 54,
                      //                 child: Stack(
                      //                   children: [
                      //                     SizedBox(
                      //                       width: 62,
                      //                       height: 62,
                      //                       child: ClipRRect(
                      //                         borderRadius: BorderRadius.circular(8),
                      //                         child: Image.file(File(p), fit: BoxFit.fill),
                      //                       ),
                      //                     ),
                      //                     Positioned(
                      //                       right: 2,
                      //                       top: 2,
                      //                       child: DotButton(
                      //                         icon: Icons.delete,
                      //                         color: Colors.red,
                      //                         onPressed: () {
                      //                           // ref.read(attachingPhotoPathProvider.notifier).update((s) => [...s.where((a) => a != p)]);
                      //                           attachingPhotos.remove(p);
                      //                           setState(() {});
                      //                         },
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             DotButton(
                      //               size: 54,
                      //               icon: Icons.image,
                      //               onPressed: () async {
                      //                 final path = await getIt<HomeController>().selectPhotoToAttachMethodDialog();
                      //                 if (path != null) {
                      //                   attachingPhotos.add(path);
                      //                   setState(() {});
                      //                 }
                      //               },
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       MyVoiceRecorder(
                      //         onSubmitRecord: (a) {
                      //           dev.log("saved to $a");
                      //           attachingVoices.insert(0, a);
                      //           setState(() {});
                      //         },
                      //       ),
                      //       Container(
                      //         constraints: BoxConstraints(maxHeight: 100),
                      //         child: ListView(
                      //           shrinkWrap: true,
                      //           children: [
                      //             ...attachingVoices.map((a) {
                      //               dev.log(a);
                      //               return Row(
                      //                 children: [
                      //                   Expanded(
                      //                     child: MyAudioPlayerWidget(
                      //                       key: Key(a),
                      //                       audioPath: a,
                      //                       backgroundColor: Colors.transparent,
                      //                       timerTextStyle: TextStyle(color: Colors.blueAccent),
                      //                       iconColor: Colors.blueAccent,
                      //                     ),
                      //                   ),
                      //                   const SizedBox(width: 8),
                      //                   DotButton(
                      //                     color: Colors.red,
                      //                     icon: ArtemisIcons.trash,
                      //                     onPressed: () {
                      //                       attachingVoices.remove(a);
                      //                       setState(() {});
                      //                     },
                      //                   ),
                      //                 ],
                      //               );
                      //             }),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                        radius: 12,
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
                        label: "Send",
                        radius: 12,
                        icon: ArtemisIcons.send_2,
                        iconInRight: true,
                        onPressed:supervisor==null?null: () async {
                          // final bool = await getIt<HomeController>().attachToResult(
                          //   logId: widget.logId,
                          //   images: attachingPhotos,
                          //   voices: attachingVoices,
                          //   data: {'airline': airline?.code, 'message': messageC.text, 'flightNumber': flnbC.text, 'supervisorId': supervisor?.id, 'action': 'askSupervisor'},
                          // );
                          final bool = await getIt<HomeController>().askSupervisor(logId: widget.logId, supervisorId: supervisor!.id!, msg: messageC.text);
                          if (bool) {
                            Navigator.of(context).pop(true);
                            Future.delayed(Duration(milliseconds: 300), () {
                              SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
                            });
                          }
                          // Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
