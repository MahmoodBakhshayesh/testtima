import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileStateProvider = ChangeNotifierProvider<ProfileState>((_) => ProfileState());

class ProfileState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


///final userProvider = StateProvider<User?>((ref) => null);
