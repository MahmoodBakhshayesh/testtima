
import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/extenstions/mrz_res_ext.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocr_mrz/mrz_result_class_fix.dart';

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
  final ParameterValue? documentCode;
  final DateTime? documentExpiryDate;
  final Location? documentIssueCountry;
  final DateTime? documentIssueDate;
  final DateTime? birthDate;
  final Location? nationality;
  final ParameterValue? documentMRZType;
  final ParameterValue? documentSeries;
  final DocumentFeature? documentFeature;
  final DateTime? applicationDate;
  final String? mrz;
  final String? ocrText;
  final String? shortType;
  final String? docCode;
  final String? sex;

  const DocumentDetail({
    this.documentNumber,
    this.shortType,
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
  }) {
    return DocumentDetail(
      documentNumber: identical(documentNumber, _unset) ? this.documentNumber : documentNumber as String?,
      fullName: identical(fullName, _unset) ? this.fullName : fullName as String?,
      documentCode: identical(documentCode, _unset) ? this.documentCode : documentCode as ParameterValue?,
      documentExpiryDate: identical(documentExpiryDate, _unset) ? this.documentExpiryDate : documentExpiryDate as DateTime?,
      birthDate: identical(birthDate, _unset) ? this.birthDate : birthDate as DateTime?,
      documentIssueCountry: identical(documentIssueCountry, _unset) ? this.documentIssueCountry : documentIssueCountry as Location?,
      documentIssueDate: identical(documentIssueDate, _unset) ? this.documentIssueDate : documentIssueDate as DateTime?,
      nationality: identical(nationality, _unset) ? this.nationality : nationality as Location?,
      documentMRZType: identical(documentMRZType, _unset) ? this.documentMRZType : documentMRZType as ParameterValue?,
      documentSeries: identical(documentSeries, _unset) ? this.documentSeries : documentSeries as ParameterValue?,
      documentFeature: identical(documentFeature, _unset) ? this.documentFeature : documentFeature as DocumentFeature?,
      applicationDate: identical(applicationDate, _unset) ? this.applicationDate : applicationDate as DateTime?,
      mrz: identical(mrz, _unset) ? this.mrz : mrz as String?,
      ocrText: identical(ocrText, _unset) ? this.ocrText : ocrText as String?,
      shortType: identical(shortType, _unset) ? this.shortType : ocrText as String?,
      docCode: identical(docCode, _unset) ? this.docCode : ocrText as String?,
      sex: identical(sex, _unset) ? this.sex : ocrText as String?,
    );
  }

  factory DocumentDetail.fromJson(Map<String, dynamic> json) {
    return DocumentDetail(
      documentNumber: json['documentNumber']?.toString(),
      fullName: json['fullName']?.toString(),
      documentCode: json['documentCode'] is Map<String, dynamic> ? ParameterValue.fromJson(json['documentCode']) : null,
      documentExpiryDate: parseDate(json['documentExpiryDate']),
      birthDate: parseDate(json['birthDate']),
      documentIssueCountry: json['documentIssueCountry'] is Map<String, dynamic> ? Location.fromJson(json['documentIssueCountry']) : null,
      documentIssueDate: parseDate(json['documentIssueDate']),
      nationality: json['nationality'] is Map<String, dynamic> ? Location.fromJson(json['nationality']) : null,
      documentMRZType: json['documentMRZType'] is Map<String, dynamic> ? ParameterValue.fromJson(json['documentMRZType']) : null,
      documentSeries: json['documentSeries'] is Map<String, dynamic> ? ParameterValue.fromJson(json['documentSeries']) : null,
      documentFeature: json['documentFeature'] != null ? DocumentFeatureDetails.fromValue(json['documentFeature']?.toString()) : null,
      applicationDate: parseDate(json['applicationDate']),
      mrz: json["mrz"],
      ocrText: json["ocrText"],
      shortType: json["shortType"],
      docCode: json["docCode"],
      sex: json["sex"],
    );
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
  };

  bool get isExpired => documentExpiryDate != null && documentExpiryDate!.isBefore(DateTime.now());

  bool get isExpiryFake => (documentExpiryDate?.difference(DateTime(1, 1, 1)).inDays ?? 100) < 1;

  bool get isExpiring => !isExpired && documentExpiryDate != null && documentExpiryDate!.difference(DateTime.now()).inDays.abs() < 180;

  int? get expiryRemain => documentExpiryDate == null ? null : -(DateTime.now().difference(documentExpiryDate!).inDays / 30).floor();

  bool get isEmpty => documentCode == null;

  bool get isScanned => mrz != null;

  bool get isVisa => shortType == "V";
  bool get isPassport => shortType == "P";

  bool isSameAs(OcrMrzResult res) {
    // log("${res.documentCode} -- ${documentCode?.code}");
    // log("${res.documentNumber} -- ${documentNumber}");

    return (shortType == res.getShortType)&& (res.documentNumber == documentNumber) && (documentNumber ?? '').isNotEmpty;
  }
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
    );
  }

  factory ItinerarySegment.empty() {
    return ItinerarySegment(
      arrival: ItinPoint(point: '', type: LocationType.airport, dateTime: DateTime.now()),
      departure: ItinPoint(point: BasicClass.user?.profile.defaultAirport ?? '', type: LocationType.airport, dateTime: DateTime.now()),
      processingEntity: "ABOMIS DOC CHECK",
      segmentType: SegmentType.entry,
      luggageCollected: true,
    );
  }

  factory ItinerarySegment.emptyNoAirport() {
    return ItinerarySegment(
      arrival: ItinPoint(point: '', type: LocationType.airport, dateTime: DateTime.now()),
      departure: ItinPoint(point: '', type: LocationType.airport, dateTime: DateTime.now()),
      processingEntity: "ABOMIS DOC CHECK",
      segmentType: SegmentType.entry,
      luggageCollected: true,
    );
  }

  bool get isEmpty => departure.point.isEmpty || arrival.point.isEmpty;

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
  };
}

// ---------------- ItinPoint ----------------

class ItinPoint {
  final DateTime? date;
  final TimeOfDay? time;
  final DateTime? dateTime;
  final String point;
  final LocationType type;

  const ItinPoint({this.date, this.time, this.dateTime, required this.point, required this.type});

  static const _unset = Object();

  ItinPoint copyWith({Object? date = _unset, Object? time = _unset, Object? dateTime = _unset, String? point, LocationType? type}) {
    return ItinPoint(
      date: identical(date, _unset) ? this.date : date as DateTime?,
      time: identical(time, _unset) ? this.time : time as TimeOfDay?,
      dateTime: identical(dateTime, _unset) ? this.dateTime : dateTime as DateTime?,
      point: point ?? this.point,
      type: type ?? this.type,
    );
  }

  factory ItinPoint.fromJson(Map<String, dynamic> json) {
    return ItinPoint(date: parseDate(json['date']), time: parseTime(json['time']), dateTime: parseDateTime(json['dateTime']), point: (json['point'] ?? '').toString(), type: LocationTypeX.fromJson(json['type']?.toString() ?? ''));
  }

  Map<String, dynamic> toJson() => {'date': formatDate(dateTime), 'time': time.format_HHmm, 'dateTime': formatDateTime(dateTime), 'point': point, 'type': type.name.toUpperCase()};
}

// ---------------- PassengerDetails ----------------

class PassengerDetails {
  final DateTime? birthDate;
  final Location? nationality;
  final Location? birthCountry;
  final Gender? gender;
  final Location? residentCountryCode;

  const PassengerDetails({this.birthDate, this.nationality, this.birthCountry, this.gender, this.residentCountryCode});

  static const _unset = Object();

  PassengerDetails copyWith({Object? birthDate = _unset, Object? nationality = _unset, Object? birthCountry = _unset, Object? gender = _unset, Object? residentCountryCode = _unset}) {
    return PassengerDetails(
      birthDate: identical(birthDate, _unset) ? this.birthDate : birthDate as DateTime?,
      nationality: identical(nationality, _unset) ? this.nationality : nationality as Location?,
      birthCountry: identical(birthCountry, _unset) ? this.birthCountry : birthCountry as Location?,
      gender: identical(gender, _unset) ? this.gender : gender as Gender?,
      residentCountryCode: identical(residentCountryCode, _unset) ? this.residentCountryCode : residentCountryCode as Location?,
    );
  }

  factory PassengerDetails.fromJson(Map<String, dynamic> json) {
    return PassengerDetails(
      birthDate: parseDate(json['birthDate']),
      nationality: json['nationality'] is Map<String, dynamic> ? Location.fromJson(json['nationality']) : null,
      birthCountry: json['birthCountry'] is Map<String, dynamic> ? Location.fromJson(json['birthCountry']) : null,
      gender: json['gender'] != null ? GenderDetails.fromValue(json['gender']?.toString()) : null,
      residentCountryCode: json['residentCountryCode'] is Map<String, dynamic> ? Location.fromJson(json['residentCountryCode']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'birthDate': formatDate(birthDate), 'nationality': nationality?.code3, 'birthCountry': birthCountry?.code3, 'gender': gender?.value, 'residentCountryCode': residentCountryCode?.code3};
}
