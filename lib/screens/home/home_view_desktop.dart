import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/classes/ref_history_log_class.dart';
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
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:abds/widgets/check_permission.dart';
import 'package:abds/widgets/user_avatar.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags_pro/country_flags_pro.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:ferry/typed_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_overlay_menu/smart_overlay_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/classes/supervisor_class.dart';
import '../../core/classes/timatic_response_new_class.dart';
import '../../core/utils_and_services/country_flag_util.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/residents_state_controller.dart';
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../../core/utils_and_services/string_utility.dart';
import '../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../initialize.dart';
import '../../widgets/AirlineLogo.dart';
import '../../widgets/MyExpansionTile.dart';
import '../../widgets/MyTimePicker.dart';
import '../../widgets/glass_widget.dart';
import '../mrz_reader/dialogs/support_warning_dialog.dart';
import 'dialogs/agent_decision_sheet.dart';
import 'dialogs/ask_supervisor_sheet.dart';
import 'dialogs/attach_photo_sheet.dart';
import 'dialogs/manager_approval_sheet.dart';
import 'home_controller.dart';
import 'home_state.dart';
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
  if (years >= 12) {
    return null;
  }
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

class HomeViewDesktop extends ConsumerStatefulWidget {
  static HomeController myHomeController = getIt<HomeController>();

  const HomeViewDesktop({super.key});

  @override
  ConsumerState<HomeViewDesktop> createState() => _HomeViewDesktopState();
}

class _HomeViewDesktopState extends ConsumerState<HomeViewDesktop> {
  late GlobalKey<ScaffoldState> flightsScaffoldKey;
  ExpansibleController flightPaxController = ExpansibleController();
  ExpansibleController timaticController = ExpansibleController();
  ScrollController scrollController = ScrollController();

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
            MyCountryFlagsPro.getFlag(a,width: 22,height: 16,borderRadius: BorderRadius.circular(2)),
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
            MyCountryFlagsPro.getFlag(a.country!,width: 22,height: 16,borderRadius: BorderRadius.circular(2)),
          ],
        );

  CustomPopupMenuController _controller = CustomPopupMenuController();

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
    bool hasAnyDocs = passports.isNotEmpty || visas.isNotEmpty || residents.isNotEmpty;
    final controller = SmartOverlayMenuController();

    //
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
    final currentStatus = ref.watch(currentStatusProvider);
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
                        child: CustomMaterialIndicator(
                          onRefresh: () async => await getIt<HomeController>().refreshResults(), // Your refresh logic
                          backgroundColor: Colors.white,
                          indicatorBuilder: (context, controller) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SpinKitChasingDots(size: 40, color: Colors.black45),
                            );
                          },
                          child: CheckPermission(
                            permission: TimaticUiPermission.read(),

                            child: Column(
                              children: [
                                SizedBox(height: 124 + (0)),

                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                LogsAndAttachmentsWidget(),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                  child: MyExpansionTile(
                                                    controller: flightPaxController,
                                                    initiallyExpanded: true,
                                                    backgroundColor: Colors.white.withOpacity(0.5),
                                                    collapsedBackgroundColor: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadiusGeometry.circular(28),
                                                      side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                                                    ),
                                                    collapsedShape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadiusGeometry.circular(28),
                                                      side: BorderSide(color: Colors.white.withOpacity(0.48), width: 1),
                                                    ),
                                                    childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                                                    tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                    showTrailingIcon: true,
                                                    title: Container(
                                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                      child: Row(
                                                        children: [

                                                          Visibility(
                                                            visible: resultMode ,
                                                            child:     CustomPopupMenu(
                                                              horizontalMargin: 96,
                                                              child: Container(
                                                                height: 40,
                                                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                                decoration: BoxDecoration(color: context.mainColor, borderRadius: BorderRadius.circular(10)),
                                                                child: Center(child: Text("Options", style: TextStyle(color: Colors.white))),
                                                              ),
                                                              menuBuilder: () => Container(
                                                                width: 350,
                                                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                                                decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadiusGeometry.circular(10),
                                                                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
                                                                ),
                                                                child: Column(
                                                                  spacing: 6,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    DrawerAction(
                                                                      radius: 12,
                                                                      tileColor: MyColors.mainBlue,
                                                                      title: "Agent Decision",
                                                                      onTap: () async {
                                                                        String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                                                                        if (logId != null) {
                                                                          _controller.hideMenu();
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AgentDecisionSheet(logId: logId);
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                      leadingIcon: ArtemisIcons.message_question,
                                                                    ),
                                                                    ?ref.watch(currentStatusProvider).canAskSupervisor
                                                                        ? DrawerAction(
                                                                      radius: 12,
                                                                      tileColor: MyColors.mainBlue,
                                                                      title: "Ask Supervisor",
                                                                      onTap: () async {
                                                                        List<Supervisor>? supervisors = await getIt<HomeController>().getSupervisors();
                                                                        if (supervisors == null) return;

                                                                        String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                                                                        if (logId != null) {
                                                                          _controller.hideMenu();
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AskSupervisorSheet(logId: logId, supervisors: supervisors);
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                      leadingIcon: ArtemisIcons.message_question,
                                                                    )
                                                                        : null,
                                                                    DrawerAction(
                                                                      radius: 12,
                                                                      tileColor: MyColors.mainBlue,
                                                                      title: "Airline Representative Decision",
                                                                      onTap: () async {
                                                                        String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                                                                        if (logId != null) {
                                                                          _controller.hideMenu();
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return ManagerApprovalSheet(logId: logId);
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                      leadingIcon: ArtemisIcons.airplane_square,
                                                                    ),
                                                                    DrawerAction(
                                                                      radius: 12,
                                                                      tileColor: MyColors.mainBlue,
                                                                      title: "Add Attachment",
                                                                      onTap: () async {
                                                                        String? logId = getIt<HomeController>().ref.read(refCodeProvider);
                                                                        if (logId != null) {
                                                                          _controller.hideMenu();
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AttachPhotoSheet(logId: logId);
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                      leadingIcon: ArtemisIcons.attach_circle,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              pressType: PressType.singleClick,
                                                              verticalMargin: -10,
                                                              controller: _controller,
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible: resultMode,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: MyButton(
                                                                label: "Unlock",
                                                                fontSize: 12,
                                                                iconSize: 15,
                                                                reverse: true,

                                                                icon: ArtemisIcons.unlock,
                                                                onPressed: !resultMode
                                                                    ? null
                                                                    : () async {
                                                                  await getIt<HomeController>().setStatus(0);
                                                                },
                                                                radius: 10,
                                                                borderSide: BorderSide(color: context.mainColor),
                                                              ),
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible: !resultMode,
                                                            child: MyButton(
                                                              label: "TIMATIC",
                                                              iconSize: 12,
                                                              fontSize: 12,
                                                              icon: ArtemisIcons.user_square,
                                                              onPressed: !canCheck
                                                                  ? () {
                                                                      ref.read(globalFormValidationMode.notifier).update((s) => true);
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all required data!"), showCloseIcon: true));
                                                                    }
                                                                  : () async {
                                                                      ref.read(globalFormValidationMode.notifier).update((s) => false);
                                                                      final timResult = await getIt<HomeController>().timatic();
                                                                      if (timResult != null) {
                                                                        ref.read(timaticResultNewProvider.notifier).update((s) => timResult);
                                                                        timaticController.expand();

                                                                        // scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                                                                      }
                                                                    },
                                                              radius: 12,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          CheckPermission(
                                                            permission: TimaticUiPermission.read(),
                                                            child: MyButton(
                                                              label: "Restart",
                                                              onPressed: () {
                                                                getIt<HomeController>().clear();
                                                                flightPaxController.expand();
                                                              },
                                                              radius: 12,
                                                              reverse: true,
                                                              borderSide: BorderSide(color: context.mainColor),
                                                              icon: ArtemisIcons.eraser_1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    showFooter: false,
                                                    children: [FlightWidget(), PassengerWidget(), PassportWidget(), VisaWidget(), ResidentWidget()],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: MyExpansionTile(
                                              initiallyExpanded: true,
                                              controller: timaticController,
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
                                              tilePadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                                                              // Text("${ref.watch(timaticResultProvider)!.refCode}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                                            ],
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ),
                                              showFooter: false,
                                              children: resultMode
                                                  ? [
                                                      Consumer(
                                                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                                          final result = ref.watch(timaticResultNewProvider);
                                                          final refCode = ref.watch(refCodeProvider);
                                                          if (result == null) {
                                                            return SizedBox();
                                                          }
                                                          // return SizedBox(height: 100);
                                                          return Column(
                                                            children: [
                                                              TimaticTrueResultWidgetNew(res: result, refCode: refCode!),
                                                              const SizedBox(height: 12),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ]
                                                  : [
                                                      Column(
                                                        children: [
                                                          const SizedBox(height: 300),
                                                          Text("After filling out data, Click on"),
                                                          const SizedBox(height: 16),
                                                          Row(
                                                            children: [
                                                              Spacer(),
                                                              Expanded(
                                                                flex: 2,
                                                                child: MyButton(
                                                                  label: "TIMATIC",
                                                                  iconSize: 12,
                                                                  fontSize: 12,
                                                                  icon: ArtemisIcons.user_square,
                                                                  onPressed: !canCheck
                                                                      ? () {
                                                                          ref.read(globalFormValidationMode.notifier).update((s) => true);
                                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all required data!"), showCloseIcon: true));
                                                                        }
                                                                      : () async {
                                                                          ref.read(globalFormValidationMode.notifier).update((s) => false);
                                                                          final timResult = await getIt<HomeController>().timatic();
                                                                          if (timResult != null) {
                                                                            ref.read(timaticResultNewProvider.notifier).update((s) => timResult);
                                                                            timaticController.expand();
                                                                            // scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                                                                          }
                                                                        },
                                                                  radius: 12,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 300),
                                                        ],
                                                      ),
                                                    ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                          HeaderSummaryWidgetDesktop(
                            header: Column(
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: SafeArea(child: Material(child: WarningsBuilder())),
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

class HeaderSummaryWidgetDesktop extends ConsumerWidget {
  final Widget header;

  const HeaderSummaryWidgetDesktop({super.key, required this.header});

  Widget countryBuilderHeader(dynamic a) => a == null
      ? SizedBox()
      : Row(
          children: [
            Text("$a"),
            const SizedBox(width: 2),
            MyCountryFlagsPro.getFlag(a,width: 22,height: 16,borderRadius: BorderRadius.circular(2)),
          ],
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timaticRes = ref.watch(timaticResultNewProvider);
    final bool resultMode = timaticRes != null;
    // log(tim.params.of(ParameterType.documentCode).map((a)=>"${a.code} -> ${a.name}").join("\n"));
    // final List<DocumentDetail> documentDetails = ref.watch(documentProvider);
    // final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> visas = ref.watch(visasProvider);
    final List<DocumentDetail> residents = ref.watch(residentsProvider);
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    final List<ItinerarySegment> segments = ref.watch(segmentsProvider);
    bool isClosed = !ref.watch(currentStatusProvider).canUseOption;
    Color color = MyColors.mainBlue;
    final currentStatus = ref.watch(currentStatusProvider);
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
        child: Row(
          children: [
            Expanded(child: header),
            resultMode
                ? Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Builder(
                            builder: (BuildContext context) {
                              final res = ref.watch(timaticResultNewProvider)!;
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                child: Row(spacing: 12, children: [...res.segments.map((seg) => seg.routeWidget)]),
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
                                          AirlineLogo(segments.first.operatingCarrier?.code ?? '', key: Key(segments.first.operatingCarrier?.code ?? ''), size: 25),
                                          Text("${segments.first.operatingCarrier?.code ?? ''} ${segments.first.flnb ?? ''}"),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("Date: ", style: TextStyle(color: Colors.grey)),
                                          Text(segments.first.departure.dateTime.format_ddMMM ?? ''),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("Route: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                          Text("${segments.first.departure.point ?? ''}-${segments.first.arrival.point ?? ''}", style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("Passport: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                          Text(StringUtility.maskString(passports.firstOrNull?.documentNumber ?? ''), style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("Tracking: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                          Text(ref.watch(refCodeShowProvider) ?? '', style: TextStyle(color: Colors.black)),
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
                                          Text(ref.watch(currentStatusProvider)?.employeeId ?? '', style: TextStyle(color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("Nationality: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                          countryBuilderHeader(passengerDetails.nationality ?? passports.firstOrNull?.nationality),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("Resident: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                          countryBuilderHeader(passengerDetails.residentCountryCode),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("VISA: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                          countryBuilderHeader(visas.firstOrNull?.documentIssueCountry),
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

class WarningsBuilder extends ConsumerWidget {
  const WarningsBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PassengerDetails passengerDetails = ref.watch(passengerProvider);
    List<DocumentDetail> passports = ref.watch(passportsProvider);
    List<DocumentDetail> visas = ref.watch(visasProvider);
    List<DocumentDetail> residents = ref.watch(residentsProvider);
    List<String> warningList = [];
    String? warning;
    List<String> nats = [];
    List<String> bDates = [];
    if (passengerDetails.nationality != null) {
      nats.add(passengerDetails.nationality!.code3);
    }
    passports.where((a) => a.nationality != null).forEach((p) {
      nats.add(p.nationality!.code3);
    });
    visas.where((a) => a.nationality != null).forEach((v) {
      nats.add(v.nationality!.code3);
    });
    residents.where((a) => a.nationality != null).forEach((v) {
      nats.add(v.nationality!.code3);
    });
    if (nats.toSet().toList().length > 1) {
      // warning = "Nationalities do not match: ${nats.toSet().join(", ")}";
      warningList.add("Nationalities do not match: ${nats.toSet().join(", ")}");
    }
    bDates.addAll(passports.where((a) => a.birthDate != null && a.birthDate.format_yyyyMMdd != "2000-01-01").map((a) => a.birthDate!.format_yyMMdd));
    bDates.addAll(visas.where((a) => a.birthDate != null).map((a) => a.birthDate!.format_yyMMdd));
    bDates.addAll(residents.where((a) => a.birthDate != null).map((a) => a.birthDate!.format_yyMMdd));
    if (passengerDetails.birthDate != null) {
      bDates.add(passengerDetails.birthDate!.format_yyMMdd);
    }

    if (bDates.toSet().toList().length > 1) {
      // warning = "Nationalities do not match: ${nats.toSet().join(", ")}";
      warningList.add("Birth dates do not match:\n${bDates.toSet().map((a) => DateFormat("dd ,MMM yyyy").format(DateFormat("yy-MM-dd").parse(a))).join(" vs ")}");
    }

    if (warningList.isNotEmpty) {
      warning = warningList.join("\n");
    }

    if (warning == null || !ref.watch(showWarningsProvider)) return SizedBox();
    Color color = Colors.black;
    Color warColor = Color(0xffBf6C00);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadiusGeometry.circular(15),
        child: Container(
          // height: 100,
          decoration: BoxDecoration(
            // color: Colors.white,
            gradient: LinearGradient(colors: [warColor.withOpacity(0.0), warColor], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadiusGeometry.circular(15),
            // border: Border.all(color: Colors.orange, width: 2),
          ),
          child: Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusGeometry.circular(15)),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(ArtemisIcons.warning_2, color: warColor, size: 30),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "Warning",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: warColor),
                      ),
                    ),
                    const SizedBox(width: 4),
                    DotButton(
                      icon: Icons.close,
                      color: color,
                      // fade: false,
                      // backgroundColor: Colors.white.withOpacity(0.3),
                      radius: 10,
                      onPressed: () {
                        ref.read(showWarningsProvider.notifier).update((s) => false);
                      },
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(warning, style: TextStyle(color: color, fontSize: 12)),
                    ),
                    const SizedBox(width: 4),
                    DotButton(
                      icon: Icons.close,
                      color: color,
                      fade: false,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      radius: 10,
                      onPressed: () {
                        ref.read(showWarningsProvider.notifier).update((s) => false);
                      },
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return ListView(
    //   shrinkWrap: true,
    //   children: ref.watch(warningsProvider).map((w){
    //     return Container(
    //       height: 56,
    //       decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadiusGeometry.circular(10)),
    //       margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    //       child: Row(
    //         children: [
    //           const SizedBox(width: 12),
    //           Icon(ArtemisIcons.warning_2, color: Colors.white, size: 30),
    //           const SizedBox(width: 4),
    //           Expanded(child: Text(w, style: TextStyle(color: Colors.white,fontSize: 12))),
    //           const SizedBox(width: 4),
    //           DotButton(icon: Icons.close,color: Colors.white,fade: false,backgroundColor: Colors.white.withOpacity(0.3),radius: 10,onPressed: (){
    //               ref.read(warningsProvider.notifier).update((s)=>[...s].where((a)=>a != w).toList());
    //           },),
    //           const SizedBox(width: 12),
    //         ],
    //       ),
    //     );
    //   }).toList(),
    // );
  }
}

airlineLogoBuild(ParameterValue? operatingCarrier) {
  if (operatingCarrier == null) return SizedBox();
  return Row(
    children: [SizedBox(width: 30, height: 30, child: AirlineLogo(key: Key(operatingCarrier.code), operatingCarrier!.code, size: 30))],
  );
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
