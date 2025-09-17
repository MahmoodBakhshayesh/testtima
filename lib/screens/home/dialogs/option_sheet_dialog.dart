import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/core/classes/supervisor_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/home/dialogs/ask_supervisor_dialog.dart';
import 'package:abds/screens/home/dialogs/attach_evisa_sheet.dart';
import 'package:abds/screens/home/dialogs/attach_photo_sheet.dart';
import 'package:abds/screens/home/dialogs/attach_voice_sheet.dart';
import 'package:abds/screens/home/dialogs/manager_approval_sheet.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';

import '../../../core/classes/mrz_agg_class.dart';
import 'ask_supervisor_sheet.dart';
import 'attach_comment_sheet.dart';

class OptionSheetDialog extends StatefulWidget {
  const OptionSheetDialog({super.key});

  @override
  State<OptionSheetDialog> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<OptionSheetDialog> {
  final  myHomeController = getIt<HomeController>();
  @override
  Widget build(BuildContext context) {
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
                Expanded(child: Text("Option")),
                CloseButton(),
              ],
            ),
            Divider(),
            Container(
              color: Colors.black.withOpacity(0.02),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () async {
                      List<Supervisor>? supervisors =await  myHomeController.getSupervisors();
                      if(supervisors==null) return;

                      String? logId = getIt<HomeController>().ref.read(timaticResultProvider)?.refCode;
                      if (logId != null) {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return AskSupervisorSheet(logId: logId,supervisors: supervisors,);
                          },
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                        );
                      }
                    },
                    dense: true,
                    leading: Icon(Icons.question_mark),
                    title: Text("Ask Supervisor"),
                  ),
                  ListTile(onTap: () {
                    String? logId = getIt<HomeController>().ref.read(timaticResultProvider)?.refCode;
                    if (logId != null) {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        builder: (BuildContext context) {
                          return ManagerApprovalSheet(logId: logId);
                        },
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                      );
                    }
                  }, dense: true, leading: Icon(Icons.queue_play_next), title: Text("Airline Station Manager Approval")),
                  ListTile(onTap: () {
                    String? logId = getIt<HomeController>().ref.read(timaticResultProvider)?.refCode;
                    if (logId != null) {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        builder: (BuildContext context) {
                          return AttachEvisaSheet(logId: logId);
                        },
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                      );
                    }
                  }, dense: true, leading: Icon(Icons.queue_play_next), title: Text("Add e-Visa")),
                  ListTile(onTap: () {
                    String? logId = getIt<HomeController>().ref.read(timaticResultProvider)?.refCode;
                    if (logId != null) {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        builder: (BuildContext context) {
                          return AttachPhotoSheet(logId: logId);
                        },
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                      );
                    }
                  }, dense: true, leading: Icon(Icons.attach_email), title: Text("Attach Photo")),
                  ListTile(onTap: () {
                    String? logId = getIt<HomeController>().ref.read(timaticResultProvider)?.refCode;
                    if (logId != null) {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        builder: (BuildContext context) {
                          return AttachVoiceSheet(logId: logId);
                        },
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                      );
                    }
                  }, dense: true, leading: Icon(Icons.attach_email), title: Text("Attach Voice")),
                  ListTile(onTap: () {
                    String? logId = getIt<HomeController>().ref.read(timaticResultProvider)?.refCode;
                    if (logId != null) {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        builder: (BuildContext context) {
                          return AttachCommentSheet(logId: logId);
                        },
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(15)),
                      );
                    }
                  }, dense: true, leading: Icon(Icons.comment), title: Text("Add Comment")),
                ],
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
            //           label: "Submit",
            //           onPressed: () {
            //             Navigator.of(context).pop(true);
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
