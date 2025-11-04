import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/widgets/AirlineLogo.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags_pro/country_flags_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils_and_services/country_flag_util.dart';
import '../../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../home_view_phone.dart';

class LockedSegmentRow extends StatelessWidget {
  final ItinerarySegment seg;
  final int index;
  final Color tileColor;

  const LockedSegmentRow({super.key, required this.seg, required this.tileColor, required this.index});

  Widget countryBuilder(dynamic a) => Row(
    children: [
      MyCountryFlagsPro.getFlag(a,width: 22,height: 16,borderRadius: BorderRadius.circular(2)),

      const SizedBox(width: 2),
      Text("$a"),
    ],
  );

  Widget countryPrefixBuilder(String? a) {
    if (a != null) {
      return Row(
        children: [
          const SizedBox(width: 4),
          SizedBox(
            width: 15,
            height: 10,
            child:             MyCountryFlagsPro.getFlag(a,width: 22,height: 16,borderRadius: BorderRadius.circular(2)),

          ),
          const SizedBox(width: 4),
          Text(a, style: TextStyle(fontSize: 12)),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: tileColor),
        padding: EdgeInsets.all(12),
        child: Column(
          spacing: 12,
          children: [
            LockedFieldWidget(label: null, value: Text("Segment ${index + 1}")),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: LockedFieldWidget(half: true, label: "From", value: Text(seg.departure.point)),
                ),
                Expanded(
                  child: LockedFieldWidget(half: true, label: "To", value: Text(seg.arrival.point)),
                ),
                Expanded(
                  child: LockedFieldWidget(
                    half: true,
                    label: "Airline",
                    value: Row(children: [AirlineLogo(seg.operatingCarrier?.code ?? '', size: 30), Text(seg.operatingCarrier?.code ?? '')]),
                  ),
                ),
                Expanded(
                  child: LockedFieldWidget(half: true, label: "Flight #", value: Text(seg.flnb ?? '')),
                ),
              ],
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: LockedFieldWidget(
                    label: "Departure",
                    value: Row(children: [Text(seg.departure.dateTime?.format_ddMMMEEE ?? ''), Text(" - "), Text(seg.departure.time?.format_HHmm ?? '')]),
                  ),
                ),
                Expanded(
                  child: LockedFieldWidget(
                    label: "Arrival",
                    value: Row(children: [Text(seg.arrival.dateTime?.format_ddMMMEEE ?? ''), Text(" - "), Text(seg.arrival.time?.format_HHmm ?? '')]),
                  ),
                ),
                Expanded(
                  child: LockedFieldWidget(label: "Type", value: Text(seg.segmentType?.title ?? '')),
                ),
              ],
            ),
            Row(
              spacing: 12,
              children: [
              Expanded(
                child: LockedFieldWidget(label: "Ticket", value: Text(seg.returnOnwardTicket?.title ?? '')),
              ),
              Expanded(
                child: LockedFieldWidget(label: "POS", value: Text(seg.purposeOfStay?.title ?? "")),
              ),
              Expanded(
                child: LockedFieldWidget(label: "DOS", value: Text(seg.durationOfStay?.formatDurationUnit ?? '')),
              ),
            ],)
            // ?seg.luggageCollected != null ? LockedFieldWidget(label: "Luggage Collected", value: Text(seg.luggageCollected!?"Yes":"No")) : null,
          ],
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: tileColor),
      padding: EdgeInsets.all(12),
      child: Column(
        spacing: 12,
        children: [
          LockedFieldWidget(label: null, value: Text("Segment ${index + 1}")),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: LockedFieldWidget(half: true, label: "From", value: Text(seg.departure.point)),
              ),
              Expanded(
                child: LockedFieldWidget(half: true, label: "To", value: Text(seg.arrival.point)),
              ),
            ],
          ),
          ?(seg.operatingCarrier != null && seg.flnb != null)
              ? Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: LockedFieldWidget(
                        half: true,
                        label: "Airline",
                        value: Row(children: [AirlineLogo(seg.operatingCarrier?.code ?? '', size: 30), Text(seg.operatingCarrier?.code ?? '')]),
                      ),
                    ),
                    Expanded(
                      child: LockedFieldWidget(half: true, label: "Flight #", value: Text(seg.flnb ?? '')),
                    ),
                  ],
                )
              : null,
          ?(seg.departure.dateTime != null)
              ? Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: LockedFieldWidget(
                        label: "Departure",
                        value: Row(children: [Text(seg.departure.dateTime?.format_ddMMMEEE ?? ''), Text(" - "), Text(seg.departure.time?.format_HHmm ?? '')]),
                      ),
                    ),
                  ],
                )
              : null,
          ?(seg.arrival.dateTime != null)
              ? Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: LockedFieldWidget(
                        label: "Arrival",
                        value: Row(children: [Text(seg.arrival.dateTime?.format_ddMMMEEE ?? ''), Text(" - "), Text(seg.arrival.time?.format_HHmm ?? '')]),
                      ),
                    ),
                  ],
                )
              : null,
          ?seg.segmentType != null ? LockedFieldWidget(label: "Type", value: Text(seg.segmentType!.title)) : null,
          ?seg.returnOnwardTicket != null ? LockedFieldWidget(label: "Ticket", value: Text(seg.returnOnwardTicket!.title)) : null,
          ?seg.purposeOfStay != null ? LockedFieldWidget(label: "POS", value: Text(seg.purposeOfStay!.title)) : null,
          ?seg.durationOfStay != null ? LockedFieldWidget(label: "DOS", value: Text(seg.durationOfStay!.formatDurationUnit)) : null,
          // ?seg.luggageCollected != null ? LockedFieldWidget(label: "Luggage Collected", value: Text(seg.luggageCollected!?"Yes":"No")) : null,
        ],
      ),
    );
  }
}

class LockedFieldWidget extends StatelessWidget {
  final String? label;
  final bool half;
  final Widget value;

  const LockedFieldWidget({super.key, required this.label, required this.value, this.half = false});

  @override
  Widget build(BuildContext context) {
    final headerBg = Color(0xffFFFFFF);
    final bodyBg = Color(0xffF0F2Fa);
    const height = 40.0;
    return Container(
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),

      child: Row(
        children: [
          label == null
              ? SizedBox()
              : Expanded(
                  flex: half ? 5 : 12,
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                      color: Colors.white.withOpacity(0.48),
                    ),

                    padding: EdgeInsets.only(left: 8, top: 6, bottom: 6),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(label!, style: TextStyle(fontSize: 11)),
                    ),
                  ),
                ),
          const SizedBox(width: 1.5, height: 40),
          Expanded(
            flex: half ? 4 : 33,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(right: Radius.circular(5), left: label == null ? Radius.circular(5) : Radius.zero),
                color: Colors.white.withOpacity(0.48),
              ),
              padding: EdgeInsets.only(left: 4, right: 8, top: 6, bottom: 6),
              child: Align(alignment: Alignment.centerLeft, child: value),
            ),
          ),
        ],
      ),
    );
  }
}
