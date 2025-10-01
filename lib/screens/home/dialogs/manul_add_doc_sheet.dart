import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/core/classes/supervisor_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/core/utils_and_services/stateControllers/residents_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
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
import 'package:abds/widgets/drawer_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';

import '../../../core/classes/mrz_agg_class.dart';
import '../../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../../core/utils_and_services/timatic/src/models/document_request.dart';
import 'ask_supervisor_sheet.dart';
import 'attach_comment_sheet.dart';

class ManualAddDocumentSheet extends StatefulWidget {
  const ManualAddDocumentSheet({super.key});

  @override
  State<ManualAddDocumentSheet> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<ManualAddDocumentSheet> {
  final myHomeController = getIt<HomeController>();

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
                Expanded(child: Text("Add Manual Document")),
                CloseButton(),
              ],
            ),
            Divider(),
            Container(
              color: Colors.black.withOpacity(0.02),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: BasicClass.constData.data.documentType.map((dt) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: DrawerAction(
                      tileColor: dt.getColor.withOpacity(0.2),
                      onTap: () async {
                        final ref = getIt<HomeController>().ref;
                        if (dt.type == "P") {
                          Navigator.of(context).pop(DocumentDetail(shortType: "P"));
                          // ref.read(passportsProvider.notifier).add(DocumentDetail());
                        } else if (dt.type == "V") {
                          Navigator.of(context).pop(DocumentDetail(shortType: "V"));
                          // ref.read(visasProvider.notifier).add(DocumentDetail());
                        } else if (dt.type == "I") {
                          Navigator.of(context).pop(DocumentDetail(shortType: "I"));
                          // ref.read(residentsProvider.notifier).add(DocumentDetail());
                        }else{
                          Navigator.of(context).pop();
                        }
                        // Navigator.of(context).pop();
                      },

                      dense: true,

                      // leading: IcomoonLayeredCss.global(baseColor: MyColors.mainBlue),
                      // leading: dt.getIcon,
                      title: "${dt.title} ${dt.type}",
                      leadingWidget: dt.getIcon,
                    ),
                  );
                }).toList(),
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
