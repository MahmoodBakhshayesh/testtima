import 'package:artemis_acps/artemis_acps.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cuppsStateProvider = ChangeNotifierProvider<CuppsState>((_) => CuppsState());

class CuppsState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


final acpsProvider = StateProvider<ArtemisAcps?>((ref) => null);
