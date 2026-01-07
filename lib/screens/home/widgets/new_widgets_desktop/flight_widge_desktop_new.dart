import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/classes/basic_class.dart';
import '../../../../core/classes/constant_data_class.dart';
import '../../../../core/constants/ui.dart';
import '../../../../core/extenstions/context_exp.dart';
import '../../../../core/interfaces/local_data_base_int.dart';
import '../../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../../core/utils_and_services/country_flag_util.dart';
import '../../../../core/utils_and_services/operations/confirm_operation.dart';
import '../../../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../../../core/utils_and_services/timatic/src/models/document_request.dart';
import '../../../../core/utils_and_services/timatic/src/models/enums.dart';
import '../../../../initialize.dart';
import '../../../../widgets/AirlineLogo.dart';
import '../../../../widgets/DotButton.dart';
import '../../../../widgets/DurationOfStayPicker.dart';
import '../../../../widgets/MyButton.dart';
import '../../../../widgets/MyDatePicker.dart';
import '../../../../widgets/MyExpansionTile.dart';
import '../../../../widgets/MyFieldPicker.dart';
import '../../../../widgets/MySwitchButton.dart';
import '../../../../widgets/MyTextFieldNew.dart';
import '../../../../widgets/MyTimePicker.dart';
import '../../home_controller.dart';

class FlightWidgetDesktop extends ConsumerWidget {
  const FlightWidgetDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final segments = ref.watch(segmentsProvider);
    final bool hasTransit = segments.length > 1;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusGeometry.circular(12)),
      child: Column(
        spacing: 8,
        children: segments.map((seg) {
          int index = segments.indexOf(seg);
          bool isLast = index == segments.length - 1;
          bool isFirst = index == 0;
          return ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Container(
              color: Color(0xffEDF1F5),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Segment ${index + 1}",
                        ),
                      ),
                    ),
                    VerticalDivider(width: 2, color: MyColors.black3),
                    Expanded(
                      child: SegmentWidgetDesktop(
                        segment: seg,
                        index: index,
                        isFirst: isFirst,
                        isLast: isLast,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SegmentWidgetDesktop extends ConsumerStatefulWidget {
  final ItinerarySegment segment;
  final int index;
  final bool isFirst;
  final bool isLast;

  const SegmentWidgetDesktop({super.key, required this.segment, required this.index, required this.isFirst, required this.isLast});

  @override
  ConsumerState<SegmentWidgetDesktop> createState() => _SegmentWidgetDesktopState();
}

class _SegmentWidgetDesktopState extends ConsumerState<SegmentWidgetDesktop> {
  final mandatories = BasicClass.constData.data.mandatory!.flight;
  late final TextEditingController flnbC;

  @override
  void initState() {
    super.initState();
    flnbC = TextEditingController(text: widget.segment.flnb);

    flnbC.addListener(() {
      Future(() {
        ref.read(segmentsProvider.notifier).updateAt(widget.index, widget.segment.copyWith(flnb: flnbC.text));
      });
    });
  }

  @override
  void didUpdateWidget(SegmentWidgetDesktop oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (flnbC.text != widget.segment.flnb) {
      flnbC.text = widget.segment.flnb ?? '';
    }
  }

  @override
  void dispose() {
    flnbC.dispose();
    super.dispose();
  }

  Widget countryBuilder(dynamic a) => Row(
    children: [
      MyCountryFlagsPro.getFlag(a, width: 22, height: 16, borderRadius: BorderRadius.circular(2)),
      const SizedBox(width: 8),
      Text("$a (${(a as Country).name})"),
    ],
  );

  @override
  Widget build(BuildContext context) {
    var seg = widget.segment;
    bool isFirst = widget.isFirst;
    bool isLast = widget.isLast;
    int index = widget.index;
    final List<ItinerarySegment> segments = ref.watch(segmentsProvider);
    final bool hasTransit = segments.length > 1;
    final mandatories = BasicClass.constData.data.mandatory!.flight;
    String fName = "Segment${hasTransit ? " ${widget.index + 1}" : ""}";
    TextStyle mainsStyle = TextStyle(fontSize: 20, color: MyColors.mainBlue);
    TextStyle secondaryStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w200);
    if (isFirst) {
      return MyExpansionTile(
        backgroundColor: Color(0xffEDF1F5),
        collapsedBackgroundColor: Color(0xffEDF1F5),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 12,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(color: Color(0xffECECEC), borderRadius: BorderRadiusGeometry.circular(12)),
              padding: EdgeInsets.all(4),
              child: seg.operatingCarrier == null
                  ? SizedBox()
                  : AirlineLogo(
                "${seg.operatingCarrier!.code}",
                size: 75,
              ),
            ),
            Expanded(
              child: MyTextFieldNew(
                label: "Flight Number",
                labelInRow: false,
                bodyBgColor: Colors.white,
                height: 60,
                style: mainsStyle,
                controller: flnbC,
                radius: BorderRadius.circular(12),
                required: mandatories!.flightNumber && isFirst,
                openNumberSheet: true,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                placeholder: "Number",
                onSubmit: (a) async {
                  await getIt<HomeController>().getFlightNumberHistory(a, index: widget.index);
                },
              ),
            ),
            Expanded(
              child: MyFieldPicker(
                label: "Airline",
                style: mainsStyle,
                items: BasicClass.constData.data.carrier,
                labelInRow: false,
                searchAutoFocus: true,
                bodyBgColor: Colors.white,
                height: 60,
                radius: BorderRadius.circular(12),
                required: true,
                value: seg.operatingCarrier,
                onChange: (a) {
                  seg = seg.copyWith(operatingCarrier: a);
                  ref.read(segmentsProvider.notifier).updateAt(index, seg);
                },
              ),
            ),
            Expanded(
              child: MyFieldPicker(
                label: "From",
                height: 60,
                style: mainsStyle,
                radius: BorderRadius.circular(12),
                searchAutoFocus: true,
                // valueToString: (dynamic a) => "$a",
                itemToWidget: (dynamic a) => Text(
                  "$a",
                  style: TextStyle(fontSize: 20, color: MyColors.mainBlue),
                ),
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
                labelInRow: false,
                bodyBgColor: Colors.white,
                required: true,
              ),
            ),
            Expanded(
              child: MyFieldPicker(
                label: "To",
                height: 60,
                labelInRow: false,
                style: mainsStyle,
                radius: BorderRadius.circular(12),
                bodyBgColor: Colors.white,
                itemToWidget: (dynamic a) => Text(
                  "$a",
                  style: TextStyle(fontSize: 20, color: MyColors.mainBlue),
                ),
                required: mandatories!.to,
                searchAutoFocus: true,
                items: BasicClass.constData.data.airport,
                // valueToString: (dynamic a) => "$a",
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
            Expanded(
              child: MyFieldPicker(
                label: "Type",
                labelInRow: false,
                height: 60,
                style: mainsStyle,
                radius: BorderRadius.circular(12),
                bodyBgColor: Colors.white,
                items: SegmentType.values,
                hasSearch: false,
                required: mandatories!.flightType && isFirst,
                value: seg.segmentType,

                onChange: (a) {
                  seg = seg.copyWith(segmentType: a);
                  ref.read(segmentsProvider.notifier).updateAt(index, seg);
                },
              ),
            ),
            Expanded(
              child: MyDurationOfStayPicker(
                label: "DOS",
                height: 60,
                style: secondaryStyle,
                radius: BorderRadius.circular(12),
                bodyBgColor: Colors.white,
                labelInRow: false,
                placeholder: "Duration Of Stay",
                value: seg.durationOfStay,
                required: mandatories!.dos && isFirst,
                onChange: (a) {
                  seg = seg.copyWith(durationOfStay: a);
                  ref.read(segmentsProvider.notifier).updateAt(index, seg);
                },
              ),
            ),
            DotButton(
              icon: ArtemisIcons.eraser_1,
              onPressed: () async {
                final confirm = await ConfirmOperation.getConfirm(
                  Operation(type: OperationType.warning, icon: ArtemisIcons.eraser_1, message: 'You are about to clear "$fName" in flight information. Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]),
                );
                if (!confirm) return;
                ref.read(segmentsProvider.notifier).updateAt(widget.index, ItinerarySegment.empty());
              },
              size: 40,
              iconSize: 20,
              radius: 8,
              flat: true,
              border: BorderSide(width: 1, color: context.mainColor),
            ),
          ],
        ),
        footerExtra: isLast
            ? MyButton(
          label: "Segment",
          height: 30,
          icon: ArtemisIcons.add_square,

          onPressed: () {
            var beforeSeg = seg;
            beforeSeg = beforeSeg.copyWith(luggageCollected: false, segmentType: SegmentType.transit, purposeOfStay: beforeSeg.purposeOfStay, returnOnwardTicket: beforeSeg.returnOnwardTicket);
            ref.read(segmentsProvider.notifier).updateAt(index, beforeSeg);
            var newSeg = ItinerarySegment.empty();
            newSeg = newSeg.copyWith(departure: seg.arrival);
            ref.read(segmentsProvider.notifier).add(newSeg);
          },
          reverse: true,
        )
            : Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
            width: 165,
            height: 30,
            child: MySwitchButton(
              rowLabelRatio: [4, 3],
              value: seg.luggageCollected ?? false,
              onChanged: (a) {
                seg = seg.copyWith(luggageCollected: a);
                ref.read(segmentsProvider.notifier).updateAt(index, seg);
              },
              label: "Luggage Collect",
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: MyFieldPicker<TicketStatus>(
                    label: "Ticket",
                    height: 60,
                    placeholder: "Ticket",
                    style: secondaryStyle,
                    radius: BorderRadius.circular(12),

                    required: mandatories!.ticket && isFirst,
                    value: seg.returnOnwardTicket,
                    labelInRow: false,
                    bodyBgColor: Colors.white,
                    items: TicketStatus.values,
                    onChange: (a) {
                      seg = seg.copyWith(returnOnwardTicket: a);
                      ref.read(segmentsProvider.notifier).updateAt(index, seg);
                    },
                  ),
                ),
                Expanded(
                  child: MyFieldPicker<PurposeOfStayType>(
                    label: "POS",
                    height: 60,
                    required: mandatories!.pos && isFirst,
                    value: seg.purposeOfStay,
                    style: secondaryStyle,
                    radius: BorderRadius.circular(12),

                    placeholder: "POS",
                    labelInRow: false,
                    bodyBgColor: Colors.white,
                    items: PurposeOfStayType.values,
                    onChange: (a) {
                      seg = seg.copyWith(purposeOfStay: a);
                      ref.read(segmentsProvider.notifier).updateAt(index, seg);
                      // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                    },
                  ),
                ),
                Expanded(
                  child: MyDatePicker(
                    label: "Departure",
                    placeholder: "Date",
                    height: 60,
                    required: mandatories!.departure && isFirst,
                    style: secondaryStyle,
                    radius: BorderRadius.circular(12),

                    labelInRow: false,
                    value: seg.departure.dateTime,
                    bodyBgColor: Colors.white,
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
                    required: mandatories!.arrival && isFirst,
                    labelInRow: false,
                    placeholder: "Date",
                    style: secondaryStyle,
                    radius: BorderRadius.circular(12),

                    height: 60,
                    bodyBgColor: Colors.white,
                    min: seg.departure.dateTime,
                    value: seg.arrival.dateTime,
                    onChanged: (a) {
                      seg = seg.copyWith(arrival: seg.arrival.copyWith(dateTime: a));
                      ref.read(segmentsProvider.notifier).updateAt(index, seg);

                      // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                    },
                  ),
                ),
                Expanded(
                  child: MyTimePicker(
                    label: "STD",
                    placeholder: "Time",
                    height: 60,
                    required: mandatories!.std && isFirst,
                    style: secondaryStyle,
                    radius: BorderRadius.circular(12),

                    labelInRow: false,
                    bodyBgColor: Colors.white,
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
                    height: 60,
                    required: mandatories!.sta && isFirst,
                    labelInRow: false,
                    style: secondaryStyle,
                    radius: BorderRadius.circular(12),

                    placeholder: "Time",
                    bodyBgColor: Colors.white,
                    value: seg.arrival.time,
                    onChanged: (a) {
                      seg = seg.copyWith(arrival: seg.arrival.copyWith(time: a));
                      ref.read(segmentsProvider.notifier).updateAt(index, seg);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return MyExpansionTile(
      backgroundColor: Color(0xffEDF1F5),
      collapsedBackgroundColor: Color(0xffEDF1F5),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 12,
        children: [
          Expanded(
            child: MyFieldPicker(
              label: "From",
              height: 60,
              style: mainsStyle,
              searchAutoFocus: true,
              // valueToString: (dynamic a) => "$a",
              itemToWidget: (dynamic a) => Text(
                "$a",
                style: TextStyle(fontSize: 20, color: MyColors.mainBlue),
              ),
              searchBuilder: (dynamic a) => "$a ${(a as Airport).name}",
              items: BasicClass.constData.data.airport,
              radius: BorderRadius.circular(12),

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
              labelInRow: false,
              bodyBgColor: Colors.white,
              required: true,
            ),
          ),
          Expanded(
            child: MyFieldPicker(
              label: "To",
              height: 60,
              labelInRow: false,
              style: mainsStyle,
              radius: BorderRadius.circular(12),

              bodyBgColor: Colors.white,
              itemToWidget: (dynamic a) => Text(
                "$a",
                style: TextStyle(fontSize: 20, color: MyColors.mainBlue),
              ),
              required: mandatories!.to,
              searchAutoFocus: true,
              items: BasicClass.constData.data.airport,
              // valueToString: (dynamic a) => "$a",
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
          Expanded(
            child: MyFieldPicker(
              label: "Type",
              labelInRow: false,
              height: 60,
              radius: BorderRadius.circular(12),

              style: mainsStyle,
              bodyBgColor: Colors.white,
              items: SegmentType.values,
              hasSearch: false,
              required: mandatories!.flightType && isFirst,
              value: seg.segmentType,

              onChange: (a) {
                seg = seg.copyWith(segmentType: a);
                ref.read(segmentsProvider.notifier).updateAt(index, seg);
              },
            ),
          ),
          Expanded(
            child: MyDurationOfStayPicker(
              label: "DOS",
              height: 60,
              radius: BorderRadius.circular(12),

              style: secondaryStyle,
              headerBgColor: Color(0xffECECEC),
              bodyBgColor: Colors.white,
              labelInRow: false,
              placeholder: "Duration Of Stay",
              value: seg.durationOfStay,
              required: mandatories!.dos && isFirst,
              onChange: (a) {
                seg = seg.copyWith(durationOfStay: a);
                ref.read(segmentsProvider.notifier).updateAt(index, seg);
              },
            ),
          ),
          DotButton(
            icon: ArtemisIcons.eraser_1,
            onPressed: () async {
              final confirm = await ConfirmOperation.getConfirm(
                Operation(type: OperationType.warning, icon: ArtemisIcons.eraser_1, message: 'You are about to clear "$fName" in flight information. Are you sure', title: "Clear", actions: ["Cancel", "Confirm"]),
              );
              if (!confirm) return;
              ref.read(segmentsProvider.notifier).updateAt(widget.index, ItinerarySegment.empty());
            },
            size: 40,
            iconSize: 20,
            radius: 8,
            flat: true,
            border: BorderSide(width: 1, color: context.mainColor),
          ),
        ],
      ),
      footerExtra: isLast
          ? MyButton(
        label: "Segment",
        height: 30,
        icon: ArtemisIcons.add_square,
        onPressed: () {
          var beforeSeg = seg;
          beforeSeg = beforeSeg.copyWith(luggageCollected: false, segmentType: SegmentType.transit, purposeOfStay: beforeSeg.purposeOfStay, returnOnwardTicket: beforeSeg.returnOnwardTicket);
          ref.read(segmentsProvider.notifier).updateAt(index, beforeSeg);
          var newSeg = ItinerarySegment.empty();
          newSeg = newSeg.copyWith(departure: seg.arrival);
          ref.read(segmentsProvider.notifier).add(newSeg);
        },
        reverse: true,
      )
          : Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SizedBox(
          width: 165,
          height: 30,
          child: MySwitchButton(
            rowLabelRatio: [4, 3],
            value: seg.luggageCollected ?? false,
            onChanged: (a) {
              seg = seg.copyWith(luggageCollected: a);
              ref.read(segmentsProvider.notifier).updateAt(index, seg);
            },
            label: "Luggage Collect",
          ),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: MyTextFieldNew(
                      label: "Flight Number",
                      labelInRow: false,
                      bodyBgColor: Colors.white,
                      height: 60,

                      style: secondaryStyle,
                      controller: flnbC,
                      radius: BorderRadius.circular(12),
                      required: mandatories!.flightNumber && isFirst,
                      openNumberSheet: true,
                      keyboardType: TextInputType.numberWithOptions(signed: true),
                      placeholder: "Number",
                      onSubmit: (a) async {
                        await getIt<HomeController>().getFlightNumberHistory(a, index: widget.index);
                      },
                    ),
                  ),
                  Expanded(
                    child: MyFieldPicker(
                      label: "Airline",
                      style: secondaryStyle,
                      items: BasicClass.constData.data.carrier,
                      labelInRow: false,
                      searchAutoFocus: true,
                      radius: BorderRadius.circular(12),

                      bodyBgColor: Colors.white,
                      height: 60,
                      required: true,
                      value: seg.operatingCarrier,
                      onChange: (a) {
                        seg = seg.copyWith(operatingCarrier: a);
                        ref.read(segmentsProvider.notifier).updateAt(index, seg);
                      },
                    ),
                  ),
                  Expanded(
                    child: MyFieldPicker<TicketStatus>(
                      label: "Ticket",
                      height: 60,
                      placeholder: "Ticket",
                      style: secondaryStyle,
                      radius: BorderRadius.circular(12),

                      required: mandatories!.ticket && isFirst,
                      value: seg.returnOnwardTicket,
                      labelInRow: false,
                      bodyBgColor: Colors.white,
                      items: TicketStatus.values,
                      onChange: (a) {
                        seg = seg.copyWith(returnOnwardTicket: a);
                        ref.read(segmentsProvider.notifier).updateAt(index, seg);
                      },
                    ),
                  ),
                  Expanded(
                    child: MyFieldPicker<PurposeOfStayType>(
                      label: "POS",
                      height: 60,
                      required: mandatories!.pos && isFirst,
                      value: seg.purposeOfStay,
                      style: secondaryStyle,
                      radius: BorderRadius.circular(12),

                      placeholder: "POS",
                      labelInRow: false,
                      bodyBgColor: Colors.white,
                      items: PurposeOfStayType.values,
                      onChange: (a) {
                        seg = seg.copyWith(purposeOfStay: a);
                        ref.read(segmentsProvider.notifier).updateAt(index, seg);
                        // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                      },
                    ),
                  ),
                  Expanded(
                    child: MyDatePicker(
                      label: "Departure",
                      placeholder: "Date",
                      height: 60,
                      required: mandatories!.departure && isFirst,
                      style: secondaryStyle,
                      radius: BorderRadius.circular(12),

                      labelInRow: false,
                      value: seg.departure.dateTime,
                      bodyBgColor: Colors.white,
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
                      required: mandatories!.arrival && isFirst,
                      labelInRow: false,
                      placeholder: "Date",
                      style: secondaryStyle,
                      radius: BorderRadius.circular(12),

                      height: 60,
                      bodyBgColor: Colors.white,
                      min: seg.departure.dateTime,
                      value: seg.arrival.dateTime,
                      onChanged: (a) {
                        seg = seg.copyWith(arrival: seg.arrival.copyWith(dateTime: a));
                        ref.read(segmentsProvider.notifier).updateAt(index, seg);

                        // ref.read(segmentsProvider.notifier).update((s) => [...s]);
                      },
                    ),
                  ),
                  Expanded(
                    child: MyTimePicker(
                      label: "STD",
                      placeholder: "Time",
                      height: 60,
                      required: mandatories!.std && isFirst,
                      style: secondaryStyle,
                      radius: BorderRadius.circular(12),

                      labelInRow: false,
                      bodyBgColor: Colors.white,
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
                      height: 60,
                      required: mandatories!.sta && isFirst,
                      labelInRow: false,
                      style: secondaryStyle,
                      radius: BorderRadius.circular(12),

                      placeholder: "Time",
                      bodyBgColor: Colors.white,
                      value: seg.arrival.time,
                      onChanged: (a) {
                        seg = seg.copyWith(arrival: seg.arrival.copyWith(time: a));
                        ref.read(segmentsProvider.notifier).updateAt(index, seg);
                      },
                    ),
                  ),
                ],
              ),
              ?isLast
                  ? SizedBox(
                width: 165,
                height: 30,
                child: MySwitchButton(
                  rowLabelRatio: [4, 3],
                  value: seg.luggageCollected ?? false,
                  onChanged: (a) {
                    seg = seg.copyWith(luggageCollected: a);
                    ref.read(segmentsProvider.notifier).updateAt(index, seg);
                  },
                  label: "Luggage Collect",
                ),
              )
                  : null,
            ],
          ),
        ),
      ],
    );
  }
}