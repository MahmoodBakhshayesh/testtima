import 'package:ocr_mrz/mrz_result_class_fix.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';

extension MrzValidationExt on OcrMrzResult {
  bool matchSetting(OcrMrzSetting setting) {
    return (valid.expiryDateValid || !setting.validateExpiryDateValid) &&
        (valid.finalCheckValid || !setting.validateFinalCheckValid) &&
        (valid.linesLengthValid || !setting.validateLinesLength) &&
        (valid.nameValid || !setting.validateNames) &&
        (valid.nationalityValid || !setting.validateNationality) &&
        (valid.personalNumberValid || !setting.validatePersonalNumberValid) &&
        (valid.birthDateValid || !setting.validateBirthDateValid) &&
        (valid.countryValid || !setting.validateCountry) &&
        (valid.docNumberValid || !setting.validateDocNumberValid);
  }
}
