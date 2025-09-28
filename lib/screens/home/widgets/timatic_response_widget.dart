import 'package:abds/core/classes/timatic_response_new_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/constants/ui.dart';
import '../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../../core/utils_and_services/timatic/src/models/document_request.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../home_state.dart';

class TimaticTrueResultWidgetNew extends ConsumerStatefulWidget {
  final TimaticResponseNew res;

  const TimaticTrueResultWidgetNew({super.key, required this.res});

  @override
  ConsumerState<TimaticTrueResultWidgetNew> createState() => _TimaticTrueResultWidgetNewState();
}

class _TimaticTrueResultWidgetNewState extends ConsumerState<TimaticTrueResultWidgetNew> {
  ExpansibleController expansibleController = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.res.segments.map((segRes) {
          int index = widget.res.segments.indexOf(segRes);
          return MyExpansionTile(
            initiallyExpanded: segRes.result!.first.ruleSetEvaluations!.any((a) => a.evaluationResult.index < 2),
            tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
            collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            showFooter: false,
            title: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: segRes.segmentEvaluationResult.getColor.withOpacity(0.12)),
                    color: segRes.segmentEvaluationResult.getColor.withOpacity(0.08),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // decoration: BoxDecoration(color: segRes.segmentEvaluationResult.getColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: Row(
                          children: [
                            Text(segRes.route),
                            Spacer(),
                            Text(
                              "Segment ${index + 1} ",
                              style: TextStyle(color: segRes.segmentEvaluationResult.getColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.48),
                          borderRadius: BorderRadiusGeometry.circular(12),
                          border: Border.all(color: Colors.white),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    segRes.segmentEvaluationResult.getTitle,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: segRes.segmentEvaluationResult.getColor),
                                  ),
                                ),
                              ],
                            ),
                            segRes.segmentEvaluationResult.getSubtitleWidget,
                          ],
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 8.0),
                      //   child: Text(
                      //     segRes.segmentEvaluationResult.getSubtitle,
                      //     style: TextStyle(color: segRes.segmentEvaluationResult.getColor, fontWeight: FontWeight.w400),
                      //   ),
                      // ),
                      // const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
            children: [
              ...(segRes.result ?? []).map((sr) {
                final sorted = sr.ruleSetEvaluations??[];
                sorted.sort((a, b) => a.evaluationResult.index.compareTo(b.evaluationResult.index));

                return Column(children: [...(sorted).map((a) => RuleSetWidgetNew(ruleSet: a))]);
              }),
              // ...segRes.result.map((r)=>r.ruleSetEvaluations!.map((a)=>RuleSetWidgetNew(ruleSet: a))).toList()
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

class RuleSetWidgetNew extends StatelessWidget {
  final RuleSetEvaluation ruleSet;

  const RuleSetWidgetNew({super.key, required this.ruleSet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14.0, top: 14),
      child: MyExpansionTile(
        // initiallyExpanded: ruleSet.evaluationResult.index < 2,
        showFooter: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: ruleSet.getColor.withOpacity(0.12)),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: ruleSet.getColor.withOpacity(0.12)),
        ),
        backgroundColor: ruleSet.getColor.withOpacity(0.08),
        collapsedBackgroundColor: ruleSet.getColor.withOpacity(0.08),
        tilePadding: EdgeInsets.symmetric(horizontal: 8),
        childPreview: ruleSet.evaluationResult.index > 1
            ? null
            : Column(
                children: [
                  ...ruleSet.regulations.map(
                    (a) => Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(a.title ?? '', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              ),
                              a.evaluationResult.getIconWidgetMini,
                              const SizedBox(width: 1),
                              Text(a.regulationResult ?? '', style: TextStyle(fontSize: 11, color: BasicClass.getColorForEvaluationResult(a.regulationResult ?? ''.toString()))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...ruleSet.documents.map(
                    (d) => Column(
                      children: d.regulations
                          .map(
                            (a) => Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(a.title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                  ),
                                  a.evaluationResult.getIconWidgetMini,
                                  const SizedBox(width: 1),
                                  Text(a.regulationResult ?? '', style: TextStyle(fontSize: 11, color: BasicClass.getColorForEvaluationResult(a.regulationResult.toString()))),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(ruleSet.title ?? '', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      children: [
                        ruleSet.evaluationResult.getIconWidget,
                        const SizedBox(width: 4),
                        Text(
                          ruleSet.ruleSetResult ?? '',
                          style: TextStyle(color: ruleSet.getColor, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Text("ada")
            ],
          ),
        ),
        childrenPadding: EdgeInsets.zero,
        children: [
          ...ruleSet.regulations.map((r) => RegulationWidgetNew(regulation: r)).toList(),
          ...ruleSet.documents.map((r) => DocumentResultWidgetNew(docRes: r)).toList(),
        ],
      ),
    );
  }
}

class RegulationWidgetNew extends StatelessWidget {
  late Regulation regulation;

  RegulationWidgetNew({super.key, required this.regulation});

  //final TimaticController myTimaticController = getIt<TimaticController>();

  @override
  Widget build(BuildContext context) {
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
              regulation.evaluationResult.getIconWidgetMini,
              const SizedBox(width: 1),
              Text(regulation.regulationResult ?? '', style: TextStyle(color: BasicClass.getColorForEvaluationResult(regulation.regulationResult ?? ''), fontSize: 11)),
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

class DocumentResultWidgetNew extends StatelessWidget {
  late DocumentResult docRes;

  DocumentResultWidgetNew({super.key, required this.docRes});

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
              (docRes.regulations.map((s2) => RegulationWidgetNew(regulation: s2)).toList()),
        ),
      ),
    );
  }
}

class CommonBorderWidgetNew extends StatelessWidget {
  final CommonBorder commonBorder;

  const CommonBorderWidgetNew({super.key, required this.commonBorder});

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
