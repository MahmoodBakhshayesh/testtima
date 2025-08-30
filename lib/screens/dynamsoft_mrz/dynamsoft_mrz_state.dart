import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dynamsoftMrzStateProvider = ChangeNotifierProvider<DynamsoftMrzState>((_) => DynamsoftMrzState());

class DynamsoftMrzState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


///final userProvider = StateProvider<User?>((ref) => null);
