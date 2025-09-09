// State + Actions
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../timatic/artemis_timatic.dart';

final segmentsProvider = StateNotifierProvider<ItemsController, List<ItinerarySegment>>((ref) {
  return ItemsController([]);
});

class ItemsController extends StateNotifier<List<ItinerarySegment>> {
  ItemsController(super.state);

  void add(ItinerarySegment item) {
    state = [...state, item]; // add with instance
  }

  void removeAt(int index) {
    final next = [...state]..removeAt(index);
    state = next;
  }

  void updateAt(int index, ItinerarySegment item) {
    final next = [...state];
    next[index] = item;
    state = next;
  }

  void removeAll() {
    final next = [ItinerarySegment.empty()];
    state = next;
  }

  void setAll(List<ItinerarySegment> next) {
    state = [...next];
  }
}
