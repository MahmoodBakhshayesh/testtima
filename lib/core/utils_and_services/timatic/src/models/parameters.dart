// parameters.dart
// Pure Dart models (no json_serializable)

class ParameterValue {
  final String name;
  final String code;

  const ParameterValue({
    required this.name,
    required this.code,
  });

  ParameterValue copyWith({
    String? name,
    String? code,
  }) {
    return ParameterValue(
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  factory ParameterValue.fromJson(Map<String, dynamic> json) {
    return ParameterValue(
      name: (json['name'] ?? '').toString(),
      code: (json['code'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code,
  };

  @override
  String toString() => "$code ($name)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ParameterValue &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              code == other.code;

  @override
  int get hashCode => Object.hash(name, code);
}

class ParameterItem {
  final String name;
  final String code;
  /// Can be null if the API omits values for a given parameter item.
  final List<ParameterValue>? parameterValues;

  const ParameterItem({
    required this.name,
    required this.code,
    required this.parameterValues,
  });

  ParameterItem copyWith({
    String? name,
    String? code,
    List<ParameterValue>? parameterValues,
  }) {
    return ParameterItem(
      name: name ?? this.name,
      code: code ?? this.code,
      parameterValues: parameterValues ?? this.parameterValues,
    );
  }

  factory ParameterItem.fromJson(Map<String, dynamic> json) {
    final raw = json['parameterValues'];
    List<ParameterValue>? values;
    if (raw is List) {
      values = raw
          .whereType<Map<String, dynamic>>()
          .map(ParameterValue.fromJson)
          .toList();
    } else {
      values = null;
    }

    return ParameterItem(
      name: (json['name'] ?? '').toString(),
      code: (json['code'] ?? '').toString(),
      parameterValues: values,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code,
    'parameterValues': parameterValues?.map((e) => e.toJson()).toList(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ParameterItem &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              code == other.code &&
              _listEquals(parameterValues, other.parameterValues);

  @override
  int get hashCode =>
      Object.hash(name, code, parameterValues == null ? null : Object.hashAll(parameterValues!));
}

class ParametersEnvelope {
  final List<ParameterItem> parameters;
  final String? transactionId;

  const ParametersEnvelope({
    required this.parameters,
    this.transactionId,
  });

  ParametersEnvelope copyWith({
    List<ParameterItem>? parameters,
    String? transactionId,
  }) {
    return ParametersEnvelope(
      parameters: parameters ?? this.parameters,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  factory ParametersEnvelope.fromJson(Map<String, dynamic> json) {
    final list = (json['parameters'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(ParameterItem.fromJson)
        .toList();

    return ParametersEnvelope(
      parameters: list,
      transactionId: json['transactionId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'parameters': parameters.map((e) => e.toJson()).toList(),
    if (transactionId != null) 'transactionId': transactionId,
  };

  @override
  String toString() =>
      'ParametersEnvelope(parameters: ${parameters.length}, transactionId: $transactionId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ParametersEnvelope &&
              runtimeType == other.runtimeType &&
              _listEquals(parameters, other.parameters) &&
              transactionId == other.transactionId;

  @override
  int get hashCode =>
      Object.hash(Object.hashAll(parameters), transactionId);
}

// --------- helpers ---------

bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null && b == null) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
