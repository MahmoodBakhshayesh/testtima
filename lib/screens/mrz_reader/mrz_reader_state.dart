import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mrzReaderStateProvider = ChangeNotifierProvider<MrzReaderState>((_) => MrzReaderState());

class MrzReaderState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


///final userProvider = StateProvider<User?>((ref) => null);
