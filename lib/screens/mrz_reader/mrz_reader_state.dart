import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:ocr_mrz/orc_mrz_log_class.dart';

final mrzReaderStateProvider = ChangeNotifierProvider<MrzReaderState>((_) => MrzReaderState());

class MrzReaderState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


final ocrMrzSettingProvider = StateProvider<OcrMrzSetting>((ref) => OcrMrzSetting(validateNames: false, validatePersonalNumberValid: false,validateFinalCheckValid: false));
final ocrMrzLogsProvider = StateProvider<List<OcrMrzLog>>((ref) => []);
