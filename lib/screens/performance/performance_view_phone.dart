import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/classes/log_report_detail_class.dart';
import 'package:abds/core/classes/overall_performance_class.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyDatePicker.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import '../../core/classes/basic_class.dart';
import '../../core/classes/performance_log_class.dart';
import '../../core/constants/ui.dart';
import 'performance_controller.dart';
import 'performance_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class PerformanceViewPhone extends StatefulWidget {
  static PerformanceController myPerformanceController = getIt<PerformanceController>();

  const PerformanceViewPhone({super.key});

  @override
  State<PerformanceViewPhone> createState() => _PerformanceViewPhoneState();
}

class _PerformanceViewPhoneState extends State<PerformanceViewPhone> with SingleTickerProviderStateMixin {
  String? from;
  String? to;
  DateTime? fromDate;
  DateTime? toDate;

  // PerformanceLog? log;
  List<OverallPerformance> overalls = [];
  List<LogReportDetail> reportDetails = [];
  String? loadingKey;
  late TabController tabBarController;

  @override
  void initState() {
    tabBarController = TabController(length: 3, vsync: this);
    from = BasicClass.user?.attributes["defaultAirport"] ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color textFieldBG = Color(0xff6e6e6e).withOpacity(0.15);
    Color greenParts = Color(0xff00C68E);
    Color redParts = Color(0xffFF3f42);
    Color blueParts = Color(0xff2A5CFF);
    Color orangeParts = Color(0xffFFA32C);
    final headerBg = MyColors.green2.withOpacity(0.26);
    final bodyBg = MyColors.green2.withOpacity(0.12);

    List<OverallPerformance> timOk = overalls.where((a) => a.timaticResult == 1).toList();
    List<OverallPerformance> timNotOk = overalls.where((a) => a.timaticResult == 2).toList();
    List<OverallPerformance> timCon = overalls.where((a) => a.timaticResult == 3).toList();
    return Scaffold(
      appBar: PerformanceAppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          spacing: 16,
          children: [
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 3,
            //       child: MyDatePicker(onChanged: (a) {
            //         fromDate = a;
            //         setState((){});
            //       }, label: "Date Range", rowLabelRatio: [2, 4], placeholder: "From", backgroundColor: textFieldBG,value: fromDate,),
            //     ),
            //     Expanded(
            //       flex: 2,
            //       child: MyDatePicker(onChanged: (a) {
            //         toDate = a;
            //         setState((){});
            //
            //       }, label: "", rowLabelRatio: [1, 100], placeholder: "Until", backgroundColor: textFieldBG,value: toDate,),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: MyFieldPicker<Airport>(
                    searchAutoFocus: true,
                    backgroundColor: textFieldBG,
                    headerBgColor: headerBg,
                    bodyBgColor: bodyBg,
                    label: "Route",
                    placeholder: "City",
                    rowLabelRatio: [2, 4],
                    itemToWidget: (dynamic a) => Text("$a (${(a as Airport).name})"),
                    searchBuilder: (dynamic a) => "$a ${(a as Airport).name}",
                    items: BasicClass.constData.data.airport,
                    value: BasicClass.constData.data.airport.firstWhereOrNull((a) => a.code3 == from),
                    onChange: (a) {
                      from = a?.code3;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: MyFieldPicker<Airport>(
                    label: "",
                    backgroundColor: textFieldBG,
                    headerBgColor: headerBg,
                    bodyBgColor: bodyBg,
                    placeholder: "To",
                    searchAutoFocus: true,
                    rowLabelRatio: [1, 100],
                    itemToWidget: (dynamic a) => Text("$a (${(a as Airport).name})"),
                    items: BasicClass.constData.data.airport,
                    searchBuilder: (dynamic a) => "$a ${(a as Airport).name}",
                    value: BasicClass.constData.data.airport.firstWhereOrNull((a) => a.code3 == to),
                    onChange: (a) {
                      to = a?.code3;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            overalls.isEmpty && reportDetails.isEmpty
                ? Expanded(child: SizedBox())
                : Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: tabBarController,
                      children: [
                        Column(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  // spacing: 12,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if(loadingKey !=null){
                                          return;
                                        }
                                        loadingKey ="";
                                        setState((){});
                                        final rdl = await getIt<PerformanceController>().getPerformanceLog(fromDate: fromDate, toDate: toDate, from: from, to: to);
                                        loadingKey =null;
                                        setState((){});
                                        if (rdl != null) {
                                          reportDetails = rdl;

                                          setState(() {});
                                          Future(() {
                                            tabBarController.animateTo(1);
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: textFieldBG),
                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "TOTAL CHECKS",
                                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff858A99)),
                                                  ),
                                                ),

                                                Icon(ArtemisIcons.user_octagon, size: 20),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(child: Text("${overalls.map((a) => a.count).sum}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
                                                  loadingKey == ""?SpinKitThreeBounce(color: context.mainColor,size: 15):SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Column(
                                      spacing: 12,
                                      children: [1, 2, 3].map((i) {
                                        TimaticResult r = BasicClass.getResultOfCode(i);
                                        return Container(
                                          decoration: BoxDecoration(color: r.getColor.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                                          padding: EdgeInsets.all(12),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      BasicClass.getResultOfCode(i).title,
                                                      style: TextStyle(color: r.getColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                    ),
                                                  ),
                                                  Text(
                                                    overalls.where((a) => a.timaticResult == i).map((a) => a.count).sum.toString(),
                                                    style: TextStyle(color: r.getColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                spacing: 12,
                                                children: [1, 2, 6].map((id) {
                                                  final res = BasicClass.getResultOfCode(id);
                                                  return Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        if(loadingKey != null){
                                                          return;
                                                        }
                                                        loadingKey = "${i}-${id}";
                                                        reportDetails.clear();
                                                        setState(() {});
                                                        final rdl = await getIt<PerformanceController>().getPerformanceLog(timaticResult: i, totalResult: id, fromDate: fromDate, toDate: toDate, from: from, to: to);
                                                        loadingKey = null;
                                                        setState((){});
                                                        if (rdl != null) {
                                                          reportDetails = rdl;

                                                          setState(() {});
                                                          Future(() {
                                                            tabBarController.animateTo(1);
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: res.getColor),
                                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    res.title,
                                                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),
                                                                res.getIconWidgetMiniWhite,
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 0.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${overalls.where((a) => a.timaticResult == i && a.totalResult == id).map((a) => a.count).sum}",
                                                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
                                                                    ),
                                                                  ),
                                                                  loadingKey == "${i}-${id}"?SpinKitThreeBounce(color: Colors.white,size: 15):SizedBox(),
                                                                  const SizedBox(width: 8),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    //
                                    // const SizedBox(height: 12),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       child: Container(
                                    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: textFieldBG),
                                    //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    //         child: Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             Row(
                                    //               children: [
                                    //                 Expanded(
                                    //                   child: Text(
                                    //                     "CONDITIONAL",
                                    //                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff858A99)),
                                    //                   ),
                                    //                 ),
                                    //                 Icon(ArtemisIcons.danger, color: orangeParts, size: 20),
                                    //               ],
                                    //             ),
                                    //             Padding(
                                    //               padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    //               child: Text(
                                    //                 "{log!.conditional}",
                                    //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: orangeParts),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     const SizedBox(width: 12),
                                    //     Expanded(
                                    //       child: Container(
                                    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: textFieldBG),
                                    //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    //         child: Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           children: [
                                    //             Row(
                                    //               children: [
                                    //                 Expanded(
                                    //                   child: Text(
                                    //                     "FORCE APPROVED",
                                    //                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff858A99)),
                                    //                   ),
                                    //                 ),
                                    //                 Icon(ArtemisIcons.tick_square, color: blueParts, size: 20),
                                    //               ],
                                    //             ),
                                    //             Padding(
                                    //               padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    //               child: Text(
                                    //                 "{log!.forceApproved}",
                                    //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: blueParts),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(height: 12),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     color: MyColors.white3,
                                    //     border: Border(
                                    //       top: BorderSide(color: MyColors.lineColor),
                                    //       left: BorderSide(color: MyColors.lineColor),
                                    //       right: BorderSide(color: MyColors.lineColor),
                                    //     ),
                                    //     borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(12)),
                                    //   ),
                                    //   child: Row(
                                    //     children: [
                                    //       Expanded(
                                    //         flex: 7,
                                    //         child: Container(
                                    //           padding: const EdgeInsets.symmetric(vertical: 12),
                                    //           decoration: BoxDecoration(
                                    //             border: Border(right: BorderSide(color: MyColors.lineColor)),
                                    //           ),
                                    //           child: Center(child: Text("TIME", style: TextStyle(fontSize: 10, wordSpacing: 0))),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         flex: 4,
                                    //         child: Container(
                                    //           padding: const EdgeInsets.symmetric(vertical: 12),
                                    //           decoration: BoxDecoration(
                                    //             border: Border(right: BorderSide(color: MyColors.lineColor)),
                                    //           ),
                                    //           child: Center(child: Text("ROUTE", style: TextStyle(fontSize: 10))),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         flex: 3,
                                    //         child: Container(
                                    //           padding: const EdgeInsets.symmetric(vertical: 12),
                                    //           decoration: BoxDecoration(
                                    //             border: Border(right: BorderSide(color: MyColors.lineColor)),
                                    //           ),
                                    //
                                    //           child: Center(child: Text("CODE", style: TextStyle(fontSize: 10))),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         flex: 6,
                                    //         child: Container(
                                    //           padding: const EdgeInsets.symmetric(vertical: 12),
                                    //           decoration: BoxDecoration(),
                                    //           child: Center(child: Text("RESULT", style: TextStyle(fontSize: 10))),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // reportDetails.isEmpty
                                    //     ? SizedBox()
                                    //     : ListView.builder(
                                    //         shrinkWrap: true,
                                    //         physics: NeverScrollableScrollPhysics(),
                                    //         itemCount: reportDetails.length,
                                    //         itemBuilder: (c, i) {
                                    //           LogReportDetail det = reportDetails[i];
                                    //           return ReportDetailsSummaryWidget(index: i, log: det);
                                    //         },
                                    //       ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.white3,
                                        border: Border(
                                          top: BorderSide(color: MyColors.lineColor),
                                          left: BorderSide(color: MyColors.lineColor),
                                          right: BorderSide(color: MyColors.lineColor),
                                        ),
                                        borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(12)),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              decoration: BoxDecoration(
                                                border: Border(right: BorderSide(color: MyColors.lineColor)),
                                              ),
                                              child: Center(child: Text("TIME", style: TextStyle(fontSize: 9, wordSpacing: 0))),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              decoration: BoxDecoration(
                                                border: Border(right: BorderSide(color: MyColors.lineColor)),
                                              ),
                                              child: Center(child: Text("DEST", style: TextStyle(fontSize: 10))),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              decoration: BoxDecoration(
                                                border: Border(right: BorderSide(color: MyColors.lineColor)),
                                              ),

                                              child: Center(child: Text("CODE", style: TextStyle(fontSize: 10))),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              decoration: BoxDecoration(
                                                border: Border(right: BorderSide(color: MyColors.lineColor)),
                                              ),
                                              child: Center(child: Text("TIMATIC", style: TextStyle(fontSize: 10))),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              decoration: BoxDecoration(),
                                              child: Center(child: Text("RESULT", style: TextStyle(fontSize: 10))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    reportDetails.isEmpty
                                        ? SizedBox()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: reportDetails.length,
                                            itemBuilder: (c, i) {
                                              LogReportDetail det = reportDetails[i];
                                              return ReportDetailsSummaryWidget(index: i, log: det);
                                            },
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    reportDetails.isEmpty
                                        ? SizedBox()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: reportDetails.length,
                                            itemBuilder: (c, i) {
                                              LogReportDetail det = reportDetails[i];
                                              return ReportDetailsDetailWidget(index: i, log: det);
                                            },
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: MyButton(
                    label: "Overall",
                    onPressed: () async {
                      final overallList = await getIt<PerformanceController>().getOverallPerformances(fromDate: fromDate, toDate: toDate, from: from, to: to);
                      overalls = overallList ?? overalls;
                      reportDetails.clear();
                      setState(() {});
                      Future(() {
                        tabBarController.animateTo(0);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: MyButton(
                    label: "Summary",
                    onPressed: () async {
                      if (reportDetails.isEmpty) {
                        final rdl = await getIt<PerformanceController>().getPerformanceLog(fromDate: fromDate, toDate: toDate, from: from, to: to);
                        if (rdl != null) {
                          reportDetails = rdl;
                          setState(() {});
                          Future(() {
                            tabBarController.animateTo(1);
                          });
                        }
                      } else {
                        Future(() {
                          tabBarController.animateTo(1);
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: MyButton(
                    label: "Details",
                    onPressed: () async {
                      if (reportDetails.isEmpty) {
                        final rdl = await getIt<PerformanceController>().getPerformanceLog(fromDate: fromDate, toDate: toDate, from: from, to: to);
                        log("rdl ${rdl?.length}");
                        if (rdl != null) {
                          reportDetails = rdl;

                          setState(() {});
                          Future(() {
                            tabBarController.animateTo(2);
                          });
                        }
                      } else {
                        Future(() {
                          tabBarController.animateTo(2);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class PerformanceAppBar extends StatelessWidget implements PreferredSizeWidget {
  static PerformanceController myPerformanceController = getIt<PerformanceController>();

  const PerformanceAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      BackButton(),
                      Text("Performance", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      Spacer(),
                      SizedBox(width: 8),
                    ],
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

class PerformanceLogWidget extends StatelessWidget {
  final PerformanceLogDetail log;
  final int index;
  final void Function()? onTap;

  const PerformanceLogWidget({super.key, required this.log, required this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isOdd = index % 2 != 0;
    const TextStyle headerTextStyle = TextStyle(fontWeight: FontWeight.w600, color: MyColors.black, fontSize: 11);
    List<Color> partColors = [Color(0xff00C68E), Color(0xffFF3f42), Color(0xffFFA32C), Color(0xff2A5CFF)];
    List<String> partNames = ["Allowed", "Not Allowed", "Conditional", "Forced"];
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: !isOdd ? MyColors.white2 : MyColors.white3),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: MyColors.lineColor),
                    left: BorderSide(color: MyColors.lineColor),
                  ),
                ),
                child: Center(child: Text("${log.dateTime}", style: TextStyle(fontSize: 10, wordSpacing: 0))),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Center(child: Text("${log.route}", style: TextStyle(fontSize: 10))),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),

                child: Center(child: Text((log.code ?? '').split("-").last, style: TextStyle(fontSize: 10))),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Center(
                  child: Text(partNames[log.result ?? 0], style: TextStyle(fontSize: 10, color: partColors[log.result ?? 0])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDetailsSummaryWidget extends StatefulWidget {
  final LogReportDetail log;
  final int index;
  final void Function()? onTap;

  const ReportDetailsSummaryWidget({super.key, required this.log, required this.index, this.onTap});

  @override
  State<ReportDetailsSummaryWidget> createState() => _ReportDetailsSummaryWidgetState();
}

class _ReportDetailsSummaryWidgetState extends State<ReportDetailsSummaryWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isOdd = widget.index % 2 != 0;
    const TextStyle headerTextStyle = TextStyle(fontWeight: FontWeight.w600, color: MyColors.black, fontSize: 11);
    List<Color> partColors = [Color(0xff00C68E), Color(0xffFF3f42), Color(0xffFFA32C), Color(0xff2A5CFF)];
    List<String> partNames = ["Allowed", "Not Allowed", "Conditional", "Forced"];
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(color: !isOdd ? MyColors.white2 : MyColors.white3),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: MyColors.lineColor),
                    left: BorderSide(color: MyColors.lineColor),
                  ),
                ),
                child: Center(child: Text("${widget.log.createdAt.format_HHmm}", style: TextStyle(fontSize: 10, wordSpacing: 0))),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Center(child: Text("${widget.log.to}", style: TextStyle(fontSize: 10))),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),

                child: Center(
                  child: loading
                      ? SpinKitThreeBounce(size: 12, color: Colors.blueAccent)
                      : GestureDetector(
                          onTap: () async {
                            if (loading) {
                              return;
                            }
                            loading = true;
                            setState(() {});
                            await getIt<PerformanceController>().goMessageDetails(widget.log.refCode.toString());
                            loading = false;
                            setState(() {});
                          },
                          child: Text(
                            ("${widget.log.showCode}"),
                            style: TextStyle(fontSize: 10, color: Colors.blueAccent, decoration: TextDecoration.underline),
                          ),
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Row(
                  spacing: 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BasicClass.getResultOfCode(widget.log.timaticResult).getIconWidgetMini,
                    Text(BasicClass.getResultOfCode(widget.log.timaticResult).title, style: TextStyle(fontSize: 8, color: BasicClass.getResultOfCode(widget.log.timaticResult).getColor)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Row(
                  spacing: 4,
                  children: [
                    SizedBox(),
                    Expanded(
                      child: Text("${widget.log.totalResultRole ?? ''}", style: TextStyle(fontSize: 10), overflow: TextOverflow.ellipsis),
                    ),
                    BasicClass.getResultOfCode(widget.log.totalResult).getIconWidgetMini,
                    Text(BasicClass.getResultOfCode(widget.log.totalResult).title, style: TextStyle(fontSize: 8, color: BasicClass.getResultOfCode(widget.log.totalResult).getColor)),
                    SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDetailsDetailWidget extends StatefulWidget {
  final LogReportDetail log;
  final int index;
  final void Function()? onTap;

  const ReportDetailsDetailWidget({super.key, required this.log, required this.index, this.onTap});

  @override
  State<ReportDetailsDetailWidget> createState() => _ReportDetailsDetailWidgetState();
}

class _ReportDetailsDetailWidgetState extends State<ReportDetailsDetailWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isOdd = widget.index % 2 != 0;
    const TextStyle headerTextStyle = TextStyle(fontWeight: FontWeight.w600, color: MyColors.black, fontSize: 11);
    final currentStatus = BasicClass.getResultOfCode(widget.log.totalResult);
    final airlineResponse = widget.log.supervisor == null ? null : BasicClass.getResultOfCode(widget.log.airlineApproval);
    final response = widget.log.supervisor?.firstOrNull?.getRes;
    final superResponse = airlineResponse ?? BasicClass.getResultOfCode(widget.log.supervisor?.firstOrNull?.action ?? 1)!;
    final baseTimaticResult = BasicClass.getResultOfCode(widget.log.timaticResult);
    log("actionId ${response?.actionId.toString()} ${widget.log.supervisor?.lastOrNull?.action}");
    final totalRes = BasicClass.getResultOfCode(widget.log.totalResult);
    // log(jsonEncode(widget.log.toJson()));
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Material(
        color: totalRes.getColor.withOpacity(0.12) ?? superResponse?.getColor.withOpacity(0.12) ?? Colors.black12,
        borderRadius: BorderRadiusGeometry.circular(12),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(12)),

          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              if (loading) {
                return;
              }
              loading = true;
              setState(() {});
              await getIt<PerformanceController>().goMessageDetails(widget.log.refCode.toString());
              loading = false;
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(12),

              // decoration: BoxDecoration(color: response?.getColor.withOpacity(0.12)??Colors.white,borderRadius: BorderRadiusGeometry.circular(12)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(width: 4),
                            Text("From: ${widget.log.user}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                      loading ? SpinKitThreeBounce(color: Colors.black, size: 12) : SizedBox(),
                      const SizedBox(width: 4),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadiusGeometry.circular(12),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Text(totalRes?.title ?? response?.name2 ?? '', style: TextStyle(fontSize: 12, color: totalRes.getColor)),
                      ),

                      // Expanded(child: Text(widget.log.code ?? '')),
                      // loading?SpinKitThreeBounce(color: context.mainColor,size: 20,):
                      // Text("${widget.log.user?.username ?? widget.log?.user?.email}"),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios_rounded, size: 15),
                    ],
                  ),
                  const SizedBox(height: 4),
                  widget.log.getFlowWidget,
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            // AirlineLogo(widget.log.airline ?? '--', size: 30),
                            Text("Flight: ", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            Text("${widget.log.airline ?? ''}${widget.log.flightNumber ?? ''}", style: TextStyle(fontSize: 10)),
                            Text(" / "),
                            Text("Nationality: ", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            CountryFlag.fromCountryCode(widget.log.nationality, shape: RoundedRectangle(3), width: 15, height: 10),
                            Text(" ${widget.log.nationality}", style: TextStyle(fontSize: 10)),
                            Text(" / "),
                            Text("Route: ", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            Text("${widget.log.from ?? ''}- ", style: TextStyle(fontSize: 10)),
                            CountryFlag.fromCountryCode(BasicClass.getAirportByCode(widget.log.to)?.country ?? '', shape: RoundedRectangle(3), width: 15, height: 10),
                            Text(" ${widget.log.to ?? ''}", style: TextStyle(fontSize: 10)),

                            // Text("Nationality",style: TextStyle(color: Colors.grey),),
                            // Text("${widget.log. ?? ''}-${widget.log.to ?? ''}", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Employee ID: ",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.log.employeeId ?? "",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.circle, color: Colors.grey, size: 5),
                      const SizedBox(width: 4),
                      Text(
                        "Tracking ID: ",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${widget.log.showCode ?? ""}",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 2),
                      Spacer(),
                      Text(
                        DateFormat("dd MMM, hh:mm").format(widget.log.createdAt!.toLocal()),
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
