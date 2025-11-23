import 'dart:developer';

import 'package:abds/widgets/MyDatePicker.dart';

import 'timatic/src/models/document_request.dart';

/// ===============================
///  NORMALIZATION HELPERS
/// ===============================

/// Normalize common MRZ OCR confusions
String normalizeMrz(String input) {
  final buffer = StringBuffer();
  for (final ch in input.toUpperCase().trim().split('')) {
    switch (ch) {
      case 'O':
        buffer.write('0');
        break;
      case 'I':
      case 'L':
        buffer.write('1');
        break;
      case 'S':
        buffer.write('5');
        break;
      case 'B':
        buffer.write('8');
        break;
      default:
        buffer.write(ch);
    }
  }
  return buffer.toString();
}

/// ===============================
///  HAMMING DISTANCE & SIMILARITY
/// ===============================

int hammingDistance(String a, String b) {
  if (a.length != b.length) return a.length;
  var diff = 0;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) diff++;
  }
  return diff;
}

double hammingSimilarity(String? a, String? b) {
  if (a == null || b == null) return 0.0;
  if (a.length != b.length) return 0.0;
  if (a.isEmpty) return 1.0;

  final dist = hammingDistance(a, b);
  return 1.0 - dist / a.length;
}

/// ===============================
///  FIELD SIMILARITY FUNCTIONS
/// ===============================

double dateSimilarity(String? a, String? b, {int maxAllowedDifferences = 1}) {
  if (a == null || b == null) return 0.0;
  if (a == b) return 1.0;

  final dist = hammingDistance(a, b);
  if (dist > maxAllowedDifferences) return 0.0;

  return 1.0 - dist / a.length;
}

double docNumberSimilarity(String? a, String? b) {
  if (a == null || b == null) return 0.0;

  final na = normalizeMrz(a);
  final nb = normalizeMrz(b);

  if (na.length != nb.length) return 0.0;

  var same = 0;
  for (var i = 0; i < na.length; i++) {
    if (na[i] == nb[i]) same++;
  }
  return same / na.length;
}

double countrySimilarity(String? a, String? b) {
  if (a == null || b == null) return 0.0;

  final aa = a.toUpperCase().trim();
  final bb = b.toUpperCase().trim();

  if (aa == bb) return 1.0;

  final dist = hammingDistance(aa, bb);
  if (dist == 1) return 0.3;

  return 0.0;
}

/// ===============================
///  MAIN DOCUMENT COMPARISON
/// ===============================


// Replace these with your real classes
class DateWrapper {
  final String format_yyMMdd;
  DateWrapper(this.format_yyMMdd);
}

class Country {
  final String code3;
  Country(this.code3);
}

bool isSameDocument(
    DocumentDetail? res,
    DocumentDetail? res2, {
      double threshold = 0.85,
    }) {
  if (res == null || res2 == null) return false;

  final exp1 = res.documentExpiryDate?.format_yyMMdd;
  final exp2 = res2.documentExpiryDate?.format_yyMMdd;

  final birth1 = res.birthDate?.format_yyMMdd;
  final birth2 = res2.birthDate?.format_yyMMdd;

  final docNum1 = res.documentNumber;
  final docNum2 = res2.documentNumber;

  final country1 = res.documentIssueCountry?.code3;
  final country2 = res2.documentIssueCountry?.code3;

  // Strict match fast path
  if (exp1 == exp2 &&
      birth1 == birth2 &&
      docNum1 == docNum2 &&
      country1 == country2) {
    return true;
  }

  // Country hard rule: completely different → reject
  if (country1 != null &&
      country2 != null &&
      country1.isNotEmpty &&
      country2.isNotEmpty &&
      country1 != country2) {
    // Optional: make this configurable if needed
    return false;
  }

  // Similarities
  final expirySim = dateSimilarity(exp1, exp2);
  final birthSim = dateSimilarity(birth1, birth2);
  final docNumSim = docNumberSimilarity(docNum1, docNum2);
  final countrySim = countrySimilarity(country1, country2);

  // Weighted scoring
  const wExpiry = 0.3;
  const wBirth = 0.3;
  const wDocNum = 0.3;
  const wCountry = 0.1;

  final score = expirySim * wExpiry +
      birthSim * wBirth +
      docNumSim * wDocNum +
      countrySim * wCountry;

  log("---- Similarity Check ----");
  log("Expiry: $exp1 vs $exp2 → $expirySim");
  log("Birth : $birth1 vs $birth2 → $birthSim");
  log("Doc#  : $docNum1 vs $docNum2 → $docNumSim");
  log("Cntry : $country1 vs $country2 → $countrySim");
  log("Total score = $score (threshold $threshold)");

  return score >= threshold;
}
