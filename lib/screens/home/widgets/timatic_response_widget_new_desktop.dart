import 'dart:developer';

import 'package:abds/core/classes/timatic_response_new_class.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/screens/home/dialogs/partial_translate_sheet.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_parser_plus/html_parser_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/constants/ui.dart';
import '../../../core/utils_and_services/country_flag_util.dart';
import '../../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../../core/utils_and_services/stateControllers/residents_state_controller.dart';
import '../../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../../../core/utils_and_services/string_utility.dart';
import '../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../../core/utils_and_services/timatic/src/models/document_request.dart';
import '../../../initialize.dart';
import '../../../widgets/AirlineLogo.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../home_state.dart';

class TimaticTrueResultWidgetNewDesktop extends ConsumerStatefulWidget {
  final TimaticResponseNew res;
  final String refCode;

  const TimaticTrueResultWidgetNewDesktop({super.key, required this.res, required this.refCode});

  @override
  ConsumerState<TimaticTrueResultWidgetNewDesktop> createState() => _TimaticTrueResultWidgetNewState();
}

class _TimaticTrueResultWidgetNewState extends ConsumerState<TimaticTrueResultWidgetNewDesktop> {
  ExpansibleController expansibleController = ExpansibleController();
  late List<ExpansibleController> expansionControllers = widget.res.segments.map((a) => ExpansibleController()).toList();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      expansibleController.addListener(() => setState(() {}));
    });
    super.initState();
  }

  Widget countryBuilderHeader(dynamic a) => a == null
      ? SizedBox()
      : Row(
    children: [
      Text("$a"),
      const SizedBox(width: 2),
      MyCountryFlagsPro.getFlag(a, width: 22, height: 16, borderRadius: BorderRadius.circular(2)),
    ],
  );


  @override
  Widget build(BuildContext context) {
    final segments = ref.watch(segmentsProvider);
    final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> visas = ref.watch(visasProvider);
    final List<DocumentDetail> residents = ref.watch(residentsProvider);
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    bool isClosed = !ref.watch(currentStatusProvider).canUseOption;
    Color color = MyColors.mainBlue;
    final currentStatus = ref.watch(currentStatusProvider);
    return Column(
      spacing: 12,
      children: [

        ...widget.res.segments.map((segRes) {
          int index = widget.res.segments.indexOf(segRes);
          final exC = expansionControllers[index];


          return MyExpansionTile(
            key: Key(segRes.route),
            controller: exC,
            initiallyExpanded: segRes.open,
            onExpansionChanged: (_) {
              setState(() {});
            },
            tilePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(2)),
            collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(2)),
            backgroundColor: segRes.getRes.getBgColor,
            collapsedBackgroundColor: segRes.getRes.getBgColor,
            showFooter: false,
            childrenPadding: EdgeInsets.all(0),
            title: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: segRes.getRes.getColor),
                    color: segRes.getRes.getColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // decoration: BoxDecoration(color: segRes.segmentEvaluationResult.getColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: Row(
                          children: [
                            Icon(
                              exC.isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                              color: Colors.white,
                            ),
                            Text(
                              "${index + 1}:",
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            segRes.routeWidgetBig,
                            Spacer(),
                            Text(
                              "${segRes.getRes.title}",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              segRes.getRes.getIconCircle,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            children: [
              ...(segRes.result ?? []).map((sr) {
                final sorted = sr.ruleSetEvaluations ?? [];
                final sortedOk = (sorted).where((a) => a.ruleSetResult == 1);
                final sortedNotOk = (sorted).where((a) => a.ruleSetResult != 1);
                if (sortedNotOk.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        ...(sortedOk)
                            .where((a) => a.ruleSetResult == 1)
                            .map(
                              (a) => RuleSetWidgetNewDesktop(
                                ruleSet: a,
                                refCode: widget.refCode,
                              ),
                            ),
                      ],
                    ),
                  );
                }
                return MyExpansionTile(
                  showFooter: false,
                  // backgroundColor: sortedOk.firstOrNull?.getSolidColor,
                  // collapsedBackgroundColor: sortedOk.firstOrNull?.getSolidColor,
                  title: Column(
                    children: [

                      ...(sortedNotOk).map(
                        (a) => RuleSetWidgetNewDesktop(
                          ruleSet: a,
                          refCode: widget.refCode,

                        ),
                      ),
                    ],
                  ),
                  childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                  children: [

                    ...(sortedOk)
                        .where((a) => a.ruleSetResult == 1)
                        .map(
                          (a) => RuleSetWidgetNewDesktop(
                            ruleSet: a,
                            refCode: widget.refCode,
                          ),
                        ),
                  ],
                );
                // sorted.sort((a, b) => a.evaluationResult.index.compareTo(b.evaluationResult.index));
                return Column(
                  children: [
                    ...(sorted).map(
                      (a) => RuleSetWidgetNewDesktop(
                        ruleSet: a,
                        refCode: widget.refCode,
                      ),
                    ),
                  ],
                );
              }),

              // ...segRes.result.map((r)=>r.ruleSetEvaluations!.map((a)=>RuleSetWidgetNew(ruleSet: a))).toList(),
              // segRes.commonBorder == null ? const SizedBox() : CommonBorderWidgetNew(commonBorder: segRes.commonBorder!),
              // ...segRes.ruleSetEvaluations.map((rs) => RuleSetWidgetNew(ruleSet: rs)),
              const SizedBox(height: 12),
            ],
          );
        }).toList(),
      ],
    );
  }
}

class RuleSetWidgetNewDesktop extends StatelessWidget {
  final String refCode;
  final RuleSetEvaluation ruleSet;

  const RuleSetWidgetNewDesktop({super.key, required this.ruleSet, required this.refCode});

  @override
  Widget build(BuildContext context) {
    // log("rulse set ${ruleSet.title} ${ ruleSet.getRes.resultId} expanded =${ruleSet.getRes.resultId !=1}");
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2.0, top: 8),
      child: MyExpansionTile(
        // initiallyExpanded: (ruleSet.getRes.resultId??1)>1,
        showFooter: false,
        initiallyExpanded: ruleSet.open,
        enabled: ruleSet.getRes.resultId == 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: ruleSet.getColor.withOpacity(0.12)),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: ruleSet.getColor.withOpacity(0.12)),
        ),
        backgroundColor: ruleSet.getSolidColor,
        collapsedBackgroundColor: ruleSet.getSolidColor,
        tilePadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        // childPreview: ruleSet.getRes.resultId! <2
        //     ? null
        //     : Column(
        //         children: [
        //           ...ruleSet.regulations.map(
        //             (a) => Column(
        //               children: [
        //                 Container(
        //                   margin: EdgeInsets.only(top: 8),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Expanded(
        //                         child: Text(a.title ?? '', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        //                       ),
        //                       a.getRes.getIconWidgetMini,
        //                       const SizedBox(width: 1),
        //                       Text(BasicClass.getResultOfCode(a.regulationResult).title??'', style: TextStyle(fontSize: 11, color: BasicClass.getResultOfCode(a.regulationResult).getColor)),
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           ...ruleSet.documents.map(
        //             (d) => Column(
        //               children: d.regulations
        //                   .map(
        //                     (a) => Container(
        //                       margin: EdgeInsets.only(top: 8),
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Expanded(
        //                             child: Text(a.title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        //                           ),
        //                           a.getRes.getIconWidgetMini,
        //                           const SizedBox(width: 1),
        //                           Text(a.getRes.title, style: TextStyle(fontSize: 11, color: BasicClass.getColorForEvaluationResult(a.regulationResult.toString()))),
        //                         ],
        //                       ),
        //                     ),
        //                   )
        //                   .toList(),
        //             ),
        //           ),
        //         ],
        //       ),
        title: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                     Icon( ruleSet.getIcon,color: ruleSet.getColor,size: 20,),
                      const SizedBox(width: 4),
                      Text(
                        ruleSet.title ?? '',
                        // "${ruleSet.regulations.length}",
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.black),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  // child: Text(ruleSet.getRes.resultId.toString() ?? '', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  // child: Text(ruleSet.regulations.length.toString() ?? '', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ),
                // Container(
                //   padding: EdgeInsets.all(4),
                //   child: Row(
                //     children: [
                //       ruleSet.getRes.getIconWidget,
                //       // const SizedBox(width: 4),
                //       // Text(
                //       //   ruleSet.getRes.title,
                //       //   style: TextStyle(color: ruleSet.getColor, fontSize: 12, fontWeight: FontWeight.bold),
                //       // ),
                //     ],
                //   ),
                // ),
              ],
            ),

            // Text("ada")
          ],
        ),
        childrenPadding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              ...ruleSet.regulations
                  .map(
                    (r) => RegulationWidgetNewDesktop(
                      regulation: r,
                      refCode: refCode,
                      isLast: false,
                      lineColor:ruleSet.getSolidLineColor
                    ),
                  )
                  .toList(),
              ...ruleSet.documents
                  .map(
                    (r) => DocumentResultWidgetNewDesktop(
                      docRes: r,
                      refCode: refCode,
                      lineColor: ruleSet.getSolidLineColor,
                    ),
                  )
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}

class RegulationWidgetNewDesktop extends StatelessWidget {
  final String refCode;
  final Color lineColor;
  final bool isLast;
  late Regulation regulation;

  RegulationWidgetNewDesktop({super.key, required this.regulation, required this.refCode, required this.isLast, required this.lineColor});

  //final TimaticController myTimaticController = getIt<TimaticController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(regulation.title),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ...(regulation.texts ?? [])
                  .map(
                    (e) {

                      e = "${e.replaceFirst("<p>", "<span style = 'font-size:24px;font-weight: 900'>${regulation.title}</span><p style='display:inline; padding-left:12px;font-size:16px;font-weight:200'>")}";
                      return Container(

                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border:Border(bottom: BorderSide(color: lineColor,width: 4)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[] + [HtmlWidget(e,
                                  onTapUrl: (p0) => launch(p0))],
                            ),
                          ),
                          DotButton(
                            icon: ArtemisIcons.translate,
                            onPressed: () async {
                              final homeC = getIt<HomeController>();
                              final langs = await homeC.getSupportLanguage(refCode);
                              if (langs == null) return;
                              log(e);
                              final regex = RegExp(r'<p[^>]*>(.*?)<\/p>', dotAll: true);
                              final match = regex.firstMatch(e);
                              log("mathc ${match}");
                              if (match != null) {
                                final innerText = match.group(1);
                                final regex = RegExp(r'<[^>]*>');
                                final plainText = e.replaceAll(regex, '').trim();
                                final allLangs = BasicClass.getAllSupportedLanguages();
                                allLangs.sort((a, b) => langs.map((l) => l.country).toList().indexOf(a.country).compareTo(langs.map((l) => l.country).toList().indexOf(b.country)));
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (c) => PartialTranslateSheet(allLangs: allLangs, languages: langs, text: plainText ?? ''),
                                );

                                // Output: Passengers with a re-entry permit or a residence permit issued by Algeria do not need a visa.
                              }else{
                                final plainText = e.trim();
                                final allLangs = BasicClass.getAllSupportedLanguages();
                                allLangs.sort((a, b) => langs.map((l) => l.country).toList().indexOf(a.country).compareTo(langs.map((l) => l.country).toList().indexOf(b.country)));
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (c) => PartialTranslateSheet(allLangs: allLangs, languages: langs, text: plainText ?? ''),
                                );
                              }
                              // log(matches.length.toString());

                              // showModalBottomSheet(context: context,isScrollControlled: true, builder: (c)=>PartialTranslateSheet(languages: langs, text: matches.join("\n")));
                            },
                          ),
                        ],
                      ),
                    );
                    },
                  )
                  .toList(),
            ],
          ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: MyExpansionTile(
        showFooter: false,
        initiallyExpanded: regulation.open,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        collapsedBackgroundColor: Colors.white.withOpacity(0.48),
        backgroundColor: Colors.white.withOpacity(0.58),
        showLeadingIcon: true,
        tilePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        title: Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 4, top: 4, left: 0),
          child: Container(
            child: Row(
              children: [
                Expanded(child: Text(regulation.title, style: TextStyle(fontSize: 10))),
                regulation.getRes.getIconWidgetMini,
                const SizedBox(width: 1),
                Text(regulation.getRes.title!, style: TextStyle(color: regulation.getRes.getColor, fontSize: 11)),
              ],
            ),
          ),
        ),
        children: (regulation.texts ?? [])
            .map(
              (e) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: MyColors.lineColor)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: <Widget>[] + [HtmlWidget(e, onTapUrl: (p0) => launch(p0), textStyle: TextStyle(fontSize: 12))],
                      ),
                    ),
                    DotButton(
                      icon: ArtemisIcons.translate,
                      onPressed: () async {
                        final homeC = getIt<HomeController>();
                        final langs = await homeC.getSupportLanguage(refCode);
                        if (langs == null) return;
                        log(e);
                        final regex = RegExp(r'<p[^>]*>(.*?)<\/p>', dotAll: true);
                        final match = regex.firstMatch(e);

                        if (match != null) {
                          final innerText = match.group(1);
                          log(innerText.toString());
                          final regex = RegExp(r'<[^>]*>');
                          final plainText = e.replaceAll(regex, '').trim();
                          final allLangs = BasicClass.getAllSupportedLanguages();
                          allLangs.sort((a, b) => langs.map((l) => l.country).toList().indexOf(a.country).compareTo(langs.map((l) => l.country).toList().indexOf(b.country)));
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (c) => PartialTranslateSheet(allLangs: allLangs, languages: langs, text: plainText ?? ''),
                          );

                          // Output: Passengers with a re-entry permit or a residence permit issued by Algeria do not need a visa.
                        }
                        // log(matches.length.toString());

                        // showModalBottomSheet(context: context,isScrollControlled: true, builder: (c)=>PartialTranslateSheet(languages: langs, text: matches.join("\n")));
                      },
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('${regulation.title}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              regulation.getRes.getIconWidgetMini,
              const SizedBox(width: 1),
              Text(regulation.getRes.title!, style: TextStyle(color: regulation.getRes.getColor, fontSize: 11)),
            ],
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (regulation.texts ?? [])
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: <Widget>[] + [HtmlWidget(e, onTapUrl: (p0) => launch(p0), textStyle: TextStyle(fontSize: 12))],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class DocumentResultWidgetNewDesktop extends StatelessWidget {
  late DocumentResult docRes;
  final String refCode;
  final Color lineColor;
  DocumentResultWidgetNewDesktop({super.key, required this.docRes, required this.refCode, required this.lineColor});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(4),
      // margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(4),
      //   border: Border.all(color: MyColors.travelDocColor),
      //   color: MyColors.travelDocColor.withOpacity(0.10),
      // ),
      child: SizedBox(
        width: width,
        child: Column(
          children:
              <Widget>[] +
              [
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: docRes.evaluationResult.getColor.withOpacity(0.4)),
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: Text('Evaluation Result for Document No. ${((docRes.index ?? 0) + 1)}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                //       ),
                //       // Icon(docRes.evaluationResult.getIcon, size: 15, color: BasicClass.getColorForEvaluationResult(docRes.evaluationResult.name.toString())),
                //       Text(docRes.evaluationResult.name, style: TextStyle(fontSize: 12, color: BasicClass.getColorForEvaluationResult(docRes.evaluationResult.name.toString()))),
                //     ],
                //   ),
                // ),
              ] +
              (docRes.regulations
                  .map(
                    (s2) => RegulationWidgetNewDesktop(
                      regulation: s2,
                      refCode: refCode, isLast: false,
                      lineColor: lineColor

                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }
}

class CommonBorderWidgetNewDesktop extends StatelessWidget {
  final CommonBorder commonBorder;

  const CommonBorderWidgetNewDesktop({super.key, required this.commonBorder});

  @override
  Widget build(BuildContext context) {
    return MyExpansionTile(
      showFooter: false,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: MyColors.greenBg.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.greenBg.withOpacity(0.12)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(commonBorder.runtimeType.toString() ?? '', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: BasicClass.getColorForEvaluationResult(""), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [Text(commonBorder.value ?? '', style: TextStyle(color: Colors.white))],
              ),
            ),
          ],
        ),
      ),
      children: [Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), child: Text(commonBorder!.text ?? ''))],
    );
  }
}
