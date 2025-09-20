import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messageDetailsStateProvider = ChangeNotifierProvider<MessageDetailsState>((_) => MessageDetailsState());

class MessageDetailsState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


///final userProvider = StateProvider<User?>((ref) => null);
