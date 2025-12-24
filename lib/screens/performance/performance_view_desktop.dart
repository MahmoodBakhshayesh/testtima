import 'dart:convert';
import 'dart:developer';
import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/classes/log_report_detail_class.dart';
import 'package:abds/core/classes/overall_performance_class.dart';
import 'package:abds/core/classes/overall_report_tabel_class.dart';
import 'package:abds/core/classes/timatic_response_new_class.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/date_range_util.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/home/home_view_desktop.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/performance/widgets/overall_report_table.dart';
import 'package:abds/widgets/AirlineLogo.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyDatePicker.dart';
import 'package:abds/widgets/MyExpansionTile.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyMultiFieldPicker.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags_pro/country_flags_pro.dart';
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/classes/basic_class.dart';
import '../../core/classes/performance_log_class.dart';
import '../../core/constants/ui.dart';
import '../../core/utils_and_services/country_flag_util.dart';
import '../home/new_widgets/flight_widget.dart';
import '../home/new_widgets/passenger_widget.dart';
import '../home/new_widgets/passport_widget.dart';
import '../home/new_widgets/resident_widget.dart';
import '../home/new_widgets/visa_widget.dart';
import '../home/widgets/logs_and_attachments.dart';
import '../home/widgets/timatic_response_widget.dart';
import '../result_report/result_report_state.dart';
import 'performance_controller.dart';
import 'performance_state.dart';
import '../../initialize.dart';

class PerformanceViewDesktop extends ConsumerStatefulWidget {
  static PerformanceController myPerformanceController = getIt<PerformanceController>();

  const PerformanceViewDesktop({super.key});

  @override
  ConsumerState<PerformanceViewDesktop> createState() => _PerformanceViewDesktopState();
}

class _PerformanceViewDesktopState extends ConsumerState<PerformanceViewDesktop> with SingleTickerProviderStateMixin {
  String? from;
  String? to;
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  bool moreMode = false;
  OverallReportTable? table;
  int reportIndex = 0;

  // List<OverallPerformance> overalls = [];
  List<LogReportDetail> reportDetails = [];
  List<String> filteredAirports = [];
  List<String> filteredAirlines = [];
  String? loadingKey;
  late TabController tabBarController;

  final Map<String, ExpansibleController> _controllers = {};

  ExpansibleController _c(String id) => _controllers.putIfAbsent(id, () => ExpansibleController());

  @override
  void initState() {
    tabBarController = TabController(length: 3, vsync: this);
    tabBarController.addListener(() {
      setState(() {});
    });
    // from = BasicClass.user?.attributes["defaultAirport"] ?? "";
    super.initState();
  }

  void expandAll(items) {
    for (final it in items) {
      _c(it).expand();
      setState(() {});
    }
  }

  void collapseAll(items) {
    for (final it in items) {
      _c(it).collapse();
      setState(() {});
    }
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

    List<String> detailsFrom = reportDetails.map((a) => a.airportAirline ?? '').toSet().toList();
    List<String> airportsFilters = reportDetails.map((a) => a.from ?? '').toSet().toList();
    List<String> airlinesFilter = reportDetails.map((a) => a.airline ?? '').toSet().toList();
    // List<OverallPerformance> timOk = overalls.where((a) => a.timaticResult == 1).toList();
    // List<OverallPerformance> timNotOk = overalls.where((a) => a.timaticResult == 2).toList();
    // List<OverallPerformance> timCon = overalls.where((a) => a.timaticResult == 3).toList();

    final timaticRes = ref.watch(reportTimaticResultNewProvider);
    bool resultMode = timaticRes != null;
    final fieldBgColor = Color(0xffF5F5F5);
    return Scaffold(
      appBar: PerformanceAppBar(
        overrideResult: timaticRes,
        title: ["Overall", "Summary", "Details"][tabBarController.index],

        onBack: () {
          Navigator.pop(context);
        },
      ),

      backgroundColor: Color(0xffF8F9FC),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                spacing: 8,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: MyFieldPicker<DateRangeEnum>(
                            label: "Date Range",
                            items: DateRangeEnum.values,
                            itemToString: (a) => a.label,
                            valueToString: (a) => a.label,
                            bodyBgColor: fieldBgColor,
                            backgroundColor: fieldBgColor,
                            showClearButton: false,
                            onChange: (a) async {
                              if (a == null) return;
                              final sAndE = getDateRange(a!);
                              fromDate = sAndE.start;
                              toDate = sAndE.end;
                              setState(() {});
                              await getOverall(null);
                            },
                          ),
                        ),
                        Text(
                          "Range",
                          style: TextStyle(fontSize: 14),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                            decoration: BoxDecoration(color: fieldBgColor, borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                DotButton(
                                  size: 28,
                                  icon: Icons.remove,
                                  color: Colors.black54,
                                  onPressed: () {
                                    fromDate = fromDate?.subtract(Duration(days: 1));
                                    setState(() {});
                                  },
                                ),
                                Expanded(
                                  child: MyDatePicker(
                                    backgroundColor: textFieldBG,
                                    headerBgColor: Colors.transparent,
                                    bodyBgColor: Colors.transparent,
                                    textAlign: TextAlign.center,
                                    radius: BorderRadius.zero,
                                    onChanged: (a) {
                                      fromDate = a;
                                      setState(() {});
                                    },
                                    label: "",

                                    rowLabelRatio: [1, 100],
                                    placeholder: "From",
                                    valueFormat: DateFormat("dd, MMM"),
                                    // backgroundColor: textFieldBG,
                                    value: fromDate,
                                  ),
                                ),
                                DotButton(
                                  size: 28,
                                  icon: Icons.add,
                                  onPressed: () {
                                    fromDate = fromDate?.add(Duration(days: 1));
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                            decoration: BoxDecoration(color: fieldBgColor, borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                DotButton(
                                  size: 28,
                                  icon: Icons.remove,
                                  color: Colors.black54,
                                  onPressed: () {
                                    toDate = toDate?.subtract(Duration(days: 1));
                                    setState(() {});
                                  },
                                ),
                                Expanded(
                                  child: MyDatePicker(
                                    backgroundColor: textFieldBG,
                                    headerBgColor: Colors.transparent,
                                    bodyBgColor: Colors.transparent,
                                    radius: BorderRadius.zero,
                                    textAlign: TextAlign.center,
                                    valueFormat: DateFormat("dd, MMM"),
                                    // bodyBgColor: bodyBg,
                                    onChanged: (a) {
                                      toDate = a;
                                      setState(() {});
                                    },
                                    label: "",
                                    rowLabelRatio: [1, 100],
                                    placeholder: "To",
                                    // backgroundColor: textFieldBG,
                                    value: toDate,
                                  ),
                                ),
                                DotButton(
                                  size: 28,
                                  icon: Icons.add,
                                  onPressed: () {
                                    toDate = toDate?.add(Duration(days: 1));
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Expanded(
                            child: table == null && reportDetails.isEmpty
                                ? SizedBox()
                                : Column(
                                    children: [
                                      Expanded(
                                        child: TabBarView(
                                          physics: NeverScrollableScrollPhysics(),

                                          controller: tabBarController,
                                          children: [
                                            OverallReportListView(model: table, fromDate: fromDate, toDate: toDate),
                                            Column(
                                              spacing: 12,
                                              children: [
                                                Row(
                                                  spacing: 12,
                                                  children: [
                                                    Expanded(
                                                      child: MyMultiFieldPicker<String>(
                                                        label: null,
                                                        rowLabelRatio: [1, 100],
                                                        items: airportsFilters,
                                                        itemToString: (a) => a,
                                                        valuesToString: (a) => a.isEmpty
                                                            ? "Filter Airport"
                                                            : a.length == airportsFilters.length
                                                            ? "All Airport Selected"
                                                            : "${a.length} Airport selected",
                                                        bodyBgColor: fieldBgColor,
                                                        backgroundColor: fieldBgColor,

                                                        showClearButton: true,
                                                        onChange: (a) async {
                                                          filteredAirports = a;
                                                          setState(() {});
                                                        },
                                                        values: filteredAirports,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: MyMultiFieldPicker<String>(
                                                        label: null,
                                                        rowLabelRatio: [1, 100],
                                                        items: airlinesFilter,

                                                        itemToString: (a) => a,
                                                        valuesToString: (a) => a.isEmpty
                                                            ? "Filter Airlines"
                                                            : a.length == airlinesFilter.length
                                                            ? "All Airlines Selected"
                                                            : "${a.length} Airlines selected",
                                                        bodyBgColor: fieldBgColor,
                                                        backgroundColor: fieldBgColor,
                                                        showClearButton: true,
                                                        onChange: (a) async {
                                                          filteredAirlines = a;
                                                          setState(() {});
                                                        },
                                                        values: filteredAirlines,
                                                      ),
                                                    ),
                                                    MyButton(
                                                      width: 140,
                                                      color: Colors.white,
                                                      borderSide: BorderSide(color: MyColors.lineColor),
                                                      textColor: Colors.black,
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 14,
                                                      iconInRight: true,
                                                      iconSize: 15,
                                                      icon: !_controllers.values.any((a) => a.isExpanded) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                                      label: _controllers.values.any((a) => a.isExpanded) ? "Collapse All" : "Expand All",
                                                      onPressed: () {
                                                        if (_controllers.values.any((a) => a.isExpanded)) {
                                                          collapseAll(detailsFrom);
                                                        } else {
                                                          expandAll(detailsFrom);
                                                        }
                                                      },
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: SizedBox(),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
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
                                                              flex: 3,
                                                              child: Container(
                                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                                decoration: BoxDecoration(
                                                                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                                                                ),
                                                                child: Center(child: Text("FROM", style: TextStyle(fontSize: 12))),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Container(
                                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                                decoration: BoxDecoration(
                                                                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                                                                ),
                                                                child: Center(child: Text("DATE", style: TextStyle(fontSize: 12, wordSpacing: 0))),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                                decoration: BoxDecoration(
                                                                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                                                                ),
                                                                child: Center(child: Text("DEST", style: TextStyle(fontSize: 12))),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 4,
                                                              child: Container(
                                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                                decoration: BoxDecoration(
                                                                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                                                                ),
                                                                child: Center(child: Text("FLIGHT NUMBER", style: TextStyle(fontSize: 12))),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                                decoration: BoxDecoration(
                                                                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                                                                ),

                                                                child: Center(child: Text("TRACKING ID", style: TextStyle(fontSize: 12))),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                                decoration: BoxDecoration(
                                                                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                                                                ),
                                                                child: Center(child: Text("TIMATIC", style: TextStyle(fontSize: 12))),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 7,
                                                              child: Container(
                                                                padding: const EdgeInsets.symmetric(vertical: 12),
                                                                decoration: BoxDecoration(),
                                                                child: Center(child: Text("RESULT", style: TextStyle(fontSize: 12))),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      reportDetails.isEmpty
                                                          ? SizedBox()
                                                          : Expanded(
                                                              child: ListView.builder(
                                                                // shrinkWrap: true,
                                                                // physics: NeverScrollableScrollPhysics(),
                                                                itemCount: detailsFrom.length,
                                                                itemBuilder: (c, i) {
                                                                  String from = detailsFrom[i];
                                                                  final items = reportDetails
                                                                      .where(
                                                                        (a) =>
                                                                            a.airportAirline == from &&
                                                                            (filteredAirports.isEmpty || filteredAirports.contains(a.from)) &&
                                                                            (filteredAirlines.isEmpty || filteredAirlines.contains(a.airline)),
                                                                      )
                                                                      .toList();

                                                                  return MyExpansionTile(
                                                                    initiallyExpanded: true,
                                                                    showFooter: false,
                                                                    onExpansionChanged: (_) {
                                                                      setState(() {});
                                                                    },
                                                                    controller: _c(from),
                                                                    tilePadding: EdgeInsets.zero,
                                                                    childrenPadding: EdgeInsets.zero,
                                                                    showTrailingIcon: true,
                                                                    backgroundColor: Colors.blueAccent.withOpacity(0.1),
                                                                    collapsedBackgroundColor: Colors.blueAccent.withOpacity(0.1),
                                                                    collapsedShape: RoundedRectangleBorder(side: BorderSide(color: MyColors.lineColor)),
                                                                    shape: RoundedRectangleBorder(side: BorderSide(color: MyColors.lineColor)),
                                                                    title: Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                                      decoration: BoxDecoration(),
                                                                      child: Row(
                                                                        children: [
                                                                          Expanded(child: Text(from, style: TextStyle(fontSize: 14))),
                                                                          Text(items.length.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    children: [...items.map((det) => ReportDetailsSummaryWidgetDesktop(key: PageStorageKey(det.refCode), index: items.indexOf(det), log: det))],
                                                                  );
                                                                  LogReportDetail det = reportDetails[i];
                                                                  return ReportDetailsSummaryWidgetDesktop(index: i, log: det);
                                                                },
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              spacing: 0,
                                              children: [
                                                Row(
                                                  spacing: 12,
                                                  children: [
                                                    Expanded(
                                                      child: MyMultiFieldPicker<String>(
                                                        label: null,
                                                        rowLabelRatio: [1, 100],
                                                        items: airportsFilters,
                                                        itemToString: (a) => a,
                                                        valuesToString: (a) => a.isEmpty
                                                            ? "Filter Airport"
                                                            : a.length == airportsFilters.length
                                                            ? "All Airport Selected"
                                                            : "${a.length} Airport selected",
                                                        bodyBgColor: fieldBgColor,
                                                        backgroundColor: fieldBgColor,

                                                        showClearButton: true,
                                                        onChange: (a) async {
                                                          filteredAirports = a;
                                                          setState(() {});
                                                        },
                                                        values: filteredAirports,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: MyMultiFieldPicker<String>(
                                                        label: null,
                                                        rowLabelRatio: [1, 100],
                                                        items: airlinesFilter,

                                                        itemToString: (a) => a,
                                                        valuesToString: (a) => a.isEmpty
                                                            ? "Filter Airlines"
                                                            : a.length == airlinesFilter.length
                                                            ? "All Airlines Selected"
                                                            : "${a.length} Airlines selected",
                                                        bodyBgColor: fieldBgColor,
                                                        backgroundColor: fieldBgColor,
                                                        showClearButton: true,
                                                        onChange: (a) async {
                                                          filteredAirlines = a;
                                                          setState(() {});
                                                        },
                                                        values: filteredAirlines,
                                                      ),
                                                    ),
                                                    SizedBox(width: 140),
                                                    Expanded(
                                                      flex: 2,
                                                      child: SizedBox(),
                                                    ),
                                                  ],
                                                ),
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
                                                                  if ((filteredAirports.isNotEmpty || filteredAirlines.isNotEmpty)) {
                                                                    if (!filteredAirports.contains(det.from) && !filteredAirlines.contains(det.airline)) {
                                                                      return SizedBox();
                                                                    }
                                                                  }
                                                                  return ReportDetailsDetailWidgetDesktop(index: i, log: det);
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
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: MyButton(
                          label: "Overall",
                          onPressed: () async {
                            await getOverall(0);
                          },
                        ),
                      ),
                      Expanded(
                        child: MyButton(
                          label: "Summary",
                          onPressed: () async {
                            await getOverall(1);
                          },
                        ),
                      ),
                      Expanded(
                        child: MyButton(
                          label: "Details",
                          onPressed: () async {
                            await getOverall(2);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getOverall(int? index) async {
    int ri = index ?? reportIndex;
    reportIndex = ri;
    if (ri == 0) {
      final t = await getIt<PerformanceController>().getOverallPerformances(fromDate: fromDate, toDate: toDate, from: from, to: to);
      table = t;
      reportDetails.clear();
      setState(() {});
      Future(() {
        tabBarController.animateTo(ri);
      });
    } else {
      final rdl = await getIt<PerformanceController>().getPerformanceLog(fromDate: fromDate, toDate: toDate, from: from, to: to);
      if (rdl != null) {
        reportDetails = rdl;
        setState(() {});
        Future(() {
          tabBarController.animateTo(ri);
        });
      }
    }
  }
}

class PerformanceAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onBack;
  final String title;
  final TimaticResponseNew? overrideResult;
  static PerformanceController myPerformanceController = getIt<PerformanceController>();

  const PerformanceAppBar({super.key, required this.onBack, required this.title, this.overrideResult});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffB3C5FF),
            Color(0xffFEFEFE),
          ],
        ),
      ),
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
                      BackButton(
                        onPressed: () {
                          onBack?.call();
                        },
                      ),
                      Text("Reports / $title", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      Spacer(),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            // HeaderSummaryWidgetDesktop(header: SizedBox(),overrideResult: overrideResult,)
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
                child: Center(child: Text("${log.dateTime}", style: TextStyle(fontSize: 14, wordSpacing: 0))),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Center(child: Text("${log.route}", style: TextStyle(fontSize: 14))),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),

                child: Center(child: Text((log.code ?? '').split("-").last, style: TextStyle(fontSize: 14))),
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
                  child: Text(partNames[log.result ?? 0], style: TextStyle(fontSize: 14, color: partColors[log.result ?? 0])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDetailsSummaryWidgetDesktop extends StatefulWidget {
  final LogReportDetail log;
  final int index;
  final void Function()? onTap;

  const ReportDetailsSummaryWidgetDesktop({super.key, required this.log, required this.index, this.onTap});

  @override
  State<ReportDetailsSummaryWidgetDesktop> createState() => _ReportDetailsSummaryWidgetDesktopState();
}

class _ReportDetailsSummaryWidgetDesktopState extends State<ReportDetailsSummaryWidgetDesktop> {
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
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Center(child: Text(widget.log.from == widget.log.airportAirline ? '' : widget.log.from, style: GoogleFonts.chivoMono(fontSize: 14))),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: MyColors.lineColor),
                    left: BorderSide(color: MyColors.lineColor),
                  ),
                ),
                child: Center(child: Text(DateFormat("dd MMM").format(widget.log.createdAt.toLocal()), style: GoogleFonts.roboto(fontSize: 12, wordSpacing: 0))),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Center(child: Text(widget.log.to, style: GoogleFonts.chivoMono(fontSize: 14))),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Center(
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      AirlineLogo(widget.log.airline, size: 15, padding: EdgeInsets.symmetric(horizontal: 0)),
                      const SizedBox(width: 8),
                      Text("${widget.log.airline}${widget.log.flightNumber}", style: GoogleFonts.chivoMono(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
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
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: MyColors.lineColor)),
                  ),

                  child: Center(
                    child: loading
                        ? SpinKitThreeBounce(size: 12, color: Colors.blueAccent)
                        : Text(
                            ("${widget.log.showCode}"),
                            style: GoogleFonts.chivoMono(fontSize: 14, color: Colors.blueAccent, decoration: TextDecoration.underline),
                          ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Row(
                  spacing: 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BasicClass.getResultOfCode(widget.log.timaticResult).getIconWidget,
                    // Text(BasicClass.getResultOfCode(widget.log.timaticResult).title, style: TextStyle(fontSize: 8, color: BasicClass.getResultOfCode(widget.log.timaticResult).getColor)),
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
                  spacing: 8,
                  children: [
                    SizedBox(),
                    Expanded(
                      child: Text(widget.log.totalResultRole ?? '', style: TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis),
                    ),
                    // BasicClass.getResultOfCode(widget.log.totalResult).getIconWidgetMini,
                    Text(BasicClass.getResultOfCode(widget.log.totalResult).title, style: TextStyle(fontSize: 12, color: BasicClass.getResultOfCode(widget.log.totalResult).getColor)),
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

class ReportDetailsDetailWidgetDesktop extends StatefulWidget {
  final LogReportDetail log;
  final int index;
  final void Function()? onTap;

  const ReportDetailsDetailWidgetDesktop({super.key, required this.log, required this.index, this.onTap});

  @override
  State<ReportDetailsDetailWidgetDesktop> createState() => _ReportDetailsDetailWidgetDesktopState();
}

class _ReportDetailsDetailWidgetDesktopState extends State<ReportDetailsDetailWidgetDesktop> {
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
    // log("actionId ${response?.actionId.toString()} ${widget.log.supervisor?.lastOrNull?.action}");
    final totalRes = BasicClass.getResultOfCode(widget.log.totalResult);
    // log(jsonEncode(widget.log.toJson()));
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Material(
        color: totalRes.getColor.withOpacity(0.05) ?? superResponse?.getColor.withOpacity(0.12) ?? Colors.black12,
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
                            Text("From: ${widget.log.user}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat("dd MMM, hh:mm").format(widget.log.createdAt!.toLocal()),
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
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
                        child: Text(totalRes?.title ?? response?.name2 ?? '', style: TextStyle(fontSize: 14, color: totalRes.getColor)),
                      ),

                      // Expanded(child: Text(widget.log.code ?? '')),
                      // loading?SpinKitThreeBounce(color: context.mainColor,size: 20,):
                      // Text("${widget.log.user?.username ?? widget.log?.user?.email}"),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios_rounded, size: 15),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // const SizedBox(height: 4),
                  // widget.log.getFlowWidget,
                  // const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: totalRes.getColor.withOpacity(0.02) ?? superResponse?.getColor.withOpacity(0.12) ?? Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Flight: ", style: TextStyle(color: Colors.grey, fontSize: 14)),
                                    AirlineLogo(widget.log.airline ?? '--', size: 30),
                                    Text("${widget.log.airline ?? ''}${widget.log.flightNumber ?? ''}", style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Nationality: ", style: TextStyle(color: Colors.grey, fontSize: 14)),
                                    MyCountryFlagsPro.getFlag(widget.log.nationality, borderRadius: BorderRadius.circular(3), width: 15, height: 10),
                                    Text(" ${widget.log.nationality}", style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Route: ", style: TextStyle(color: Colors.grey, fontSize: 14)),
                                    Text("${widget.log.from ?? ''}- ", style: TextStyle(fontSize: 14)),
                                    MyCountryFlagsPro.getFlag(BasicClass.getAirportByCode(widget.log.to)?.country ?? '', borderRadius: BorderRadius.circular(3), width: 15, height: 10),
                                    Text(" ${widget.log.to ?? ''}", style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "Employee ID: ",
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      widget.log.employeeId ?? "",
                                      style: TextStyle(fontSize: 14, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "Tracking ID: ",
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${widget.log.showCode ?? ""}",
                                      style: TextStyle(fontSize: 14, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "TIMATIC: ",
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(baseTimaticResult.title, style: TextStyle(fontSize: 14, color: baseTimaticResult.getColor)),
                                  ],
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
