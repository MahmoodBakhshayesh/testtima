// To parse this JSON data, do
//
//     final refHistory = refHistoryFromJson(jsonString);

import 'dart:convert';

RefHistory refHistoryFromJson(String str) => RefHistory.fromJson(json.decode(str));

String refHistoryToJson(RefHistory data) => json.encode(data.toJson());

class RefHistory {
  final List<Log>? logs;
  final DateTime? updatedAt;

  RefHistory({
    this.logs,
    this.updatedAt,
  });

  RefHistory copyWith({
    List<Log>? logs,
    DateTime? updatedAt,
  }) =>
      RefHistory(
        logs: logs ?? this.logs,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory RefHistory.fromJson(Map<String, dynamic> json) => RefHistory(
    logs: json["logs"] == null ? [] : List<Log>.from(json["logs"]!.map((x) => Log.fromJson(x))),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "logs": logs == null ? [] : List<dynamic>.from(logs!.map((x) => x.toJson())),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Log {
  final String? url;
  final String? input;
  final String? output;
  final bool? result;
  final bool? cache;
  final String? type;

  Log({
    this.url,
    this.input,
    this.output,
    this.result,
    this.cache,
    this.type,
  });

  Log copyWith({
    String? url,
    String? input,
    String? output,
    bool? result,
    bool? cache,
    String? type,
  }) =>
      Log(
        url: url ?? this.url,
        input: input ?? this.input,
        output: output ?? this.output,
        result: result ?? this.result,
        cache: cache ?? this.cache,
        type: type ?? this.type,
      );

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    url: json["url"],
    input: json["input"],
    output: json["output"],
    result: json["result"],
    cache: json["cache"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "input": input,
    "output": output,
    "result": result,
    "cache": cache,
    "type": type,
  };
}

class Output {
  final String? transactionId;
  final String? passengerId;
  final EvaluationResult? evaluationResult;
  final List<SubmittedDocument>? submittedDocuments;
  final List<SegmentResult>? segmentResults;
  final List<dynamic>? traces;

  Output({
    this.transactionId,
    this.passengerId,
    this.evaluationResult,
    this.submittedDocuments,
    this.segmentResults,
    this.traces,
  });

  Output copyWith({
    String? transactionId,
    String? passengerId,
    EvaluationResult? evaluationResult,
    List<SubmittedDocument>? submittedDocuments,
    List<SegmentResult>? segmentResults,
    List<dynamic>? traces,
  }) =>
      Output(
        transactionId: transactionId ?? this.transactionId,
        passengerId: passengerId ?? this.passengerId,
        evaluationResult: evaluationResult ?? this.evaluationResult,
        submittedDocuments: submittedDocuments ?? this.submittedDocuments,
        segmentResults: segmentResults ?? this.segmentResults,
        traces: traces ?? this.traces,
      );

  factory Output.fromJson(Map<String, dynamic> json) => Output(
    transactionId: json["transactionId"],
    passengerId: json["passengerId"],
    evaluationResult: evaluationResultValues.map[json["evaluationResult"]]!,
    submittedDocuments: json["submittedDocuments"] == null ? [] : List<SubmittedDocument>.from(json["submittedDocuments"]!.map((x) => SubmittedDocument.fromJson(x))),
    segmentResults: json["segmentResults"] == null ? [] : List<SegmentResult>.from(json["segmentResults"]!.map((x) => SegmentResult.fromJson(x))),
    traces: json["traces"] == null ? [] : List<dynamic>.from(json["traces"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "passengerId": passengerId,
    "evaluationResult": evaluationResultValues.reverse[evaluationResult],
    "submittedDocuments": submittedDocuments == null ? [] : List<dynamic>.from(submittedDocuments!.map((x) => x.toJson())),
    "segmentResults": segmentResults == null ? [] : List<dynamic>.from(segmentResults!.map((x) => x.toJson())),
    "traces": traces == null ? [] : List<dynamic>.from(traces!.map((x) => x)),
  };
}

enum EvaluationResult {
  YES
}

final evaluationResultValues = EnumValues({
  "YES": EvaluationResult.YES
});

class SegmentResult {
  final Country? arrivingCountry;
  final Country? departureCountry;
  final Arrival? arrival;
  final Arrival? departure;
  final String? regulationApplicability;
  final EvaluationResult? segmentEvaluationResult;
  final List<RuleSet>? ruleSetEvaluations;

  SegmentResult({
    this.arrivingCountry,
    this.departureCountry,
    this.arrival,
    this.departure,
    this.regulationApplicability,
    this.segmentEvaluationResult,
    this.ruleSetEvaluations,
  });

  SegmentResult copyWith({
    Country? arrivingCountry,
    Country? departureCountry,
    Arrival? arrival,
    Arrival? departure,
    String? regulationApplicability,
    EvaluationResult? segmentEvaluationResult,
    List<RuleSet>? ruleSetEvaluations,
  }) =>
      SegmentResult(
        arrivingCountry: arrivingCountry ?? this.arrivingCountry,
        departureCountry: departureCountry ?? this.departureCountry,
        arrival: arrival ?? this.arrival,
        departure: departure ?? this.departure,
        regulationApplicability: regulationApplicability ?? this.regulationApplicability,
        segmentEvaluationResult: segmentEvaluationResult ?? this.segmentEvaluationResult,
        ruleSetEvaluations: ruleSetEvaluations ?? this.ruleSetEvaluations,
      );

  factory SegmentResult.fromJson(Map<String, dynamic> json) => SegmentResult(
    arrivingCountry: json["arrivingCountry"] == null ? null : Country.fromJson(json["arrivingCountry"]),
    departureCountry: json["departureCountry"] == null ? null : Country.fromJson(json["departureCountry"]),
    arrival: json["arrival"] == null ? null : Arrival.fromJson(json["arrival"]),
    departure: json["departure"] == null ? null : Arrival.fromJson(json["departure"]),
    regulationApplicability: json["regulationApplicability"],
    segmentEvaluationResult: evaluationResultValues.map[json["segmentEvaluationResult"]]!,
    ruleSetEvaluations: json["ruleSetEvaluations"] == null ? [] : List<RuleSet>.from(json["ruleSetEvaluations"]!.map((x) => RuleSet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "arrivingCountry": arrivingCountry?.toJson(),
    "departureCountry": departureCountry?.toJson(),
    "arrival": arrival?.toJson(),
    "departure": departure?.toJson(),
    "regulationApplicability": regulationApplicability,
    "segmentEvaluationResult": evaluationResultValues.reverse[segmentEvaluationResult],
    "ruleSetEvaluations": ruleSetEvaluations == null ? [] : List<dynamic>.from(ruleSetEvaluations!.map((x) => x.toJson())),
  };
}

class Arrival {
  final String? point;
  final String? type;
  final DateTime? dateTime;

  Arrival({
    this.point,
    this.type,
    this.dateTime,
  });

  Arrival copyWith({
    String? point,
    String? type,
    DateTime? dateTime,
  }) =>
      Arrival(
        point: point ?? this.point,
        type: type ?? this.type,
        dateTime: dateTime ?? this.dateTime,
      );

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
    point: json["point"],
    type: json["type"],
    dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "point": point,
    "type": type,
    "dateTime": dateTime?.toIso8601String(),
  };
}

class Country {
  final String? name;

  Country({
    this.name,
  });

  Country copyWith({
    String? name,
  }) =>
      Country(
        name: name ?? this.name,
      );

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class RuleSet {
  final bool? applicable;
  final DocumentCategory? ruleSetType;
  final EvaluationResult? evaluationResult;
  final bool? evaluationResultOverridden;
  final List<DocumentResult>? documentResults;
  final List<Regulation>? regulations;

  RuleSet({
    this.applicable,
    this.ruleSetType,
    this.evaluationResult,
    this.evaluationResultOverridden,
    this.documentResults,
    this.regulations,
  });

  RuleSet copyWith({
    bool? applicable,
    DocumentCategory? ruleSetType,
    EvaluationResult? evaluationResult,
    bool? evaluationResultOverridden,
    List<DocumentResult>? documentResults,
    List<Regulation>? regulations,
  }) =>
      RuleSet(
        applicable: applicable ?? this.applicable,
        ruleSetType: ruleSetType ?? this.ruleSetType,
        evaluationResult: evaluationResult ?? this.evaluationResult,
        evaluationResultOverridden: evaluationResultOverridden ?? this.evaluationResultOverridden,
        documentResults: documentResults ?? this.documentResults,
        regulations: regulations ?? this.regulations,
      );

  factory RuleSet.fromJson(Map<String, dynamic> json) => RuleSet(
    applicable: json["applicable"],
    ruleSetType: json["ruleSetType"] == null ? null : DocumentCategory.fromJson(json["ruleSetType"]),
    evaluationResult: evaluationResultValues.map[json["evaluationResult"]]!,
    evaluationResultOverridden: json["evaluationResultOverridden"],
    documentResults: json["documentResults"] == null ? [] : List<DocumentResult>.from(json["documentResults"]!.map((x) => DocumentResult.fromJson(x))),
    regulations: json["regulations"] == null ? [] : List<Regulation>.from(json["regulations"]!.map((x) => Regulation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "applicable": applicable,
    "ruleSetType": ruleSetType?.toJson(),
    "evaluationResult": evaluationResultValues.reverse[evaluationResult],
    "evaluationResultOverridden": evaluationResultOverridden,
    "documentResults": documentResults == null ? [] : List<dynamic>.from(documentResults!.map((x) => x.toJson())),
    "regulations": regulations == null ? [] : List<dynamic>.from(regulations!.map((x) => x.toJson())),
  };
}

class DocumentResult {
  final int? documentIndex;
  final EvaluationResult? evaluationResult;
  final List<Regulation>? regulations;

  DocumentResult({
    this.documentIndex,
    this.evaluationResult,
    this.regulations,
  });

  DocumentResult copyWith({
    int? documentIndex,
    EvaluationResult? evaluationResult,
    List<Regulation>? regulations,
  }) =>
      DocumentResult(
        documentIndex: documentIndex ?? this.documentIndex,
        evaluationResult: evaluationResult ?? this.evaluationResult,
        regulations: regulations ?? this.regulations,
      );

  factory DocumentResult.fromJson(Map<String, dynamic> json) => DocumentResult(
    documentIndex: json["documentIndex"],
    evaluationResult: evaluationResultValues.map[json["evaluationResult"]]!,
    regulations: json["regulations"] == null ? [] : List<Regulation>.from(json["regulations"]!.map((x) => Regulation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "documentIndex": documentIndex,
    "evaluationResult": evaluationResultValues.reverse[evaluationResult],
    "regulations": regulations == null ? [] : List<dynamic>.from(regulations!.map((x) => x.toJson())),
  };
}

class Regulation {
  final String? code;
  final String? name;
  final EvaluationResult? evaluationResult;
  final List<Text>? texts;
  final VerificationBy? verificationBy;

  Regulation({
    this.code,
    this.name,
    this.evaluationResult,
    this.texts,
    this.verificationBy,
  });

  Regulation copyWith({
    String? code,
    String? name,
    EvaluationResult? evaluationResult,
    List<Text>? texts,
    VerificationBy? verificationBy,
  }) =>
      Regulation(
        code: code ?? this.code,
        name: name ?? this.name,
        evaluationResult: evaluationResult ?? this.evaluationResult,
        texts: texts ?? this.texts,
        verificationBy: verificationBy ?? this.verificationBy,
      );

  factory Regulation.fromJson(Map<String, dynamic> json) => Regulation(
    code: json["code"],
    name: json["name"],
    evaluationResult: evaluationResultValues.map[json["evaluationResult"]]!,
    texts: json["texts"] == null ? [] : List<Text>.from(json["texts"]!.map((x) => Text.fromJson(x))),
    verificationBy: verificationByValues.map[json["verificationBy"]]!,
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "evaluationResult": evaluationResultValues.reverse[evaluationResult],
    "texts": texts == null ? [] : List<dynamic>.from(texts!.map((x) => x.toJson())),
    "verificationBy": verificationByValues.reverse[verificationBy],
  };
}

class Text {
  final String? text;
  final List<DocumentCategory>? categories;
  final VerificationMethod? verificationMethod;

  Text({
    this.text,
    this.categories,
    this.verificationMethod,
  });

  Text copyWith({
    String? text,
    List<DocumentCategory>? categories,
    VerificationMethod? verificationMethod,
  }) =>
      Text(
        text: text ?? this.text,
        categories: categories ?? this.categories,
        verificationMethod: verificationMethod ?? this.verificationMethod,
      );

  factory Text.fromJson(Map<String, dynamic> json) => Text(
    text: json["text"],
    categories: json["categories"] == null ? [] : List<DocumentCategory>.from(json["categories"]!.map((x) => DocumentCategory.fromJson(x))),
    verificationMethod: verificationMethodValues.map[json["verificationMethod"]]!,
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "verificationMethod": verificationMethodValues.reverse[verificationMethod],
  };
}

class DocumentCategory {
  final String? code;
  final String? name;

  DocumentCategory({
    this.code,
    this.name,
  });

  DocumentCategory copyWith({
    String? code,
    String? name,
  }) =>
      DocumentCategory(
        code: code ?? this.code,
        name: name ?? this.name,
      );

  factory DocumentCategory.fromJson(Map<String, dynamic> json) => DocumentCategory(
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
  };
}

enum VerificationMethod {
  DATA_ENTRY,
  MANUAL
}

final verificationMethodValues = EnumValues({
  "Data Entry": VerificationMethod.DATA_ENTRY,
  "Manual": VerificationMethod.MANUAL
});

enum VerificationBy {
  AGENT
}

final verificationByValues = EnumValues({
  "AGENT": VerificationBy.AGENT
});

class SubmittedDocument {
  final List<DocumentUsability>? documentUsability;
  final DocumentCategory? documentCategory;
  final DateTime? documentExpiryDate;
  final DocumentCategory? documentIssueCountry;
  final DocumentCategory? documentCode;
  final DocumentCategory? nationality;

  SubmittedDocument({
    this.documentUsability,
    this.documentCategory,
    this.documentExpiryDate,
    this.documentIssueCountry,
    this.documentCode,
    this.nationality,
  });

  SubmittedDocument copyWith({
    List<DocumentUsability>? documentUsability,
    DocumentCategory? documentCategory,
    DateTime? documentExpiryDate,
    DocumentCategory? documentIssueCountry,
    DocumentCategory? documentCode,
    DocumentCategory? nationality,
  }) =>
      SubmittedDocument(
        documentUsability: documentUsability ?? this.documentUsability,
        documentCategory: documentCategory ?? this.documentCategory,
        documentExpiryDate: documentExpiryDate ?? this.documentExpiryDate,
        documentIssueCountry: documentIssueCountry ?? this.documentIssueCountry,
        documentCode: documentCode ?? this.documentCode,
        nationality: nationality ?? this.nationality,
      );

  factory SubmittedDocument.fromJson(Map<String, dynamic> json) => SubmittedDocument(
    documentUsability: json["documentUsability"] == null ? [] : List<DocumentUsability>.from(json["documentUsability"]!.map((x) => DocumentUsability.fromJson(x))),
    documentCategory: json["documentCategory"] == null ? null : DocumentCategory.fromJson(json["documentCategory"]),
    documentExpiryDate: json["documentExpiryDate"] == null ? null : DateTime.parse(json["documentExpiryDate"]),
    documentIssueCountry: json["documentIssueCountry"] == null ? null : DocumentCategory.fromJson(json["documentIssueCountry"]),
    documentCode: json["documentCode"] == null ? null : DocumentCategory.fromJson(json["documentCode"]),
    nationality: json["nationality"] == null ? null : DocumentCategory.fromJson(json["nationality"]),
  );

  Map<String, dynamic> toJson() => {
    "documentUsability": documentUsability == null ? [] : List<dynamic>.from(documentUsability!.map((x) => x.toJson())),
    "documentCategory": documentCategory?.toJson(),
    "documentExpiryDate": "${documentExpiryDate!.year.toString().padLeft(4, '0')}-${documentExpiryDate!.month.toString().padLeft(2, '0')}-${documentExpiryDate!.day.toString().padLeft(2, '0')}",
    "documentIssueCountry": documentIssueCountry?.toJson(),
    "documentCode": documentCode?.toJson(),
    "nationality": nationality?.toJson(),
  };
}

class DocumentUsability {
  final List<RuleSet>? ruleSets;
  final bool? canUse;
  final int? segmentIndex;

  DocumentUsability({
    this.ruleSets,
    this.canUse,
    this.segmentIndex,
  });

  DocumentUsability copyWith({
    List<RuleSet>? ruleSets,
    bool? canUse,
    int? segmentIndex,
  }) =>
      DocumentUsability(
        ruleSets: ruleSets ?? this.ruleSets,
        canUse: canUse ?? this.canUse,
        segmentIndex: segmentIndex ?? this.segmentIndex,
      );

  factory DocumentUsability.fromJson(Map<String, dynamic> json) => DocumentUsability(
    ruleSets: json["ruleSets"] == null ? [] : List<RuleSet>.from(json["ruleSets"]!.map((x) => RuleSet.fromJson(x))),
    canUse: json["canUse"],
    segmentIndex: json["segmentIndex"],
  );

  Map<String, dynamic> toJson() => {
    "ruleSets": ruleSets == null ? [] : List<dynamic>.from(ruleSets!.map((x) => x.toJson())),
    "canUse": canUse,
    "segmentIndex": segmentIndex,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
