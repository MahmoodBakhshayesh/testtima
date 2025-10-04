import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/classes/outbox_message_class.dart';

final outboxStateProvider = ChangeNotifierProvider<OutboxState>((_) => OutboxState());

class OutboxState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


///final userProvider = StateProvider<User?>((ref) => null);

final outboxMessagesProvider = StateProvider<List<OutboxMessage>>((ref) => []);
final outboxNextMessageId =  StateProvider<int?>((ref) => null);
