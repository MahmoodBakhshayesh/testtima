import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';

final offlineScannerStateProvider = ChangeNotifierProvider<OfflineScannerState>((_) => OfflineScannerState());

class OfflineScannerState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


final offlineScannedDocsProvider = StateProvider<List<DocumentDetail>>((ref) => []);
final confirmingOfflineDocProvider = StateProvider<DocumentDetail?>((ref) => null);
