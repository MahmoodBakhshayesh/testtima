// parameter_type.dart
// No json_serializable, fully manual enum with JSON support.

enum ParameterType {
  pets,
  channel,
  passengerType,
  carrier,
  ruleSetType,
  documentSeries,
  stayType,
  queryType,
  documentCode,
  product,
  documentModel;

  /// String code used by the API.
  String get code {
    switch (this) {
      case ParameterType.pets:
        return 'pets';
      case ParameterType.channel:
        return 'channel';
      case ParameterType.passengerType:
        return 'passengerType';
      case ParameterType.carrier:
        return 'carrier';
      case ParameterType.ruleSetType:
        return 'ruleSetType';
      case ParameterType.documentSeries:
        return 'documentSeries';
      case ParameterType.stayType:
        return 'stayType';
      case ParameterType.queryType:
        return 'queryType';
      case ParameterType.documentCode:
        return 'documentCode';
      case ParameterType.product:
        return 'product';
      case ParameterType.documentModel:
        return 'documentModel';
    }
  }

  /// Parse from a code string (case-insensitive).
  static ParameterType? fromCode(String? code) {
    if (code == null) return null;
    final normalized = code.trim().toLowerCase();
    for (final type in ParameterType.values) {
      if (type.code.toLowerCase() == normalized) {
        return type;
      }
    }
    return null;
  }

  /// Deserialize from JSON.
  static ParameterType fromJson(dynamic json) {
    if (json == null) {
      throw ArgumentError('ParameterType.fromJson: value is null');
    }
    final type = fromCode(json.toString());
    if (type == null) {
      throw ArgumentError('Unknown ParameterType: $json');
    }
    return type;
  }

  /// Serialize to JSON.
  String toJson() => code;
}
