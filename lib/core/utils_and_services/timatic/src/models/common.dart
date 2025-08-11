// common.dart

enum TravelPurpose {
  tourism,
  business,
  transit,
  study,
  work,
  other;

  /// Parse from JSON string (case-insensitive)
  static TravelPurpose fromJson(dynamic value) {
    if (value == null) return TravelPurpose.other;
    final normalized = value.toString().toLowerCase();
    return TravelPurpose.values.firstWhere(
          (e) => e.name.toLowerCase() == normalized,
      orElse: () => TravelPurpose.other,
    );
  }

  /// Convert to JSON string (lowercase)
  String toJson() => name.toLowerCase();

  /// Human-readable title
  String get title {
    switch (this) {
      case TravelPurpose.tourism:
        return 'Tourism / Vacation';
      case TravelPurpose.business:
        return 'Business';
      case TravelPurpose.transit:
        return 'Transit';
      case TravelPurpose.study:
        return 'Study';
      case TravelPurpose.work:
        return 'Work';
      case TravelPurpose.other:
        return 'Other';
    }
  }
}

class Nationality {
  final String iso2; // e.g., "DE"
  final String? name;

  const Nationality({required this.iso2, this.name});

  Nationality copyWith({String? iso2, String? name}) {
    return Nationality(
      iso2: iso2 ?? this.iso2,
      name: name ?? this.name,
    );
  }

  factory Nationality.fromJson(Map<String, dynamic> json) {
    return Nationality(
      iso2: json['iso2'] ?? '',
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'iso2': iso2,
    'name': name,
  };
}
