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
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
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
  final control = HandSignatureControl(initialSetup: SignaturePathSetup(threshold: 3.0, smoothRatio: 0.65, velocityRange: 2.0, pressureRatio: 0.0, args: {'color': 'red'}));

  // Create the signature pad widget

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom > 30;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))
          ),
          
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final timaticRes = ref.watch(timaticResultNewProvider)!;
              final visas = ref.watch(visasProvider);
              final passports = ref.watch(passportsProvider);
              final passengerDetails = ref.watch(passengerProvider);
              final segments = ref.watch(segmentsProvider);
              return FigmaGlass(
                // height: 124 + (resultMode ? additionalHeight : 0),
                child: Container(
                  padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 16),
                  width: context.width,
                  decoration: BoxDecoration(
                    color: timaticRes!.evaluationResult.getColor.withOpacity(0.28),
                    border: Border(bottom: BorderSide(color: timaticRes!.evaluationResult.getColor, width: 2)),

                    // color: Colors.red
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 36, width: double.infinity),
                      const SizedBox(height: 36, width: double.infinity),

                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          spacing: 8,
                          children: [
                            Builder(
                              builder: (BuildContext context) {
                                final res = ref.watch(timaticResultNewProvider)!;
                                return Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                                  child: Column(
                                    children: [
                                      Row(
                                        spacing: 12,
                                        children: [
                                          ...res.segments.map(
                                            (seg) => Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadiusGeometry.circular(4),
                                                color: seg.segmentEvaluationResult.getColor,
                                                border: Border.all(color: seg.segmentEvaluationResult.getColor),
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                              child: Row(
                                                children: [
                                                  Icon(seg.segmentEvaluationResult.getIconCircle, color: Colors.white, size: 15),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    "${seg.route}",
                                                    style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Flight: ", style: TextStyle(color: Colors.grey)),
                                    Text("${segments.first.operatingCarrier?.code ?? ''} ${segments.first.flnb ?? ''}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Date: ", style: TextStyle(color: Colors.grey)),
                                    Text("${segments.first.departure.dateTime.format_ddMMM ?? ''}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Route: ", style: TextStyle(color: Colors.grey)),
                                    Text("${segments.first.departure.point ?? ''}-${segments.first.arrival.point ?? ''}"),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              spacing: 12,
                              children: [
                                Row(
                                  children: [
                                    Text("Passport: ", style: TextStyle(color: Colors.grey)),
                                    Text("${passports.firstOrNull?.documentNumber ?? ''}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Tracking: ", style: TextStyle(color: Colors.grey)),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadiusGeometry.circular(5),
                                        color: timaticRes.evaluationResult.getColor.withOpacity(0.3),
                                        border: Border.all(color: timaticRes.evaluationResult.getColor),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Text(ref.watch(refCodeProvider) ?? '', style: TextStyle(color: Colors.black)),
                                          const SizedBox(width: 8),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadiusGeometry.circular(5),
                                              color: timaticRes.evaluationResult.getColor,
                                              border: Border.all(color: timaticRes.evaluationResult.getColor),
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 4),
                                            child: Text("${timaticRes.evaluationResult.name}", style: TextStyle(color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Nationality: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    countryBuilderHeader(passengerDetails.nationality),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Resident: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    countryBuilderHeader(passengerDetails.residentCountryCode),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("VISA: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    countryBuilderHeader(visas.firstOrNull?.documentIssueCountry),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  spacing: 8,
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                          child: Column(
                            children: [
                              Row(
                                spacing: 12,
                                children: [
                                  ...timaticRes.segments.map(
                                    (seg) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadiusGeometry.circular(4),
                                        color: seg.segmentEvaluationResult.getColor,
                                        border: Border.all(color: seg.segmentEvaluationResult.getColor),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      child: Row(
                                        children: [
                                          Icon(seg.segmentEvaluationResult.getIconCircle, color: Colors.white, size: 15),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${seg.route}",
                                            style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Flight: ", style: TextStyle(color: Colors.grey)),
                            Text("${segments.first.operatingCarrier?.code ?? ''} ${segments.first.flnb ?? ''}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Date: ", style: TextStyle(color: Colors.grey)),
                            Text(segments.first.departure.dateTime?.format_ddMMM ?? ''),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Route: ", style: TextStyle(color: Colors.grey)),
                            Text("${segments.first.departure.point ?? ''}-${segments.first.arrival.point ?? ''}"),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      spacing: 12,
                      children: [
                        Row(
                          children: [
                            Text("Passport: ", style: TextStyle(color: Colors.grey)),
                            Text("${passports.firstOrNull?.documentNumber ?? ''}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Tracking: ", style: TextStyle(color: Colors.grey)),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusGeometry.circular(5),
                                color: timaticRes.evaluationResult.getColor.withOpacity(0.3),
                                border: Border.all(color: timaticRes.evaluationResult.getColor),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Text(ref.watch(refCodeProvider) ?? '', style: TextStyle(color: Colors.black)),
                                  const SizedBox(width: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadiusGeometry.circular(5),
                                      color: timaticRes.evaluationResult.getColor,
                                      border: Border.all(color: timaticRes.evaluationResult.getColor),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: Text("${timaticRes.evaluationResult.name}", style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Nationality: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            countryBuilderHeader(passengerDetails.nationality),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Resident: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            countryBuilderHeader(passengerDetails.residentCountryCode),
                          ],
                        ),
                        Row(
                          children: [
                            Text("VISA: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            countryBuilderHeader(visas.firstOrNull?.documentIssueCountry),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        Spacer(),
        Container(
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
                      Expanded(child: Text("Station Manager Approval")),
                      CloseButton(),
                    ],
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff2a5cff).withOpacity(0.18), Color(0xff535353).withOpacity(0.08)]),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextFieldNew(headerBgColor: Colors.white, bodyBgColor: Color(0xffF4f4f4), labelInRow: true, label: "Full Name", backgroundColor: Colors.white, placeholder: "Enter your full name", controller: nameC),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Center(
                                  child: Container(
                                    width: context.width * 0.7,
                                    height: context.width * 0.7,
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
                            label: "Decline",
                            color: Color(0xffFF3F42),
                            onPressed: () async {
                              final size = (context.width * 0.9).abs().floor();
                              final byteData = await control.toImage(width: size, height: size, background: Colors.transparent);
                              if (byteData == null) {
                                return;
                              }
                              final buffer = byteData.buffer;
                              final dir = await getTemporaryDirectory();

                              final String path = "${dir.path}/sign.png";
                              final f = await File(path).writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
                              final bool = await getIt<HomeController>().attachToResult(logId: widget.logId, images: [f.path], voices: [], data: {'name': nameC.text, "action": "managerApproval", "approved": false});
                              if (bool) {
                                Navigator.of(context).pop(true);
                                Future.delayed(Duration(milliseconds: 300), () {
                                  SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MyButton(
                            label: "Approve",
                            color: Color(0xff00C68E),
                            onPressed: () async {
                              final size = (context.width * 0.9).abs().floor();
                              final byteData = await control.toImage(width: size, height: size);
                              if (byteData == null) {
                                return;
                              }
                              final buffer = byteData.buffer;
                              final dir = await getTemporaryDirectory();

                              final String path = "${dir.path}/sign.png";
                              final f = await File(path).writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
                              final bool = await getIt<HomeController>().attachToResult(logId: widget.logId, images: [f.path], voices: [], data: {'name': nameC.text, "action": "managerApproval", "approved": true});
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
