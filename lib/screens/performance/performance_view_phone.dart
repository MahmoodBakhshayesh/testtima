import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyDatePicker.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:flutter/material.dart';
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

class _PerformanceViewPhoneState extends State<PerformanceViewPhone> {
  final tim = BasicClass.timData;
  String? from;
  String? to;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    Color textFieldBG = Color(0xff6e6e6e).withOpacity(0.15);
    Color greenParts = Color(0xff00C68E);
    Color redParts = Color(0xffFF3f42);
    Color blueParts = Color(0xff2A5CFF);
    Color orangeParts = Color(0xffFFA32C);
    List<PerformanceLog> logList = [PerformanceLog.test(), PerformanceLog.test(), PerformanceLog.test()];
    return Scaffold(
      appBar: PerformanceAppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          spacing: 16,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: MyDatePicker(onChanged: (a) {}, label: "Date Range", rowLabelRatio: [2, 4], placeholder: "From", backgroundColor: textFieldBG),
                ),
                Expanded(
                  flex: 2,
                  child: MyDatePicker(onChanged: (a) {}, label: "", rowLabelRatio: [1, 100], placeholder: "Until", backgroundColor: textFieldBG),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: MyFieldPicker<Location>(
                    searchAutoFocus: true,
                    backgroundColor: textFieldBG,

                    label: "Route",
                    placeholder: "City",
                    rowLabelRatio: [2, 4],
                    itemToWidget: (dynamic a) => Text("$a (${(a as Location).name})"),
                    searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
                    items: tim.locations.of(LocationType.airport),
                    value: tim.locations.of(LocationType.airport).firstWhereOrNull((a) => a.code3 == from),
                    onChange: (a) {
                      from = a?.code3;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: MyFieldPicker<Location>(
                    label: "",
                    backgroundColor: textFieldBG,

                    placeholder: "To",
                    searchAutoFocus: true,
                    rowLabelRatio: [1, 100],
                    itemToWidget: (dynamic a) => Text("$a (${(a as Location).name})"),
                    items: tim.locations.of(LocationType.airport),
                    searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
                    value: tim.locations.of(LocationType.airport).firstWhereOrNull((a) => a.code3 == to),
                    onChange: (a) {
                      to = a?.code3;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Container(
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
                    child: Text("2,569", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
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
                                "ALLOWED",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff858A99)),
                              ),
                            ),
                            Icon(ArtemisIcons.tick_square, color: greenParts, size: 20),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "2,569",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: greenParts),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
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
                                "NOT ALLOWED",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff858A99)),
                              ),
                            ),
                            Icon(ArtemisIcons.close_square, color: redParts, size: 20),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "2,569",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: redParts),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
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
                                "CONDITIONAL",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff858A99)),
                              ),
                            ),
                            Icon(ArtemisIcons.danger, color: orangeParts, size: 20),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "2,569",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: orangeParts),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
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
                                "FORCE APPROVED",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff858A99)),
                              ),
                            ),
                            Icon(ArtemisIcons.tick_square, color: blueParts, size: 20),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "2,569",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: blueParts),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          flex: 7,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(color: MyColors.lineColor)),
                            ),
                            child: Center(child: Text("TIME", style: TextStyle(fontSize: 10, wordSpacing: 0))),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(color: MyColors.lineColor)),
                            ),
                            child: Center(child: Text("ROUTE", style: TextStyle(fontSize: 10))),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(color: MyColors.lineColor)),
                            ),

                            child: Center(child: Text("CODE", style: TextStyle(fontSize: 10))),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(),
                            child: Center(child: Text("RESULT", style: TextStyle(fontSize: 10))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: logList.length,
                      itemBuilder: (c, i) {
                        PerformanceLog log = logList[i];
                        return PerformanceLogWidget(index: i, log: log);
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
  final PerformanceLog log;
  final int index;
  final void Function()? onTap;

  const PerformanceLogWidget({Key? key, required this.log, required this.index, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isOdd = index % 2 != 0;
    const TextStyle headerTextStyle = TextStyle(fontWeight: FontWeight.w600, color: MyColors.black, fontSize: 11);

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
                child: Center(child: Text("${DateFormat("dd MMM 2025 - hh:mm").format(log.dateTime!)}", style: TextStyle(fontSize: 10, wordSpacing: 0))),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Center(child: Text("${log.from}-${log.to}", style: TextStyle(fontSize: 10))),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),

                child: Center(child: Text("${log.code}", style: TextStyle(fontSize: 10))),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: MyColors.lineColor)),
                ),
                child: Center(child: Text("${log.result}", style: TextStyle(fontSize: 10))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
