import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final addUserStateProvider = ChangeNotifierProvider<AddUserState>((_) => AddUserState());

class AddUserState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


///final userProvider = StateProvider<User?>((ref) => null);
