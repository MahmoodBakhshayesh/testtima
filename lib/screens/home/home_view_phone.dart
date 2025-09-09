import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:abds/core/navigation/routes.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
import 'package:abds/core/utils_and_services/operations/confirm_operation.dart';
import 'package:abds/core/utils_and_services/time_picker/ui_permission.dart';
import 'package:abds/screens/home/dialogs/requested_data_dialog.dart';
import 'package:abds/screens/home/home_drawer.dart';
import 'package:abds/screens/login/login_controller.dart';
import 'package:abds/screens/login/login_state.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smart_overlay_menu/smart_overlay_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/residents_state_controller.dart';
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../../core/utils_and_services/string_utility.dart';
import '../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../initialize.dart';
import '../../widgets/MyExpansionTile.dart';
import '../../widgets/MyTimePicker.dart';
import 'home_controller.dart';
import 'home_state.dart';
import 'widgets/passport_section.dart';
import 'widgets/resident_section.dart';
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

  @override
  initState() {
    flightsScaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  Widget countryBuilder(dynamic a) => Row(
    children: [
      ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
      const SizedBox(width: 8),
      Text("$a (${(a as Location).name})"),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final timaticRes = ref.watch(timaticResultProvider);

    final tim = BasicClass.timData;
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
    bool canCheck = segments.any((a) => a.arrival.point.isNotEmpty && a.departure.point.isNotEmpty);
    // bool foundPassInVisa = passports.any((p)=>p.documentNumber!=null && (ref.read(lastVisaOcrProvider)?.text??'').contains(p.documentNumber??'-------------------'));
    return PopScope(
      canPop: false,
      child: Container(
        color: MyColors.greyBG,
        child: SafeArea(
          bottom: true,
          top: false,
          child: Scaffold(
            key: flightsScaffoldKey,
            appBar: HomeAppBar(scaffoldKey: flightsScaffoldKey),
            drawer: HomeDrawer(),
            backgroundColor: Colors.white,
            // floatingActionButton: Container(
            //   width: 56,
            //   height: 56,
            //   margin: EdgeInsets.only(bottom: 56),
            //   child: MyButton(
            //     radius: 10,
            //     label: "",
            //     child: Column(
            //       children: [
            //         const SizedBox(height: 4),
            //         Icon(ArtemisIcons.scanner, color: Colors.white),
            //         Text("Scan\nDocs", style: TextStyle(color: Colors.white, fontSize: 12, height: 1)),
            //       ],
            //     ),
            //     onPressed: () {
            //       HomeViewPhone.myHomeController.goMrzReadr();
            //     },
            //   ),
            // ),
            body: Column(
              children: [
                if (!resultMode)
                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: MyColors.scaffoldHeader,
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("FLIGHT", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                                      ),
                                      MyButton(
                                        label: "Scan",
                                        icon: Icons.qr_code_scanner,
                                        onPressed: () {
                                          HomeViewPhone.myHomeController.goNamed(Routes.barcodeReader);
                                        },
                                        textColor: Colors.white,
                                        // textColor: context.mainColor,
                                        borderSide: BorderSide(color: Colors.white),
                                        radius: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    // var seg = segments[0];
                                    // int index = 0;
                                    return Column(
                                      children: segments.map((seg) {
                                        int index = segments.indexOf(seg);
                                        bool isLast = segments.length == index + 1;
                                        bool isFirst = index == 0;
                                        return SegmentItemRow(index: index, item: seg, isLast: isLast, isFirst: isFirst);

                                        // return Container(
                                        //   decoration: BoxDecoration(
                                        //     border: Border(bottom: BorderSide(color: Colors.white)),
                                        //   ),
                                        //   child: MyExpansionTile(
                                        //     backgroundColor: MyColors.scaffoldBg,
                                        //     collapsedBackgroundColor: MyColors.scaffoldBg,
                                        //     footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
                                        //     shape: RoundedRectangleBorder(),
                                        //     collapsedShape: RoundedRectangleBorder(),
                                        //     tilePadding: EdgeInsets.symmetric(horizontal: 14),
                                        //     footerExtra: IndexedStack(
                                        //       index: isLast ? 0 : 1,
                                        //       children: [
                                        //         Padding(
                                        //           padding: const EdgeInsets.all(8.0),
                                        //           child: MyButton(
                                        //             height: 30,
                                        //             label: "Transit",
                                        //             icon: Icons.add_circle_outline,
                                        //             onPressed: () {
                                        //               ref.read(segmentsProvider.notifier).update((s) => [...s, ItinerarySegment.empty()]);
                                        //             },
                                        //             textColor: Colors.blueAccent,
                                        //             color: Colors.blueAccent.withOpacity(0.1),
                                        //           ),
                                        //         ),
                                        //         SizedBox(),
                                        //       ],
                                        //     ),
                                        //     title: Column(
                                        //       crossAxisAlignment: CrossAxisAlignment.start,
                                        //       children: [
                                        //         Padding(
                                        //           padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        //           child: Row(
                                        //             children: [
                                        //               Expanded(
                                        //                 child: Text(
                                        //                   "FLIGHT ${index + 1}",
                                        //                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: MyColors.greyText),
                                        //                 ),
                                        //               ),
                                        //               isFirst
                                        //                   ? SizedBox()
                                        //                   : DotButton(
                                        //                       icon: Icons.delete,
                                        //                       color: Colors.red,
                                        //                       flat: true,
                                        //                       onPressed: () {
                                        //                         ref.read(segmentsProvider.notifier).update((s) => [...s.where((a) => s.indexOf(a) != index)]);
                                        //                       },
                                        //                     ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //         Row(
                                        //           spacing: 12,
                                        //           children: [
                                        //             Expanded(
                                        //               child: MyFieldPicker<Location>(
                                        //                 required: true,
                                        //                 label: "From",
                                        //                 placeholder: "City",
                                        //                 itemToWidget: (dynamic a) => Text("$a (${(a as Location).name})"),
                                        //                 items: tim.locations.of(LocationType.airport),
                                        //                 value: tim.locations.of(LocationType.airport).firstWhereOrNull((a) => a.code3 == seg.departure.point),
                                        //                 onChange: (a) {
                                        //                   if (a is Location) {
                                        //                     final update = seg.departure.copyWith(point: a.code3);
                                        //                     seg = seg.copyWith(departure: update);
                                        //                     final ul = [...segments];
                                        //                     ul[index] = seg;
                                        //                     ref.read(segmentsProvider.notifier).update((s) => ul);
                                        //                   }
                                        //                 },
                                        //               ),
                                        //             ),
                                        //             Expanded(
                                        //               child: MyFieldPicker<Location>(
                                        //                 label: "To",
                                        //                 placeholder: "City",
                                        //                 itemToWidget: (dynamic a) => Text("$a (${(a as Location).name})"),
                                        //                 required: true,
                                        //                 items: tim.locations.of(LocationType.airport),
                                        //                 value: tim.locations.of(LocationType.airport).firstWhereOrNull((a) => a.code3 == seg.arrival.point),
                                        //                 onChange: (a) {
                                        //                   if (a is Location) {
                                        //                     final update = seg.arrival.copyWith(point: a.code3);
                                        //                     seg = seg.copyWith(arrival: update);
                                        //                     final ul = [...segments];
                                        //                     ul[index] = seg;
                                        //                     ref.read(segmentsProvider.notifier).update((s) => ul);
                                        //                   }
                                        //                 },
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     childrenPadding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 12),
                                        //     children: [
                                        //       Row(
                                        //         spacing: 12,
                                        //         children: [
                                        //           Expanded(
                                        //             child: MyDatePicker(
                                        //               label: "Departure",
                                        //               placeholder: "Date",
                                        //               value: seg.departure.dateTime,
                                        //               onChanged: (a) {
                                        //                 seg = seg.copyWith(arrival: seg.departure.copyWith(dateTime: a));
                                        //                 log(jsonEncode(seg.toJson()));
                                        //                 ref.read(segmentsProvider.notifier).update((s) => [...s]);
                                        //               },
                                        //             ),
                                        //           ),
                                        //           Expanded(
                                        //             child: MyDatePicker(
                                        //               label: "Arrival",
                                        //               placeholder: "Date",
                                        //               value: seg.arrival.dateTime,
                                        //               onChanged: (a) {
                                        //                 seg = seg.copyWith(arrival: seg.arrival.copyWith(dateTime: a));
                                        //                 ref.read(segmentsProvider.notifier).update((s) => [...s]);
                                        //               },
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //       const SizedBox(height: 12),
                                        //       MyFieldPicker<ParameterValue>(
                                        //         label: "Operating Carrier",
                                        //         placeholder: "Airline",
                                        //         items: tim.params.of(ParameterType.carrier),
                                        //         value: seg.operatingCarrier,
                                        //         onChange: (a) {
                                        //           seg = seg.copyWith(operatingCarrier: a);
                                        //           log(jsonEncode(seg.toJson()));
                                        //           ref.read(segmentsProvider.notifier).update((s) => [...s]);
                                        //         },
                                        //       ),
                                        //     ],
                                        //   ),
                                        // );
                                      }).toList(),
                                    );
                                  },
                                ),
                                const SizedBox(height: 12),
                                PassengerDetailsWidget(),
                                const SizedBox(height: 12),
                                const SizedBox(height: 12),
                                Visibility(
                                  visible: passports.isNotEmpty,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          // color: MyColors.scaffoldHeader,
                                          color: Color(0xff324073).withOpacity(0.4),
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text("PASSPORT", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                                            ),
                                            DotButton(
                                              icon: ArtemisIcons.trash,
                                              color: Colors.red,
                                              flat: true,
                                              onPressed: () async {
                                                final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                                                if (!confirm) return;
                                                // ref.read(passportsProvider.notifier).removeAt(index);
                                                int lastIndex = passports.length - 1;
                                                ref.read(passportsProvider.notifier).removeAt(lastIndex);
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                            DotButton(
                                              border: BorderSide(color: Colors.blueAccent),
                                              icon: Icons.refresh,
                                              flat: true,
                                              onPressed: () async {
                                                final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                                                if (!confirm) return;
                                                int lastIndex = passports.length - 1;
                                                ref.read(passportsProvider.notifier).updateAt(lastIndex, DocumentDetail());
                                              },
                                            ),
                                            // MyButton(
                                            //   label: "Scan",
                                            //   icon: Icons.qr_code_scanner,
                                            //   onPressed: () {
                                            //     myHomeController.goNamed(Routes.mrzReader);
                                            //   },
                                            //   textColor: Colors.white,
                                            //   // textColor: context.mainColor,
                                            //   borderSide: BorderSide(color: Colors.white),
                                            //   radius: 12,
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          return Column(
                                            children: passports.map((d) {
                                              int index = passports.indexOf(d);
                                              bool isLast = passports.length == index + 1;
                                              bool isFirst = index == 0;
                                              return PassportItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst);
                                            }).toList(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Visibility(
                                  visible: visas.isNotEmpty,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          // color: MyColors.scaffoldHeader,
                                          color: Colors.orange.withOpacity(0.4),
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text("VISA", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                                            ),
                                            DotButton(
                                              icon: ArtemisIcons.trash,
                                              color: Colors.red,
                                              flat: true,
                                              onPressed: () async {
                                                final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                                                if (!confirm) return;
                                                int lastIndex = visas.length - 1;
                                                ref.read(visasProvider.notifier).removeAt(lastIndex);
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                            DotButton(
                                              border: BorderSide(color: Colors.blueAccent),
                                              icon: Icons.refresh,
                                              flat: true,
                                              onPressed: () async {
                                                final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                                                if (!confirm) return;
                                                int lastIndex = visas.length - 1;
                                                ref.read(visasProvider.notifier).updateAt(lastIndex, DocumentDetail());

                                                // ref.read(segmentsProvider.notifier).updateAt(index, ItinerarySegment.empty());
                                              },
                                            ),
                                            // MyButton(
                                            //   label: "Scan",
                                            //   icon: Icons.qr_code_scanner,
                                            //   onPressed: () {
                                            //     myHomeController.goNamed(Routes.mrzReader);
                                            //   },
                                            //   textColor: Colors.white,
                                            //   // textColor: context.mainColor,
                                            //   borderSide: BorderSide(color: Colors.white),
                                            //   radius: 12,
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          return Column(
                                            children: visas.map((d) {
                                              int index = visas.indexOf(d);
                                              bool isLast = visas.length == index + 1;
                                              bool isFirst = index == 0;
                                              return VisaItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst);
                                            }).toList(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Visibility(
                                  visible: residents.isNotEmpty,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          // color: MyColors.scaffoldHeader,
                                          color: Colors.green.withOpacity(0.4),
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text("ID / Residency Card".toUpperCase(), style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                                            ),
                                            DotButton(
                                              icon: ArtemisIcons.trash,
                                              color: Colors.red,
                                              flat: true,
                                              onPressed: () async {
                                                final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                                                if (!confirm) return;
                                                int lastIndex = residents.length - 1;
                                                ref.read(residentsProvider.notifier).removeAt(lastIndex);
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                            DotButton(
                                              border: BorderSide(color: Colors.blueAccent),
                                              icon: Icons.refresh,
                                              flat: true,
                                              onPressed: () async {
                                                final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                                                if (!confirm) return;
                                                int lastIndex = residents.length - 1;
                                                ref.read(residentsProvider.notifier).updateAt(lastIndex, DocumentDetail());

                                                // ref.read(segmentsProvider.notifier).updateAt(index, ItinerarySegment.empty());
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          return Column(
                                            children: residents.map((d) {
                                              int index = residents.indexOf(d);
                                              bool isLast = residents.length == index + 1;
                                              bool isFirst = index == 0;
                                              return ResidentItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst);
                                            }).toList(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                PhotoAttachmentWidget(),
                              ],
                            ),
                          ),
                        ),
                        WarningsBuilder(),
                      ],
                    ),
                  )
                else
                  Expanded(child: TimaticTrueResultWidget(res: timaticRes)),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  color: MyColors.greyBG,
                  child: Row(
                    children: [
                      resultMode
                          ? MyButton(
                              label: "Clear",
                              borderSide: BorderSide(color: MyColors.black8),
                              icon: Icons.refresh,
                              iconSize: 20,
                              onPressed: () {
                                ref.read(timaticResultProvider.notifier).update((s) => null);
                              },
                              reverse: true,
                              color: Colors.black,
                            )
                          : Row(
                              children: [
                                MyButton(
                                  label: "Clear",
                                  radius: 10,
                                  borderSide: BorderSide(color: MyColors.black8),
                                  icon: Icons.refresh,
                                  onPressed: () async {
                                    final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                                    if (!confirm) return;
                                    getIt<HomeController>().clear();
                                  },
                                  reverse: true,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 12),
                                MyButton(
                                  label: "Manual",
                                  onPressed: ref.watch(passportsProvider).isNotEmpty && ref.watch(visasProvider).isNotEmpty && ref.watch(residentsProvider).isNotEmpty
                                      ? null
                                      : () {
                                          if (ref.read(passportsProvider).isEmpty) {
                                            ref.read(passportsProvider.notifier).add(DocumentDetail());
                                          }
                                          if (ref.read(visasProvider).isEmpty) {
                                            ref.read(visasProvider.notifier).add(DocumentDetail());
                                          }
                                          if (ref.read(residentsProvider).isEmpty) {
                                            ref.read(residentsProvider.notifier).add(DocumentDetail());
                                          }
                                        },
                                  radius: 10,
                                  reverse: true,
                                  borderSide: BorderSide(color: context.mainColor),
                                ),
                                const SizedBox(width: 12),
                                MyButton(
                                  label: "Scan",
                                  onPressed: () {
                                    HomeViewPhone.myHomeController.goMrzReadr();
                                  },
                                  radius: 10,
                                  icon: ArtemisIcons.scan,
                                ),
                              ],
                            ),
                      Spacer(),
                      resultMode
                          ? MyButton(
                              label: "Start Again",
                              icon: Icons.refresh,
                              iconInRight: true,
                              onPressed: () async {
                                HomeViewPhone.myHomeController.clear();
                                ref.read(timaticResultProvider.notifier).update((s) => null);
                              },
                              radius: 12,
                            )
                          : MyButton(
                              label: "TIMATIC",
                              icon: Icons.perm_identity,
                              iconInRight: true,
                              onPressed: !canCheck
                                  ? null
                                  : () async {
                                      // FailureHandler.handle(ServerFailure(code: -1, msg: "dakldjasd\adnjaskdaskj\na;skdsa;ldk\adnjad\nklkd;ad;askd;l", traceMsg: "dakldjasd\adnjaskdaskj\na;skdsa;ldk\adnjad\nklkd;ad;askd;l"));

                                      List<DocumentDetail> ddl = [...ref.read(passportsProvider), ...ref.read(visasProvider), ...ref.read(residentsProvider)].where((a) => a.documentCode != null).toList();
                                      final timResult = await HomeViewPhone.myHomeController.timaticApi.submitDocumentRequest(
                                        DocumentRequest(
                                          documentDetails: ddl,
                                          itineraryDetails: ItineraryDetails(segments: segments),
                                          passengerDetails: passengerDetails,
                                        ),
                                      );
                                      ref.read(timaticResultProvider.notifier).update((s) => timResult);
                                    },
                              radius: 12,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PassengerDetailsWidget extends ConsumerWidget {
  const PassengerDetailsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: MyColors.scaffoldHeader,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text("PASSENGER", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
              ),
              DotButton(
                icon: Icons.refresh,
                border: BorderSide(color: Colors.blueAccent),
                flat: true,
                onPressed: () async {
                  final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                  if (!confirm) return;
                  ref.read(passengerProvider.notifier).update((s) => PassengerDetails());
                },
              ),
            ],
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return PassengerDetailsRow(index: 0, details: ref.watch(passengerProvider), isLast: true, isFirst: true);
          },
        ),
      ],
    );
  }
}

class ExpiryInfoWidget extends StatelessWidget {
  final DateTime? expiry;

  const ExpiryInfoWidget(this.expiry, {super.key});

  @override
  Widget build(BuildContext context) {
    return IndexedStack(index: expiry == null ? 0 : 1, children: [SizedBox(), Container(width: 100)]);
  }
}

class SegmentItemRow extends ConsumerStatefulWidget {
  const SegmentItemRow({super.key, required this.index, required this.item, required this.isLast, required this.isFirst});

  final bool isFirst;
  final bool isLast;
  final int index;
  final ItinerarySegment item;

  @override
  ConsumerState<SegmentItemRow> createState() => _SegmentItemRowState();
}

class _SegmentItemRowState extends ConsumerState<SegmentItemRow> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.item.flnb);

    controller.addListener(() {
      Future(() {
        ref.read(segmentsProvider.notifier).updateAt(widget.index, widget.item.copyWith(flnb: controller.text));
      });
    });
  }

  @override
  void didUpdateWidget(SegmentItemRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // log(widget.item.toJson().toString());

    if (controller.text != widget.item.flnb) {
      controller.text = widget.item.flnb ?? '';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget countryBuilder(dynamic a) => Row(
    children: [
      ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
      const SizedBox(width: 8),
      Text("$a (${(a as Location).name})"),
    ],
  );

  @override
  Widget build(BuildContext context) {
    bool isLast = widget.isLast;
    bool isFirst = widget.isFirst;
    int index = widget.index;
    ItinerarySegment seg = widget.item;
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    final tim = BasicClass.timData;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),
      child: MyExpansionTile(
        backgroundColor: MyColors.scaffoldBg,
        collapsedBackgroundColor: MyColors.scaffoldBg,
        footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
        shape: RoundedRectangleBorder(),
        collapsedShape: RoundedRectangleBorder(),
        tilePadding: EdgeInsets.symmetric(horizontal: 14),
        footerExtra: IndexedStack(
          index: isLast ? 0 : 1,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                height: 30,
                label: "Transit",
                icon: Icons.add_circle_outline,
                onPressed: () {
                  var beforeSeg = seg;
                  beforeSeg = beforeSeg.copyWith(luggageCollected: false, segmentType: SegmentType.transit);
                  ref.read(segmentsProvider.notifier).updateAt(index, beforeSeg);
                  var newSeg = ItinerarySegment.empty();
                  newSeg = newSeg.copyWith(departure: seg.arrival);
                  ref.read(segmentsProvider.notifier).add(newSeg);
                },
                textColor: Colors.blueAccent,
                color: Colors.blueAccent.withOpacity(0.1),
              ),
            ),
            SizedBox(),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "FLIGHT ${index + 1}",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: MyColors.greyText),
                    ),
                  ),
                  isFirst
                      ? SizedBox()
                      : DotButton(
                          icon: ArtemisIcons.trash,
                          color: Colors.red,
                          flat: true,
                          onPressed: () async {
                            final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                            if (!confirm) return;
                            ref.read(segmentsProvider.notifier).removeAt(index);
                          },
                        ),

                  const SizedBox(width: 8),
                  DotButton(
                    icon: Icons.refresh,
                    border: BorderSide(color: Colors.blueAccent),
                    flat: true,
                    onPressed: () async {
                      final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                      if (!confirm) return;
                      ref.read(segmentsProvider.notifier).updateAt(index, ItinerarySegment.emptyNoAirport());
                    },
                  ),
                ],
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: MyFieldPicker<Location>(
                    required: true,
                    searchAutoFocus: true,
                    label: "From",
                    placeholder: "City",
                    rowLabelRatio: [3, 5],
                    labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    itemToWidget: (dynamic a) => Text("$a (${(a as Location).name})"),
                    searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
                    items: tim.locations.of(LocationType.airport),
                    value: tim.locations.of(LocationType.airport).firstWhereOrNull((a) => a.code3 == seg.departure.point),
                    onChange: (a) {
                      final update = seg.departure.copyWith(point: a?.code3 ?? '');
                      seg = seg.copyWith(departure: update);
                      ref.read(segmentsProvider.notifier).updateAt(index, seg);

                      if (!isFirst && seg.departure.point.isNotEmpty) {
                        int prevIndex = index - 1;
                        var prevSeg = ref.read(segmentsProvider)[prevIndex];
                        prevSeg = prevSeg.copyWith(arrival: seg.departure);
                        ref.read(segmentsProvider.notifier).updateAt(prevIndex, prevSeg);
                      }

                      // final ul = [...segments];
                      // ul[index] = seg;
                      // ref.read(segmentsProvider.notifier).update((s) => ul);
                    },
                  ),
                ),
                Expanded(
                  child: MyFieldPicker<Location>(
                    label: "To",
                    placeholder: "City",
                    searchAutoFocus: true,
                    rowLabelRatio: [3, 5],
                    labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    itemToWidget: (dynamic a) => Text("$a (${(a as Location).name})"),
                    required: true,
                    items: tim.locations.of(LocationType.airport),
                    searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
                    value: tim.locations.of(LocationType.airport).firstWhereOrNull((a) => a.code3 == seg.arrival.point),
                    onChange: (a) {
                      final update = seg.arrival.copyWith(point: a?.code3 ?? '');
                      seg = seg.copyWith(arrival: update);
                      log(jsonEncode(seg.toJson()));
                      ref.read(segmentsProvider.notifier).updateAt(index, seg);

                      if (!isLast) {
                        int nextIndex = index + 1;
                        var nextSeg = ref.read(segmentsProvider)[nextIndex];
                        nextSeg = nextSeg.copyWith(departure: seg.arrival);
                        ref.read(segmentsProvider.notifier).updateAt(nextIndex, nextSeg);
                      }

                      // final ul = [...segments];
                      // ul[index] = seg;
                      // ref.read(segmentsProvider.notifier).update((s) => ul);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        childrenPadding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 12),
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: MyDatePicker(
                  label: "Departure",
                  placeholder: "Date",
                  rowLabelRatio: [3, 5],
                  value: seg.departure.dateTime,
                  onChanged: (a) {
                    if (a!.isAfter(seg.arrival.dateTime!)) {
                      seg = seg.copyWith(
                        departure: seg.departure.copyWith(dateTime: a),
                        arrival: seg.arrival.copyWith(dateTime: a),
                      );
                    } else {
                      seg = seg.copyWith(departure: seg.departure.copyWith(dateTime: a));
                    }
                    // seg = seg.copyWith(departure: seg.departure.copyWith(dateTime: a));
                    // seg = seg.copyWith(arrival: seg.departure.copyWith(dateTime: a));
                    // log(jsonEncode(seg.toJson()));

                    ref.read(segmentsProvider.notifier).updateAt(index, seg);

                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
              Expanded(
                child: MyDatePicker(
                  label: "Arrival",
                  placeholder: "Date",
                  rowLabelRatio: [3, 5],
                  min: seg.departure.dateTime,
                  value: seg.arrival.dateTime,
                  onChanged: (a) {
                    seg = seg.copyWith(arrival: seg.arrival.copyWith(dateTime: a));
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);

                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: MyTimePicker(
                  label: "STD",
                  placeholder: "Time",
                  rowLabelRatio: [3, 5],
                  value: seg.departure.time,
                  onChanged: (a) {
                    seg = seg.copyWith(departure: seg.departure.copyWith(time: a));

                    log(jsonEncode(seg.toJson()));

                    ref.read(segmentsProvider.notifier).updateAt(index, seg);

                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
              Expanded(
                child: MyTimePicker(
                  label: "STA",
                  placeholder: "Time",
                  rowLabelRatio: [3, 5],
                  value: seg.arrival.time,
                  onChanged: (a) {
                    seg = seg.copyWith(arrival: seg.arrival.copyWith(time: a));
                    log(jsonEncode(seg.toJson()));
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);

                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MyFieldPicker<ParameterValue>(
                  label: "Airline",
                  placeholder: "Airline",
                  searchAutoFocus: true,
                  rowLabelRatio: [3, 5],
                  items: tim.params.of(ParameterType.carrier),
                  value: seg.operatingCarrier,
                  onChange: (a) {
                    seg = seg.copyWith(operatingCarrier: a);
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);

                    // log(jsonEncode(seg.toJson()));
                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MyFieldPicker<PurposeOfStayType>(
                  label: "POS",
                  placeholder: "Purpose Of Stay",
                  rowLabelRatio: [3, 5],
                  items: PurposeOfStayType.values,
                  hasSearch: false,
                  value: seg.purposeOfStay,
                  onChange: (a) {
                    log("aa $a");
                    seg = seg.copyWith(purposeOfStay: a);
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);

                    log(jsonEncode(seg.toJson()));
                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MyTextField(controller: controller, label: "Flight Num", placeholder: "Number", rowLabelRatio: [3, 5], labelInRow: true),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MyDurationOfStayPicker(
                  label: "DOS",

                  placeholder: "Duration Of Stay",
                  value: seg.durationOfStay,
                  onChange: (a) {
                    seg = seg.copyWith(durationOfStay: a);
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MyFieldPicker<TicketStatus>(
                  label: "Ticket",
                  placeholder: "Ticket Status",
                  rowLabelRatio: [3, 5],
                  items: TicketStatus.values,
                  hasSearch: false,
                  value: seg.returnOnwardTicket,

                  onChange: (a) {
                    seg = seg.copyWith(returnOnwardTicket: a);
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);

                    // log(jsonEncode(seg.toJson()));
                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MyFieldPicker<SegmentType>(
                  label: "Type",
                  placeholder: "Type",
                  rowLabelRatio: [3, 5],
                  items: SegmentType.values,
                  hasSearch: false,
                  value: seg.segmentType,

                  onChange: (a) {
                    seg = seg.copyWith(segmentType: a);
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);

                    // log(jsonEncode(seg.toJson()));
                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: MySwitchButton(
                  value: seg.luggageCollected ?? false,
                  onChanged: (a) {
                    seg = seg.copyWith(luggageCollected: a);
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);
                  },
                  label: "Luggage Collect",
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

class PassengerDetailsRow extends ConsumerStatefulWidget {
  const PassengerDetailsRow({super.key, required this.index, required this.details, required this.isLast, required this.isFirst});

  final bool isFirst;
  final bool isLast;
  final int index;
  final PassengerDetails details;

  @override
  ConsumerState<PassengerDetailsRow> createState() => _PassengerDetailsRowState();
}

class _PassengerDetailsRowState extends ConsumerState<PassengerDetailsRow> {
  Widget countryBuilder(dynamic a) => Row(
    children: [
      ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
      const SizedBox(width: 8),
      Text("$a (${(a as Location).name})"),
    ],
  );

  Widget? countryPrefixBuilder(String? a) {
    if (a != null) {
      return Row(
        children: [
          const SizedBox(width: 4),
          SizedBox(
            width: 15,
            height: 10,
            child: ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
          ),
          const SizedBox(width: 4),
          Text(a, style: TextStyle(fontSize: 12)),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLast = widget.isLast;
    bool isFirst = widget.isFirst;
    int index = widget.index;
    PassengerDetails details = ref.watch(passengerProvider);
    final tim = BasicClass.timData;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),
      child: MyExpansionTile(
        backgroundColor: MyColors.scaffoldBg,
        collapsedBackgroundColor: MyColors.scaffoldBg,
        footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
        shape: RoundedRectangleBorder(),
        collapsedShape: RoundedRectangleBorder(),
        tilePadding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: MyFieldPicker<Location>(
                    hasSearch: true,
                    searchAutoFocus: true,
                    label: "Nationality",
                    required: true,
                    placeholder: "Country",
                    prefixIcon: countryPrefixBuilder(details.nationality?.code3),

                    rowLabelRatio: [4, 4],
                    searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
                    itemToWidget: countryBuilder,
                    items: tim.locations.of(LocationType.country),
                    value: details.nationality,
                    onChange: (a) {
                      details = details.copyWith(nationality: a);
                      ref.read(passengerProvider.notifier).update((s) => details);
                    },
                  ),
                ),
                Expanded(
                  child: MyFieldPicker<Location>(
                    hasSearch: true,
                    searchAutoFocus: true,
                    label: "Resident",
                    required: true,
                    rowLabelRatio: [4, 4],
                    placeholder: "Country",
                    prefixIcon: countryPrefixBuilder(details.residentCountryCode?.code3),

                    searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
                    itemToWidget: countryBuilder,
                    items: tim.locations.of(LocationType.country),
                    value: details.residentCountryCode,
                    onChange: (a) {
                      details = details.copyWith(residentCountryCode: a);
                      ref.read(passengerProvider.notifier).update((s) => details);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            MyFieldPicker<Gender>(
              label: "Gender",
              placeholder: "Gender",
              items: Gender.values,
              hasSearch: false,
              value: details.gender,
              onChange: (a) {
                details = details.copyWith(gender: a);
                ref.read(passengerProvider.notifier).update((s) => details);
              },
            ),
          ],
        ),
        childrenPadding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 0),
        children: [
          Row(
            children: [
              Expanded(
                child: MyDatePicker(
                  required: true,
                  rowLabelRatio: [3, 7],
                  label: "Birth Date",
                  placeholder: "Birth Date",
                  validator: (a) => birthDateValidator(a, details.birthDate),
                  validationColor: birthDateValidationColor(details.birthDate),
                  max: DateTime.now(),
                  validationIcon: ArtemisIcons.user_square,
                  value: details.birthDate,
                  onChanged: (a) {
                    ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthDate: a));
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          MyFieldPicker<Location>(
            label: "Birth Place",
            hasSearch: true,
            searchAutoFocus: true,
            placeholder: "Country",
            prefixIcon: countryPrefixBuilder(details.birthCountry?.code3),

            searchBuilder: (dynamic a) => "$a ${(a as Location).name}",
            items: tim.locations.of(LocationType.country),
            itemToWidget: countryBuilder,
            value: details.birthCountry,
            onChange: (a) {
              ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthCountry: a));
            },
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
                        MyButton(
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
                        // SmartOverlayMenu(
                        //   blurSize: 2,
                        //   duration: Duration(milliseconds: 50),
                        //   controller: controller,
                        //   blurBackgroundColor: Colors.transparent,
                        //   bottomWidget: Container(
                        //     decoration: BoxDecoration(color: MyColors.black2, borderRadius: BorderRadius.circular(12)),
                        //     padding: EdgeInsets.all(16),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         SizedBox(
                        //           height: 50,
                        //           width: 200,
                        //           child: Row(
                        //             children: [
                        //               Consumer(
                        //                 builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        //                   return UserAvatar(url: '', canEdit: true, hasImage: ref.watch(userProvider)?.profile.hasImage ?? false);
                        //                 },
                        //               ),
                        //
                        //               const SizedBox(width: 12),
                        //               Consumer(
                        //                 builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        //                   final profile = ref.watch(profileProvider);
                        //                   return Column(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: [
                        //                       Text(profile!.username ?? '-', style: TextStyle(color: Colors.white)),
                        //                       // Text(profile.email??"-", style: TextStyle(color: Colors.white)),
                        //                     ],
                        //                   );
                        //                 },
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Divider(color: Colors.white),
                        //         SizedBox(
                        //           height: 50,
                        //           width: 200,
                        //           child: ListTile(
                        //             contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        //             dense: true,
                        //             title: Text("About", style: TextStyle(color: Colors.white)),
                        //             trailing: Icon(Icons.info, color: Colors.white),
                        //             onTap: () {
                        //               showAboutDialog(context: context, applicationName: "ABOMIS Document Check", applicationVersion: "");
                        //             },
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: 50,
                        //           width: 200,
                        //           child: ListTile(
                        //             contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        //             dense: true,
                        //             title: Text("User Management", style: TextStyle(color: Colors.white)),
                        //             trailing: Icon(Icons.supervised_user_circle_sharp, color: Colors.white),
                        //             onTap: () {
                        //               myHomeController.goNamed(Routes.users);
                        //             },
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: 50,
                        //           width: 200,
                        //           child: ListTile(
                        //             contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        //             dense: true,
                        //             title: Text("Logout", style: TextStyle(color: Colors.red)),
                        //             trailing: Icon(Icons.exit_to_app, color: Colors.red),
                        //             onTap: () {
                        //               getIt<LoginController>().logout();
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   child: MyButton(
                        //     label: "Menu",
                        //     radius: 12,
                        //     icon: Icons.menu,
                        //     onPressed: () {
                        //       controller.open();
                        //     },
                        //     borderSide: BorderSide(color: MyColors.black8),
                        //     color: Colors.white,
                        //     textColor: Colors.black,
                        //   ),
                        // ),
                        Spacer(),
                        Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            return MyButton(
                              borderSide: BorderSide(color: MyColors.mainColor),
                              radius: 12,
                              reverse: true,
                              fontWeight: FontWeight.w700,
                              label: ref.watch(userProvider)?.profile.defaultAirport ?? 'Set Airport',
                              onPressed: () async {
                                await myHomeController.setAirportDialog(context);
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

class TimaticTrueResultWidget extends ConsumerStatefulWidget {
  final DocumentResponse res;

  const TimaticTrueResultWidget({super.key, required this.res});

  @override
  ConsumerState<TimaticTrueResultWidget> createState() => _TimaticTrueResultWidgetState();
}

class _TimaticTrueResultWidgetState extends ConsumerState<TimaticTrueResultWidget> {

  ExpansibleController expansibleController = ExpansibleController();
  @override
  Widget build(BuildContext context) {
    final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> visas = ref.watch(visasProvider);
    final List<DocumentDetail> residents = ref.watch(residentsProvider);
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    final List<ItinerarySegment> segments = ref.watch(segmentsProvider);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 0),
              decoration: BoxDecoration(color: widget.res.evaluationResult.getColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.res.evaluationResult.getTitle}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: widget.res.evaluationResult.getColor),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: widget.res.evaluationResult.getColor, borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(widget.res.evaluationResult.getIcon, color: Colors.white, size: 25),
                              const SizedBox(width: 4),
                              Text(
                                widget.res.evaluationResult.name,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "${(widget.res.refCode ?? '').split("-").last}",
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              MyExpansionTile(
                controller:expansibleController,
                key:Key("result req exp"),
                tilePadding: EdgeInsets.symmetric(horizontal: 8),
                showFooter: false,
                title:  Container(
                  // margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                  decoration: BoxDecoration(color: widget.res.evaluationResult.getColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    children: [

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: MyColors.black8),
                        ),
                        child: RequestBriefWidget(),
                      ),
                    ],
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: MyColors.scaffoldHeader,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text("FLIGHT", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                              ),
                              MyButton(
                                label: "Scan",
                                icon: Icons.qr_code_scanner,
                                onPressed: () {
                                  HomeViewPhone.myHomeController.goNamed(Routes.barcodeReader);
                                },
                                textColor: Colors.white,
                                // textColor: context.mainColor,
                                borderSide: BorderSide(color: Colors.white),
                                radius: 12,
                              ),
                            ],
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            // var seg = segments[0];
                            // int index = 0;
                            return Column(
                              children: segments.map((seg) {
                                int index = segments.indexOf(seg);
                                bool isLast = segments.length == index + 1;
                                bool isFirst = index == 0;
                                return SegmentItemRow(index: index, item: seg, isLast: isLast, isFirst: isFirst);
                              }).toList(),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        PassengerDetailsWidget(),
                        const SizedBox(height: 12),
                        Visibility(
                          visible: passports.isNotEmpty,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  // color: MyColors.scaffoldHeader,
                                  color: Color(0xff324073).withOpacity(0.4),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text("PASSPORT", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                                    ),
                                    DotButton(
                                      icon: ArtemisIcons.trash,
                                      color: Colors.red,
                                      flat: true,
                                      onPressed: () async {
                                        final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                                        if (!confirm) return;
                                        // ref.read(passportsProvider.notifier).removeAt(index);
                                        int lastIndex = passports.length - 1;
                                        ref.read(passportsProvider.notifier).removeAt(lastIndex);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    DotButton(
                                      border: BorderSide(color: Colors.blueAccent),
                                      icon: Icons.refresh,
                                      flat: true,
                                      onPressed: () async {
                                        final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                                        if (!confirm) return;
                                        int lastIndex = passports.length - 1;
                                        ref.read(passportsProvider.notifier).updateAt(lastIndex, DocumentDetail());
                                      },
                                    ),

                                  ],
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  return Column(
                                    children: passports.map((d) {
                                      int index = passports.indexOf(d);
                                      bool isLast = passports.length == index + 1;
                                      bool isFirst = index == 0;
                                      return PassportItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst);
                                    }).toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Visibility(
                          visible: visas.isNotEmpty,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  // color: MyColors.scaffoldHeader,
                                  color: Colors.orange.withOpacity(0.4),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text("VISA", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                                    ),
                                    DotButton(
                                      icon: ArtemisIcons.trash,
                                      color: Colors.red,
                                      flat: true,
                                      onPressed: () async {
                                        final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                                        if (!confirm) return;
                                        int lastIndex = visas.length - 1;
                                        ref.read(visasProvider.notifier).removeAt(lastIndex);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    DotButton(
                                      border: BorderSide(color: Colors.blueAccent),
                                      icon: Icons.refresh,
                                      flat: true,
                                      onPressed: () async {
                                        final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                                        if (!confirm) return;
                                        int lastIndex = visas.length - 1;
                                        ref.read(visasProvider.notifier).updateAt(lastIndex, DocumentDetail());

                                        // ref.read(segmentsProvider.notifier).updateAt(index, ItinerarySegment.empty());
                                      },
                                    ),
                                    // MyButton(
                                    //   label: "Scan",
                                    //   icon: Icons.qr_code_scanner,
                                    //   onPressed: () {
                                    //     myHomeController.goNamed(Routes.mrzReader);
                                    //   },
                                    //   textColor: Colors.white,
                                    //   // textColor: context.mainColor,
                                    //   borderSide: BorderSide(color: Colors.white),
                                    //   radius: 12,
                                    // ),
                                  ],
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  return Column(
                                    children: visas.map((d) {
                                      int index = visas.indexOf(d);
                                      bool isLast = visas.length == index + 1;
                                      bool isFirst = index == 0;
                                      return VisaItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst);
                                    }).toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Visibility(
                          visible: residents.isNotEmpty,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  // color: MyColors.scaffoldHeader,
                                  color: Colors.green.withOpacity(0.4),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text("ID / Residency Card".toUpperCase(), style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                                    ),
                                    DotButton(
                                      icon: ArtemisIcons.trash,
                                      color: Colors.red,
                                      flat: true,
                                      onPressed: () async {
                                        final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Delete", actions: ["Cancel", "Confirm"]));
                                        if (!confirm) return;
                                        int lastIndex = residents.length - 1;
                                        ref.read(residentsProvider.notifier).removeAt(lastIndex);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    DotButton(
                                      border: BorderSide(color: Colors.blueAccent),
                                      icon: Icons.refresh,
                                      flat: true,
                                      onPressed: () async {
                                        final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                                        if (!confirm) return;
                                        int lastIndex = residents.length - 1;
                                        ref.read(residentsProvider.notifier).updateAt(lastIndex, DocumentDetail());

                                        // ref.read(segmentsProvider.notifier).updateAt(index, ItinerarySegment.empty());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  return Column(
                                    children: residents.map((d) {
                                      int index = residents.indexOf(d);
                                      bool isLast = residents.length == index + 1;
                                      bool isFirst = index == 0;
                                      return ResidentItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst);
                                    }).toList(),
                                  );
                                },
                              ),
                              PhotoAttachmentWidget()
                            ],
                          ),
                        ),
                      ],),
                  )
                ],
              ),
              ...widget.res.segmentResults.map((segRes) {
              int index = widget.res.segmentResults.indexOf(segRes);
              segRes.ruleSetEvaluations.sort((a, b) => a.evaluationResult.index.compareTo(b.evaluationResult.index));
              return MyExpansionTile(
                initiallyExpanded: segRes.ruleSetEvaluations.any((a) => a.evaluationResult.index < 2),
                tilePadding: EdgeInsets.symmetric(horizontal: 16),
                showFooter: false,
                title: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: segRes.segmentEvaluationResult.getColor.withOpacity(0.12)),
                        color: segRes.segmentEvaluationResult.getColor.withOpacity(0.08),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: segRes.segmentEvaluationResult.getColor.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(children: [Text("Seg #${index + 1} "), Spacer(), Text(segRes.departure.point), Icon(Icons.arrow_right_alt), Text(segRes.arrival.point)]),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(segRes.segmentEvaluationResult.getTitle, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              // visaField.applicable ? 'Applicable' : "Not applicable",
                              segRes.segmentEvaluationResult.getSubtitle,
                              style: TextStyle(color: segRes.segmentEvaluationResult.getColor, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 72,
                            decoration: BoxDecoration(color: segRes.segmentEvaluationResult.getColor, borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(segRes.segmentEvaluationResult.getIcon, color: Colors.white, size: 25),
                                  const SizedBox(width: 4),
                                  Text(
                                    segRes.segmentEvaluationResult.getActionName,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                children: [
                  segRes.commonBorder == null ? const SizedBox() : CommonBorderWidget(commonBorder: segRes.commonBorder!),
                  ...segRes.ruleSetEvaluations.map((rs) => RuleSetWidget(ruleSet: rs)),
                ],
                // children: res.segmentResults.first.ruleSetEvaluations.map((a) => RuleSetWidget(ruleSet: a)).toList(),
                // children: res.segmentResults.map((a) {
                //
                //   log(a.ruleSetEvaluations.first.evaluationResult.name);
                //
                //   a.ruleSetEvaluations.sort((a,b)=>a.evaluationResult.name.compareTo(b.evaluationResult.name));
                //   return Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       a.commonBorder == null ? const SizedBox() : CommonBorderWidget(commonBorder: a.commonBorder!),
                //       ...a.ruleSetEvaluations.map((rs) => RuleSetWidget(ruleSet: rs)).toList(),
                //     ],
                //   );
                // }).toList(),
              );
            }).toList()],
          ),
        ),
      ],
    );
  }
}

class TimaticResultWidget extends StatelessWidget {
  final DocumentResponse res;

  const TimaticResultWidget({super.key, required this.res});

  @override
  Widget build(BuildContext context) {
    log(res.segmentResults.length.toString());

    // final commonBorder = res.segmentResults.first.commonBorder;
    return ListView(
      children: res.segmentResults.map((segRes) {
        final visaField = segRes.ruleSetEvaluations.firstWhereOrNull((a) => a.ruleSetType.name.startsWith("Visa Requirements"));
        int index = res.segmentResults.indexOf(segRes);
        segRes.ruleSetEvaluations.sort((a, b) => a.evaluationResult.index.compareTo(b.evaluationResult.index));
        return MyExpansionTile(
          initiallyExpanded: segRes.ruleSetEvaluations.any((a) => a.evaluationResult.index < 2),
          tilePadding: EdgeInsets.symmetric(horizontal: 16),
          showFooter: false,
          title: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.lightBlueAccent.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(children: [Text("(${(res.refCode ?? '').split("-").last}) Seg #${index + 1} "), Spacer(), Text(segRes.departure.point), Icon(Icons.arrow_right_alt), Text(segRes.arrival.point)]),
              ),
              const SizedBox(height: 8),
              visaField == null
                  ? NoVisaDataCardWidget()
                  : Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: visaField.evaluationResult.getColor.withOpacity(0.12)),
                        color: visaField.evaluationResult.getColor.withOpacity(0.08),
                      ),
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(visaField.evaluationResult.getTitle, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              // visaField.applicable ? 'Applicable' : "Not applicable",
                              visaField.evaluationResult.getSubtitle,
                              style: TextStyle(color: visaField.getColor, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 72,
                            decoration: BoxDecoration(color: visaField.getColor, borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(visaField.getIcon, color: Colors.white, size: 25),
                                  const SizedBox(width: 4),
                                  Text(
                                    visaField.evaluationResult.getActionName,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
          children: [
            segRes.commonBorder == null ? const SizedBox() : CommonBorderWidget(commonBorder: segRes.commonBorder!),
            ...segRes.ruleSetEvaluations.map((rs) => RuleSetWidget(ruleSet: rs)),
          ],
          // children: res.segmentResults.first.ruleSetEvaluations.map((a) => RuleSetWidget(ruleSet: a)).toList(),
          // children: res.segmentResults.map((a) {
          //
          //   log(a.ruleSetEvaluations.first.evaluationResult.name);
          //
          //   a.ruleSetEvaluations.sort((a,b)=>a.evaluationResult.name.compareTo(b.evaluationResult.name));
          //   return Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       a.commonBorder == null ? const SizedBox() : CommonBorderWidget(commonBorder: a.commonBorder!),
          //       ...a.ruleSetEvaluations.map((rs) => RuleSetWidget(ruleSet: rs)).toList(),
          //     ],
          //   );
          // }).toList(),
        );
      }).toList(),
    );
    // return ListView(
    //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   children:
    //       <Widget>[DocsDataWidget()] +
    //       (res.segmentResults
    //           .map(
    //             (e) => Column(
    //               children: [
    //                 const SizedBox(height: 8),
    //                 Container(
    //                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    //                   margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 6),
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2), offset: Offset(0, 1), spreadRadius: 0, blurRadius: 4)],
    //                     borderRadius: BorderRadius.circular(8),
    //                   ),
    //                   child: Column(
    //                     children: [
    //                       DataField(title: "Regulation Applicability", value: e.regulationApplicability ?? ''),
    //                       const Divider(height: 1.5, thickness: 1.5),
    //                       DataField(
    //                         title: "Departure",
    //                         value: '${e.departureCountry.name} (${e.departure.point})',
    //                         valueWidget: Row(
    //                           children: [
    //                             Text('${e.departureCountry.name} (${e.departure.point})'),
    //                             //const SizedBox(width: 12),
    //                             //Flag.fromString(e.arrivingCountry.code, height: 20, width: 20),
    //                           ],
    //                         ),
    //                       ),
    //                       const Divider(height: 1.5, thickness: 1.5),
    //                       DataField(
    //                         title: "Arrival",
    //                         value: '${e.arrivingCountry.name} (${e.arrival.point})',
    //                         valueWidget: Row(
    //                           children: [
    //                             Text('${e.arrivingCountry.name} (${e.arrival.point})'),
    //                             //const SizedBox(width: 12),
    //                             //Flag.fromString(e.arrivingCountry.code, height: 20, width: 20),
    //                           ],
    //                         ),
    //                       ),
    //                       const Divider(height: 1.5, thickness: 1.5),
    //                       DataField(title: "Evaluation Result (Country)", value: e.segmentEvaluationResult.name),
    //                       //todo nakisa
    //                       //const Divider(height: 1.5, thickness: 1.5),
    //                       //TimaticSummaryWidget(field: e),
    //                     ],
    //                   ),
    //                 ),
    //                 ...e.ruleSetEvaluations.map(
    //                   (section) => Padding(
    //                     padding: const EdgeInsets.only(bottom: 8),
    //                     child: ExpansionTile(
    //                       title: Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Expanded(
    //                                   child: Text(section.ruleSetType.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    //                                 ),
    //                                 Container(
    //                                   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    //                                   decoration: BoxDecoration(color: BasicClass.getColorForEvaluationResult(section.evaluationResult.name)),
    //                                   child: Text(
    //                                     section.evaluationResult.name,
    //                                     style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       children: [
    //                         ...section.documentResults.map((dr) => DocumentResultWidget(docRes: dr)),
    //                         ...section.regulations.map((reg) => RegulationWidget(regulation: reg)),
    //                       ],
    //                       // <Widget>[] +
    //                       //
    //                       // // [...section.documentResults.map((a)=>a.regulations.map((subSec) => RegulationWidget(regulation: subSec)).toList())]+
    //                       // [
    //                       //   (section.documentResults != null && section.documentResults.isNotEmpty)
    //                       //       ? Padding(
    //                       //           padding: const EdgeInsets.all(2),
    //                       //           child: (Column(children: section.documentResults.map((x) => DocumentResultWidget(docRes: x)).toList())),
    //                       //         )
    //                       //       : const SizedBox(),
    //                       // ],
    //                     ),
    //                   ),
    //                 ),
    //                 // e.ruleSetEvaluations.isEmpty
    //                 //     ? const SizedBox()
    //                 //     : Padding(
    //                 //   padding: const EdgeInsets.only(
    //                 //     bottom: 8,
    //                 //   ),
    //                 //   child: ExpansionTile(
    //                 //     title: Padding(
    //                 //       padding: const EdgeInsets.all(8.0),
    //                 //       child: Column(
    //                 //         crossAxisAlignment: CrossAxisAlignment.start,
    //                 //         children: [
    //                 //           Row(
    //                 //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 //             children: [
    //                 //               const Text("Common Border", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    //                 //               Container(
    //                 //                 padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    //                 //                 decoration: BoxDecoration(color: BasicClass.getColorForEvaluationResult("")),
    //                 //                 child: Text(
    //                 //                   e.commonBorder!.value,
    //                 //                   style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    //                 //                 ),
    //                 //               ),
    //                 //             ],
    //                 //           ),
    //                 //         ],
    //                 //       ),
    //                 //     ),
    //                 //     initiallyExpanded: true,
    //                 //     children: [
    //                 //       Padding(
    //                 //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //                 //         child: Text(e.commonBorder!.text),
    //                 //       )
    //                 //     ],
    //                 //   ),
    //                 // ),
    //                 (res.segmentResults.length > 1 ? const Divider(thickness: 4, height: 24) : const SizedBox()),
    //               ],
    //             ),
    //           )
    //           .toList()),
    // );
  }
}

class RuleSetWidget extends StatelessWidget {
  final RuleSetEvaluation ruleSet;

  const RuleSetWidget({super.key, required this.ruleSet});

  @override
  Widget build(BuildContext context) {
    // ruleSet.documentResults.sort((a,b)=>a.evaluationResult.name.compareTo(b.evaluationResult.name));
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
                                child: Text(a.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                              Text(a.evaluationResult.name, style: TextStyle(fontSize: 12, color: BasicClass.getColorForEvaluationResult(a.evaluationResult.name.toString()))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...ruleSet.documentResults.map(
                    (a) => Column(
                      children: a.regulations
                          .map(
                            (a) => Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(a.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                  Text(a.evaluationResult.name, style: TextStyle(fontSize: 12, color: BasicClass.getColorForEvaluationResult(a.evaluationResult.name.toString()))),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
        title: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(ruleSet.ruleSetType.name, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(color: ruleSet.getColor, borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Icon(ruleSet.getIcon, color: Colors.white, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        ruleSet.evaluationResult.name,
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Text("ada")
          ],
        ),
        childrenPadding: EdgeInsets.zero,
        children: [
          ...ruleSet.regulations.map((r) => RegulationWidget(regulation: r)).toList(),
          ...ruleSet.documentResults.map((r) => DocumentResultWidget(docRes: r)).toList(),
        ],
      ),
    );
  }
}

class CommonBorderWidget extends StatelessWidget {
  final CommonBorder commonBorder;

  const CommonBorderWidget({super.key, required this.commonBorder});

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

class DataField extends StatelessWidget {
  final String title;
  final String value;
  final Widget? valueWidget;

  DataField({super.key, required this.title, required this.value, this.valueWidget});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            height: 30,
            child: Row(
              children: [
                Expanded(
                  child: Text(title, style: const TextStyle(color: Color.fromRGBO(160, 160, 160, 1), fontSize: 12)),
                ),
                valueWidget ?? Text(value),
              ],
            ),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.symmetric(vertical: 5),
        //   height: 50,
        //   alignment: Alignment.center,
        //   width: MediaQuery.of(context).size.width * 0.3,
        //   child:
        // ),
      ],
    );
  }
}

class WarningsWidget extends StatelessWidget {
  const WarningsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(),
        // state.wrongPersonDoc
        //     ? const WarningContainer(msg: "Document names do not match", color: Colors.red)
        //     : state.isAnyDocumentExpiryFake
        //     ? const WarningContainer(msg: "Document(s) expiry date is unreadable !", color: Colors.red)
        //     : state.isAnyDocumentExpired
        //     ? const WarningContainer(msg: "Document(s) expired" /*"since ${StringUtility.getDurationDetailsString(state.passportExpiryDate!, justValue: true, longStr: true)} Ago !"*/, color: Colors.red)
        //     : state.isAnyDocumentExpiring
        //     ? const WarningContainer(msg: "Document(s) Expiring soon" /*"in ${StringUtility.getDurationDetailsString(state.passportExpiryDate!, justValue: true, longStr: true)} !"*/, color: Colors.red)
        //     : const SizedBox(),
      ],
    );
  }
}

class WarningContainer extends StatelessWidget {
  final String msg;
  final Color color;

  const WarningContainer({super.key, required this.msg, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: color.withOpacity(0.8)),
      child: Text(
        msg,
        style: GoogleFonts.aBeeZee(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ExpiryStatusWidget extends StatelessWidget {
  final DateTime? expiryDate;

  ExpiryStatusWidget({super.key, required this.expiryDate});

  @override
  Widget build(BuildContext context) {
    if (expiryDate == null || expiryDate!.isAfter(DateTime.now())) return const SizedBox();

    bool isExpiryFake = (expiryDate!.difference(DateTime(1, 1, 1)).inDays) < 1;
    String msg = isExpiryFake ? "Unreadable Date" : StringUtility.getDurationDetailsString(expiryDate!);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        msg,
        style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class NoVisaDataCardWidget extends StatelessWidget {
  const NoVisaDataCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.12)),
        color: color.withOpacity(0.08),
      ),
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Unspecific Status", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              // visaField.applicable ? 'Applicable' : "Not applicable",
              "Missing VISA requirements data",
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 72,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(visaField.getIcon, color: Colors.white, size: 25),
                  // const SizedBox(width: 4),
                  Text(
                    "View Requirements",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class DocsDataWidget extends ConsumerWidget {
//   DocsDataWidget({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final docs = ref.watch(documentProvider);
//     // if (state.documentDetails.isEmpty) return const SizedBox();
//
//     return Container(
//       margin: const EdgeInsets.only(top: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: MyColors.travelDocColor),
//         color: MyColors.travelDocColor.withOpacity(0.10),
//       ),
//       child: ExpansionTile(
//         title: Text("Documents"),
//         children: [
//           ...docs.map((doc) {
//             var index = docs.indexOf(doc);
//             return Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // ArtemisCardField(title: "No.", value: (index + 1).toString()),
//                   // ArtemisCardField(title: "Expiry", value: doc.documentExpiryDate?.format_yyyyMMdd ?? ''),
//                   // ArtemisCardField(title: "Issuing Country", value: doc.documentIssueCountry?.code3 ?? ''),
//                   // ArtemisCardField(title: "Nationality", value: doc.nationality?.code3 ?? '-'),
//                 ],
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

class RegulationWidget extends StatelessWidget {
  late Regulation regulation;

  RegulationWidget({super.key, required this.regulation});

  //final TimaticController myTimaticController = getIt<TimaticController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('${regulation.name} (${regulation.code.toUpperCase()})', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Text(regulation.evaluationResult.name, style: TextStyle(color: BasicClass.getColorForEvaluationResult(regulation.evaluationResult.name), fontSize: 12)),
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
                            children:
                                <Widget>[] +
                                /*e.categories
                                        .map(
                                          (cat) => Text(cat.name),
                                        )
                                        .toList() +
                                    e.categories.map((itf) {
                                      return itf.hrefField == null
                                          ? const SizedBox()
                                          : TextButton(
                                              style: TextButton.styleFrom(backgroundColor: Colors.transparent),
                                              onPressed: () async {
                                                await launch(itf.hrefField ?? "");
                                              },
                                              child: Text(
                                                itf.hrefField ?? "",
                                                style: const TextStyle(decoration: TextDecoration.underline, color: Colors.blueAccent),
                                              ));
                                    }).toList() +*/
                                [HtmlWidget(e.text, onTapUrl: (p0) => launch(p0))],
                          ),
                        ),
                        /*const SizedBox(width: 4),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                //color: e.color,
                              ),
                              child: Center(child: Text(e.verificationMethod, style: const TextStyle(color: Colors.white))),
                            ),
                          )*/
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class DocumentResultWidget extends StatelessWidget {
  late DocumentResult docRes;

  DocumentResultWidget({super.key, required this.docRes});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: docRes.evaluationResult.getColor.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('Evaluation Result for Document No. ${((docRes.documentIndex ?? 0) + 1)}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                      Icon(docRes.evaluationResult.getIcon, size: 15, color: BasicClass.getColorForEvaluationResult(docRes.evaluationResult.name.toString())),
                      Text(docRes.evaluationResult.name, style: TextStyle(fontSize: 12, color: BasicClass.getColorForEvaluationResult(docRes.evaluationResult.name.toString()))),
                    ],
                  ),
                ),
              ] +
              (docRes.regulations.map((s2) => RegulationWidget(regulation: s2)).toList()),
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
    if (nats.toSet().toList().length > 1) {
      // warning = "Nationalities do not match: ${nats.toSet().join(", ")}";
      warningList.add("Nationalities do not match: ${nats.toSet().join(", ")}");
    }
    bDates.addAll(passports.where((a) => a.birthDate != null).map((a) => a.birthDate!.format_yyMMdd));
    bDates.addAll(visas.where((a) => a.birthDate != null).map((a) => a.birthDate!.format_yyMMdd));
    bDates.addAll(residents.where((a) => a.birthDate != null).map((a) => a.birthDate!.format_yyMMdd));
    if (passengerDetails.birthDate != null) {
      bDates.add(passengerDetails.birthDate!.format_yyMMdd);
    }

    if (bDates.toSet().toList().length > 1) {
      // warning = "Nationalities do not match: ${nats.toSet().join(", ")}";
      warningList.add("BirthDates do not match: ${bDates.toSet().join(", ")}");
    }

    if (warningList.isNotEmpty) {
      warning = warningList.join("\n");
    }

    if (warning == null || !ref.watch(showWarningsProvider)) return SizedBox();
    return Container(
      height: 56,
      decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadiusGeometry.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(ArtemisIcons.warning_2, color: Colors.white, size: 30),
          const SizedBox(width: 4),
          Expanded(
            child: Text(warning, style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 4),
          DotButton(
            icon: Icons.close,
            color: Colors.white,
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

class RequestBriefWidget extends ConsumerWidget {
  const RequestBriefWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PassengerDetails passengerDetails = ref.watch(passengerProvider);
    List<ItinerarySegment> segments = ref.watch(segmentsProvider);
    List<DocumentDetail> passports = ref.watch(passportsProvider);
    List<DocumentDetail> visas = ref.watch(visasProvider);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 2,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pax", style: TextStyle(fontSize: 9)),
                            Row(
                              spacing: 2,
                              children: [
                                BriefFiledInfoWidget(label: "Nat", value: passengerDetails.nationality?.code3 ?? ''),
                                BriefFiledInfoWidget(label: "Res", value: passengerDetails.residentCountryCode?.code3 ?? ''),
                              ],
                            ),
                          ],
                        ),
                        passports.isEmpty
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Passport", style: TextStyle(fontSize: 9)),
                                  Row(
                                    children: passports
                                        .map(
                                          (pass) => Row(
                                            spacing: 2,
                                            children: [
                                              Row(
                                                spacing: 2,
                                                children: [
                                                  BriefFiledInfoWidget(label: "Iss", value: pass.documentIssueCountry?.code3),
                                                  BriefFiledInfoWidget(label: "Exp", value: pass.documentExpiryDate?.format_yyMMdd),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                        visas.isEmpty
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Visa", style: TextStyle(fontSize: 9)),
                                  Row(
                                    children: visas
                                        .map(
                                          (visa) => Row(
                                            spacing: 2,
                                            children: [
                                              Row(
                                                spacing: 2,
                                                children: [
                                                  BriefFiledInfoWidget(label: "Iss", value: visa.documentIssueCountry?.code3),
                                                  BriefFiledInfoWidget(label: "Exp", value: visa.documentExpiryDate?.format_yyMMdd),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoAttachmentWidget extends ConsumerWidget {
  const PhotoAttachmentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox();
    final photos = ref.watch(attachingPhotoProvider);
    return Container(
      margin: EdgeInsets.only(top: 12),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 8,
        runSpacing: 4,
        children: [
          MyButton(
            width: 75,
            height: 75,
            label: "Attach\nPhoto",
            // child: Text("Attach\nPhoto",textAlign: TextAlign.center,),
            onPressed: () {
              getIt<HomeController>().selectPhotoToAttachMethodDialog();
            },
            radius: 10,
          ),
          ...photos.map(
            (p) => SizedBox(
              width: 75,
              height: 75,
              child: Stack(
                children: [
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.memory(p, fit: BoxFit.fill),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: DotButton(
                      icon: Icons.delete,
                      color: Colors.red,
                      onPressed: () {
                        ref.read(attachingPhotoProvider.notifier).update((s) => [...s.where((a) => a != p)]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
