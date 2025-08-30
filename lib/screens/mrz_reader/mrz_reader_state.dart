import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:ocr_mrz/orc_mrz_log_class.dart';

import '../../core/classes/mrz_agg_class.dart';

final mrzReaderStateProvider = ChangeNotifierProvider<MrzReaderState>((_) => MrzReaderState());

class MrzReaderState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;
}

final ocrMrzSettingProvider = StateProvider<OcrMrzSetting>(
  (ref) => OcrMrzSetting(

      validateBirthDateValid: false,
      validateLinesLength: false, validateDocNumberValid: false, validateNames: false, validatePersonalNumberValid: false, validateFinalCheckValid: false),
);
final ocrMrzLogsProvider = StateProvider<List<OcrMrzLog>>((ref) => []);
// final improvingMrzResultProvider = StateProvider<OcrMrzResult?>((ref) => null);
final improvingMrzResultProvider = StateProvider<OcrMrzConsensus?>((ref) => null);
final enableDynamsoftProvider = StateProvider<bool?>((ref) => false);
final showLogProvider = StateProvider<bool>((ref) => false);
