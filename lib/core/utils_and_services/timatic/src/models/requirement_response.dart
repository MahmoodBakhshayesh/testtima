class RequirementResponse {
  final String summary;                 // human-readable summary
  final List<RuleItem> rules;           // structured rules
  final List<String> warnings;          // any special notices
  final List<String> requiredDocuments; // e.g., passport, visa, onward ticket

  const RequirementResponse({
    required this.summary,
    required this.rules,
    required this.warnings,
    required this.requiredDocuments,
  });

  RequirementResponse copyWith({
    String? summary,
    List<RuleItem>? rules,
    List<String>? warnings,
    List<String>? requiredDocuments,
  }) {
    return RequirementResponse(
      summary: summary ?? this.summary,
      rules: rules ?? List<RuleItem>.from(this.rules),
      warnings: warnings ?? List<String>.from(this.warnings),
      requiredDocuments: requiredDocuments ?? List<String>.from(this.requiredDocuments),
    );
  }

  factory RequirementResponse.fromJson(Map<String, dynamic> json) {
    return RequirementResponse(
      summary: (json['summary'] ?? '').toString(),
      rules: (json['rules'] as List? ?? [])
          .whereType<Map<String, dynamic>>()
          .map((e) => RuleItem.fromJson(e))
          .toList(),
      warnings: (json['warnings'] as List? ?? []).map((e) => e.toString()).toList(),
      requiredDocuments:
      (json['requiredDocuments'] as List? ?? []).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
      'rules': rules.map((e) => e.toJson()).toList(),
      'warnings': warnings,
      'requiredDocuments': requiredDocuments,
    };
  }

  @override
  String toString() =>
      'RequirementResponse(summary: $summary, rules: $rules, warnings: $warnings, requiredDocuments: $requiredDocuments)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RequirementResponse &&
              runtimeType == other.runtimeType &&
              summary == other.summary &&
              _listEquals(rules, other.rules) &&
              _listEquals(warnings, other.warnings) &&
              _listEquals(requiredDocuments, other.requiredDocuments);

  @override
  int get hashCode =>
      Object.hash(summary, rules, warnings, requiredDocuments);
}

class RuleItem {
  final String code;          // e.g., "VISA", "PASSPORT_VALIDITY"
  final String title;         // e.g., "Visa Requirement"
  final String description;   // human readable
  final Map<String, dynamic>? data; // optional structured fields

  const RuleItem({
    required this.code,
    required this.title,
    required this.description,
    this.data,
  });

  RuleItem copyWith({
    String? code,
    String? title,
    String? description,
    Map<String, dynamic>? data,
  }) {
    return RuleItem(
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      data: data ?? (this.data != null ? Map<String, dynamic>.from(this.data!) : null),
    );
  }

  factory RuleItem.fromJson(Map<String, dynamic> json) {
    return RuleItem(
      code: (json['code'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'] as Map)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
      'description': description,
      if (data != null) 'data': data,
    };
  }

  @override
  String toString() =>
      'RuleItem(code: $code, title: $title, description: $description, data: $data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RuleItem &&
              runtimeType == other.runtimeType &&
              code == other.code &&
              title == other.title &&
              description == other.description &&
              _mapEquals(data, other.data);

  @override
  int get hashCode => Object.hash(code, title, description, data);
}

// --- Helpers for deep equality ---
bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null || b == null) return a == b;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

bool _mapEquals(Map? a, Map? b) {
  if (a == null || b == null) return a == b;
  if (a.length != b.length) return false;
  for (final key in a.keys) {
    if (!b.containsKey(key) || a[key] != b[key]) return false;
  }
  return true;
}
