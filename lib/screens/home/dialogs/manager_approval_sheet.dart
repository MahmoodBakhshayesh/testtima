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
import 'package:ferry/typed_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_signature/signature.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voice_note_kit/recorder/voice_enums/voice_enums.dart';
import 'package:voice_note_kit/voice_note_kit.dart';

import '../../../core/classes/mrz_agg_class.dart';
import '../../../core/interfaces/success_int.dart';
import '../../../core/utils_and_services/handlers/success_handler.dart';

class ManagerApprovalSheet extends StatefulWidget {
  final String logId;

  const ManagerApprovalSheet({super.key, required this.logId});

  @override
  State<ManagerApprovalSheet> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<ManagerApprovalSheet> {
  File? recordedSound;
  List<String> attachingPhotos = [];
  TextEditingController flnbC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  ParameterValue? airline;
  final control = HandSignatureControl(initialSetup: SignaturePathSetup(threshold: 3.0, smoothRatio: 0.65, velocityRange: 2.0, pressureRatio: 0.0, args: {'color': 'red'}));

  // Create the signature pad widget

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
                Expanded(child: Text("Airline Station Manager Approval")),
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
                    MyTextField(labelInRow: true, label: "Full Name", backgroundColor: Colors.white, placeholder: "Enter your full name",controller: nameC,),
                    MyFieldPicker<ParameterValue?>(
                        value: airline,
                        onChange: (a){
                          airline = a;
                          setState((){});
                        },
                        label: 'Airline Code', items: BasicClass.timData.params.of(ParameterType.carrier), backgroundColor: Colors.white, placeholder: "Select"),
                    MyTextField(
                        labelInRow: true, label: "Flight Number", backgroundColor: Colors.white, placeholder: "Flight Number", controller: flnbC, keyboardType: TextInputType.numberWithOptions(signed: true)),
                    GestureDetector(
                      onTap: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: context.width * 0.9,
                            height: context.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              border: Border.all(color: Colors.white),
                              color: Colors.white,
                            ),
                            child: HandSignature(
                              control: control,
                              onPointerDown: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              drawer: ShapeSignatureDrawer(color: Colors.black, width: 3.0, maxWidth: 5.0),
                            ),
                          ),
                          Positioned(
                            top: 24,
                              child: Text("Draw Signature Here...",style: TextStyle(color: Colors.black),))
                        ],
                      ),
                    ),
                    Row(children: [
                      Spacer(),
                      DotButton(icon: ArtemisIcons.eraser_1,onPressed: (){
                        control.clear();
                      },)
                    ],),
                    Visibility(
                      visible: !keyboardIsOpen,
                      child: Column(spacing: 12, children: []),
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
                      onPressed: () async {
                        final size = (context.width*0.9).abs().floor();
                        final byteData = await control.toImage(width:size ,height: size);
                        if(byteData == null){
                          return ;
                        }
                        final buffer = byteData.buffer;
                        final dir = await getTemporaryDirectory();

                        final String path = "${dir.path}/sign.png";
                        final f =await  File(path).writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
                        final bool = await getIt<HomeController>().attachToResult(
                          logId: widget.logId,
                          images: [f.path],
                          voices: [],
                          data: {'airline': airline?.code, 'name': nameC.text, 'flightNumber': flnbC.text},
                        );
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
