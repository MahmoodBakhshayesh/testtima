// State + Actions
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../timatic/artemis_timatic.dart';

final passportsProvider = StateNotifierProvider<ItemsController, List<DocumentDetail>>((ref) {
  return ItemsController(const []);
});

class ItemsController extends StateNotifier<List<DocumentDetail>> {
  ItemsController(super.state);

  void add(DocumentDetail item) {
    state = [...state, item]; // add with instance
  }

  void removeAt(int index) {
    final next = [...state]..removeAt(index);
    state = next;
  }

  void updateAt(int index, DocumentDetail item) {
    final next = [...state];
    next[index] = item;
    state = next;
  }

  void removeAll() {
    final List<DocumentDetail> next = [];
    state = next;
  }

  void setAll(List<DocumentDetail> next) {
    state = [...next];
  }
}
