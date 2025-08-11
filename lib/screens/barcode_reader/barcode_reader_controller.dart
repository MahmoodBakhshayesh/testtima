import 'dart:developer';

import 'package:abds/screens/home/home_state.dart';
import 'package:logging/logging.dart';
import '../../core/classes/boarding_pass_class.dart';
import '../../core/interfaces/controller_int.dart';


class BarcodeReaderController extends ControllerInterface {
  final _log = Logger('BarcodeReaderController');
  String? lastScanned;
  DateTime lastScanTime = DateTime.now();

  void onBarcodeRead(String barcode) {
    if (barcode == lastScanned && DateTime.now().difference(lastScanTime).inSeconds < 5) return;
    lastScanned = barcode;
    lastScanTime = DateTime.now();


    if (barcode.startsWith("M1") && barcode.length > 56) {
      try {
        BoardingPass bp = BoardingPass.fromBarcode(barcode);
        final segment = bp.getFlightLeg;

        ref.read(segmentsProvider.notifier).update((s)=>[segment]);
        navigation.pop();
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
