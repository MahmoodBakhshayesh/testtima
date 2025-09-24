import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/core/classes/supervisor_class.dart';
import 'package:abds/core/classes/supported_language_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/initialize.dart';
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
import 'package:country_flags/country_flags.dart';
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/classes/mrz_agg_class.dart';
import 'ask_supervisor_sheet.dart';
import 'attach_comment_sheet.dart';

class TranslateLanguageSelectSheet extends ConsumerStatefulWidget {
  final List<SupportedLanguage> languages;

  const TranslateLanguageSelectSheet({super.key, required this.languages});

  @override
  ConsumerState<TranslateLanguageSelectSheet> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends ConsumerState<TranslateLanguageSelectSheet> {
  final myHomeController = getIt<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLocked = ref.watch(timaticResultProvider)!.status == 1;
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
                      Icon(ArtemisIcons.translate),
                      const SizedBox(width: 8),
                      Text("Translate", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                CloseButton(),
              ],
            ),
            Divider(),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  children: widget.languages
                      .map(
                        (a) => Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              // decoration: BoxDecoration(
                              //   color: Colors.black.withOpacity(0.08),
                              //   borderRadius: BorderRadius.circular(12),
                              //   border: Border.all(color: MyColors.lineColor),
                              // ),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(color: MyColors.lineColor, borderRadius: BorderRadius.circular(4)),
                                        child: CountryFlag.fromCountryCode(a.country!, width: 40, height: 20),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(a.country ?? '-', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Column(
                                            children: (a.languages ?? [])
                                                .map(
                                                  (l) => DrawerAction(
                                                    title: l.name!,
                                                    onTap: () async {
                                                      await myHomeController.translateTimaticResponse(language: l.language!, logId: ref.read(timaticResultProvider)!.refCode!);

                                                    },
                                                    leadingIcon: Icons.circle,
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
