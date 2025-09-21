import 'package:abds/core/classes/inbox_message_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/classes/ref_history_log_class.dart';

final inboxStateProvider = ChangeNotifierProvider<InboxState>((_) => InboxState());

class InboxState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


final inboxMessagesProvider = StateProvider<List<InboxMessage>>((ref) => []);
final nextMessageId =  StateProvider<int?>((ref) => null);
final inboxMessageDetailsProvider =  StateProvider<List<RefHistoryLog>>((ref) => []);
