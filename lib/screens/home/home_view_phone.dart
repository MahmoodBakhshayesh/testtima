import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/interfaces/controller_int.dart';
import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:abds/core/navigation/routes.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
import 'package:abds/core/utils_and_services/operations/confirm_operation.dart';
import 'package:abds/core/utils_and_services/time_picker/ui_permission.dart';
import 'package:abds/screens/home/dialogs/manul_add_doc_sheet.dart';
import 'package:abds/screens/home/dialogs/option_sheet_dialog.dart';
import 'package:abds/screens/home/dialogs/photo_preview_dialog.dart';
import 'package:abds/screens/home/dialogs/requested_data_dialog.dart';
import 'package:abds/screens/home/dialogs/voice_preview_dialog.dart';
import 'package:abds/screens/home/home_drawer.dart';
import 'package:abds/screens/home/new_widgets/flight_widget.dart';
import 'package:abds/screens/home/new_widgets/passenger_widget.dart';
import 'package:abds/screens/home/new_widgets/passport_widget.dart';
import 'package:abds/screens/home/new_widgets/resident_widget.dart';
import 'package:abds/screens/home/new_widgets/visa_widget.dart';
import 'package:abds/screens/home/widgets/logs_and_attachments.dart';
import 'package:abds/screens/login/login_controller.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_controller.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/DurationOfStayPicker.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyDatePicker.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MySwitchButton.dart';
import 'package:abds/widgets/MyTextField.dart';
import 'package:abds/widgets/check_permission.dart';
import 'package:abds/widgets/user_avatar.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
import 'package:dio/dio.dart';
import 'package:ferry/typed_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_overlay_menu/smart_overlay_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/classes/timatic_response_new_class.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/residents_state_controller.dart';
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../../core/utils_and_services/string_utility.dart';
import '../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../initialize.dart';
import '../../widgets/MyExpansionTile.dart';
import '../../widgets/MyTimePicker.dart';
import '../../widgets/glass_widget.dart';
import '../mrz_reader/dialogs/support_warning_dialog.dart';
import 'home_controller.dart';
import 'home_state.dart';
import 'home_view_phone_old.dart';
import 'widgets/passport_section.dart';
import 'widgets/resident_section.dart';
import 'widgets/timatic_response_widget.dart';
import 'widgets/visa_section.dart';

String? expiryValidator(String v, DateTime? expiry) {
  bool isExpired = expiry != null && expiry.difference(DateTime.now()).inDays < -1;

  bool isExpiryFake = (expiry?.difference(DateTime(1, 1, 1)).inDays ?? 100) < 1;

  bool isExpiring = !isExpired && expiry != null && expiry!.difference(DateTime.now()).inDays.abs() < 180;

  int? expiryRemain = expiry == null ? null : -(DateTime.now().difference(expiry!).inDays);
  int? expiredDays = expiry == null ? null : (DateTime.now().difference(expiry!).inDays);

  if (isExpiryFake) {
    return "Document(s) expiry date is unreadable !";
  } else if (isExpired) {
    return "Expired: ${StringUtility.formatDaysToYearsMonths(expiredDays)}";
  } else if (isExpiring) {
    return "Expiring: ${StringUtility.formatDaysToYearsMonths(expiryRemain)}";
  } else if (expiry != null) {
    int remaining = expiry.difference(DateTime.now()).inDays;

    return "Valid: ${StringUtility.formatDaysToYearsMonths(remaining)}";
  }

  return null;
}

Color? expiryValidationColor(DateTime? expiry) {
  bool isExpired = expiry != null && expiry!.isBefore(DateTime.now());

  bool isExpiryFake = (expiry?.difference(DateTime(1, 1, 1)).inDays ?? 100) < 1;

  bool isExpiring = !isExpired && expiry != null && expiry!.difference(DateTime.now()).inDays.abs() < 180;

  int? expiryRemain = expiry == null ? null : -(DateTime.now().difference(expiry!).inDays);
  int? expiredDays = expiry == null ? null : (DateTime.now().difference(expiry!).inDays);

  if (isExpiryFake) {
    return Colors.red;
  } else if (isExpired) {
    return Colors.red;
  } else if (isExpiring) {
    return Colors.orange;
  } else if (expiry != null) {
    int remaining = expiry.difference(DateTime.now()).inDays;

    return MyColors.green2;
  }

  return null;
}

Color? visaExpiryValidationColor(DateTime? expiry) {
  bool isExpired = expiry != null && expiry!.isBefore(DateTime.now());

  bool isExpiryFake = (expiry?.difference(DateTime(1, 1, 1)).inDays ?? 100) < 1;

  bool isExpiring = !isExpired && expiry != null && expiry!.difference(DateTime.now()).inDays.abs() < 180;

  int? expiryRemain = expiry == null ? null : -(DateTime.now().difference(expiry!).inDays);
  int? expiredDays = expiry == null ? null : (DateTime.now().difference(expiry!).inDays);

  if (isExpiryFake) {
    return Colors.red;
  } else if (isExpired) {
    return Colors.red;
  } else if (isExpiring) {
    return MyColors.green2;
  } else if (expiry != null) {
    int remaining = expiry.difference(DateTime.now()).inDays;

    return MyColors.green2;
  }

  return null;
}

IconData? expiryValidationIcon(DateTime? expiry) {
  bool isExpired = expiry != null && expiry!.isBefore(DateTime.now());

  bool isExpiryFake = (expiry?.difference(DateTime(1, 1, 1)).inDays ?? 100) < 1;

  bool isExpiring = !isExpired && expiry != null && expiry!.difference(DateTime.now()).inDays.abs() < 180;

  int? expiryRemain = expiry == null ? null : -(DateTime.now().difference(expiry!).inDays);
  int? expiredDays = expiry == null ? null : (DateTime.now().difference(expiry!).inDays);

  if (isExpiryFake) {
    return ArtemisIcons.danger;
  } else if (isExpired) {
    return ArtemisIcons.danger;
  } else if (isExpiring) {
    return ArtemisIcons.warning_2;
  } else if (expiry != null) {
    int remaining = expiry.difference(DateTime.now()).inDays;

    return ArtemisIcons.tick_square;
  }

  return null;
}

IconData? visaExpiryValidationIcon(DateTime? expiry) {
  bool isExpired = expiry != null && expiry!.isBefore(DateTime.now());

  bool isExpiryFake = (expiry?.difference(DateTime(1, 1, 1)).inDays ?? 100) < 1;

  bool isExpiring = !isExpired && expiry != null && expiry!.difference(DateTime.now()).inDays.abs() < 180;

  int? expiryRemain = expiry == null ? null : -(DateTime.now().difference(expiry!).inDays);
  int? expiredDays = expiry == null ? null : (DateTime.now().difference(expiry!).inDays);

  if (isExpiryFake) {
    return ArtemisIcons.danger;
  } else if (isExpired) {
    return ArtemisIcons.danger;
  } else if (isExpiring) {
    return ArtemisIcons.tick_square;
  } else if (expiry != null) {
    int remaining = expiry.difference(DateTime.now()).inDays;

    return ArtemisIcons.tick_square;
  }

  return null;
}

String? birthDateValidator(String v, DateTime? bDate) {
  if (bDate == null) return null;
  int years = (bDate.difference(DateTime.now()).inDays / 365).floor().abs();
  String s = StringUtility.formatDaysToAge(bDate.difference(DateTime.now()).inDays.abs());
  return s;
  if (years > 0) {
    return "$s years old";
  } else {
    int mounts = (bDate.difference(DateTime.now()).inDays / 12).floor().abs();
    return "$mounts months old";
  }

  return null;
}

Color? birthDateValidationColor(DateTime? bDate) {
  if (bDate == null) return null;
  int years = (bDate.difference(DateTime.now()).inDays / 365).floor().abs();
  double realYears = (bDate.difference(DateTime.now()).inDays / 365).abs();
  // log("realYears $realYears");
  if (realYears < 2) {
    return Colors.orange;
  }
  if (realYears <= 12) {
    return Colors.orange;
  }
  return MyColors.green2;
}

class HomeViewPhone extends ConsumerStatefulWidget {
  static HomeController myHomeController = getIt<HomeController>();

  const HomeViewPhone({super.key});

  @override
  ConsumerState<HomeViewPhone> createState() => _HomeViewPhoneState();
}

class _HomeViewPhoneState extends ConsumerState<HomeViewPhone> {
  late GlobalKey<ScaffoldState> flightsScaffoldKey;
  ExpansibleController flightPaxController = ExpansibleController();
  ExpansibleController timaticController = ExpansibleController();

  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    flightsScaffoldKey = GlobalKey<ScaffoldState>();
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
    final timaticRes = ref.watch(timaticResultNewProvider);

    // log(tim.params.of(ParameterType.documentCode).map((a)=>"${a.code} -> ${a.name}").join("\n"));
    // final List<DocumentDetail> documentDetails = ref.watch(documentProvider);
    // final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> visas = ref.watch(visasProvider);
    final List<DocumentDetail> residents = ref.watch(residentsProvider);
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    final List<ItinerarySegment> segments = ref.watch(segmentsProvider);
    // log("passes ${passports.length}");
    // log("visas ${visas.length}");
    bool resultMode = timaticRes != null;
    bool canCheck = segments.any((a) => a.arrival.point.isNotEmpty && a.departure.point.isNotEmpty && (a.flnb??"").isNotEmpty && a.operatingCarrier != null);
    // bool foundPassInVisa = passports.any((p)=>p.documentNumber!=null && (ref.read(lastVisaOcrProvider)?.text??'').contains(p.documentNumber??'-------------------'));
    double additionalHeight = 120;

    return PopScope(
      canPop: false,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          bottom: true,
          top: false,
          child: Scaffold(
            key: flightsScaffoldKey,
            // appBar: HomeAppBar(scaffoldKey: flightsScaffoldKey),
            drawer: HomeDrawer(),
            body: Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 124 + (resultMode ? additionalHeight : 0)),
                              LogsAndAttachmentsWidget(),
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
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text("Flight / Passenger", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  ),
                                  showFooter: false,
                                  children: [
                                    FlightWidget(),
                                    const SizedBox(height: 12),
                                    PassengerWidget(),
                                    const SizedBox(height: 12),
                                    PassportWidget(),
                                    const SizedBox(height: 12),
                                    VisaWidget(),
                                    const SizedBox(height: 12),
                                    ResidentWidget(),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: MyExpansionTile(
                                  controller: timaticController,
                                  backgroundColor: timaticRes == null ? Colors.white : timaticRes!.evaluationResult.getColor.withOpacity(0.08),
                                  collapsedBackgroundColor: timaticRes == null ? Colors.white : timaticRes!.evaluationResult.getColor.withOpacity(0.08),
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
                                                  Text(" ● ", style: TextStyle(color: Colors.grey, fontSize: 7)),
                                                  Text(
                                                    "Eligibility #: ",
                                                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
                                                  ),
                                                  timaticRes.evaluationResult.getIconWidget,
                                                  Text(timaticRes!.evaluationResult.name,style: TextStyle(color: timaticRes.evaluationResult.getColor),),
                                                  // Text("${ref.watch(timaticResultProvider)!.refCode}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
                                        final result = ref.watch(timaticResultNewProvider);
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
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 12,
                    left: 12,
                    child: Material(
                      borderRadius: BorderRadius.circular(18),
                      elevation: 2,
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [BoxShadow(spreadRadius: 0, blurRadius: 34, color: Colors.black.withOpacity(0.16))],
                        ),
                        child: timaticRes?.isLocked??false
                            ? Row(
                                children: [
                                  Expanded(
                                    child: MyButton(
                                      label: "Options",
                                      fontSize: 12,
                                      iconSize: 15,
                                      onPressed: !resultMode
                                          ? null
                                          : () {
                                              getIt<HomeController>().showOptionSheet();
                                            },
                                      radius: 10,
                                      borderSide: BorderSide(color: context.mainColor),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                spacing: 8,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: MyButton(
                                      label: "Options",
                                      fontSize: 12,
                                      iconSize: 15,
                                      onPressed: !resultMode
                                          ? null
                                          : () {
                                              getIt<HomeController>().showOptionSheet();
                                            },
                                      radius: 10,
                                      borderSide: BorderSide(color: context.mainColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: MyButton(
                                      label: "Manual",
                                      fontSize: 12,
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ManualAddDocumentSheet();
                                          },
                                        );
                                      },

                                      radius: 10,
                                      borderSide: BorderSide(color: context.mainColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: MyButton(
                                      label: "Scan",
                                      fontSize: 12,
                                      iconSize: 15,
                                      onPressed: () {
                                        // getIt<MrzReaderController>().askActiveSupport(context);
                                        HomeViewPhone.myHomeController.goMrzReadr();
                                      },
                                      radius: 10,
                                      icon: ArtemisIcons.scan,
                                    ),
                                  ),
                                  Expanded(
                                    child: MyButton(
                                      label: "TIMATIC",
                                      iconInRight: true,
                                      iconSize: 12,
                                      fontSize: 12,
                                      onPressed: !canCheck
                                          ? null
                                          : () async {
                                              final timResult = await getIt<HomeController>().timatic();
                                              if (timResult != null) {
                                                ref.read(timaticResultNewProvider.notifier).update((s) => timResult);
                                                flightPaxController.collapse();
                                                timaticController.expand();
                                              }
                                            },
                                      radius: 12,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Material(
                      child: Column(
                        children: [
                          FigmaGlass(
                            // height: 124 + (resultMode ? additionalHeight : 0),
                            child: Container(
                              padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 16),
                              width: context.width,
                              decoration: BoxDecoration(
                                color: resultMode ? timaticRes!.evaluationResult.getColor.withOpacity(0.28) : null,
                                border: Border(bottom: BorderSide(color: resultMode ? timaticRes!.evaluationResult.getColor : Colors.white, width: 2)),

                                // color: Colors.red
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 36, width: double.infinity),
                                  Row(
                                    spacing: 12,
                                    children: [
                                      Consumer(
                                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                          return Badge(
                                            isLabelVisible: ref.watch(notifCountProvider) > 0,
                                            label: Text("${ref.watch(notifCountProvider)}"),
                                            child: MyButton(
                                              label: "Menu",
                                              radius: 12,
                                              icon: Icons.menu,
                                              onPressed: () {
                                                flightsScaffoldKey.currentState!.openDrawer();
                                              },
                                              borderSide: BorderSide(color: MyColors.black8),
                                              color: Colors.white,
                                              textColor: Colors.black,
                                            ),
                                          );
                                        },
                                      ),
                                      Spacer(),
                                      // resultMode? MyButton(
                                      //   label: "Option",
                                      //   onPressed: () {
                                      //     getIt<HomeController>().showOptionSheet();
                                      //     // showModalBottomSheet(context: context, builder: (BuildContext context) {
                                      //     //   return OptionSheetDialog();
                                      //     // });
                                      //   },
                                      //   reverse: true,
                                      //   borderSide: BorderSide(color: context.mainColor),
                                      //   icon: ArtemisIcons.more_square,
                                      // ):SizedBox(),
                                      MyButton(
                                        label: "Restart",
                                        onPressed: () {
                                          getIt<HomeController>().clear();
                                          flightPaxController.expand();
                                        },
                                        reverse: true,
                                        borderSide: BorderSide(color: context.mainColor),
                                        icon: ArtemisIcons.eraser_1,
                                      ),
                                    ],
                                  ),
                                  resultMode
                                      ? Padding(
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
                                                        Row(
                                                          spacing: 12,
                                                          children: [
                                                            ...res.segments.map(
                                                              (seg) => Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadiusGeometry.circular(4),
                                                                  color: seg.segmentEvaluationResult.getColor,
                                                                  border: Border.all(color: seg.segmentEvaluationResult.getColor),
                                                                ),
                                                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(seg.segmentEvaluationResult.getIconCircle, color: Colors.white, size: 15),
                                                                    const SizedBox(width: 4),
                                                                    Text(
                                                                      "${seg.route}",
                                                                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
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
                                                      Text("${segments.first.departure.dateTime.format_ddMMM ?? ''}"),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Route: ", style: TextStyle(color: Colors.grey)),
                                                      Text("${segments.first.departure.point ?? ''}-${segments.first.arrival.point ?? ''}"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                spacing: 12,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Passport: ", style: TextStyle(color: Colors.grey)),
                                                      Text("${passports.firstOrNull?.documentNumber ?? ''}"),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Tracking: ", style: TextStyle(color: Colors.grey)),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadiusGeometry.circular(5),
                                                          color: timaticRes.evaluationResult.getColor.withOpacity(0.3),
                                                          border: Border.all(color: timaticRes.evaluationResult.getColor),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(width: 8),
                                                            Text(ref.watch(refCodeProvider) ?? '', style: TextStyle(color: Colors.black)),
                                                            const SizedBox(width: 8),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadiusGeometry.circular(5),
                                                                color: timaticRes.evaluationResult.getColor,
                                                                border: Border.all(color: timaticRes.evaluationResult.getColor),
                                                              ),
                                                              padding: EdgeInsets.symmetric(horizontal: 4),
                                                              child: Text("${timaticRes.evaluationResult.name}", style: TextStyle(color: Colors.white)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
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
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(12.0), child: HeaderAskSupervisorWidget()),
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

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  static HomeController myHomeController = getIt<HomeController>();
  static SmartOverlayMenuController controller = SmartOverlayMenuController();
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeAppBar({super.key, required this.scaffoldKey});

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
                        Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            return Badge(
                              isLabelVisible: ref.watch(notifCountProvider) > 0,
                              label: Text("${ref.watch(notifCountProvider)}"),
                              child: MyButton(
                                label: "Menu",
                                radius: 12,
                                icon: Icons.menu,
                                onPressed: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                                borderSide: BorderSide(color: MyColors.black8),
                                color: Colors.white,
                                textColor: Colors.black,
                              ),
                            );
                          },
                        ),

                        Spacer(),

                        Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            return MyButton(
                              borderSide: BorderSide(color: MyColors.mainColor),
                              radius: 12,
                              reverse: true,
                              fontWeight: FontWeight.w700,
                              label: 'History',
                              onPressed: () async {
                                await myHomeController.askRefCodeDialog(context);
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 12),
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

// class TimaticTrueResultWidget extends ConsumerStatefulWidget {
//   final DocumentResponse res;
//
//   const TimaticTrueResultWidget({super.key, required this.res});
//
//   @override
//   ConsumerState<TimaticTrueResultWidget> createState() => _TimaticTrueResultWidgetState();
// }
//
// class _TimaticTrueResultWidgetState extends ConsumerState<TimaticTrueResultWidget> {
//   ExpansibleController expansibleController = ExpansibleController();
//
//   @override
//   Widget build(BuildContext context) {
//     final List<DocumentDetail> passports = ref.watch(passportsProvider);
//     // final List<DocumentDetail> visas = ref.watch(visasProvider);
//     // final List<DocumentDetail> residents = ref.watch(residentsProvider);
//     final PassengerDetails passengerDetails = ref.watch(passengerProvider);
//     final List<ItinerarySegment> segments = ref.watch(segmentsProvider);
//     final showingLogs = ref.watch(showingLogsProvider);
//     return Column(
//       // shrinkWrap: true,
//       children: [
//         // showingLogs.isEmpty
//         //     ? SizedBox()
//         //     : MyExpansionTile(
//         //         controller: expansibleController,
//         //         key: Key("showing logs exp"),
//         //         tilePadding: EdgeInsets.symmetric(horizontal: 0),
//         //         showFooter: false,
//         //         title: Container(
//         //           // margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
//         //           decoration: BoxDecoration(color: widget.res.evaluationResult.getColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
//         //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//         //           child: Column(
//         //             children: [
//         //               Container(
//         //                 padding: EdgeInsets.symmetric(vertical: 4),
//         //                 decoration: BoxDecoration(
//         //                   borderRadius: BorderRadius.circular(5),
//         //                   border: Border.all(color: MyColors.black8),
//         //                 ),
//         //                 child: Text("Note And Attachments"),
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //         childrenPadding: EdgeInsets.symmetric(horizontal: 16),
//         //         children: showingLogs.map((l) {
//         //           return Container(
//         //             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//         //             decoration: BoxDecoration(border: Border.all(color: MyColors.lineColor)),
//         //             child: Row(
//         //               children: [
//         //                 Expanded(
//         //                   child: Column(
//         //                     crossAxisAlignment: CrossAxisAlignment.start,
//         //                     children: [
//         //                       Row(
//         //                         children: [
//         //                           Expanded(
//         //                             child: Text(("${l.payload?.title ?? ''} (${(l.type ?? '')})").toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//         //                           ),
//         //                           Text(l.user?.username ?? l.user?.email ?? '', style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
//         //                         ],
//         //                       ),
//         //                       Padding(
//         //                         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         //                         child: Row(
//         //                           children: [
//         //                             Expanded(
//         //                               child: Text((l.payload?.description ?? '').toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
//         //                             ),
//         //                           ],
//         //                         ),
//         //                       ),
//         //                       (l.payload?.attachFiles ?? []).isEmpty
//         //                           ? SizedBox()
//         //                           : Row(
//         //                               children: [
//         //                                 Expanded(
//         //                                   child: Wrap(
//         //                                     children: [
//         //                                       ...(l.payload?.attachFiles ?? []).map((img) {
//         //                                         bool isVoice = img.endsWith("m4a");
//         //                                         if (isVoice) {
//         //                                           return Padding(
//         //                                             padding: const EdgeInsets.only(left: 8.0),
//         //                                             child: DotButton(
//         //                                               size: 40,
//         //                                               icon: Icons.record_voice_over,
//         //                                               onPressed: () async {
//         //                                                 String dlUrl = "${ref.read(selectedServerProvider)!.apiAddress}/logs/attach/${img}";
//         //                                                 final f = await getIt<HomeController>().getFile(url: dlUrl);
//         //                                                 log(f.path);
//         //                                                 showDialog(
//         //                                                   context: context,
//         //                                                   builder: (BuildContext context) {
//         //                                                     return VoicePreviewDialog(address: f.path);
//         //                                                   },
//         //                                                 );
//         //                                               },
//         //                                             ),
//         //                                           );
//         //                                         }
//         //                                         log(img);
//         //                                         return GestureDetector(
//         //                                           onTap: () {
//         //                                             showDialog(
//         //                                               context: context,
//         //                                               builder: (BuildContext context) {
//         //                                                 return PhotoPreviewDialog(address: img);
//         //                                               },
//         //                                             );
//         //                                           },
//         //                                           child: SizedBox(
//         //                                             width: 40,
//         //                                             height: 40,
//         //                                             child: ClipRRect(
//         //                                               borderRadius: BorderRadiusGeometry.circular(5),
//         //                                               child: Image.network(
//         //                                                 "${ref.read(selectedServerProvider)!.apiAddress}/logs/attach/$img",
//         //                                                 fit: BoxFit.fill,
//         //                                                 headers: {"Authorization": "Bearer ${ref.read(userProvider)!.token}"},
//         //                                               ),
//         //                                             ),
//         //                                           ),
//         //                                         );
//         //                                       }).toList(),
//         //                                     ],
//         //                                   ),
//         //                                 ),
//         //                                 Column(
//         //                                   children: [
//         //                                     Text(l.at?.toLocal().format_ddMMMEEE ?? '', style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
//         //                                     Text(l.at?.toLocal().format_HHmmss ?? '', style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
//         //                                   ],
//         //                                 ),
//         //                               ],
//         //                             ),
//         //                     ],
//         //                   ),
//         //                 ),
//         //               ],
//         //             ),
//         //           );
//         //         }).toList(),
//         //       ),
//         ...widget.res.segmentResults.map((segRes) {
//           int index = widget.res.segmentResults.indexOf(segRes);
//           segRes.ruleSetEvaluations.sort((a, b) => a.evaluationResult.index.compareTo(b.evaluationResult.index));
//           return MyExpansionTile(
//             initiallyExpanded: segRes.ruleSetEvaluations.any((a) => a.evaluationResult.index < 2),
//             tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
//             collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
//             backgroundColor: Colors.white,
//             collapsedBackgroundColor: Colors.white,
//             showFooter: false,
//             title: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: segRes.segmentEvaluationResult.getColor.withOpacity(0.12)),
//                     color: segRes.segmentEvaluationResult.getColor.withOpacity(0.08),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         // decoration: BoxDecoration(color: segRes.segmentEvaluationResult.getColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
//                         padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                         child: Row(
//                           children: [
//                             Text(
//                               "Seg #${index + 1} ",
//                               style: TextStyle(color: segRes.segmentEvaluationResult.getColor, fontWeight: FontWeight.bold),
//                             ),
//                             Spacer(),
//                             Text(segRes.departure.point),
//                             Icon(Icons.arrow_right_alt),
//                             Text(segRes.arrival.point),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       FittedBox(
//                         fit: BoxFit.fitWidth,
//                         child: Text(segRes.segmentEvaluationResult.getTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.only(bottom: 8.0),
//                       //   child: Text(
//                       //     segRes.segmentEvaluationResult.getSubtitle,
//                       //     style: TextStyle(color: segRes.segmentEvaluationResult.getColor, fontWeight: FontWeight.w400),
//                       //   ),
//                       // ),
//                       // const SizedBox(height: 4),
//                       Container(
//                         height: 72,
//                         decoration: BoxDecoration(color: segRes.segmentEvaluationResult.getColor, borderRadius: BorderRadius.circular(12)),
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(segRes.segmentEvaluationResult.getIcon, color: Colors.white, size: 25),
//                               const SizedBox(width: 4),
//                               Text(
//                                 segRes.segmentEvaluationResult.getSubtitle,
//                                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             children: [
//               segRes.commonBorder == null ? const SizedBox() : CommonBorderWidget(commonBorder: segRes.commonBorder!),
//               ...segRes.ruleSetEvaluations.map((rs) => RuleSetWidget(ruleSet: rs)),
//               const SizedBox(height: 12),
//             ],
//           );
//         }).toList(),
//       ],
//     );
//   }
// }
//
// class RuleSetWidget extends StatelessWidget {
//   final RuleSetEvaluation ruleSet;
//
//   const RuleSetWidget({super.key, required this.ruleSet});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 14, right: 14.0, top: 14),
//       child: MyExpansionTile(
//         // initiallyExpanded: ruleSet.evaluationResult.index < 2,
//         showFooter: false,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(color: ruleSet.getColor.withOpacity(0.12)),
//         ),
//         collapsedShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(color: ruleSet.getColor.withOpacity(0.12)),
//         ),
//         backgroundColor: ruleSet.getColor.withOpacity(0.08),
//         collapsedBackgroundColor: ruleSet.getColor.withOpacity(0.08),
//         tilePadding: EdgeInsets.symmetric(horizontal: 8),
//         childPreview: true?null:ruleSet.evaluationResult.index > 1
//             ? null
//             : Column(
//                 children: [
//                   ...ruleSet.regulations.map(
//                     (a) => Column(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(top: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(a.regulationResult??'', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//                               ),
//                               Text(a.title??'', style: TextStyle(fontSize: 12, color: BasicClass.getColorForEvaluationResult(a.regulationResult.toString()))),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // ...ruleSet.documentResults.map(
//                   //   (a) => Column(
//                   //     children: a.regulations
//                   //         .map(
//                   //           (a) => Container(
//                   //             margin: EdgeInsets.only(top: 8),
//                   //             child: Row(
//                   //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //               children: [
//                   //                 Expanded(
//                   //                   child: Text(a.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//                   //                 ),
//                   //                 Text(a.evaluationResult.name, style: TextStyle(fontSize: 12, color: BasicClass.getColorForEvaluationResult(a.evaluationResult.name.toString()))),
//                   //               ],
//                   //             ),
//                   //           ),
//                   //         )
//                   //         .toList(),
//                   //   ),
//                   // ),
//                 ],
//               ),
//         title: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(ruleSet.title??'', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(4),
//                   decoration: BoxDecoration(color: ruleSet.getColor.withOpacity(0.08), borderRadius: BorderRadius.circular(5)),
//                   child: Row(
//                     children: [
//                       Icon(ruleSet.getIcon, color: ruleSet.getColor, size: 20),
//                       const SizedBox(width: 4),
//                       Text(
//                         ruleSet.title??'',
//                         style: TextStyle(color: ruleSet.getColor, fontSize: 12, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             // Text("ada")
//           ],
//         ),
//         childrenPadding: EdgeInsets.zero,
//         children: [
//           ...ruleSet.regulations.map((r) => RegulationWidget(regulation: r)).toList(),
//           // ...ruleSet.documentResults.map((r) => DocumentResultWidget(docRes: r)).toList(),
//         ],
//       ),
//     );
//   }
// }
//
// class RegulationWidget extends StatelessWidget {
//   late Regulation regulation;
//
//   RegulationWidget({super.key, required this.regulation});
//
//   //final TimaticController myTimaticController = getIt<TimaticController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text('${regulation.regulationResult} ', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//               ),
//               Text(regulation.title??'', style: TextStyle(color: BasicClass.getColorForEvaluationResult(regulation.regulationResult??''), fontSize: 12)),
//             ],
//           ),
//           const Divider(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: (regulation.texts ?? [])
//                 .map(
//                   (e) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 5,
//                           child: Column(
//                             children:
//                                 <Widget>[] +
//                                 /*e.categories
//                                         .map(
//                                           (cat) => Text(cat.name),
//                                         )
//                                         .toList() +
//                                     e.categories.map((itf) {
//                                       return itf.hrefField == null
//                                           ? const SizedBox()
//                                           : TextButton(
//                                               style: TextButton.styleFrom(backgroundColor: Colors.transparent),
//                                               onPressed: () async {
//                                                 await launch(itf.hrefField ?? "");
//                                               },
//                                               child: Text(
//                                                 itf.hrefField ?? "",
//                                                 style: const TextStyle(decoration: TextDecoration.underline, color: Colors.blueAccent),
//                                               ));
//                                     }).toList() +*/
//                                 [HtmlWidget(e, onTapUrl: (p0) => launch(p0))],
//                           ),
//                         ),
//                         /*const SizedBox(width: 4),
//                           Expanded(
//                             flex: 2,
//                             child: Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(4),
//                                 //color: e.color,
//                               ),
//                               child: Center(child: Text(e.verificationMethod, style: const TextStyle(color: Colors.white))),
//                             ),
//                           )*/
//                       ],
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DocumentResultWidget extends StatelessWidget {
//   late DocumentResult docRes;
//
//   DocumentResultWidget({super.key, required this.docRes});
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//
//     return Container(
//       padding: const EdgeInsets.all(4),
//       margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
//       // decoration: BoxDecoration(
//       //   borderRadius: BorderRadius.circular(4),
//       //   border: Border.all(color: MyColors.travelDocColor),
//       //   color: MyColors.travelDocColor.withOpacity(0.10),
//       // ),
//       child: SizedBox(
//         width: width,
//         child: Column(
//           children:
//               <Widget>[] +
//               [
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: docRes.evaluationResult.getColor.withOpacity(0.4)),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text('Evaluation Result for Document No. ${((docRes.documentIndex ?? 0) + 1)}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
//                       ),
//                       Icon(docRes.evaluationResult.getIcon, size: 15, color: BasicClass.getColorForEvaluationResult(docRes.evaluationResult.name.toString())),
//                       Text(docRes.evaluationResult.name, style: TextStyle(fontSize: 12, color: BasicClass.getColorForEvaluationResult(docRes.evaluationResult.name.toString()))),
//                     ],
//                   ),
//                 ),
//               ] +
//               (docRes.regulations.map((s2) => RegulationWidget(regulation: s2)).toList()),
//         ),
//       ),
//     );
//   }
// }
//
// class CommonBorderWidget extends StatelessWidget {
//   final CommonBorder commonBorder;
//
//   const CommonBorderWidget({super.key, required this.commonBorder});
//
//   @override
//   Widget build(BuildContext context) {
//     return MyExpansionTile(
//       showFooter: false,
//       title: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: MyColors.greenBg.withOpacity(0.08),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: MyColors.greenBg.withOpacity(0.12)),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(commonBorder.runtimeType.toString() ?? '', style: TextStyle(fontWeight: FontWeight.w600)),
//             ),
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(color: BasicClass.getColorForEvaluationResult(""), borderRadius: BorderRadius.circular(12)),
//               child: Row(
//                 children: [Text(commonBorder.value ?? '', style: TextStyle(color: Colors.white))],
//               ),
//             ),
//           ],
//         ),
//       ),
//       children: [Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), child: Text(commonBorder!.text ?? ''))],
//     );
//   }
// }
