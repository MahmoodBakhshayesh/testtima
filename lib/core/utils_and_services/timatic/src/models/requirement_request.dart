import 'common.dart';

class RequirementRequest {
  final String from;               // IATA code, e.g., "FRA"
  final String to;                 // IATA code, e.g., "JFK"
  final String? via;               // optional transit airport
  final Nationality nationality;
  final DateTime travelDate;       // outbound date
  final TravelPurpose purpose;     // tourism/business/transit/etc.
  final bool isTransit;            // true if only transiting
  final int? stayLengthDays;       // if required by API

  const RequirementRequest({
    required this.from,
    required this.to,
    this.via,
    required this.nationality,
    required this.travelDate,
    required this.purpose,
    required this.isTransit,
    this.stayLengthDays,
  });

  RequirementRequest copyWith({
    String? from,
    String? to,
    String? via,
    Nationality? nationality,
    DateTime? travelDate,
    TravelPurpose? purpose,
    bool? isTransit,
    int? stayLengthDays,
  }) {
    return RequirementRequest(
      from: from ?? this.from,
      to: to ?? this.to,
      via: via ?? this.via,
      nationality: nationality ?? this.nationality,
      travelDate: travelDate ?? this.travelDate,
      purpose: purpose ?? this.purpose,
      isTransit: isTransit ?? this.isTransit,
      stayLengthDays: stayLengthDays ?? this.stayLengthDays,
    );
  }

  factory RequirementRequest.fromJson(Map<String, dynamic> json) {
    return RequirementRequest(
      from: (json['from'] ?? '').toString(),
      to: (json['to'] ?? '').toString(),
      via: json['via']?.toString(),
      nationality: Nationality.fromJson(
        (json['nationality'] as Map<String, dynamic>? ?? const {}),
      ),
      travelDate: DateTime.parse(json['travelDate'].toString()),
      purpose: _travelPurposeFromJson(json['purpose']),
      isTransit: json['isTransit'] == true || json['isTransit'] == 'true',
      stayLengthDays: json['stayLengthDays'] != null
          ? int.tryParse(json['stayLengthDays'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      if (via != null) 'via': via,
      'nationality': nationality.toJson(),
      'travelDate': travelDate.toIso8601String(),
      'purpose': _travelPurposeToJson(purpose),
      'isTransit': isTransit,
      if (stayLengthDays != null) 'stayLengthDays': stayLengthDays,
    };
  }

  @override
  String toString() {
    return 'RequirementRequest(from: $from, to: $to, via: $via, '
        'nationality: $nationality, travelDate: $travelDate, purpose: $purpose, '
        'isTransit: $isTransit, stayLengthDays: $stayLengthDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RequirementRequest &&
            runtimeType == other.runtimeType &&
            from == other.from &&
            to == other.to &&
            via == other.via &&
            nationality == other.nationality &&
            travelDate == other.travelDate &&
            purpose == other.purpose &&
            isTransit == other.isTransit &&
            stayLengthDays == other.stayLengthDays;
  }

  @override
  int get hashCode => Object.hash(
    from,
    to,
    via,
    nationality,
    travelDate,
    purpose,
    isTransit,
    stayLengthDays,
  );
}

// --- Enum helpers ---
TravelPurpose _travelPurposeFromJson(dynamic value) {
  if (value == null) {
    throw ArgumentError('purpose cannot be null');
  }
  final str = value.toString().toLowerCase();
  return TravelPurpose.values.firstWhere(
        (e) => e.name.toLowerCase() == str,
    orElse: () => throw ArgumentError('Unknown TravelPurpose: $value'),
  );
}

String _travelPurposeToJson(TravelPurpose purpose) => purpose.name;
