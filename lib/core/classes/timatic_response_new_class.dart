// To parse this JSON data, do
//
//     final timaticResponseNew = timaticResponseNewFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/material.dart';

import 'basic_class.dart';

TimaticResponseNew timaticResponseNewFromJson(String str) => TimaticResponseNew.fromJson(json.decode(str));

String timaticResponseNewToJson(TimaticResponseNew data) => json.encode(data.toJson());

class TimaticResponseNew {
  final String? totalResult;
  final int? status;
  final List<Segment> segments;

  TimaticResponseNew({this.totalResult, this.status, required this.segments});

  TimaticResponseNew copyWith({String? totalResult, int? status, List<Segment>? segments}) => TimaticResponseNew(status: status ?? this.status, totalResult: totalResult ?? this.totalResult, segments: segments ?? this.segments);

  factory TimaticResponseNew.fromJson(Map<String, dynamic> json) =>
      TimaticResponseNew(totalResult: json["totalResult"], status: json["status"], segments: json["segments"] == null ? [] : List<Segment>.from(json["segments"]!.map((x) => Segment.fromJson(x))));

  bool get isLocked => status == 1;

  EvalResult get evaluationResult {
    return EvalResult.values.firstWhere((a) => a.name.toUpperCase() == totalResult, orElse: () => EvalResult.UNKNOWN);
  }

  Map<String, dynamic> toJson() => {"totalResult": totalResult, "status": status, "segments": segments == null ? [] : List<dynamic>.from(segments!.map((x) => x.toJson()))};

  TimaticResponseNew setStatus(int? status) {
    var res = this;
    res = res.copyWith(status: status);
    return TimaticResponseNew.fromJson(res.toJson());
  }
}

class Segment {
  final String? segmentResult;

  final From? from;
  final From? to;
  final List<SegmentResult>? result;

  Segment({this.segmentResult, this.from, this.to, this.result});

  Segment copyWith({String? segmentResult, From? from, From? to, List<SegmentResult>? result}) =>
      Segment(segmentResult: segmentResult ?? this.segmentResult, from: from ?? this.from, to: to ?? this.to, result: result ?? this.result);

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    segmentResult: json["segmentResult"],
    from: json["from"] == null ? null : From.fromJson(json["from"]),
    to: json["to"] == null ? null : From.fromJson(json["to"]),
    result: json["result"] == null ? [] : List<SegmentResult>.from(json["result"]!.map((x) => SegmentResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {"segmentResult": segmentResult, "from": from?.toJson(), "to": to?.toJson(), "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson()))};

  EvalResult get segmentEvaluationResult {
    return EvalResult.values.firstWhere((a) => a.name.toUpperCase() == segmentResult, orElse: () => EvalResult.UNKNOWN);
  }

  String get route => "${from?.airport ?? ''} - ${to?.airport ?? ''}";

  String get routeWidget => "${from?.country ?? ''} - ${to?.country ?? ''}";
}

class From {
  final String? airport;
  final String? country;

  From({this.airport, this.country});

  From copyWith({String? airport, String? country}) => From(airport: airport ?? this.airport, country: country ?? this.country);

  factory From.fromJson(Map<String, dynamic> json) => From(airport: json["airport"], country: json["country"]);

  Map<String, dynamic> toJson() => {"airport": airport, "country": country};
}

class SegmentResult {
  final String? language;
  final List<RuleSetEvaluation>? ruleSetEvaluations;

  SegmentResult({this.language, this.ruleSetEvaluations});

  SegmentResult copyWith({String? language, List<RuleSetEvaluation>? ruleSetEvaluations}) => SegmentResult(language: language ?? this.language, ruleSetEvaluations: ruleSetEvaluations ?? this.ruleSetEvaluations);

  factory SegmentResult.fromJson(Map<String, dynamic> json) =>
      SegmentResult(language: json["language"], ruleSetEvaluations: json["ruleSetEvaluations"] == null ? [] : List<RuleSetEvaluation>.from(json["ruleSetEvaluations"]!.map((x) => RuleSetEvaluation.fromJson(x))));

  Map<String, dynamic> toJson() => {"language": language, "ruleSetEvaluations": ruleSetEvaluations == null ? [] : List<dynamic>.from(ruleSetEvaluations!.map((x) => x.toJson()))};
}

class RuleSetEvaluation {
  final String? title;
  final String? ruleSetResult;
  final List<DocumentResult> documents;
  final List<Regulation> regulations;

  RuleSetEvaluation({this.title, this.ruleSetResult, this.documents = const [], this.regulations = const []});

  RuleSetEvaluation copyWith({String? title, String? ruleSetResult, List<DocumentResult>? documents, List<Regulation>? regulations}) =>
      RuleSetEvaluation(title: title ?? this.title, ruleSetResult: ruleSetResult ?? this.ruleSetResult, documents: documents ?? this.documents, regulations: regulations ?? this.regulations);

  factory RuleSetEvaluation.fromJson(Map<String, dynamic> json) => RuleSetEvaluation(
    title: json["title"],
    ruleSetResult: json["ruleSetResult"],
    documents: json["documents"] == null ? [] : List<DocumentResult>.from(json["documents"]!.map((x) => DocumentResult.fromJson(x))),
    regulations: json["regulations"] == null ? [] : List<Regulation>.from(json["regulations"]!.map((x) => Regulation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "ruleSetResult": ruleSetResult,
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
    "regulations": regulations == null ? [] : List<dynamic>.from(regulations!.map((x) => x.toJson())),
  };

  EvalResult get evaluationResult => EvalResult.values.firstWhere((a) => a.name.toUpperCase() == ruleSetResult, orElse: () => EvalResult.UNKNOWN);

  Color get getColor => BasicClass.getColorForEvaluationResult(evaluationResult.name);

  IconData get getIcon => evaluationResult.getIcon;
}

class DocumentResult {
  final int? index;
  final String documentResult;
  final List<Regulation> regulations;

  DocumentResult({this.index, required this.documentResult, this.regulations = const []});

  DocumentResult copyWith({int? index, String? documentResult, List<Regulation>? regulations}) =>
      DocumentResult(index: index ?? this.index, documentResult: documentResult ?? this.documentResult, regulations: regulations ?? this.regulations);

  factory DocumentResult.fromJson(Map<String, dynamic> json) =>
      DocumentResult(index: json["index"], documentResult: json["documentResult"], regulations: json["regulations"] == null ? [] : List<Regulation>.from(json["regulations"]!.map((x) => Regulation.fromJson(x))));

  Map<String, dynamic> toJson() => {"index": index, "documentResult": documentResult, "regulations": regulations == null ? [] : List<dynamic>.from(regulations!.map((x) => x.toJson()))};

  EvalResult get evaluationResult => EvalResult.values.firstWhere((a) => a.name.toUpperCase() == documentResult, orElse: () => EvalResult.UNKNOWN);
}

class Regulation {
  final String regulationResult;
  final String title;
  final List<String>? texts;

  Regulation({required this.regulationResult, required this.title, this.texts});

  Regulation copyWith({String? regulationResult, String? title, List<String>? texts}) => Regulation(regulationResult: regulationResult ?? this.regulationResult, title: title ?? this.title, texts: texts ?? this.texts);

  factory Regulation.fromJson(Map<String, dynamic> json) => Regulation(regulationResult: json["regulationResult"], title: json["title"], texts: json["texts"] == null ? [] : List<String>.from(json["texts"]!.map((x) => x)));

  Map<String, dynamic> toJson() => {"regulationResult": regulationResult, "title": title, "texts": texts == null ? [] : List<dynamic>.from(texts!.map((x) => x))};

  EvalResult get evaluationResult => EvalResult.values.firstWhere((a) => a.name.toUpperCase() == regulationResult, orElse: () => EvalResult.UNKNOWN);
}
