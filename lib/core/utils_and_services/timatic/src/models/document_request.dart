import 'package:flutter/cupertino.dart';

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
  final Location? nationality;
  final ParameterValue? documentMRZType;
  final ParameterValue? documentSeries;
  final DocumentFeature? documentFeature;
  final DateTime? applicationDate;

  const DocumentDetail({
    this.documentNumber,
    this.fullName,
    this.documentCode,
    this.documentExpiryDate,
    this.documentIssueCountry,
    this.documentIssueDate,
    this.nationality,
    this.documentMRZType,
    this.documentSeries,
    this.documentFeature,
    this.applicationDate,
  });

  DocumentDetail copyWith({
    String? documentNumber,
    String? fullName,
    ParameterValue? documentCode,
    DateTime? documentExpiryDate,
    Location? documentIssueCountry,
    DateTime? documentIssueDate,
    Location? nationality,
    ParameterValue? documentMRZType,
    ParameterValue? documentSeries,
    DocumentFeature? documentFeature,
    DateTime? applicationDate,
  }) {
    return DocumentDetail(
      documentNumber: documentNumber ?? this.documentNumber,
      fullName: fullName ?? this.fullName,
      documentCode: documentCode ?? this.documentCode,
      documentExpiryDate: documentExpiryDate ?? this.documentExpiryDate,
      documentIssueCountry: documentIssueCountry ?? this.documentIssueCountry,
      documentIssueDate: documentIssueDate ?? this.documentIssueDate,
      nationality: nationality ?? this.nationality,
      documentMRZType: documentMRZType ?? this.documentMRZType,
      documentSeries: documentSeries ?? this.documentSeries,
      documentFeature: documentFeature ?? this.documentFeature,
      applicationDate: applicationDate ?? this.applicationDate,
    );
  }

  factory DocumentDetail.fromJson(Map<String, dynamic> json) {
    return DocumentDetail(
      documentNumber: json['documentNumber']?.toString(),
      fullName: json['fullName']?.toString(),
      documentCode: json['documentCode'] is Map<String, dynamic> ? ParameterValue.fromJson(json['documentCode']) : null,
      documentExpiryDate: parseDate(json['documentExpiryDate']),
      documentIssueCountry: json['documentIssueCountry'] is Map<String, dynamic> ? Location.fromJson(json['documentIssueCountry']) : null,
      documentIssueDate: parseDate(json['documentIssueDate']),
      nationality: json['nationality'] is Map<String, dynamic> ? Location.fromJson(json['nationality']) : null,
      documentMRZType: json['documentMRZType'] is Map<String, dynamic> ? ParameterValue.fromJson(json['documentMRZType']) : null,
      documentSeries: json['documentSeries'] is Map<String, dynamic> ? ParameterValue.fromJson(json['documentSeries']) : null,
      documentFeature: json['documentFeature'] != null ? DocumentFeatureDetails.fromValue(json['documentFeature']?.toString()) : null,
      applicationDate: parseDate(json['applicationDate']),
    );
  }

  Map<String, dynamic> toJson() => {
    'documentNumber': documentNumber,
    'fullName': fullName,
    'documentCode': documentCode?.code,
    'documentExpiryDate': formatDate(documentExpiryDate),
    'documentIssueCountry': documentIssueCountry?.code3,
    'documentIssueDate': formatDate(documentIssueDate),
    'nationality': nationality?.code3,
    'documentMRZType': documentMRZType?.code,
    'documentSeries': documentSeries?.code,
    'documentFeature': documentFeature?.value,
    'applicationDate': formatDate(applicationDate),
  };

  bool get isExpired => documentExpiryDate != null && documentExpiryDate!.isBefore(DateTime.now());

  bool get isExpiryFake => (documentExpiryDate?.difference(DateTime(1, 1, 1)).inDays ?? 100) < 1;

  bool get isExpiring => !isExpired && documentExpiryDate != null && documentExpiryDate!.difference(DateTime.now()).inDays.abs() < 180;

  int? get expiryRemain => documentExpiryDate == null ? null : -(DateTime.now().difference(documentExpiryDate!).inDays / 30).floor();

  bool get isEmpty => documentCode == null;

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

  const ItinerarySegment({
    this.flnb,
    required this.arrival, required this.departure, this.processingEntity, this.durationOfStay, this.luggageCollected, this.purposeOfStay, this.returnOnwardTicket, this.operatingCarrier});

  ItinerarySegment copyWith({
    ItinPoint? arrival,
    ItinPoint? departure,
    String? processingEntity,
    String? flnb,
    DurationOfStay? durationOfStay,
    bool? luggageCollected,
    ParameterValue? operatingCarrier,
    PurposeOfStayType? purposeOfStay,
    TicketStatus? returnOnwardTicket,
  }) {
    return ItinerarySegment(
      arrival: arrival ?? this.arrival,
      departure: departure ?? this.departure,
      processingEntity: processingEntity ?? this.processingEntity,
      durationOfStay: durationOfStay ?? this.durationOfStay,
      luggageCollected: luggageCollected ?? this.luggageCollected,
      operatingCarrier: operatingCarrier ?? this.operatingCarrier,
      purposeOfStay: purposeOfStay ?? this.purposeOfStay,
      flnb: flnb ?? this.flnb,
      returnOnwardTicket: returnOnwardTicket ?? this.returnOnwardTicket,
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
      operatingCarrier: json['operatingCarrier'] is Map<String, dynamic> ? ParameterValue.fromJson(json['operatingCarrier']) : null,
    );
  }

  factory ItinerarySegment.empty() {
    return ItinerarySegment(
      arrival: ItinPoint(point: '', type: LocationType.airport, dateTime: DateTime.now()),
      departure: ItinPoint(point: '', type: LocationType.airport, dateTime: DateTime.now()),
      processingEntity: "ABOMIS DOC CHECK",
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
  };
}

// ---------------- ItinPoint ----------------

class ItinPoint {
  final DateTime? date;
  final DateTime? time;
  final DateTime? dateTime;
  final String point;
  final LocationType type;

  const ItinPoint({this.date, this.time, this.dateTime, required this.point, required this.type});

  ItinPoint copyWith({DateTime? date, DateTime? time, DateTime? dateTime, String? point, LocationType? type}) {
    return ItinPoint(date: date ?? this.date, time: time ?? this.time, dateTime: dateTime ?? this.dateTime, point: point ?? this.point, type: type ?? this.type);
  }

  factory ItinPoint.fromJson(Map<String, dynamic> json) {
    return ItinPoint(date: parseDate(json['date']), time: parseTime(json['time']), dateTime: parseDateTime(json['dateTime']), point: (json['point'] ?? '').toString(), type: LocationTypeX.fromJson(json['type']?.toString() ?? ''));
  }

  Map<String, dynamic> toJson() => {'date': formatDate(dateTime), 'time': formatTime(dateTime), 'dateTime': formatDateTime(dateTime), 'point': point, 'type': type.name.toUpperCase()};
}

// ---------------- PassengerDetails ----------------

class PassengerDetails {
  final DateTime? birthDate;
  final Location? nationality;
  final Location? birthCountry;
  final Gender? gender;
  final Location? residentCountryCode;

  const PassengerDetails({this.birthDate, this.nationality, this.birthCountry, this.gender, this.residentCountryCode});

  PassengerDetails copyWith({DateTime? birthDate, Location? nationality, Location? birthCountry, Gender? gender, Location? residentCountryCode}) {
    return PassengerDetails(
      birthDate: birthDate ?? this.birthDate,
      nationality: nationality ?? this.nationality,
      birthCountry: birthCountry ?? this.birthCountry,
      gender: gender ?? this.gender,
      residentCountryCode: residentCountryCode ?? this.residentCountryCode,
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
