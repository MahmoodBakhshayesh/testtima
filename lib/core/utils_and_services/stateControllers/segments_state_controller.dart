// State + Actions
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../timatic/artemis_timatic.dart';

final segmentsProvider = StateNotifierProvider<ItemsController, List<ItinerarySegment>>((ref) {
  return ItemsController([]);
});

class ItemsController extends StateNotifier<List<ItinerarySegment>> {
  ItemsController(super.state);

  void add(ItinerarySegment item) {
    log("${state.map((a)=>a.purposeOfStay?.name)}");
    log("${[...state.map((a)=>a.purposeOfStay?.name)]}");
    state = [...state, item]; // add with instance
  }

  void removeAt(int index) {
    final next = [...state]..removeAt(index);
    state = next;
  }

  void updateAt(int index, ItinerarySegment item) {
    if (state.isEmpty) {
      state = [item];
    } else {
      final next = [...state];
      next[index] = item;
      state = next;
    }
  }

  void removeAll() {
    final next = [ItinerarySegment.empty()];
    state = next;
  }

  void resetFirst() {
    if (state.isEmpty) {
      state = [ItinerarySegment.empty()];
    }
    final next = [
      ItinerarySegment(
        luggageCollected: true,
        segmentType: SegmentType.entry,
        flnb: state.first.flnb,
        operatingCarrier: state.first.operatingCarrier,
        departure: state.first.departure.copyWith(dateTime: DateTime.now()),
        arrival: state.first.arrival.copyWith(dateTime: DateTime.now()),
      ),
    ];
    state = next;
  }

  void setAll(List<ItinerarySegment> next) {
    state = [...next];
  }
}
