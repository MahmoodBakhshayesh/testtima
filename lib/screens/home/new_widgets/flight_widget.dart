import 'dart:developer';

import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/my_icons.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/widgets/AirlineLogo.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/constants/ui.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../core/utils_and_services/operations/confirm_operation.dart';
import '../../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/DurationOfStayPicker.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../../widgets/MySwitchButton.dart';
import '../../../widgets/MyTextField.dart';
import '../../../widgets/MyTextFieldNew.dart';
import '../../../widgets/MyTimePicker.dart';
import '../home_state.dart';
import '../home_view_phone.dart';
import '../widgets/locked_segment_widget.dart';

class FlightWidget extends ConsumerWidget {
  const FlightWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItinerarySegment> segments = ref.watch(segmentsProvider);
    final bool locked =  ref.watch(currentStatusProvider).isLocked;
    if (locked) {
      return Column(
        children: segments.map((d) {
          return LockedSegmentRow(seg: d, tileColor: Colors.black.withOpacity(0.08), index: segments.indexOf(d));
        }).toList(),
      );
    }
    return MyExpansionTile(
      title: Column(
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text("Flight", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    airlineLogoBuild(segments.first.operatingCarrier)
                  ],
                ),
              ),
              MyButton(
                label: "Scan Boarding Pass",
                onPressed: () {
                  getIt<HomeController>().goNamed(Routes.barcodeReader);
                },
                radius: 8,
              ),
              DotButton(
                icon: ArtemisIcons.eraser_1,
                onPressed: () async {
                  final confirm = await ConfirmOperation.getConfirm(Operation(message: 'Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]));
                  if (!confirm) return;
                  if (segments.length == 1) {
                    ref.read(segmentsProvider.notifier).updateAt(ref.read(segmentsProvider).length - 1, ItinerarySegment.emptyNoAirport());
                  } else {
                    ref.read(segmentsProvider.notifier).removeAt(ref.read(segmentsProvider).length - 1);
                  }
                },
                size: 40,
                iconSize: 20,

                radius: 8,
                flat: true,
                border: BorderSide(width: 1, color: context.mainColor),
              ),
            ],
          ),
          Column(
            children: segments.map((seg) {
              int index = segments.indexOf(seg);
              bool isLast = segments.length == index + 1;
              bool isFirst = index == 0;
              return SegmentItemRow(index: index, item: seg, isLast: isLast, isFirst: isFirst);
            }).toList(),
          ),

          // Row(
          //   spacing: 12,
          //   children: [
          //     Expanded(
          //       child: MyFieldPicker(label: "From", items: [], headerBgColor: Color(0xffECECEC), bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48)),
          //     ),
          //     Expanded(
          //       child: MyFieldPicker(label: "From", items: []),
          //     ),
          //   ],
          // ),
        ],
      ),
      showFooter: false,
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
      Text("$a (${(a as Country).name})"),
    ],
  );

  @override
  Widget build(BuildContext context) {
    bool isLast = widget.isLast;
    bool isFirst = widget.isFirst;
    int index = widget.index;
    ItinerarySegment seg = widget.item;
    final PassengerDetails passengerDetails = ref.watch(passengerProvider);

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),
      child: MyExpansionTile(
        footerRadius: BorderRadius.vertical(bottom: Radius.circular(!isLast ? 0 : 12)),
        shape: RoundedRectangleBorder(),
        collapsedShape: RoundedRectangleBorder(),
        tilePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        footerExtra: IndexedStack(
          index: isLast ? 0 : 1,
          children: [
            MyButton(
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
            SizedBox(),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: MyTextFieldNew(
                    headerBgColor: Color(0xffECECEC),
                    bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
                    controller: controller,
                    label: "Flight#",
                    required: true,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    placeholder: "Number",
                    rowLabelRatio: [3, 5],
                    labelInRow: true,
                    onSubmit: (a) async {
                      log("get history for $a");
                      await getIt<HomeController>().getFlightNumberHistory(a,index:widget.index);

                    },
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: MyFieldPicker<ParameterValue>(
                    label: "Airline",
                    required: true,
                    placeholder: "Airline",
                    searchAutoFocus: true,
                    rowLabelRatio: [3, 5],
                    headerBgColor: Color(0xffECECEC),
                    bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),

                    items: BasicClass.constData.data.carrier,
                    value: seg.operatingCarrier,
                    // prefixIcon: airlineLogoBuild(seg.operatingCarrier),
                    valueToString: (a) => a.code,
                    onChange: (a) {
                      seg = seg.copyWith(operatingCarrier: a);
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
                  child: MyFieldPicker<Airport>(
                    required: true,
                    searchAutoFocus: true,
                    label: "From",
                    placeholder: "City",
                    rowLabelRatio: [3, 5],
                    headerBgColor: Color(0xffECECEC),
                    bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
                    // labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    itemToWidget: (dynamic a) => Text("$a (${(a as Airport).name})"),
                    searchBuilder: (dynamic a) => "$a ${(a as Airport).name}",
                    items: BasicClass.constData.data.airport,
                    value: BasicClass.constData.data.airport.firstWhereOrNull((a) => a.code3 == seg.departure.point),
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
                  child: MyFieldPicker<Airport>(
                    label: "To",
                    placeholder: "City",
                    searchAutoFocus: true,
                    headerBgColor: Color(0xffECECEC),
                    bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
                    rowLabelRatio: [3, 5],
                    // labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    itemToWidget: (dynamic a) => Text("$a (${(a as Airport).name})"),
                    required: true,
                    items: BasicClass.constData.data.airport,
                    searchBuilder: (dynamic a) => "$a ${(a as Airport).name}",
                    value: BasicClass.constData.data.airport.firstWhereOrNull((a) => a.code3 == seg.arrival.point),
                    onChange: (a) {
                      final update = seg.arrival.copyWith(point: a?.code3 ?? '');
                      seg = seg.copyWith(arrival: update);
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
        // childrenPadding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 12),
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
                  headerBgColor: Color(0xffECECEC),
                  bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
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
                  headerBgColor: Color(0xffECECEC),
                  bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
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
                  headerBgColor: Color(0xffECECEC),
                  bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
                  value: seg.departure.time,
                  onChanged: (a) {
                    seg = seg.copyWith(departure: seg.departure.copyWith(time: a));
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
                  headerBgColor: Color(0xffECECEC),
                  bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
                  value: seg.arrival.time,
                  onChanged: (a) {
                    seg = seg.copyWith(arrival: seg.arrival.copyWith(time: a));
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
                child: MyFieldPicker<PurposeOfStayType>(
                  label: "POS",
                  placeholder: "Purpose Of Stay",
                  rowLabelRatio: [3, 5],
                  headerBgColor: Color(0xffECECEC),
                  bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
                  items: PurposeOfStayType.values,
                  hasSearch: false,
                  value: seg.purposeOfStay,
                  onChange: (a) {
                    seg = seg.copyWith(purposeOfStay: a);
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);

                    // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                  },
                ),
              ),

              const SizedBox(width: 12),
              Expanded(
                child: MyDurationOfStayPicker(
                  label: "DOS",
                  headerBgColor: Color(0xffECECEC),
                  bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
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
                  headerBgColor: Color(0xffECECEC),
                  bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
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
                  headerBgColor: Color(0xffECECEC),
                  bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
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
