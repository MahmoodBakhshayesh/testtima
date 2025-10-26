import 'dart:developer';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/extenstions/mrz_res_ext.dart';
import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart' hide DocumentType;

import '../../../../classes/constant_data_class.dart';
import '../../artemis_timatic.dart';
import 'enums.dart';
import 'location.dart'; // Location & LocationType
import 'converters.dart';

// ---------------- DocumentRequest ----------------

class DocumentRequest {
  final List<DocumentDetail> documentDetails;
  final ItineraryDetails itineraryDetails;
  final PassengerDetails passengerDetails;

  const DocumentRequest({required this.documentDetails, required this.itineraryDetails, required this.passengerDetails});

  DocumentRequest copyWith({List<DocumentDetail>? documentDetails, ItineraryDetails? itineraryDetails, PassengerDetails? passengerDetails}) {
    return DocumentRequest(documentDetails: documentDetails ?? this.documentDetails, itineraryDetails: itineraryDetails ?? this.itineraryDetails, passengerDetails: passengerDetails ?? this.passengerDetails);
  }

  factory DocumentRequest.fromJson(Map<String, dynamic> json) {
    final docs = (json['documentDetails'] as List<dynamic>? ?? const []).whereType<Map<String, dynamic>>().map(DocumentDetail.fromJson).toList();

    return DocumentRequest(
      documentDetails: docs,
      itineraryDetails: ItineraryDetails.fromJson((json['itineraryDetails'] as Map<String, dynamic>? ?? const {})),
      passengerDetails: PassengerDetails.fromJson((json['passengerDetails'] as Map<String, dynamic>? ?? const {})),
    );
  }

  Map<String, dynamic> toJson() => {'documentDetails': documentDetails.map((e) => e.toJson()).toList(), 'itineraryDetails': itineraryDetails.toJson(), 'passengerDetails': passengerDetails.toJson()};
}

// ---------------- DocumentDetail ----------------

class DocumentDetail {
  final String? documentNumber;
  final String? fullName;
  final DocumentCode? documentCode;
  final DateTime? documentExpiryDate;
  final Country? documentIssueCountry;
  final DateTime? documentIssueDate;
  final DateTime? birthDate;
  final Country? nationality;
  final ParameterValue? documentMRZType;
  final ParameterValue? documentSeries;
  final DocumentFeature? documentFeature;
  final DateTime? applicationDate;
  final String? mrz;
  final String? ocrText;
  final String? shortType;
  final String? docCode;
  final String? sex;
  final bool verifiedDocNum;
  final bool verifiedDocCode;
  final List<String> suggestionCodes;

  const DocumentDetail({
    this.documentNumber,
    this.shortType,
    this.suggestionCodes = const[],
    this.fullName,
    this.documentCode,
    this.documentExpiryDate,
    this.birthDate,
    this.documentIssueCountry,
    this.documentIssueDate,
    this.nationality,
    this.documentMRZType,
    this.documentSeries,
    this.documentFeature,
    this.applicationDate,
    this.mrz,
    this.ocrText,
    this.docCode,
    this.sex,
    this.verifiedDocNum = false,
    this.verifiedDocCode = false,
  });

  static const _unset = Object();

  DocumentDetail copyWith({
    Object? documentNumber = _unset,
    Object? fullName = _unset,
    Object? documentCode = _unset,
    Object? documentExpiryDate = _unset,
    Object? birthDate = _unset,
    Object? documentIssueCountry = _unset,
    Object? documentIssueDate = _unset,
    Object? nationality = _unset,
    Object? documentMRZType = _unset,
    Object? documentSeries = _unset,
    Object? documentFeature = _unset,
    Object? applicationDate = _unset,
    Object? mrz = _unset,
    Object? ocrText = _unset,
    Object? shortType = _unset,
    Object? docCode = _unset,
    Object? sex = _unset,
    Object? verifiedDocNum = _unset,
    Object? verifiedDocCode = _unset,
    Object? suggestionCodes = _unset,
  }) {
    return DocumentDetail(
      documentNumber: identical(documentNumber, _unset) ? this.documentNumber : documentNumber as String?,
      fullName: identical(fullName, _unset) ? this.fullName : fullName as String?,
      documentCode: identical(documentCode, _unset) ? this.documentCode : documentCode as DocumentCode?,
      documentExpiryDate: identical(documentExpiryDate, _unset) ? this.documentExpiryDate : documentExpiryDate as DateTime?,
      birthDate: identical(birthDate, _unset) ? this.birthDate : birthDate as DateTime?,
      documentIssueCountry: identical(documentIssueCountry, _unset) ? this.documentIssueCountry : documentIssueCountry as Country?,
      documentIssueDate: identical(documentIssueDate, _unset) ? this.documentIssueDate : documentIssueDate as DateTime?,
      nationality: identical(nationality, _unset) ? this.nationality : nationality as Country?,
      documentMRZType: identical(documentMRZType, _unset) ? this.documentMRZType : documentMRZType as ParameterValue?,
      documentSeries: identical(documentSeries, _unset) ? this.documentSeries : documentSeries as ParameterValue?,
      documentFeature: identical(documentFeature, _unset) ? this.documentFeature : documentFeature as DocumentFeature?,
      applicationDate: identical(applicationDate, _unset) ? this.applicationDate : applicationDate as DateTime?,
      mrz: identical(mrz, _unset) ? this.mrz : mrz as String?,
      ocrText: identical(ocrText, _unset) ? this.ocrText : ocrText as String?,
      shortType: identical(shortType, _unset) ? this.shortType : shortType as String?,
      docCode: identical(docCode, _unset) ? this.docCode : docCode as String?,
      suggestionCodes: identical(suggestionCodes, _unset) ? this.suggestionCodes : ((suggestionCodes??[]) as List).map((a)=>a.toString()).toList() as List<String>,
      sex: identical(sex, _unset) ? this.sex : sex as String?,
      verifiedDocNum: identical(verifiedDocNum, _unset) ? this.verifiedDocNum : verifiedDocNum as bool,
      verifiedDocCode: identical(verifiedDocCode, _unset) ? this.verifiedDocCode : verifiedDocCode as bool,
    );
  }

  factory DocumentDetail.fromJson(Map<String, dynamic> json) {
    return DocumentDetail(
      documentNumber: json['documentNumber']?.toString(),
      fullName: json['fullName']?.toString(),
      documentCode: json['documentCode'] is Map<String, dynamic> ? DocumentCode.fromJson(json['documentCode']) : null,
      documentExpiryDate: parseDate(json['documentExpiryDate']),
      birthDate: parseDate(json['birthDate']),
      documentIssueCountry: json['documentIssueCountry'] is Map<String, dynamic> ? Country.fromJson(json['documentIssueCountry']) : null,
      documentIssueDate: parseDate(json['documentIssueDate']),
      nationality: json['nationality'] is Map<String, dynamic> ? Country.fromJson(json['nationality']) : null,
      documentMRZType: json['documentMRZType'] is Map<String, dynamic> ? ParameterValue.fromJson(json['documentMRZType']) : null,
      documentSeries: json['documentSeries'] is Map<String, dynamic> ? ParameterValue.fromJson(json['documentSeries']) : null,
      documentFeature: json['documentFeature'] != null ? DocumentFeatureDetails.fromValue(json['documentFeature']?.toString()) : null,
      applicationDate: parseDate(json['applicationDate']),
      mrz: json["mrz"],
      ocrText: json["ocrText"],
      shortType: json["shortType"],
      docCode: json["docCode"],
      sex: json["sex"],
      verifiedDocNum: json["verifiedDocNum"],
    );
  }


  factory DocumentDetail.visa() {
    return DocumentDetail(shortType: "V");
  }
  factory DocumentDetail.passport() {
    return DocumentDetail(shortType: "P",birthDate: DateTime(2000,1,1));
  }
  factory DocumentDetail.resident() {
    return DocumentDetail(shortType: "I");
  }

  Map<String, dynamic> toJson() => {
    'documentNumber': documentNumber,
    'fullName': fullName,
    'documentCode': documentCode?.code,
    'documentExpiryDate': formatDate(documentExpiryDate),
    'birthDate': formatDate(birthDate),
    'documentIssueCountry': documentIssueCountry?.code3,
    'documentIssueDate': formatDate(documentIssueDate),
    'nationality': nationality?.code3,
    'documentMRZType': documentMRZType?.code,
    'documentSeries': documentSeries?.code,
    'documentFeature': documentFeature?.value,
    'applicationDate': formatDate(applicationDate),
    'mrz': mrz,
    'ocrText': ocrText,
    'shortType': shortType,
    'docCode': docCode,
    'sex': sex,
    'verifiedDocNum': verifiedDocNum,
  };

  bool get isExpired => documentExpiryDate != null && documentExpiryDate!.isBefore(DateTime.now());

  bool get isExpiryFake => (documentExpiryDate?.difference(DateTime(1, 1, 1)).inDays ?? 100) < 1;

  bool get isExpiring => !isExpired && documentExpiryDate != null && documentExpiryDate!.difference(DateTime.now()).inDays.abs() < 180;

  int? get expiryRemain => documentExpiryDate == null ? null : -(DateTime.now().difference(documentExpiryDate!).inDays / 30).floor();

  bool get isEmpty => documentCode == null;

  bool get isScanned => mrz != null;

  bool get isVisa => shortType == "V";

  bool get isPassport => shortType == "P";

  Gender? get gender => Gender.values.firstWhereOrNull((a)=>a.value == sex);


  Widget get getMrzWidget => (mrz ?? "").isEmpty || true
      ? SizedBox()
      : Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.08), borderRadius: BorderRadiusGeometry.circular(4)),
          child: FittedBox(
            child: Text(censorText(mrz ?? '', (fullName ?? "").split(" ")), style: TextStyle(fontFamily: "Ocr")),
          ),
        );

  bool isSameAs(OcrMrzResult res,{List<String?> notThis= const[]}) {
    // log("${res.documentCode} -- ${documentCode?.code}");
    // log("${res.documentNumber} -- ${documentNumber}");

    return (documentExpiryDate.format_yyyyMMdd == res.expiryDate.format_yyyyMMdd) && (docCode == res.documentCode) && (res.documentNumber == documentNumber) && (documentNumber ?? '').isNotEmpty;
  }

  DocumentType? getMatch() {
    String? dc = docCode;
    DocumentType? match;
    if (dc != null && dc.length > 1) {
      match = BasicClass.constData.data.documentType.lastOrNullWhere((a) => a.type == BasicClass.constData.data.documentCode.firstWhere((a) => a.type == shortType || a.code == documentCode?.code).type);
    }
    match ??= BasicClass.constData.data.documentType.lastOrNullWhere((a) => a.type == shortType);
    return match;
  }

  DocumentDetailType? getTypeDetailsMatch() {
    String? dc = docCode;
    DocumentDetailType? match;
    if (docCode == null) {
      return null;
    }
    if (dc != null && dc.length > 1) {
      match = BasicClass.constData.data.documentDetailType.lastOrNullWhere(
        (a) => a.type == docCode?.characters.first && (a.subType == "*" || a.subType == docCode?.characters.last) && (a.country == "*" || a.country == documentIssueCountry?.code3),
      );
    }
    return match;
  }

  DocumentFields get getRequiredFields {
    DocumentFields required = DocumentFields();
    if(BasicClass.constData.data.mandatory == null ) return required;
    if (shortType == "P") {
      required = BasicClass.constData.data.mandatory!.passport!;
    } else if (shortType == "V") {
      required = BasicClass.constData.data.mandatory!.visa!;
    } else if (shortType == "I") {
      required = BasicClass.constData.data.mandatory!.idCard!;
    }
    return required;
  }

  bool hasAllRequired() {
    if(BasicClass.constData.data.mandatory == null ) return true;

    DocumentFields required = getRequiredFields;

    final bDate = !required.birthDate || birthDate != null;
    final eDate = !required.expiryDate || documentExpiryDate != null;
    final number = !required.documentNumber || (documentNumber ?? '').isNotEmpty;
    final nat = !required.notionality || nationality != null;
    final issuing = !required.issuedIn || documentIssueCountry != null;
    final code = !required.code || documentCode != null;

    return (bDate && eDate && number && nat && issuing && code);
  }
}

String censorText(String input, List<String> forbidden) {
  for (final word in forbidden) {
    input = input.replaceAll(word, '*' * word.length);
  }
  return input;
}

// ---------------- ItineraryDetails ----------------

class ItineraryDetails {
  final List<ItinerarySegment> segments;

  const ItineraryDetails({required this.segments});

  ItineraryDetails copyWith({List<ItinerarySegment>? segments}) => ItineraryDetails(segments: segments ?? this.segments);

  factory ItineraryDetails.fromJson(Map<String, dynamic> json) {
    final list = (json['segments'] as List<dynamic>? ?? const []).whereType<Map<String, dynamic>>().map(ItinerarySegment.fromJson).toList();
    return ItineraryDetails(segments: list);
  }

  Map<String, dynamic> toJson() => {'segments': segments.map((e) => e.toJson()).toList()};
}

// ---------------- ItinerarySegment ----------------

class ItinerarySegment {
  final ItinPoint arrival;
  final ItinPoint departure;
  final String? processingEntity;
  final String? flnb;
  final DurationOfStay? durationOfStay;
  final bool? luggageCollected;
  final ParameterValue? operatingCarrier;
  final PurposeOfStayType? purposeOfStay;
  final TicketStatus? returnOnwardTicket;
  final SegmentType? segmentType;

  const ItinerarySegment({
    this.flnb,
    this.segmentType,
    required this.arrival,
    required this.departure,
    this.processingEntity,
    this.durationOfStay,
    this.luggageCollected,
    this.purposeOfStay,
    this.returnOnwardTicket,
    this.operatingCarrier,
  });

  static const _unset = Object();

  ItinerarySegment copyWith({
    ItinPoint? arrival, // non-nullable field, no sentinel
    ItinPoint? departure, // non-nullable field, no sentinel
    Object? processingEntity = _unset,
    Object? flnb = _unset,
    Object? durationOfStay = _unset,
    Object? luggageCollected = _unset,
    Object? operatingCarrier = _unset,
    Object? purposeOfStay = _unset,
    Object? returnOnwardTicket = _unset,
    Object? segmentType = _unset,
  }) {
    return ItinerarySegment(
      arrival: arrival ?? this.arrival,
      departure: departure ?? this.departure,
      processingEntity: identical(processingEntity, _unset) ? this.processingEntity : processingEntity as String?,
      flnb: identical(flnb, _unset) ? this.flnb : flnb as String?,
      durationOfStay: identical(durationOfStay, _unset) ? this.durationOfStay : durationOfStay as DurationOfStay?,
      luggageCollected: identical(luggageCollected, _unset) ? this.luggageCollected : luggageCollected as bool?,
      operatingCarrier: identical(operatingCarrier, _unset) ? this.operatingCarrier : operatingCarrier as ParameterValue?,
      purposeOfStay: identical(purposeOfStay, _unset) ? this.purposeOfStay : purposeOfStay as PurposeOfStayType?,
      returnOnwardTicket: identical(returnOnwardTicket, _unset) ? this.returnOnwardTicket : returnOnwardTicket as TicketStatus?,
      segmentType: identical(segmentType, _unset) ? this.segmentType : segmentType as SegmentType?,
    );
  }

  factory ItinerarySegment.fromJson(Map<String, dynamic> json) {
    return ItinerarySegment(
      arrival: ItinPoint.fromJson((json['arrival'] as Map<String, dynamic>? ?? const {})),
      departure: ItinPoint.fromJson((json['departure'] as Map<String, dynamic>? ?? const {})),
      processingEntity: json['processingEntity']?.toString(),
      durationOfStay: json['durationOfStay'] is Map<String, dynamic> ? DurationOfStay.fromJson(json['durationOfStay']) : null,
      luggageCollected: json['luggageCollected'] as bool?,
      purposeOfStay: json['purposeOfStay'] != null ? StayTypeDetails.fromValue(json['purposeOfStay']?.toString()) : null,
      returnOnwardTicket: json['returnOnwardTicket'] != null ? TicketStatusDetails.fromValue(json['returnOnwardTicket']?.toString()) : null,
      segmentType: json['segmentType'] != null ? SegmentType.values.firstWhere((a) => a.value.toUpperCase() == json['segmentType']?.toString()) : null,
      operatingCarrier: json['operatingCarrier'] is Map<String, dynamic> ? ParameterValue.fromJson(json['operatingCarrier']) : null,
      flnb: json["flightNumber"],
    );
  }

  factory ItinerarySegment.empty() {
    return ItinerarySegment(
      arrival: ItinPoint(point: '', dateTime: DateTime.now()),
      departure: ItinPoint(point: BasicClass.user?.attributes["defaultAirport"] ?? '', dateTime: DateTime.now()),
      processingEntity: "ABOMIS DOC CHECK",
      segmentType: SegmentType.entry,
      luggageCollected: true,
    );
  }

  factory ItinerarySegment.regenerateFromJson(Map<String, dynamic> json) {
    return ItinerarySegment(
      arrival: ItinPoint.fromJson((json['arrival'] as Map<String, dynamic>? ?? const {})),
      departure: ItinPoint.fromJson((json['departure'] as Map<String, dynamic>? ?? const {})),
      processingEntity: "ABOMIS DOC CHECK",
      segmentType: SegmentType.values.firstWhere((a) => a.toString() == json["segmentType"], orElse: () => SegmentType.entry),
      luggageCollected: json["luggageCollected"],
      flnb: json["flightNumber"],
      returnOnwardTicket: TicketStatus.values.firstWhereOrNull((a) => a.value == json["returnOnwardTicket"]),
      purposeOfStay: PurposeOfStayType.values.firstWhereOrNull((a) => a.value == json["purposeOfStay"]),
      durationOfStay: json["durationOfStay"] == null ? null : DurationOfStay.fromJson(json["durationOfStay"]),
      operatingCarrier: BasicClass.getAirlineWithCode(json["operatingCarrier"] ?? ''),
    );
  }

  factory ItinerarySegment.emptyNoAirport() {
    return ItinerarySegment(
      departure: ItinPoint(point: BasicClass.user?.attributes["defaultAirport"] ?? '', dateTime: DateTime.now()),
      arrival: ItinPoint(point: '', dateTime: DateTime.now()),
      processingEntity: "ABOMIS DOC CHECK",
      segmentType: SegmentType.entry,
      luggageCollected: true,
    );
  }

  bool get isEmpty => departure.point.isEmpty || arrival.point.isEmpty;

  String get route => "${departure.point} - ${arrival.point}";

  Map<String, dynamic> toJson() => {
    'arrival': arrival.toJson(),
    'departure': departure.toJson(),
    'processingEntity': processingEntity,

    'durationOfStay': durationOfStay?.toJson(),
    'luggageCollected': luggageCollected,
    'purposeOfStay': purposeOfStay?.value,
    'returnOnwardTicket': returnOnwardTicket?.value,
    'operatingCarrier': operatingCarrier?.code,
    'segmentType': segmentType?.toString(),
    "flightNumber": flnb,
  };

  bool hasAllRequired() {
    if(BasicClass.constData.data.mandatory == null ) return true;
    FlightFields required = BasicClass.constData.data.mandatory!.flight!;

    final from = !required.from || departure.point.isNotEmpty;
    final to = !required.to || arrival.point.isNotEmpty;
    final fling = !required.to || (flnb ?? '').isNotEmpty;
    final flightType = !required.flightType || segmentType != null;
    final al = !required.airline || operatingCarrier != null;
    final pos = !required.pos || purposeOfStay != null;
    final dos = !required.dos || durationOfStay != null;
    final ticket = !required.ticket || returnOnwardTicket != null;

    return (from && to && fling && flightType && al && pos && dos && ticket);
  }

  bool hasRoute() {

    final from = departure.point.isNotEmpty;
    final to = arrival.point.isNotEmpty;
    return (from && to);
  }

}

// ---------------- ItinPoint ----------------

class ItinPoint {
  final DateTime? date;
  final TimeOfDay? time;
  final DateTime? dateTime;
  final String point;

  const ItinPoint({this.date, this.time, this.dateTime, required this.point});

  static const _unset = Object();

  ItinPoint copyWith({Object? date = _unset, Object? time = _unset, Object? dateTime = _unset, String? point}) {
    return ItinPoint(
      date: identical(date, _unset) ? this.date : date as DateTime?,
      time: identical(time, _unset) ? this.time : time as TimeOfDay?,
      dateTime: identical(dateTime, _unset) ? this.dateTime : dateTime as DateTime?,
      point: point ?? this.point,
    );
  }

  factory ItinPoint.fromJson(Map<String, dynamic> json) {
    return ItinPoint(date: parseDate(json['date']), time: parseTime(json['time']), dateTime: parseDateTime(json['dateTime']), point: (json['point'] ?? '').toString());
  }

  Map<String, dynamic> toJson() => {'date': formatDate(dateTime), 'time': time.format_HHmm, 'dateTime': formatDateTime(dateTime), 'point': point, 'type': "AIRPORT"};
}

// ---------------- PassengerDetails ----------------

class PassengerDetails {
  final DateTime? birthDate;
  final Country? nationality;
  final Country? birthCountry;
  final Gender? gender;
  final Country? residentCountryCode;

  const PassengerDetails({this.birthDate, this.nationality, this.birthCountry, this.gender, this.residentCountryCode});

  static const _unset = Object();

  PassengerDetails copyWith({Object? birthDate = _unset, Object? nationality = _unset, Object? birthCountry = _unset, Object? gender = _unset, Object? residentCountryCode = _unset}) {
    return PassengerDetails(
      birthDate: identical(birthDate, _unset) ? this.birthDate : birthDate as DateTime?,
      nationality: identical(nationality, _unset) ? this.nationality : nationality as Country?,
      birthCountry: identical(birthCountry, _unset) ? this.birthCountry : birthCountry as Country?,
      gender: identical(gender, _unset) ? this.gender : gender as Gender?,
      residentCountryCode: identical(residentCountryCode, _unset) ? this.residentCountryCode : residentCountryCode as Country?,
    );
  }

  factory PassengerDetails.fromJson(Map<String, dynamic> json) {
    return PassengerDetails(
      birthDate: parseDate(json['birthDate']),
      nationality: json['nationality'] is Map<String, dynamic> ? Country.fromJson(json['nationality']) : null,
      birthCountry: json['birthCountry'] is Map<String, dynamic> ? Country.fromJson(json['birthCountry']) : null,
      gender: json['gender'] != null ? GenderDetails.fromValue(json['gender']?.toString()) : null,
      residentCountryCode: json['residentCountryCode'] is Map<String, dynamic> ? Country.fromJson(json['residentCountryCode']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'birthDate': formatDate(birthDate), 'nationality': nationality?.code3, 'birthCountry': birthCountry?.code3, 'gender': gender?.value, 'residentCountryCode': residentCountryCode?.code3};

  bool hasAllRequired() {
    if(BasicClass.constData.data.mandatory == null ) return true;

    PassengerFields required = BasicClass.constData.data.mandatory!.passenger!;

    // final bDate = !required.birthDate || birthDate != null;
    final bDate =true;
    final nat =true;
    // final gen = !required.gender || gender != null;
    final gen = true;

    // final nat = !required.notionality || nationality != null;
    final bp = !required.birthPlace || birthCountry != null;
    final res = !required.resident || residentCountryCode != null;

    return (bDate && gen && bp && nat && res);
  }
}
