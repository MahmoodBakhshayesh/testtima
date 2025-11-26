import 'dart:developer';

import 'package:abds/core/classes/boarding_pass_class.dart';
import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/core/classes/supervisor_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/home/dialogs/agent_decision_sheet.dart';
import 'package:abds/screens/home/dialogs/ask_supervisor_dialog.dart';
import 'package:abds/screens/home/dialogs/attach_evisa_sheet.dart';
import 'package:abds/screens/home/dialogs/attach_photo_sheet.dart';
import 'package:abds/screens/home/dialogs/attach_voice_sheet.dart';
import 'package:abds/screens/home/dialogs/manager_approval_sheet.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/widgets/AirlineLogo.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:abds/widgets/drawer_action.dart';
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/classes/constant_data_class.dart';
import '../../../core/classes/mrz_agg_class.dart';
import '../../../core/navigation/routes.dart';
import '../home_drawer.dart';
import 'ask_supervisor_sheet.dart';
import 'attach_comment_sheet.dart';
import 'manul_add_doc_sheet.dart';

class OptionSheetDialog extends ConsumerStatefulWidget {
  const OptionSheetDialog({super.key});

  @override
  ConsumerState<OptionSheetDialog> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends ConsumerState<OptionSheetDialog> {
  final myHomeController = getIt<HomeController>();
  ParameterValue? airline;
  TextEditingController flnbC = TextEditingController();
  TextEditingController userC = TextEditingController();
  int index = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((a) {
      ItinerarySegment seg = myHomeController.ref.read(segmentsProvider).first;
      airline = seg.operatingCarrier;
      flnbC.text = seg.flnb ?? '';
      if (airline != null && flnbC.text.isNotEmpty) {
        index = 1;
      }
      setState(() {});
    });
    flnbC.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    bool isLocked =  ref.watch(currentStatusProvider).isLocked;
    return SafeArea(
      bottom: true,
      child: SizedBox(
        // height: context.height*0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      Icon(ArtemisIcons.more),
                      const SizedBox(width: 8),
                      Text("Option", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    AirlineLogo(airline?.code ?? '', size: 40),
                    Text("${airline?.code ?? ''} ${flnbC.text}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                CloseButton(),
              ],
            ),
            Divider(),
            Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isLocked
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            spacing: 8,
                            children: [
                              DrawerAction(
                                tileColor: Colors.blueAccent.withOpacity(0.18),
                                borderColor: Colors.blueAccent,
                                iconColor: Colors.blueAccent,
                                radius: 8,
                                title: "Agent Decision",
                                onTap: () async {
                                  String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                                  if (logId != null) {
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      context: context,
                                      enableDrag: false,
                                      builder: (BuildContext context) {
                                        return AgentDecisionSheet(logId: logId);
                                      },
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                                    );
                                  }
                                },
                                leadingIcon: ArtemisIcons.message_question,
                              ),
                              ?ref.watch(currentStatusProvider).canAskSupervisor?
                              DrawerAction(
                                tileColor: Colors.blueAccent.withOpacity(0.18),
                                borderColor: Colors.blueAccent,
                                iconColor: Colors.blueAccent,

                                radius: 8,
                                title: "Ask Supervisor",
                                onTap: () async {
                                  List<Supervisor>? supervisors = await myHomeController.getSupervisors();
                                  if (supervisors == null) return;

                                  String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                                  if (logId != null) {
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AskSupervisorSheet(logId: logId, supervisors: supervisors);
                                      },
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                                    );
                                  }
                                },
                                leadingIcon: ArtemisIcons.message_question,
                              ):null,
                              DrawerAction(
                                iconColor: Colors.blueAccent,

                                tileColor: Colors.blueAccent.withOpacity(0.18),
                                borderColor: Colors.blueAccent,
                                radius: 8,
                                title: "Airline Representative Decision",
                                onTap: () async {
                                  String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                                  if (logId != null) {
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      context: context,
                                      enableDrag: false,
                                      builder: (BuildContext context) {
                                        return ManagerApprovalSheet(logId: logId);
                                      },
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                                    );
                                  }
                                },
                                leadingIcon: ArtemisIcons.airplane_square,
                              ),
                              DrawerAction(
                                tileColor: Colors.blueAccent.withOpacity(0.18),
                                borderColor: Colors.blueAccent,
                                iconColor: Colors.blueAccent,

                                radius: 8,
                                title: "Add Attachment",
                                onTap: () async {
                                  String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                                  if (logId != null) {
                                    showModalBottomSheet(
                                      context: context,
                                      enableDrag: false,

                                      builder: (BuildContext context) {
                                        return AttachPhotoSheet(logId: logId);
                                      },
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                                    );
                                  }
                                },
                                leadingIcon: ArtemisIcons.attach_circle,
                              ),

                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            spacing: 8,
                            children: [
                              DrawerAction(
                                tileColor: MyColors.mainBlue,
                                title: "Manual",
                                onTap: () async {
                                  Navigator.pop(context);
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ManualAddDocumentSheet();
                                    },
                                  );
                                },
                                leadingIcon: ArtemisIcons.edit_2,
                              ),
                            ],
                          ),
                        ),
                  // EasyAnimatedIndexedStack(
                  //   index: isLocked ? 1 : 0,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(left: 12.0, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         spacing: 12,
                  //         children: [
                  //           const SizedBox(height: 0),
                  //           Row(
                  //             children: [
                  //               Expanded(
                  //                 child: Text("Flight: ${ref.watch(segmentsProvider)!.first.route}", style: TextStyle(fontWeight: FontWeight.w600)),
                  //               ),
                  //               MyButton(
                  //                 label: "Scan Boarding Pass",
                  //                 onPressed: () async {
                  //                   final scanRes = await getIt<HomeController>().goNamed(Routes.barcodeReader);
                  //                   log(scanRes.runtimeType.toString());
                  //                   if(scanRes is List<BoardingPass>){
                  //                     if(scanRes.isNotEmpty){
                  //                       BoardingPass bp = scanRes.first;
                  //                       airline = BasicClass.constData.data.carrier.firstWhereOrNull((a)=>a.code == bp.al);
                  //                       flnbC.text = bp.flnb;
                  //                       setState((){});
                  //                     }
                  //                   }
                  //                 },
                  //                 icon: ArtemisIcons.scan_barcode,
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             spacing: 12,
                  //             children: [
                  //               Expanded(
                  //                 child: MyTextFieldNew(
                  //                   maxLength: 5,
                  //                   label: "Flight #",
                  //                   controller: flnbC,
                  //                   placeholder: "Flight Number",
                  //                   rowLabelRatio: [3, 5],
                  //                   headerBgColor: Color(0xffECECEC),
                  //                   bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
                  //                 ),
                  //               ),
                  //               Expanded(
                  //                 child: MyFieldPicker<ParameterValue>(
                  //                   label: "Airline",
                  //                   placeholder: "Airline",
                  //                   searchAutoFocus: true,
                  //                   rowLabelRatio: [3, 5],
                  //                   headerBgColor: Color(0xffECECEC),
                  //                   bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
                  //                   items: BasicClass.constData.data.carrier,
                  //                   value: airline,
                  //                   onChange: (a) {
                  //                     airline = a;
                  //                     setState(() {});
                  //                   },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Expanded(
                  //                 child: MyTextFieldNew(maxLength: 5, label: "User", controller: userC, placeholder: "Enter full name", headerBgColor: Color(0xffECECEC), bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48)),
                  //               ),
                  //             ],
                  //           ),
                  //           Container(
                  //             decoration: BoxDecoration(color: Color(0xff2A5Cff).withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                  //             padding: EdgeInsets.all(12),
                  //             child: Row(
                  //               children: [
                  //                 Icon(ArtemisIcons.lock, color: Color(0xff2A5Cff)),
                  //                 const SizedBox(width: 8),
                  //                 Expanded(child: Text("To access options, lock passenger information first. Once locked, no changes can be made.", style: TextStyle(fontSize: 12))),
                  //               ],
                  //             ),
                  //           ),
                  //           Row(
                  //             spacing: 12,
                  //             children: [
                  //               Expanded(
                  //                 child: MyButton(
                  //                   color: Colors.grey,
                  //                   label: "Cancel",
                  //                   reverse: true,
                  //                   borderSide: BorderSide(color: Colors.grey),
                  //                   onPressed: () {
                  //                     Navigator.pop(context);
                  //                   },
                  //                 ),
                  //               ),
                  //               Expanded(
                  //                 child: MyButton(
                  //                   label: "Confirm",
                  //                   onPressed: airline == null || flnbC.text.isEmpty
                  //                       ? null
                  //                       : () async {
                  //                           FocusScope.of(context).requestFocus(FocusNode());
                  //                           await getIt<HomeController>().lockUnlockResponse(true);
                  //                           setState(() {});
                  //                         },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     // Padding(
                  //     //   padding: const EdgeInsets.all(8.0),
                  //     //   child: Wrap(
                  //     //     direction: Axis.horizontal,
                  //     //     runSpacing: 8,
                  //     //     spacing: 8,
                  //     //     children: [
                  //     //       MyButton(
                  //     //         // title: "Ask Supervisor",
                  //     //         onPressed: () async {
                  //     //           List<Supervisor>? supervisors = await myHomeController.getSupervisors();
                  //     //           if (supervisors == null) return;
                  //     //
                  //     //           String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                  //     //           if (logId != null) {
                  //     //             showModalBottomSheet(
                  //     //               context: context,
                  //     //               builder: (BuildContext context) {
                  //     //                 return AskSupervisorSheet(logId: logId, supervisors: supervisors);
                  //     //               },
                  //     //               isScrollControlled: true,
                  //     //               shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                  //     //             );
                  //     //           }
                  //     //         },
                  //     //         color: MyColors.mainGrey.withOpacity(0.08),
                  //     //         label: '',
                  //     //         padding: EdgeInsets.zero,
                  //     //         width: (context.width-32)/3,
                  //     //         height: (context.width-32)/3,
                  //     //         radius: 20,
                  //     //         borderSide: BorderSide(color: MyColors.lineColor),
                  //     //         child: Column(
                  //     //           mainAxisAlignment: MainAxisAlignment.center,
                  //     //           children: [
                  //     //           IcomoonLayeredCss.message_question(size: 30),
                  //     //           const SizedBox(height: 8),
                  //     //           Text("Ask Supervisor",style: TextStyle(color: Colors.black,fontSize: 12),),
                  //     //         ],),
                  //     //         // leadingIcon: ArtemisIcons.message_question,
                  //     //       ),
                  //     //       MyButton(
                  //     //         // title: "Ask Supervisor",
                  //     //         onPressed: () async {
                  //     //           String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                  //     //           if (logId != null) {
                  //     //             showModalBottomSheet(
                  //     //               context: context,
                  //     //               enableDrag: false,
                  //     //               builder: (BuildContext context) {
                  //     //                 return ManagerApprovalSheet(logId: logId);
                  //     //               },
                  //     //               isScrollControlled: true,
                  //     //               shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                  //     //             );
                  //     //           }
                  //     //         },
                  //     //         color: MyColors.mainGrey.withOpacity(0.08),
                  //     //         label: '',
                  //     //         padding: EdgeInsets.zero,
                  //     //         width: (context.width-32)/3,
                  //     //         height: (context.width-32)/3,
                  //     //         radius: 20,
                  //     //         borderSide: BorderSide(color: MyColors.lineColor),
                  //     //         child: Column(
                  //     //           mainAxisAlignment: MainAxisAlignment.center,
                  //     //           children: [
                  //     //             IcomoonLayeredCss.airplane_square(size: 30),
                  //     //             const SizedBox(height: 8),
                  //     //             Text("Station Manager Approval",style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,),
                  //     //           ],),
                  //     //         // leadingIcon: ArtemisIcons.message_question,
                  //     //       ),
                  //     //       MyButton(
                  //     //         // title: "Ask Supervisor",
                  //     //         onPressed: () async {
                  //     //           await myHomeController.translateForPassenger();
                  //     //         },
                  //     //         color: MyColors.mainGrey.withOpacity(0.08),
                  //     //         label: '',
                  //     //         padding: EdgeInsets.zero,
                  //     //         width: (context.width-32)/3,
                  //     //         height: (context.width-32)/3,
                  //     //         radius: 20,
                  //     //         borderSide: BorderSide(color: MyColors.lineColor),
                  //     //         child: Column(
                  //     //           mainAxisAlignment: MainAxisAlignment.center,
                  //     //           children: [
                  //     //             IcomoonLayeredCss.translate(size: 30),
                  //     //             const SizedBox(height: 8),
                  //     //             Text("Translation for Passenger",style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,),
                  //     //           ],),
                  //     //         // leadingIcon: ArtemisIcons.message_question,
                  //     //       ),
                  //     //       MyButton(
                  //     //         onPressed: () async {
                  //     //           String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                  //     //           if (logId != null) {
                  //     //             showModalBottomSheet(
                  //     //               context: context,
                  //     //               enableDrag: false,
                  //     //               builder: (BuildContext context) {
                  //     //                 return AttachPhotoSheet(logId: logId);
                  //     //               },
                  //     //               isDismissible: false,
                  //     //               isScrollControlled: true,
                  //     //               shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                  //     //             );
                  //     //           }
                  //     //         },
                  //     //         color: MyColors.mainGrey.withOpacity(0.08),
                  //     //         label: '',
                  //     //         padding: EdgeInsets.zero,
                  //     //         width: (context.width-32)/3,
                  //     //         height: (context.width-32)/3,
                  //     //         radius: 20,
                  //     //         borderSide: BorderSide(color: MyColors.lineColor),
                  //     //         child: Column(
                  //     //           mainAxisAlignment: MainAxisAlignment.center,
                  //     //           children: [
                  //     //             IcomoonLayeredCss.attach_circle(size: 30),
                  //     //             const SizedBox(height: 8),
                  //     //             Text("Add Attachment",style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,),
                  //     //           ],),
                  //     //         // leadingIcon: ArtemisIcons.message_question,
                  //     //       ),
                  //     //       MyButton(
                  //     //         onPressed: () async {
                  //     //           final res = await getIt<HomeController>().lockUnlockResponse(false);
                  //     //           setState(() {});
                  //     //           if (res) {
                  //     //             Navigator.pop(context);
                  //     //           }
                  //     //         },
                  //     //         color: MyColors.mainGrey.withOpacity(0.08),
                  //     //         label: '',
                  //     //         padding: EdgeInsets.zero,
                  //     //         width: (context.width-32)/3,
                  //     //         height: (context.width-32)/3,
                  //     //         radius: 20,
                  //     //         borderSide: BorderSide(color: MyColors.lineColor),
                  //     //         child: Column(
                  //     //           mainAxisAlignment: MainAxisAlignment.center,
                  //     //           children: [
                  //     //             IcomoonLayeredCss.refresh(size: 30),
                  //     //             const SizedBox(height: 8),
                  //     //             Text("Re-check TIMATIC",style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,),
                  //     //           ],),
                  //     //         // leadingIcon: ArtemisIcons.message_question,
                  //     //       ),
                  //     //       MyButton(
                  //     //         onPressed: () async {
                  //     //           final res = await getIt<HomeController>().lockUnlockResponse(false);
                  //     //           setState(() {});
                  //     //           if (res) {
                  //     //             Navigator.pop(context);
                  //     //           }
                  //     //         },
                  //     //         color: MyColors.mainGrey.withOpacity(0.08),
                  //     //         label: '',
                  //     //         padding: EdgeInsets.zero,
                  //     //         width: (context.width-32)/3,
                  //     //         height: (context.width-32)/3,
                  //     //         radius: 20,
                  //     //         borderSide: BorderSide(color: MyColors.lineColor),
                  //     //         child: Column(
                  //     //           mainAxisAlignment: MainAxisAlignment.center,
                  //     //           children: [
                  //     //             IcomoonLayeredCss.shield_tick(size: 30),
                  //     //             const SizedBox(height: 8),
                  //     //             Text("Final Decision",style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,),
                  //     //           ],),
                  //     //         // leadingIcon: ArtemisIcons.message_question,
                  //     //       ),
                  //     //     ],
                  //     //   ),
                  //     // ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Column(
                  //         spacing: 8,
                  //         children: [
                  //           DrawerAction(
                  //             tileColor: MyColors.mainBlue,
                  //             title: "Ask Supervisor",
                  //             onTap: () async {
                  //               List<Supervisor>? supervisors = await myHomeController.getSupervisors();
                  //               if (supervisors == null) return;
                  //
                  //               String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                  //               if (logId != null) {
                  //                 showModalBottomSheet(
                  //                   context: context,
                  //                   builder: (BuildContext context) {
                  //                     return AskSupervisorSheet(logId: logId, supervisors: supervisors);
                  //                   },
                  //                   isScrollControlled: true,
                  //                   shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                  //                 );
                  //               }
                  //             },
                  //             leadingIcon: ArtemisIcons.message_question,
                  //           ),
                  //           DrawerAction(
                  //             tileColor: MyColors.mainBlue,
                  //             title: "Station Manager Approval",
                  //             onTap: () async {
                  //               String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                  //               if (logId != null) {
                  //                 showModalBottomSheet(
                  //                   context: context,
                  //                   enableDrag: false,
                  //                   builder: (BuildContext context) {
                  //                     return ManagerApprovalSheet(logId: logId);
                  //                   },
                  //                   isScrollControlled: true,
                  //                   backgroundColor: Colors.transparent,
                  //                   shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                  //                 );
                  //               }
                  //             },
                  //             leadingIcon: ArtemisIcons.airplane_square,
                  //           ),
                  //           DrawerAction(
                  //             tileColor: MyColors.mainBlue,
                  //             title: "Translation for Passenger",
                  //             onTap: () async {
                  //               await myHomeController.translateForPassenger();
                  //             },
                  //             leadingIcon: ArtemisIcons.translate,
                  //           ),
                  //           DrawerAction(
                  //             tileColor: MyColors.mainBlue,
                  //             title: "Add Attachment",
                  //             onTap: () async {
                  //               String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                  //               if (logId != null) {
                  //                 showModalBottomSheet(
                  //                   context: context,
                  //                   enableDrag: false,
                  //
                  //                   builder: (BuildContext context) {
                  //                     return AttachPhotoSheet(logId: logId);
                  //                   },
                  //                   isDismissible: false,
                  //                   isScrollControlled: true,
                  //                   shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                  //                 );
                  //               }
                  //             },
                  //             leadingIcon: ArtemisIcons.attach_circle,
                  //           ),
                  //           // DrawerAction(
                  //           //   title: "Re-check TIMATIC",
                  //           //   onTap: () async {
                  //           //     final res = await getIt<HomeController>().lockUnlockResponse(false);
                  //           //     setState(() {});
                  //           //     if (res) {
                  //           //       Navigator.pop(context);
                  //           //     }
                  //           //   },
                  //           //   leadingIcon: ArtemisIcons.refresh,
                  //           // ),
                  //           // DrawerAction(
                  //           //   title: "Final Decision",
                  //           //   onTap: () async {
                  //           //   },
                  //           //   leadingIcon: ArtemisIcons.shield_tick,
                  //           // ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
