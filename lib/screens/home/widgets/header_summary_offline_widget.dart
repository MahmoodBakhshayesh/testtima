import 'package:abds/core/classes/current_status_class.dart';
import 'package:abds/core/classes/header_summary_object_class.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/ui.dart';
import '../../../core/utils_and_services/country_flag_util.dart';
import '../../../core/utils_and_services/string_utility.dart';
import '../../../widgets/AirlineLogo.dart';
import '../../../widgets/glass_widget.dart';



class HeaderSummaryOfflineWidget extends StatelessWidget {
  final Widget header;
  final HeaderSummaryObject? summaryObject;

  const HeaderSummaryOfflineWidget({super.key, required this.header,required this.summaryObject});

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
    if(summaryObject==null){
      return header;
    }
    Color color = MyColors.mainBlue;
    final currentStatus = summaryObject!.currentStatus;
    bool isClosed = !summaryObject!.currentStatus.canUseOption;

    var gradiant = LinearGradient(colors: [color.withOpacity(0.18), color.withOpacity(0.02)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
    if (isClosed) {
      gradiant = LinearGradient(colors: [currentStatus!.getRes.getColor.withOpacity(0.48), currentStatus!.getRes.getColor.withOpacity(0.18)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
    }


    return FigmaGlass(
      // height: 124 + (resultMode ? additionalHeight : 0),
      child: Container(
        padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 16),
        width: context.width,
        decoration: BoxDecoration(gradient: gradiant),
        child: Row(
          children: [
            Expanded(child: header),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Builder(
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          child: Row(spacing: 12, children: [...summaryObject!.segments.map((seg) => seg.routeWidget)]),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Flight: ", style: TextStyle(color: Colors.grey)),
                                    AirlineLogo(summaryObject!.airline??'', size: 25),
                                    Text(summaryObject!.flnb??''),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Date: ", style: TextStyle(color: Colors.grey)),
                                    Text(summaryObject!.dateTime.format_ddMMM ?? ''),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Route: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    Text("${summaryObject!.departure}-${summaryObject!.arrival}", style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Passport: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    Text(StringUtility.maskString(summaryObject!.docNumber??''), style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Tracking: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    Text(summaryObject!.showCode??'', style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("EmployeeId: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    Text(summaryObject!.employeeId??'', style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Nationality: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    countryBuilderHeader(summaryObject!.nationality),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text("Resident: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    countryBuilderHeader(summaryObject!.resident),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Row(
                                  children: [
                                    Text("VISA: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    countryBuilderHeader(summaryObject!.issuing),
                                  ],
                                ),
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
