import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/screens/result_report/result_report_state.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_overlay_menu/smart_overlay_menu.dart';

import '../../core/classes/constant_data_class.dart';
import '../../core/constants/ui.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/residents_state_controller.dart';
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../../core/utils_and_services/string_utility.dart';
import '../../core/utils_and_services/timatic/src/models/document_request.dart';
import '../../core/utils_and_services/time_picker/ui_permission.dart';
import '../../initialize.dart';
import '../../widgets/AirlineLogo.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/MyExpansionTile.dart';
import '../../widgets/check_permission.dart';
import '../../widgets/glass_widget.dart';
import '../home/home_state.dart';
import '../home/new_widgets/flight_widget.dart';
import '../home/new_widgets/passenger_widget.dart';
import '../home/new_widgets/passport_widget.dart';
import '../home/new_widgets/resident_widget.dart';
import '../home/new_widgets/visa_widget.dart';
import '../home/widgets/logs_and_attachments.dart';
import '../home/widgets/timatic_response_widget.dart';
import 'result_report_controller.dart';

class ResultReportViewPhone extends ConsumerStatefulWidget {
  static ResultReportController myResultReportController = getIt<ResultReportController>();

  const ResultReportViewPhone({super.key});

  @override
  ConsumerState<ResultReportViewPhone> createState() => _ResultReportViewPhoneState();
}

class _ResultReportViewPhoneState extends ConsumerState<ResultReportViewPhone> {
  ExpansibleController flightPaxController = ExpansibleController();
  ExpansibleController timaticController = ExpansibleController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget countryBuilder(dynamic a) => a == null
      ? SizedBox()
      : Row(
    children: [
      ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
      const SizedBox(width: 8),
      Text("$a (${(a as Country).name})"),
    ],
  );

  Widget countryBuilderHeader(dynamic a) => a == null
      ? SizedBox()
      : Row(
    children: [
      Text("$a"),
      const SizedBox(width: 2),
      ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final timaticRes = ref.watch(reportTimaticResultNewProvider);

    // log(tim.params.of(ParameterType.documentCode).map((a)=>"${a.code} -> ${a.name}").join("\n"));
    // final List<DocumentDetail> documentDetails = ref.watch(documentProvider);
    // final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> passports = ref.watch(reportPassportsProvider);
    final List<DocumentDetail> visas = ref.watch(reportVisasProvider);
    final List<DocumentDetail> residents = ref.watch(reportResidentsProvider);
    final PassengerDetails passengerDetails = ref.watch(reportPassengerProvider);
    final List<ItinerarySegment> segments = ref.watch(reportSegmentsProvider);
    // log("passes ${passports.length}");
    // log("visas ${visas.length}");
    bool resultMode = timaticRes != null;
    bool hasAnyDocs = passports.isNotEmpty || visas.isNotEmpty || residents.isNotEmpty;

    // bool canCheck = segments.any((a) => a.arrival.point.isNotEmpty && a.departure.point.isNotEmpty && (a.flnb ?? "").isNotEmpty && a.operatingCarrier != null);
    bool canCheck =
        segments.first.hasAllRequired() &&
            segments.every((s) => s.hasRoute()) &&
            passengerDetails.hasAllRequired() &&
            passports.every((p) => p.hasAllRequired()) &&
            visas.every((v) => v.hasAllRequired()) &&
            residents.every((r) => r.hasAllRequired());
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 30;
    double additionalHeight = 120;
    return PopScope(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          bottom: true,
          top: false,
          child: Scaffold(
            body: Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              SizedBox(height: 124 + (resultMode ? additionalHeight : 0)),
                              LogsAndAttachmentsWidget(report: true,),
                              Padding(

                                padding: const EdgeInsets.all(12.0),
                                child: MyExpansionTile(
                                  controller: flightPaxController,
                                  initiallyExpanded: true,
                                  backgroundColor: Color(0xffFAFAFB),
                                  collapsedBackgroundColor: Color(0xffFAFAFB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(28),
                                    side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                                  ),
                                  collapsedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(28),
                                    side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                                  ),
                                  childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                                  showTrailingIcon: true,
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text("Flight / Passenger", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  ),
                                  showFooter: false,
                                  children: [
                                    FlightWidget(report: true,),
                                    PassengerWidget(report: true,),
                                    PassportWidget(report: true,),
                                    VisaWidget(report: true,),
                                    ResidentWidget(report:true)],
                                ),
                              ),
                              ?resultMode
                                  ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: MyExpansionTile(
                                  initiallyExpanded: true,
                                  // controller: timaticController,
                                  showTrailingIcon: resultMode,
                                  backgroundColor: timaticRes == null ? Colors.white : timaticRes!.getRes.getColor.withOpacity(0.08),
                                  collapsedBackgroundColor: timaticRes == null ? Colors.white : timaticRes!.getRes.getColor.withOpacity(0.08),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(28),
                                    side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                                  ),
                                  collapsedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(28),
                                    side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                                  ),
                                  childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Text("TIMATIC ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                        resultMode
                                            ? Row(
                                          children: [
                                            timaticRes.getRes.getIconWidget,
                                            Text(timaticRes!.getRes.title, style: TextStyle(color: timaticRes.getRes.getColor)),
                                          ],
                                        )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                  showFooter: false,
                                  children: [
                                    Consumer(
                                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                        final result = ref.watch(reportTimaticResultNewProvider);
                                        if (result == null) {
                                          return SizedBox();
                                        }
                                        // return SizedBox(height: 100);
                                        return Column(
                                          children: [
                                            TimaticTrueResultWidgetNew(res: result),
                                            const SizedBox(height: 12),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                                  : null,
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Material(
                      child: Column(
                        children: [
                          HeaderSummaryWidget(
                            header: Column(
                              children: [
                                const SizedBox(height: 36, width: double.infinity),
                                Row(
                                  spacing: 12,
                                  children: [
                                    BackButton(),
                                    Text("Report Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // FigmaGlass(
                          //   // height: 124 + (resultMode ? additionalHeight : 0),
                          //   child: Container(
                          //     padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 16),
                          //     width: context.width,
                          //     decoration: BoxDecoration(
                          //       gradient: LinearGradient(colors: [MyColors.mainBlue.withOpacity(0.18), MyColors.mainBlue.withOpacity(0.02)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         const SizedBox(height: 36, width: double.infinity),
                          //         Row(
                          //           spacing: 12,
                          //           children: [
                          //             Consumer(
                          //               builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          //                 return Badge(
                          //                   isLabelVisible: ref.watch(notifCountProvider) > 0,
                          //                   label: Text("${ref.watch(notifCountProvider)}"),
                          //                   child: MyButton(
                          //                     label: "Menu",
                          //                     radius: 12,
                          //                     icon: Icons.menu,
                          //                     onPressed: () {
                          //                       flightsScaffoldKey.currentState!.openDrawer();
                          //                     },
                          //                     borderSide: BorderSide(color: MyColors.black8),
                          //                     color: Colors.white,
                          //                     textColor: Colors.black,
                          //                   ),
                          //                 );
                          //               },
                          //             ),
                          //             Spacer(),
                          //             // resultMode? MyButton(
                          //             //   label: "Option",
                          //             //   onPressed: () {
                          //             //     getIt<HomeController>().showOptionSheet();
                          //             //     // showModalBottomSheet(context: context, builder: (BuildContext context) {
                          //             //     //   return OptionSheetDialog();
                          //             //     // });
                          //             //   },
                          //             //   reverse: true,
                          //             //   borderSide: BorderSide(color: context.mainColor),
                          //             //   icon: ArtemisIcons.more_square,
                          //             // ):SizedBox(),
                          //             // resultMode
                          //             //     ? DotButton(
                          //             //         icon: ref.watch(currentStatusProvider).isLocked ? ArtemisIcons.lock : ArtemisIcons.unlock,
                          //             //         radius: 12,
                          //             //         size: 40,
                          //             //         onPressed: () async {
                          //             //           await getIt<HomeController>().setStatus(ref.watch(currentStatusProvider).isLocked ? 0 : 1);
                          //             //           // ref.read(timaticResultNewProvider.notifier).update((s) => s?.setStatus(timaticRes.isLocked ? 0 : 1));
                          //             //         },
                          //             //         border: BorderSide(color: context.mainColor),
                          //             //         flat: true,
                          //             //         color: context.mainColor,
                          //             //       )
                          //             //     : SizedBox(),
                          //             MyButton(
                          //               label: "Restart",
                          //               onPressed: () {
                          //                 getIt<HomeController>().clear();
                          //                 flightPaxController.expand();
                          //               },
                          //               radius: 12,
                          //               reverse: true,
                          //               borderSide: BorderSide(color: context.mainColor),
                          //               icon: ArtemisIcons.eraser_1,
                          //             ),
                          //           ],
                          //         ),
                          //         resultMode ? HeaderSummaryWidget() : SizedBox(),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Padding(padding: const EdgeInsets.all(12.0), child: HeaderAskSupervisorWidget()),
                        ],
                      ),
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

class HeaderSummaryWidget extends ConsumerWidget {
  final Widget header;

  const HeaderSummaryWidget({super.key, required this.header});

  Widget countryBuilderHeader(dynamic a) => a == null
      ? SizedBox()
      : Row(
    children: [
      Text("$a"),
      const SizedBox(width: 2),
      ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timaticRes = ref.watch(reportTimaticResultNewProvider);
    final bool resultMode = timaticRes != null;
    // log(tim.params.of(ParameterType.documentCode).map((a)=>"${a.code} -> ${a.name}").join("\n"));
    // final List<DocumentDetail> documentDetails = ref.watch(documentProvider);
    // final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> passports = ref.watch(reportPassportsProvider);
    final List<DocumentDetail> visas = ref.watch(reportVisasProvider);
    final List<DocumentDetail> residents = ref.watch(reportResidentsProvider);
    final PassengerDetails passengerDetails = ref.watch(reportPassengerProvider);
    final List<ItinerarySegment> segments = ref.watch(reportSegmentsProvider);
    bool isClosed = !ref.watch(reportCurrentStatusProvider).canUseOption;
    Color color = MyColors.mainBlue;
    final currentStatus = ref.watch(reportCurrentStatusProvider);
    // final logs = ref.watch(showingLogsProvider);
    // RefHistoryLog? airlineApproval = logs.lastOrNullWhere((a)=>a.type == "airlineApproval");
    // RefHistoryLog? supervisorApproval = logs.lastOrNullWhere((a)=>a.type == "supervisorResponse");
    // SupervisorResponse? finalResponse ;
    // if(supervisorApproval!=null){
    //   log(" has supervisorApproval");
    //   finalResponse = BasicClass.user?.setting?.supervisorResponse?.firstWhereOrNull((a)=>a.actionId == supervisorApproval.payload?.actionId);
    // }
    // if(airlineApproval!=null){
    //   log(" has airlineApproval");
    //
    //   finalResponse = BasicClass.user?.setting?.supervisorResponse?.firstWhereOrNull((a)=>a.actionId == airlineApproval.payload?.actionId);
    // }
    var gradiant = LinearGradient(colors: [color.withOpacity(0.18), color.withOpacity(0.02)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
    if (isClosed) {
      gradiant = LinearGradient(colors: [currentStatus!.getRes.getColor.withOpacity(0.48), currentStatus!.getRes.getColor.withOpacity(0.18)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
    }
    // if(finalResponse !=null){
    //   gradiant = LinearGradient(colors: [finalResponse.getColor.withOpacity(0.48), finalResponse.getColor.withOpacity(0.18)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
    // }
    // log(logs.map((l)=>l.type??'').join("*"));
    // log("final response ${finalResponse?.name}");
    return FigmaGlass(
      // height: 124 + (resultMode ? additionalHeight : 0),
      child: Container(
        padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 16),
        width: context.width,
        decoration: BoxDecoration(gradient: gradiant),
        child: Column(
          children: [
            header,
            resultMode
                ? Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                spacing: 8,
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      final res = ref.watch(reportTimaticResultNewProvider)!;
                      return Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                        child: Column(
                          children: [
                            Row(spacing: 12, children: [...res.segments.map((seg) => seg.routeWidget)]),
                          ],
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Flight: ", style: TextStyle(color: Colors.grey)),
                          AirlineLogo(segments.first.operatingCarrier?.code ?? '',key: Key(segments.first.operatingCarrier?.code ?? ''),size: 25,),
                          Text("${segments.first.operatingCarrier?.code ?? ''} ${segments.first.flnb ?? ''}"),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Date: ", style: TextStyle(color: Colors.grey)),
                          Text(segments.first.departure.dateTime?.format_ddMMM ?? ''),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Route: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text("${segments.first.departure.point ?? ''}-${segments.first.arrival.point ?? ''}", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    spacing: 12,
                    children: [
                      Row(
                        children: [
                          Text("Passport: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text(StringUtility.maskString(passports.firstOrNull?.documentNumber ?? ''), style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Tracking: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text(ref.watch(reportRefCodeShowProvider) ?? '', style: TextStyle(color: Colors.black)),
                          // timaticRes.getRes.getIconWidget,
                          // Text("${timaticRes.getRes.title}",style: TextStyle(fontSize: 12,color: timaticRes.getRes.getColor),),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadiusGeometry.circular(5),
                          //     color: timaticRes.evaluationResult.getColor.withOpacity(0.3),
                          //     border: Border.all(color: timaticRes.evaluationResult.getColor),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       const SizedBox(width: 8),
                          //       Text(ref.watch(refCodeProvider) ?? '', style: TextStyle(color: Colors.black)),
                          //       const SizedBox(width: 8),
                          //       Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadiusGeometry.circular(5),
                          //           color: timaticRes.evaluationResult.getColor,
                          //           border: Border.all(color: timaticRes.evaluationResult.getColor),
                          //         ),
                          //         padding: EdgeInsets.symmetric(horizontal: 4),
                          //         child: Text("${timaticRes.evaluationResult.name}", style: TextStyle(color: Colors.white)),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("EmployeeId: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text(ref.watch(reportCurrentStatusProvider)?.employeeId ?? '', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Nationality: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          countryBuilderHeader(passengerDetails.nationality??passports.firstOrNull?.nationality),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Resident: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          countryBuilderHeader(passengerDetails.residentCountryCode),
                        ],
                      ),
                      Row(
                        children: [
                          Text("VISA: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          countryBuilderHeader(visas.firstOrNull?.documentIssueCountry),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        spacing: 8,
        children: [
          Builder(
            builder: (BuildContext context) {
              final res = ref.watch(timaticResultNewProvider)!;
              return Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                child: Column(
                  children: [
                    Row(spacing: 12, children: [...res.segments.map((seg) => seg.routeWidget)]),
                  ],
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Flight: ", style: TextStyle(color: Colors.grey)),
                  Text("${segments.first.operatingCarrier?.code ?? ''} ${segments.first.flnb ?? ''}"),
                ],
              ),
              Row(
                children: [
                  Text("Date: ", style: TextStyle(color: Colors.grey)),
                  Text(segments.first.departure.dateTime.format_ddMMM ?? ''),
                ],
              ),
              Row(
                children: [
                  Text("Route: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text("${segments.first.departure.point ?? ''}-${segments.first.arrival.point ?? ''}", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          Row(
            spacing: 12,
            children: [
              Row(
                children: [
                  Text("Passport: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(passports.firstOrNull?.documentNumber ?? '', style: TextStyle(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  Text("Tracking: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(ref.watch(refCodeProvider) ?? '', style: TextStyle(color: Colors.black)),
                  // timaticRes.getRes.getIconWidget,
                  // Text("${timaticRes.getRes.title}",style: TextStyle(fontSize: 12,color: timaticRes.getRes.getColor),),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadiusGeometry.circular(5),
                  //     color: timaticRes.evaluationResult.getColor.withOpacity(0.3),
                  //     border: Border.all(color: timaticRes.evaluationResult.getColor),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       const SizedBox(width: 8),
                  //       Text(ref.watch(refCodeProvider) ?? '', style: TextStyle(color: Colors.black)),
                  //       const SizedBox(width: 8),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadiusGeometry.circular(5),
                  //           color: timaticRes.evaluationResult.getColor,
                  //           border: Border.all(color: timaticRes.evaluationResult.getColor),
                  //         ),
                  //         padding: EdgeInsets.symmetric(horizontal: 4),
                  //         child: Text("${timaticRes.evaluationResult.name}", style: TextStyle(color: Colors.white)),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              Row(
                children: [
                  Text("EmployeeId: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(ref.watch(currentStatusProvider)?.employeeId ?? '', style: TextStyle(color: Colors.black)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Nationality: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  countryBuilderHeader(passengerDetails.nationality),
                ],
              ),
              Row(
                children: [
                  Text("Resident: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  countryBuilderHeader(passengerDetails.residentCountryCode),
                ],
              ),
              Row(
                children: [
                  Text("VISA: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  countryBuilderHeader(visas.firstOrNull?.documentIssueCountry),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResultReportAppBar extends StatelessWidget implements PreferredSizeWidget {
  static ResultReportController myResultReportController = getIt<ResultReportController>();
  static SmartOverlayMenuController controller = SmartOverlayMenuController();
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ResultReportAppBar({super.key, required this.scaffoldKey});

  @override
  Size get preferredSize => const Size.fromHeight(104);

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
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),

                        Spacer(),

                      ],
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