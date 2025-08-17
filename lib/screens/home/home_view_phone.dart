import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:abds/core/navigation/routes.dart';
import 'package:abds/core/utils_and_services/time_picker/ui_permission.dart';
import 'package:abds/screens/login/login_controller.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyDatePicker.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
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
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../core/utils_and_services/stateControllers/visas_state_controller.dart';
import '../../core/utils_and_services/string_utility.dart';
import '../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../initialize.dart';
import '../../widgets/MyExpansionTile.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeViewPhone extends ConsumerWidget {
  static HomeController myHomeController = getIt<HomeController>();

  const HomeViewPhone({super.key});

  Widget countryBuilder(dynamic a) => Row(
    children: [
      ClipRRect(borderRadius: BorderRadiusGeometry.circular(2), child: CountryFlag.fromCountryCode('${a}', width: 22, height: 16)),
      const SizedBox(width: 8),
      Text("$a (${(a as Location).name})"),
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timaticRes = ref.watch(timaticResultProvider);
    final tim = BasicClass.timData;
    // final List<DocumentDetail> documentDetails = ref.watch(documentProvider);
    // final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> passports = ref.watch(passportsProvider);
    final List<DocumentDetail> visas = ref.watch(visasProvider);
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);
    final List<ItinerarySegment> segments = ref.watch(segmentsProvider);
    bool resultMode = timaticRes != null;
    return PopScope(
      canPop: false,
      child: Container(
        color: MyColors.greyBG,
        child: SafeArea(
          bottom: true,
          top: false,
          child: Scaffold(
            appBar: HomeAppBar(),
            backgroundColor: Colors.white,

            body: Column(
              children: [
                if (!resultMode)
                  Expanded(
                    child: SingleChildScrollView(
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
                                      myHomeController.goNamed(Routes.barcodeReader);
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: MyColors.scaffoldHeader,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("PASSPORT", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                                  ),
                                  MyButton(
                                    label: "Scan",
                                    icon: Icons.qr_code_scanner,
                                    onPressed: () {
                                      myHomeController.goNamed(Routes.mrzReader);
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
                                return Column(
                                  children: passports.map((d) {
                                    int index = passports.indexOf(d);
                                    bool isLast = passports.length == index + 1;
                                    bool isFirst = index == 0;
                                    return DocumentItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst, isVisa: false);
                                  }).toList(),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: MyColors.scaffoldHeader,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("VISA", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
                                  ),
                                  MyButton(
                                    label: "Scan",
                                    icon: Icons.qr_code_scanner,
                                    onPressed: () {
                                      myHomeController.goNamed(Routes.mrzReader);
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
                                return Column(
                                  children: visas.map((d) {
                                    int index = visas.indexOf(d);
                                    bool isLast = visas.length == index + 1;
                                    bool isFirst = index == 0;
                                    return DocumentItemRow(index: index, item: d, isLast: isLast, isFirst: isFirst, isVisa: true);
                                  }).toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(child: TimaticResultWidget(res: timaticRes)),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  color: MyColors.greyBG,
                  child: Row(
                    children: [
                      resultMode
                          ? MyButton(
                              label: "Back",
                              borderSide: BorderSide(color: MyColors.black8),
                              icon: Icons.arrow_left,
                              iconSize: 20,
                              onPressed: () {
                                ref.read(timaticResultProvider.notifier).update((s) => null);
                              },
                              reverse: true,
                              color: Colors.black,
                            )
                          : MyButton(
                              label: "Clear",
                              borderSide: BorderSide(color: MyColors.black8),
                              icon: Icons.refresh,
                              onPressed: () {
                                getIt<HomeController>().clear();
                              },
                              reverse: true,
                              color: Colors.black,
                            ),
                      Spacer(),
                      resultMode
                          ? MyButton(
                              label: "Start Again",
                              icon: Icons.refresh,
                              iconInRight: true,
                              onPressed: () async {
                                myHomeController.clear();
                                ref.read(timaticResultProvider.notifier).update((s) => null);
                              },
                              radius: 12,
                            )
                          : MyButton(
                              label: "TIMATIC Check",
                              icon: Icons.perm_identity,
                              iconInRight: true,
                              onPressed: () async {
                                final timResult = await myHomeController.timaticApi.submitDocumentRequest(
                                  DocumentRequest(
                                    documentDetails: [...ref.read(passportsProvider), ...ref.read(visasProvider)].where((a) => a.documentCode != null).toList(),
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

// Row (with its own controller)
class DocumentItemRow extends ConsumerStatefulWidget {
  const DocumentItemRow({super.key, required this.index, required this.item, required this.isLast, required this.isFirst, required this.isVisa});

  final bool isFirst;
  final bool isLast;
  final bool isVisa;
  final int index;
  final DocumentDetail item;

  @override
  ConsumerState<DocumentItemRow> createState() => _DocumentItemRowState();
}

class _DocumentItemRowState extends ConsumerState<DocumentItemRow> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.item.documentNumber);

    controller.addListener(() {
      // log("listern ${controller.text}");
      if (widget.isVisa) {
        ref.read(visasProvider.notifier).updateAt(widget.index, widget.item.copyWith(documentNumber: controller.text));
      } else {
        ref.read(passportsProvider.notifier).updateAt(widget.index, widget.item.copyWith(documentNumber: controller.text));
      }
    });
  }

  @override
  void didUpdateWidget(DocumentItemRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // log(widget.item.toJson().toString());

    if (controller.text != widget.item.documentNumber) {
      controller.text = widget.item.documentNumber ?? '';
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
    DocumentDetail d = widget.item;
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
                label: widget.isVisa ? "Visa" : "Passport",
                icon: Icons.add_circle_outline,
                onPressed: () {
                  // ref.read(passportsProvider.notifier).update((s) => [...s, DocumentDetail()]);
                  if (widget.isVisa) {
                    ref.read(visasProvider.notifier).add(DocumentDetail());
                  } else {
                    ref.read(passportsProvider.notifier).add(DocumentDetail());
                  }
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
                      "DOCUMENT ${index + 1}",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: MyColors.greyText),
                    ),
                  ),
                  isFirst
                      ? SizedBox()
                      : DotButton(
                          icon: Icons.delete,
                          color: Colors.red,
                          flat: true,
                          onPressed: () {
                            // ref.read(passportsProvider.notifier).update((s) => [...s.where((a) => s.indexOf(a) != index)]);
                            if (widget.isVisa) {
                              ref.read(visasProvider.notifier).removeAt(index);
                            } else {
                              ref.read(passportsProvider.notifier).removeAt(index);
                            }
                          },
                        ),
                ],
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: MyDatePicker(
                    label: "Expiry",
                    required: true,
                    placeholder: "Date",
                    value: d.documentExpiryDate,
                    onChanged: (a) {
                      d = d.copyWith(documentExpiryDate: a);
                      if (widget.isVisa) {
                        ref.read(visasProvider.notifier).updateAt(widget.index, d);
                      } else {
                        ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: MyFieldPicker<Location>(
                    hasSearch: true,
                    label: "Nationality",
                    required: true,
                    placeholder: "Country",
                    itemToWidget: countryBuilder,
                    items: tim.locations.of(LocationType.country),
                    value: passengerDetails.nationality,
                    onChange: (a) {
                      ref.read(passengerProvider.notifier).update((s) => s.copyWith(nationality: a));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        childrenPadding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 12),
        children: [
          MyTextField(controller: controller, label: "Document Number", placeholder: "Number", labelInRow: true),
          const SizedBox(height: 12),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: MyFieldPicker<ParameterValue>(
                  label: "Code",
                  placeholder: "Code",
                  items: tim.params.of(ParameterType.documentCode),
                  value: d.documentCode,
                  onChange: (a) {
                    d = d.copyWith(documentCode: a);
                    if (widget.isVisa) {
                      ref.read(visasProvider.notifier).updateAt(widget.index, d);
                    } else {
                      ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                    }
                  },
                ),
              ),
              Expanded(
                child: MyFieldPicker<DocumentFeature>(
                  hasSearch: false,
                  label: "Feature",
                  placeholder: "Feature",
                  items: DocumentFeature.values,
                  value: d.documentFeature,
                  onChange: (a) {
                    d = d.copyWith(documentFeature: a);
                    if (widget.isVisa) {
                      ref.read(visasProvider.notifier).updateAt(widget.index, d);
                    } else {
                      ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                    }
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
                child: MyFieldPicker<Location>(
                  label: "Issuing",
                  placeholder: "Country",
                  itemToWidget: countryBuilder,
                  items: tim.locations.of(LocationType.country),
                  value: d.documentIssueCountry,
                  onChange: (a) {
                    d = d.copyWith(documentIssueCountry: a);
                    if (widget.isVisa) {
                      ref.read(visasProvider.notifier).updateAt(widget.index, d);
                    } else {
                      ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                    }
                  },
                ),
              ),
              Expanded(
                child: MyDatePicker(
                  label: "Issue Date",
                  placeholder: "Issue Date",
                  value: d.documentIssueDate,
                  onChanged: (a) {
                    d = d.copyWith(documentIssueDate: a);
                    if (widget.isVisa) {
                      ref.read(visasProvider.notifier).updateAt(widget.index, d);
                    } else {
                      ref.read(passportsProvider.notifier).updateAt(widget.index, d);
                    }
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
                child: MyFieldPicker<Location>(
                  label: "Birth Place",
                  hasSearch: true,
                  placeholder: "Country",
                  items: tim.locations.of(LocationType.country),
                  itemToWidget: countryBuilder,
                  value: passengerDetails.birthCountry,
                  onChange: (a) {
                    ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthCountry: a));
                  },
                ),
              ),
              Expanded(
                child: MyDatePicker(
                  required: true,
                  label: "Birth Date",
                  placeholder: "Birth Date",
                  value: passengerDetails.birthDate,
                  onChanged: (a) {
                    ref.read(passengerProvider.notifier).update((s) => s.copyWith(birthDate: a));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
      ref.read(segmentsProvider.notifier).updateAt(widget.index, widget.item.copyWith(flnb: controller.text));
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
                  ref.read(segmentsProvider.notifier).add( ItinerarySegment.empty());
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
                    icon: Icons.delete,
                    color: Colors.red,
                    flat: true,
                    onPressed: () {
                      ref.read(segmentsProvider.notifier).removeAt(index);
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
                    label: "From",
                    placeholder: "City",
                    itemToWidget: (dynamic a) => Text("$a (${(a as Location).name})"),
                    items: tim.locations.of(LocationType.airport),
                    value: tim.locations.of(LocationType.airport).firstWhereOrNull((a) => a.code3 == seg.departure.point),
                    onChange: (a) {
                      if (a is Location) {
                        final update = seg.departure.copyWith(point: a.code3);
                        seg = seg.copyWith(departure: update);
                        ref.read(segmentsProvider.notifier).updateAt(index,seg);
                        // final ul = [...segments];
                        // ul[index] = seg;
                        // ref.read(segmentsProvider.notifier).update((s) => ul);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: MyFieldPicker<Location>(
                    label: "To",
                    placeholder: "City",
                    itemToWidget: (dynamic a) => Text("$a (${(a as Location).name})"),
                    required: true,
                    items: tim.locations.of(LocationType.airport),
                    value: tim.locations.of(LocationType.airport).firstWhereOrNull((a) => a.code3 == seg.arrival.point),
                    onChange: (a) {
                      if (a is Location) {
                        final update = seg.arrival.copyWith(point: a.code3);
                        seg = seg.copyWith(arrival: update);
                        ref.read(segmentsProvider.notifier).updateAt(index,seg);

                        // final ul = [...segments];
                        // ul[index] = seg;
                        // ref.read(segmentsProvider.notifier).update((s) => ul);
                      }
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
                  value: seg.departure.dateTime,
                  onChanged: (a) {
                    seg = seg.copyWith(arrival: seg.departure.copyWith(dateTime: a));
                    // log(jsonEncode(seg.toJson()));

                    ref.read(segmentsProvider.notifier).updateAt(index,seg);

                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
              Expanded(
                child: MyDatePicker(
                  label: "Arrival",
                  placeholder: "Date",
                  value: seg.arrival.dateTime,
                  onChanged: (a) {
                    seg = seg.copyWith(arrival: seg.arrival.copyWith(dateTime: a));
                    ref.read(segmentsProvider.notifier).updateAt(index,seg);

                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          MyFieldPicker<ParameterValue>(
            label: "Operating Carrier",
            placeholder: "Airline",
            items: tim.params.of(ParameterType.carrier),
            value: seg.operatingCarrier,
            onChange: (a) {
              seg = seg.copyWith(operatingCarrier: a);
              ref.read(segmentsProvider.notifier).updateAt(index,seg);

              // log(jsonEncode(seg.toJson()));
              // ref.read(segmentsProvider.notifier).update((s) => [...s]);
            },
          ),
          const SizedBox(height: 12),
          MyTextField(controller: controller,label: "Flight Number",placeholder: "Number",labelInRow: true,)
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  static HomeController myHomeController = getIt<HomeController>();
  static SmartOverlayMenuController controller = SmartOverlayMenuController();

  const HomeAppBar({super.key});

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

                        SmartOverlayMenu(
                          blurSize: 2,
                          duration: Duration(milliseconds: 50),
                          controller: controller,
                          blurBackgroundColor: Colors.transparent,
                          bottomWidget: Container(
                            decoration: BoxDecoration(color: MyColors.black2, borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                        return UserAvatar(url: '',canEdit: true,hasImage: ref.watch(userProvider)?.profile.hasImage??false,);
                                      },),

                                      const SizedBox(width: 12),
                                      Consumer(
                                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                          final profile = ref.watch(profileProvider);
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(profile!.username ?? '-', style: TextStyle(color: Colors.white)),
                                              // Text(profile.email??"-", style: TextStyle(color: Colors.white)),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: Colors.white),
                                SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                    dense: true,
                                    title: Text("About", style: TextStyle(color: Colors.white)),
                                    trailing: Icon(Icons.info, color: Colors.white),
                                    onTap: () {
                                      showAboutDialog(context: context, applicationName: "ABOMIS Document Check", applicationVersion: "");
                                    },
                                  ),
                                ),
                                CheckPermission(
                                  permission: UserUiPermission.add(),
                                  child: SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                      dense: true,
                                      title: Text("User Management", style: TextStyle(color: Colors.white)),
                                      trailing: Icon(Icons.supervised_user_circle_sharp, color: Colors.white),
                                      onTap: () {
                                        myHomeController.goNamed(Routes.users);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                    dense: true,
                                    title: Text("Logout", style: TextStyle(color: Colors.red)),
                                    trailing: Icon(Icons.exit_to_app, color: Colors.red),
                                    onTap: () {
                                      getIt<LoginController>().logout();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: MyButton(
                            label: "Menu",
                            radius: 12,
                            icon: Icons.menu,
                            onPressed: () {
                              controller.open();
                            },
                            borderSide: BorderSide(color: MyColors.black8),
                            color: Colors.white,
                            textColor: Colors.black,
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
    );
  }
}

class TimaticResultWidget extends StatelessWidget {
  final DocumentResponse res;

  const TimaticResultWidget({super.key, required this.res});

  @override
  Widget build(BuildContext context) {
    log(res.segmentResults.length.toString());
    final visaField = res.segmentResults.first.ruleSetEvaluations.firstWhereOrNull((a) => a.ruleSetType.name.startsWith("Visa Requirements"));
    final commonBorder = res.segmentResults.first.commonBorder;
    return ListView(
      children: [
        MyExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.symmetric(horizontal: 16),
          title: visaField == null
              ? SizedBox()
              : Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: MyColors.red.withOpacity(0.12)),
                    color: MyColors.red.withOpacity(0.08),
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
          // children: res.segmentResults.first.ruleSetEvaluations.map((a) => RuleSetWidget(ruleSet: a)).toList(),
          children: res.segmentResults
              .map(
                (a) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    a.commonBorder == null ? const SizedBox() : CommonBorderWidget(commonBorder: a.commonBorder!),
                    ...a.ruleSetEvaluations.map((rs) => RuleSetWidget(ruleSet: rs)).toList(),
                  ],
                ),
              )
              .toList(),
        ),
      ],
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
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14.0, top: 14),
      child: MyExpansionTile(
        showFooter: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: ruleSet.getColor.withOpacity(0.12)),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: ruleSet.getColor.withOpacity(0.12)),
        ),
        backgroundColor: ruleSet.getColor.withOpacity(0.08),
        collapsedBackgroundColor: ruleSet.getColor.withOpacity(0.08),
        tilePadding: EdgeInsets.symmetric(horizontal: 14),
        title: Row(
          children: [
            Expanded(
              child: Text(ruleSet.ruleSetType.name, style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: ruleSet.getColor, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Icon(ruleSet.getIcon, color: Colors.white),
                  Text(ruleSet.evaluationResult.name, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
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
