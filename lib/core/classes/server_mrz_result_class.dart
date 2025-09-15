// To parse this JSON data, do
//
//     final serverMrzResult = serverMrzResultFromJson(jsonString);

import 'dart:convert';

import 'package:camera_kit_plus/camera_kit_ocr_plus_view.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';

ServerMrzResult serverMrzResultFromJson(String str) => ServerMrzResult.fromJson(json.decode(str));

String serverMrzResultToJson(ServerMrzResult data) => json.encode(data.toJson());

class ServerMrzResult {
  final FieldData? type;
  final FieldData? subType;
  final FieldData? documentNumber;
  final FieldData? birthDate;
  final FieldData? expiryDate;
  final FieldData? gender;
  final FieldData? nationality;
  final FieldData? issueCountry;

  ServerMrzResult({this.type, this.subType, this.documentNumber, this.birthDate, this.expiryDate, this.gender, this.nationality, this.issueCountry});

  factory ServerMrzResult.fromJson(Map<String, dynamic> json) => ServerMrzResult(
    type: json["type"] == null ? null : FieldData.fromJson(json["type"]),
    subType: json["subType"] == null ? null : FieldData.fromJson(json["subType"]),
    documentNumber: json["documentNumber"] == null ? null : FieldData.fromJson(json["documentNumber"]),
    birthDate: json["birthDate"] == null ? null : FieldData.fromJson(json["birthDate"]),
    expiryDate: json["expiryDate"] == null ? null : FieldData.fromJson(json["expiryDate"]),
    gender: json["gender"] == null ? null : FieldData.fromJson(json["gender"]),
    nationality: json["nationality"] == null ? null : FieldData.fromJson(json["nationality"]),
    issueCountry: json["issueCountry"] == null ? null : FieldData.fromJson(json["issueCountry"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type?.toJson(),
    "subType": subType?.toJson(),
    "documentNumber": documentNumber?.toJson(),
    "birthDate": birthDate?.toJson(),
    "expiryDate": expiryDate?.toJson(),
    "gender": gender?.toJson(),
    "nationality": nationality?.toJson(),
    "issueCountry": issueCountry?.toJson(),
  };

  OcrMrzResult get getOcrMrzResult => OcrMrzResult(
    line1: '',
    line2: '',
    format: MrzFormat.unknown,
    documentCode: (type?.value??'')+(subType?.value??'<'),
    documentType: type?.value??'',
    mrzFormat: MrzFormat.unknown,
    countryCode: issueCountry?.value??'',
    issuingState:  issueCountry?.value??'',
    lastName: '',
    firstName: '',
    documentNumber: documentNumber?.value??'',
    nationality:  nationality?.value??'',
    birthDate: _parseMrzDate(birthDate?.value??''),
    expiryDate: _parseMrzDate(expiryDate?.value??''),
    sex: gender?.value??'',
    personalNumber: '',
    optionalData: '',
    valid: OcrMrzValidation(
      nationalityValid: (nationality?.percent??0)>80,
      countryValid: (issueCountry?.percent??0)>80,
      birthDateValid: (birthDate?.percent??0)>80,
      expiryDateValid: (expiryDate?.percent??0)>80,
      docCodeValid: (type?.percent??0)>80,
      docNumberValid: (documentNumber?.percent??0)>80,
    ),
    checkDigits: CheckDigits(document: true, birth: true, expiry: true, optional: true),
    ocrData: OcrData(text: '', lines: []),
  );
}

class FieldData {
  final String? value;
  final int? percent;

  FieldData({this.value, this.percent});

  factory FieldData.fromJson(Map<String, dynamic> json) => FieldData(value: json["value"], percent: int.tryParse((json["percent"] ?? '0').toString()));

  Map<String, dynamic> toJson() => {"value": value, "percent": percent};
}

DateTime? _parseMrzDate(String yymmdd) {
  if (!RegExp(r'^\d{6}$').hasMatch(yymmdd)) return null;

  final year = int.parse(yymmdd.substring(0, 2));
  final month = int.parse(yymmdd.substring(2, 4));
  final day = int.parse(yymmdd.substring(4, 6));

  // MRZ dates assume:
  // - birth: usually 1900–2029 (but safe to assume <= current year)
  // - expiry: usually 2000–2099
  final now = DateTime.now().year % 100;

  final fullYear = year <= now + 10 ? 2000 + year : 1900 + year;

  try {
    return DateTime.utc(fullYear, month, day);
  } catch (_) {
    return null;
  }
}