import 'dart:developer';

import 'package:abds/screens/barcode_reader/barcode_reader_state.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:logging/logging.dart';
import '../../core/classes/boarding_pass_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';


class BarcodeReaderController extends ControllerInterface {
  final _log = Logger('BarcodeReaderController');
  String? lastScanned;
  DateTime lastScanTime = DateTime.now();

  void onBarcodeRead(String barcode) {
    // log(barcode);
    if (barcode == lastScanned && DateTime.now().difference(lastScanTime).inSeconds < 5) return;
    lastScanned = barcode;
    lastScanTime = DateTime.now();
    ///M2SIBANGANI/RACHAEL MSEEWPLZE CPHADDET 0725 239Y055L0129 377>8322RO5239BET 3071605428002                          2A0712748466992 1ET                        N*30602046K0900       EWPLZE ADDVFAET 0823 240Y030A0139 32C290712748466992 1ET                        N


    List<BoardingPass> bpl = BoardingPass.listFromBarcode(barcode);
    if(bpl.isNotEmpty){
      for (var bp in bpl) {
        final segment = bp.getFlightLeg;
        int emptyIndex = ref.read(segmentsProvider).indexWhere((s)=>s.isEmpty);
        bool isSamePerson = bp.fullname == ref.read(scannedBpProvider)?.fullname;
        if(emptyIndex == -1 && isSamePerson){
          ref.read(segmentsProvider.notifier).add(segment);
        }else{
          ref.read(segmentsProvider.notifier).updateAt(emptyIndex,segment);
        }
        ref.read(scannedBpProvider.notifier).update((s)=>bp);
      }
      navigation.pop();
    }
    // if (barcode.startsWith("M1") && barcode.length > 56) {
    //   try {
    //     BoardingPass bp = BoardingPass.fromBarcode(barcode);
    //     final segment = bp.getFlightLeg;
    //     int emptyIndex = ref.read(segmentsProvider).indexWhere((s)=>s.isEmpty);
    //     bool isSamePerson = bp.fullname == ref.read(scannedBpProvider)?.fullname;
    //     if(emptyIndex == -1 && isSamePerson){
    //       // ref.read(segmentsProvider.notifier).update((s)=>[...s,segment]);
    //       ref.read(segmentsProvider.notifier).add(segment);
    //     }else{
    //       ref.read(segmentsProvider.notifier).updateAt(emptyIndex,segment);
    //
    //       // var current = ref.read(segmentsProvider);
    //       // current[emptyIndex]=segment;
    //       // ref.read(segmentsProvider.notifier).update((s)=>[...current]);
    //     }
    //     ref.read(scannedBpProvider.notifier).update((s)=>bp);
    //     navigation.pop();
    //   } catch (e) {
    //     log(e.toString());
    //   }
    // }
  }
}
