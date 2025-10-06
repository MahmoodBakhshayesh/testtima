import 'dart:developer';

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
import 'package:abds/widgets/MyExpansionTile.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:abds/widgets/drawer_action.dart';
import 'package:country_flags/country_flags.dart';
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/classes/mrz_agg_class.dart';
import 'ask_supervisor_sheet.dart';
import 'attach_comment_sheet.dart';

class PartialTranslateSheet extends ConsumerStatefulWidget {
  final String text;
  final List<SupportedLanguage> languages;
  final List<SupportedLanguage> allLangs;

  const PartialTranslateSheet({super.key, required this.languages,required this.allLangs, required this.text});

  @override
  ConsumerState<PartialTranslateSheet> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends ConsumerState<PartialTranslateSheet> {
  final myHomeController = getIt<HomeController>();
  Language? selected;
  TextEditingController searchC = TextEditingController();
  TextEditingController textC = TextEditingController();
  String? translated;
  bool allLangMode = false;

  @override
  void initState() {
    searchC.addListener(() => setState(() {}));
    textC.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final langs = widget.allLangs.where((a) => a.validateSearch(searchC.text)).toList();
    // var langs = widget.languages.where((a) => a.validateSearch(searchC.text)).toList();
    var langs = widget.languages;
    if(allLangMode){
      langs = widget.allLangs.where((a) => a.validateSearch(searchC.text)).toList();
    }
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        bottom: true,
        child: SizedBox(
          height: context.height * 0.9,
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
              Container(
                constraints: BoxConstraints(
                  maxHeight: context.height*0.25
                ),
                padding: const EdgeInsets.all(12.0),
                child: CupertinoTextField(controller: textC, maxLines: null),
              ),
              Divider(),
              Expanded(
                child: translated == null
                    ? Column(
                        children: [
                          allLangMode?CupertinoTextField(
                            decoration: BoxDecoration(border: Border.all(color: MyColors.lineColor)),
                            prefix: Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.search)),
                            placeholder: "Search",
                            controller: searchC,
                            style: TextStyle(fontSize: 12),
                          ):SizedBox(),
                          allLangMode?SizedBox():ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              margin: EdgeInsets.only(left: 8, right: 8, top: 12),
                              decoration: BoxDecoration(color: MyColors.greyBG, borderRadius: BorderRadius.circular(12)),
                              child: RadioListTile(
                                dense: true,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                selected: selected == null,
                                selectedTileColor: MyColors.mainBlue.withOpacity(0.08),
                                title: Text("English (Default)", style: TextStyle(fontSize: 14, color: selected == null ? context.mainColor : Colors.black)),
                                value: null,
                                groupValue: selected?.language,
                                onChanged: (a) {
                                  selected = null;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: ListView.builder(
                                itemCount:langs.length ,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                               itemBuilder: (c,i){
                                  final a = langs[i];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: MyExpansionTile(
                                      enabled: false,
                                      initiallyExpanded: true,
                                      showTrailingIcon: true,
                                      dense: true,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                                      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                                      backgroundColor: Color(0xffAbAbAb).withOpacity(0.08),
                                      collapsedBackgroundColor: Color(0xffAbAbAb).withOpacity(0.08),
                                      title: Row(
                                        children: [
                                          CountryFlag.fromCountryCode(a.country!, width: 30, height: 20),
                                          const SizedBox(width: 8),
                                          Text(a.country!, style: TextStyle(color: Colors.black)),
                                        ],
                                      ),
                                      showFooter: false,
                                      children: a.languages!.where((l) => l.validateSearch(searchC.text) || true).map((l) {
                                        bool isSelected = l.language == selected?.language;
                                        return RadioListTile(
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          selected: isSelected,
                                          selectedTileColor: MyColors.mainBlue.withOpacity(0.08),
                                          title: Text("${l.name} (${l.title!})", style: TextStyle(fontSize: 14, color: isSelected ? context.mainColor : Colors.black)),
                                          value: l.language!,
                                          groupValue: selected?.language,
                                          onChanged: (a) {
                                            selected = l;
                                            setState(() {});
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  );
                               },
                              ),
                            ),
                          ),
                          Row(children: [
                            Spacer(),
                            MyButton(label:allLangMode?"Suggested Languages": "All Languages",icon: allLangMode?Icons.arrow_left: Icons.arrow_right,onPressed: (){
                              allLangMode = !allLangMode;
                              setState((){});
                            },flat: true,reverse: true,iconInRight: !allLangMode,),
                          ],)
                        ],
                      )
                    : Column(children: [Expanded(child: SingleChildScrollView(
                      child: Directionality(
                        textDirection: BasicClass.getLanguageByCode(selected!.language!).dir =="ltr"?TextDirection.ltr:TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(translated!,style: TextStyle(fontSize: 18,fontFamily: BasicClass.getLanguageByCode(selected!.language!).dir !="ltr"?null:"Signika" ),),
                        ),
                      ),
                    ))]),
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
                      child:
                      translated == null?
                      MyButton(
                        label: "Translate",
                        radius: 12,
                        icon: ArtemisIcons.translate,
                        iconInRight: true,
                        onPressed: selected == null
                            ? null
                            : () async {
                                final tt = await myHomeController.translateText(lang: selected!.language!, texts: [textC.text]);
                                log(translated ?? '-');
                                translated = tt;
                                setState(() {});
                                // Navigator.of(context).pop(true);
                              },
                      ):MyButton(
                        label: "New Translate",
                        radius: 12,
                        icon: ArtemisIcons.refresh,
                        iconInRight: true,
                        onPressed: (){
                          translated = null;
                          setState(() {});
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
