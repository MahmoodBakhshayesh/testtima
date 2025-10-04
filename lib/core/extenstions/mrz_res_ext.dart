import 'package:ocr_mrz/mrz_result_class_fix.dart';

extension OcrMrzResultDetails on OcrMrzResult {
  String get getShortType => isVisa?"V":isPassport?"P":"I";
}