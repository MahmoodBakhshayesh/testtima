class AcceptedValue {
  final String code;
  final String name;

  const AcceptedValue({
    required this.code,
    required this.name,
  });

  AcceptedValue copyWith({
    String? code,
    String? name,
  }) {
    return AcceptedValue(
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  factory AcceptedValue.fromJson(Map<String, dynamic> json) {
    return AcceptedValue(
      code: (json['code'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
  };

  @override
  String toString() => 'AcceptedValue(code: $code, name: $name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AcceptedValue &&
              runtimeType == other.runtimeType &&
              code == other.code &&
              name == other.name;

  @override
  int get hashCode => Object.hash(code, name);
}

class AcceptedParameter {
  final String parameterCode;
  final String parameterName;
  final List<AcceptedValue> parameterValues;

  const AcceptedParameter({
    required this.parameterCode,
    required this.parameterName,
    required this.parameterValues,
  });

  AcceptedParameter copyWith({
    String? parameterCode,
    String? parameterName,
    List<AcceptedValue>? parameterValues,
  }) {
    return AcceptedParameter(
      parameterCode: parameterCode ?? this.parameterCode,
      parameterName: parameterName ?? this.parameterName,
      parameterValues: parameterValues ?? this.parameterValues,
    );
  }

  factory AcceptedParameter.fromJson(Map<String, dynamic> json) {
    final values = (json['parameterValues'] as List<dynamic>? ?? const [])
        .map((e) => AcceptedValue.fromJson(e as Map<String, dynamic>))
        .toList();

    return AcceptedParameter(
      parameterCode: (json['parameterCode'] ?? '').toString(),
      parameterName: (json['parameterName'] ?? '').toString(),
      parameterValues: values,
    );
  }

  Map<String, dynamic> toJson() => {
    'parameterCode': parameterCode,
    'parameterName': parameterName,
    'parameterValues': parameterValues.map((e) => e.toJson()).toList(),
  };

  @override
  String toString() =>
      'AcceptedParameter(code: $parameterCode, name: $parameterName, values: ${parameterValues.length})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AcceptedParameter &&
              runtimeType == other.runtimeType &&
              parameterCode == other.parameterCode &&
              parameterName == other.parameterName &&
              _listEquals(parameterValues, other.parameterValues);

  @override
  int get hashCode =>
      Object.hash(parameterCode, parameterName, Object.hashAll(parameterValues));
}

class AcceptedRuleSet {
  final String ruleSetTypeCode;   // e.g., "REQDOC"
  final String ruleSetTypeName;   // e.g., "Travel Document Requirements"
  final AcceptedParameter parameter;

  const AcceptedRuleSet({
    required this.ruleSetTypeCode,
    required this.ruleSetTypeName,
    required this.parameter,
  });

  AcceptedRuleSet copyWith({
    String? ruleSetTypeCode,
    String? ruleSetTypeName,
    AcceptedParameter? parameter,
  }) {
    return AcceptedRuleSet(
      ruleSetTypeCode: ruleSetTypeCode ?? this.ruleSetTypeCode,
      ruleSetTypeName: ruleSetTypeName ?? this.ruleSetTypeName,
      parameter: parameter ?? this.parameter,
    );
  }

  factory AcceptedRuleSet.fromJson(Map<String, dynamic> json) {
    return AcceptedRuleSet(
      ruleSetTypeCode: (json['ruleSetTypeCode'] ?? '').toString(),
      ruleSetTypeName: (json['ruleSetTypeName'] ?? '').toString(),
      parameter:
      AcceptedParameter.fromJson((json['parameter'] ?? const {}) as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'ruleSetTypeCode': ruleSetTypeCode,
    'ruleSetTypeName': ruleSetTypeName,
    'parameter': parameter.toJson(),
  };

  @override
  String toString() =>
      'AcceptedRuleSet(type: $ruleSetTypeCode/$ruleSetTypeName, parameter: $parameter)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AcceptedRuleSet &&
              runtimeType == other.runtimeType &&
              ruleSetTypeCode == other.ruleSetTypeCode &&
              ruleSetTypeName == other.ruleSetTypeName &&
              parameter == other.parameter;

  @override
  int get hashCode =>
      Object.hash(ruleSetTypeCode, ruleSetTypeName, parameter);
}

class AcceptedValuesEnvelope {
  final String locationCode;   // e.g., "TR"
  final String locationName;   // e.g., "Turkiye"
  final List<AcceptedRuleSet> ruleSets;

  const AcceptedValuesEnvelope({
    required this.locationCode,
    required this.locationName,
    required this.ruleSets,
  });

  AcceptedValuesEnvelope copyWith({
    String? locationCode,
    String? locationName,
    List<AcceptedRuleSet>? ruleSets,
  }) {
    return AcceptedValuesEnvelope(
      locationCode: locationCode ?? this.locationCode,
      locationName: locationName ?? this.locationName,
      ruleSets: ruleSets ?? this.ruleSets,
    );
  }

  factory AcceptedValuesEnvelope.fromJson(Map<String, dynamic> json) {
    final sets = (json['ruleSets'] as List<dynamic>? ?? const [])
        .map((e) => AcceptedRuleSet.fromJson(e as Map<String, dynamic>))
        .toList();

    return AcceptedValuesEnvelope(
      locationCode: (json['locationCode'] ?? '').toString(),
      locationName: (json['locationName'] ?? '').toString(),
      ruleSets: sets,
    );
  }

  Map<String, dynamic> toJson() => {
    'locationCode': locationCode,
    'locationName': locationName,
    'ruleSets': ruleSets.map((e) => e.toJson()).toList(),
  };

  @override
  String toString() =>
      'AcceptedValuesEnvelope($locationName/$locationCode, ruleSets: ${ruleSets.length})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AcceptedValuesEnvelope &&
              runtimeType == other.runtimeType &&
              locationCode == other.locationCode &&
              locationName == other.locationName &&
              _listEquals(ruleSets, other.ruleSets);

  @override
  int get hashCode =>
      Object.hash(locationCode, locationName, Object.hashAll(ruleSets));
}

// ----- small helper -----
bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
