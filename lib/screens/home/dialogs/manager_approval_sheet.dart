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
import 'package:abds/screens/home/home_view_phone.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyTextField.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:ferry/typed_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hand_signature/signature.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voice_note_kit/recorder/voice_enums/voice_enums.dart';
import 'package:voice_note_kit/voice_note_kit.dart';

import '../../../core/classes/constant_data_class.dart';
import '../../../core/classes/mrz_agg_class.dart';
import '../../../core/interfaces/success_int.dart';
import '../../../core/utils_and_services/handlers/success_handler.dart';
import '../../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../../../widgets/MyTextFieldNew.dart';
import '../../../widgets/glass_widget.dart';

class ManagerApprovalSheet extends StatefulWidget {
  final String logId;

  const ManagerApprovalSheet({super.key, required this.logId});

  @override
  State<ManagerApprovalSheet> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<ManagerApprovalSheet> {
  File? recordedSound;
  List<String> attachingPhotos = [];
  TextEditingController nameC = TextEditingController();
  TextEditingController msgC = TextEditingController();
  final control = HandSignatureControl(initialSetup: SignaturePathSetup(threshold: 3.0, smoothRatio: 0.65, velocityRange: 2.0, pressureRatio: 0.0, args: {'color': 'red'}));

  int response = 0;

  // Create the signature pad widget

  @override
  Widget build(BuildContext context) {
    final green = Color(0xff00C68E);
    final blue = context.mainColor;
    final red = Color(0xffFF3F42);
    final colors = [blue, red, green];
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 30;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),

          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final timaticRes = ref.watch(timaticResultNewProvider)!;
              final visas = ref.watch(visasProvider);
              final passports = ref.watch(passportsProvider);
              final passengerDetails = ref.watch(passengerProvider);
              final segments = ref.watch(segmentsProvider);
              return HeaderSummaryWidget(header: const SizedBox(height: 24));
            },
          ),
        ),

        Expanded(
          child: Container(
            color: Colors.white,
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
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const SizedBox(width: 12),
                        Expanded(child: Text("Station Manager Decision")),
                        CloseButton(),
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff2a5cff).withOpacity(0.18), Color(0xff535353).withOpacity(0.08)]),
                        ),
                        child: Column(
                          spacing: 12,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextFieldNew(
                              inputFormatters: [MyInputFormatter.uppercase],
                              headerBgColor: Colors.white,
                              bodyBgColor: Color(0xffF4f4f4),
                              labelInRow: true,
                              label: "Full Name",
                              backgroundColor: Colors.white,
                              placeholder: "Enter your full name",
                              controller: nameC,
                            ),

                            MyTextFieldNew(headerBgColor: Colors.white, bodyBgColor: Color(0xffF4f4f4), labelInRow: true, label: "Note", backgroundColor: Colors.white, placeholder: "Note", controller: msgC),

                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: context.width,
                                        height: double.infinity,
                                        // height: context.width * 0.7,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadiusGeometry.circular(10),
                                          border: Border.all(color: Colors.white),
                                          color: Colors.white,
                                        ),
                                        child: HandSignature(
                                          control: control,
                                          onPointerDown: () {
                                            FocusScope.of(context).requestFocus(FocusNode());
                                          },
                                          drawer: ShapeSignatureDrawer(color: Colors.black, width: 3.0, maxWidth: 5.0),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 24,
                                      child: Text("Draw Signature Here...", style: TextStyle(color: Colors.black.withOpacity(0.4))),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          DotButton(
                                            icon: ArtemisIcons.eraser_1,
                                            onPressed: () {
                                              control.clear();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            //   String passNumber = ref.watch(passportsProvider).map((a)=>a.documentNumber).where((a)=>(a??'').isNotEmpty).firstOrNull??'********';
                            //   String flnb = "${ref.watch(segmentsProvider).first.operatingCarrier?.code??''}${ref.watch(segmentsProvider).first.flnb??''}";
                            //   String dateStr =ref.watch(segmentsProvider).first.departure.dateTime==null?"": DateFormat("dd MMM yyyy").format(ref.watch(segmentsProvider).first.departure.dateTime!);
                            //   return Container(
                            //     decoration: BoxDecoration(color: Color(0xff2A5Cff).withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                            //     padding: EdgeInsets.all(12),
                            //     child: Row(
                            //       children: [
                            //         Icon(ArtemisIcons.verify, color: Color(0xff2A5Cff)),
                            //         const SizedBox(width: 8),
                            //         Expanded(
                            //           child: Text("I confirm that the passenger holding passport number ${passNumber} is authorized to travel on flight ${flnb} on ${dateStr}.",style: TextStyle(fontSize: 12),),
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // },)
                          ],
                        ),
                      ),
                    ),
                    isKeyboardOpen
                        ? SizedBox()
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: MyButton(
                                        label: "OKTB",
                                        radius: 12,
                                        reverse: response == 0 ? false : response != 1,
                                        borderSide: response != 1 ? BorderSide(color: blue) : null,
                                        color: response == 1 ? green : blue,
                                        onPressed: () async {
                                          if (response == 1) {
                                            response = 0;
                                          } else {
                                            response = 1;
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: MyButton(
                                        label: "NO GO",
                                        radius: 12,
                                        reverse: response == 0 ? false : response != 2,
                                        borderSide: response != 2 ? BorderSide(color: blue) : null,
                                        color: response == 2 ? Colors.red : blue,
                                        onPressed: () async {
                                          if (response == 2) {
                                            response = 0;
                                          } else {
                                            response = 2;
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                                child: EasyAnimatedIndexedStack(
                                  index: response,
                                  children: [
                                    SizedBox(),
                                    Consumer(
                                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                        String passNumber = ref.watch(passportsProvider).map((a) => a.documentNumber).where((a) => (a ?? '').isNotEmpty).firstOrNull ?? '********';
                                        String flnb = "${ref.watch(segmentsProvider).first.operatingCarrier?.code ?? ''}${ref.watch(segmentsProvider).first.flnb ?? ''}";
                                        String dateStr = ref.watch(segmentsProvider).first.departure.dateTime == null ? "" : DateFormat("dd MMM yyyy").format(ref.watch(segmentsProvider).first.departure.dateTime!);
                                        return Container(
                                          decoration: BoxDecoration(color: green.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                                          padding: EdgeInsets.all(12),
                                          child: Row(
                                            children: [
                                              Icon(ArtemisIcons.verify, color: green),
                                              const SizedBox(width: 8),
                                              Expanded(child: Text("I confirm that the passenger holding passport number ${passNumber} is authorized to travel on flight ${flnb} on ${dateStr}.", style: TextStyle(fontSize: 12))),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    Consumer(
                                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                        String passNumber = ref.watch(passportsProvider).map((a) => a.documentNumber).where((a) => (a ?? '').isNotEmpty).firstOrNull ?? '********';
                                        String flnb = "${ref.watch(segmentsProvider).first.operatingCarrier?.code ?? ''}${ref.watch(segmentsProvider).first.flnb ?? ''}";
                                        String dateStr = ref.watch(segmentsProvider).first.departure.dateTime == null ? "" : DateFormat("dd MMM yyyy").format(ref.watch(segmentsProvider).first.departure.dateTime!);
                                        return Container(
                                          decoration: BoxDecoration(color: red.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                                          padding: EdgeInsets.all(12),
                                          child: Row(
                                            children: [
                                              Icon(ArtemisIcons.danger, color: red),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text("I confirm that the passenger holding passport number ${passNumber} is not authorized to travel on flight ${flnb} on ${dateStr}.", style: TextStyle(fontSize: 12)),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: MyButton(
                                        color: Colors.grey,
                                        borderSide: BorderSide(color: MyColors.lineColor),
                                        reverse: true,
                                        radius: 12,
                                        label: "Cancel",
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: MyButton(
                                        label: "Confirm",
                                        radius: 12,
                                        iconInRight: true,
                                        icon: ArtemisIcons.send_2,
                                        onPressed: response == 0
                                            ? null
                                            : () async {
                                                final size = (context.width * 0.9).abs().floor();
                                                final byteData = await control.toImage(width: size, height: size, background: Colors.transparent);
                                                if (byteData == null) {
                                                  return;
                                                }
                                                final buffer = byteData.buffer;
                                                final dir = await getTemporaryDirectory();

                                                final String path = "${dir.path}/sign.png";
                                                final f = await File(path).writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
                                                final bool = await getIt<HomeController>().airlineApproval(
                                                  logId: widget.logId,
                                                  sign: f.path,
                                                  data: {'name': nameC.text, "comment": msgC.text, "message": msgC.text, "action": "managerApproval", "approve": response == 1},
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget countryBuilderHeader(dynamic a) => a == null
      ? SizedBox()
      : Row(
          children: [
            Text("$a"),
            const SizedBox(width: 2),
            ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
          ],
        );
}
