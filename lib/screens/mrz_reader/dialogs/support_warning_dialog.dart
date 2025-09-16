import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';

import '../../../core/classes/mrz_agg_class.dart';

class SupportWarningDialog extends StatefulWidget {
  const SupportWarningDialog({super.key});

  @override
  State<SupportWarningDialog> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<SupportWarningDialog> {
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
                Expanded(child: Text("Confirm Support Capture")),
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
                  Container(
                    margin:EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    padding:EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    decoration: BoxDecoration(
                        color: Color(0xff2A5CFF).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12,
                      children: [
                        Text("By enabling Support Capture, scanned documents (such as passports or IDs) will be shared with our support team for troubleshooting.",style: TextStyle(fontSize: 12),),
                        Row(
                          children: [
                            Icon(ArtemisIcons.arrow_right,size: 15),
                            const SizedBox(width: 4),
                            Expanded(child: Text("Data is encrypted and accessible only to support.",style: TextStyle(fontSize: 12))),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(ArtemisIcons.arrow_right,size: 15),
                            const SizedBox(width: 4),
                            Expanded(child: Text("All data is automatically deleted after 24 hours.",style: TextStyle(fontSize: 12))),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(ArtemisIcons.arrow_right,size: 15),
                            const SizedBox(width: 4),
                            Expanded(child: Text("You can turn this off anytime.",style: TextStyle(fontSize: 12))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("Do you want to enable Support Capture?"),
                  ),
                  const SizedBox(height: 12),
                ],
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
                      onPressed: () {
                        Navigator.of(context).pop(true);
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
