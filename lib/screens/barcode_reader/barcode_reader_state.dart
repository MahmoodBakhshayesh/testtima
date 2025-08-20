import 'package:abds/core/classes/boarding_pass_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final barcodeReaderStateProvider = ChangeNotifierProvider<BarcodeReaderState>((_) => BarcodeReaderState());

class BarcodeReaderState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


///final userProvider = StateProvider<User?>((ref) => null);
final scannedBpProvider = StateProvider<BoardingPass?>((ref)=>null);

