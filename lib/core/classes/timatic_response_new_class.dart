// To parse this JSON data, do
//
//     final timaticResponseNew = timaticResponseNewFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:abds/core/classes/constant_data_class.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:country_flags_pro/country_flags_pro.dart';
import 'package:flutter/material.dart';

import '../utils_and_services/country_flag_util.dart';
import 'basic_class.dart';

TimaticResponseNew timaticResponseNewFromJson(String str) => TimaticResponseNew.fromJson(json.decode(str));

String timaticResponseNewToJson(TimaticResponseNew data) => json.encode(data.toJson());

class TimaticResponseNew {
  final int? totalResult;
  final int? status;
  final bool open;
  final List<Segment> segments;

  TimaticResponseNew({this.totalResult, this.status, required this.segments, this.open = true});

  TimaticResponseNew copyWith({int? totalResult, int? status, List<Segment>? segments}) => TimaticResponseNew(status: status ?? this.status, totalResult: totalResult ?? this.totalResult, segments: segments ?? this.segments);

  factory TimaticResponseNew.fromJson(Map<String, dynamic> json) =>
      TimaticResponseNew(totalResult: json["totalResult"], status: json["status"], segments: json["segments"] == null ? [] : List<Segment>.from(json["segments"]!.map((x) => Segment.fromJson(x))));

  // bool get isLocked => status == 1;

  TimaticResult get getRes => BasicClass.getResultOfCode(totalResult!);

  // EvalResult get evaluationResult {
  //   return EvalResult.values.firstWhere((a) => a.name.toUpperCase() == totalResult, orElse: () => EvalResult.UNKNOWN);
  // }

  Map<String, dynamic> toJson() => {"totalResult": totalResult, "status": status, "segments": segments == null ? [] : List<dynamic>.from(segments!.map((x) => x.toJson()))};

  TimaticResponseNew setStatus(int? status) {
    var res = this;
    res = res.copyWith(status: status);
    return TimaticResponseNew.fromJson(res.toJson());
  }
}

class Segment {
  final int? segmentResult;
  final bool open;
  final From? from;
  final From? to;
  final List<SegmentResult>? result;

  Segment({this.segmentResult, this.from, this.to, this.result, this.open = false});

  Segment copyWith({int? segmentResult, From? from, From? to, List<SegmentResult>? result, bool? open}) =>
      Segment(segmentResult: segmentResult ?? this.segmentResult, from: from ?? this.from, to: to ?? this.to, result: result ?? this.result, open: open ?? this.open);

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    segmentResult: json["segmentResult"],
    open: json["open"] ?? false,
    from: json["from"] == null ? null : From.fromJson(json["from"]),
    to: json["to"] == null ? null : From.fromJson(json["to"]),
    result: json["result"] == null ? [] : List<SegmentResult>.from(json["result"]!.map((x) => SegmentResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {"segmentResult": segmentResult, "open": open, "from": from?.toJson(), "to": to?.toJson(), "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson()))};

  // EvalResult get segmentEvaluationResult {
  //   return EvalResult.values.firstWhere((a) => a.index == segmentResult - 1, orElse: () => EvalResult.UNKNOWN);
  // }

  TimaticResult get getRes => BasicClass.getResultOfCode(segmentResult!);

  String get route => "${from?.airport ?? ''} - ${to?.airport ?? ''}";

  // String get routeWidget => "${from?.country ?? ''} - ${to?.country ?? ''}";

  Widget get routeWidget => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadiusGeometry.circular(4),
      color: getRes.getColor,
      border: Border.all(color: getRes.getColor),
    ),
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    child: Row(
      children: [
        // Icon(getRes.getIconCircle, color: Colors.white, size: 15),
        // const SizedBox(width: 4),
        Text(
          "${from!.airport} - ",
          style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        MyCountryFlagsPro.getFlag(to!.country!,  borderRadius: BorderRadius.circular(4)),
        Text(
          " ${to!.airport}",
          style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
  Widget get routeWidgetBig => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadiusGeometry.circular(4),
      color: getRes.getColor,
      border: Border.all(color: getRes.getColor),
    ),
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    child: Row(
      children: [
        // Icon(getRes.getIconCircle, color: Colors.white, size: 15),
        // const SizedBox(width: 4),
        Text(
          "${from!.airport} ",
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        Icon(Icons.arrow_right_alt,color: Colors.white,),
        MyCountryFlagsPro.getFlag(to!.country!,  borderRadius: BorderRadius.circular(4),width: 30,height: 24),
        Text(
          " ${to!.airport}",
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

class From {
  final String airport;
  final String country;

  From({required this.airport, required this.country});

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
  final bool open;
  final int ruleSetResult;
  final List<DocumentResult> documents;
  final List<Regulation> regulations;

  RuleSetEvaluation({this.title, required this.ruleSetResult, this.documents = const [], this.regulations = const [], this.open = false});

  RuleSetEvaluation copyWith({String? title, int? ruleSetResult, List<DocumentResult>? documents, List<Regulation>? regulations, bool? open}) =>
      RuleSetEvaluation(open: open ?? this.open, title: title ?? this.title, ruleSetResult: ruleSetResult ?? this.ruleSetResult, documents: documents ?? this.documents, regulations: regulations ?? this.regulations);

  factory RuleSetEvaluation.fromJson(Map<String, dynamic> json) => RuleSetEvaluation(
    title: json["title"],
    open: json["open"] ?? false,
    ruleSetResult: json["ruleSetResult"],
    documents: json["documents"] == null ? [] : List<DocumentResult>.from(json["documents"]!.map((x) => DocumentResult.fromJson(x))),
    regulations: json["regulations"] == null ? [] : List<Regulation>.from(json["regulations"]!.map((x) => Regulation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "open": open,
    "ruleSetResult": ruleSetResult,
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
    "regulations": regulations == null ? [] : List<dynamic>.from(regulations!.map((x) => x.toJson())),
  };

  EvalResult get evaluationResult => EvalResult.values.firstWhere((a) => a.index == ruleSetResult - 1, orElse: () => EvalResult.UNKNOWN);

  Color get getColor => getRes.getColor;
  Color get getSolidColor => getRes.getSolidColor;
  Color get getSolidLineColor => getRes.getSolidLineColor;

  IconData get getIcon {
    return getRes.getIconCircle!;
    return evaluationResult.getIcon;
  }

  TimaticResult get getRes => BasicClass.getResultOfCode(ruleSetResult);
}

class DocumentResult {
  final int? index;
  final int documentResult;
  final bool open;
  final List<Regulation> regulations;

  DocumentResult({this.index, required this.documentResult, this.regulations = const [], this.open = false});

  DocumentResult copyWith({int? index, int? documentResult, List<Regulation>? regulations, bool? open}) =>
      DocumentResult(open: open ?? this.open, index: index ?? this.index, documentResult: documentResult ?? this.documentResult, regulations: regulations ?? this.regulations);

  factory DocumentResult.fromJson(Map<String, dynamic> json) => DocumentResult(
    index: json["index"],
    open: json["open"] ?? false,
    documentResult: json["documentResult"],
    regulations: json["regulations"] == null ? [] : List<Regulation>.from(json["regulations"]!.map((x) => Regulation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {"open": open, "index": index, "documentResult": documentResult, "regulations": regulations == null ? [] : List<dynamic>.from(regulations!.map((x) => x.toJson()))};

  EvalResult get evaluationResult => EvalResult.values.firstWhere((a) => a.index == documentResult - 1, orElse: () => EvalResult.UNKNOWN);
}

class Regulation {
  final int regulationResult;
  final String title;
  final bool open;
  final List<String>? texts;

  Regulation({required this.regulationResult, required this.title, this.texts, this.open = false});

  Regulation copyWith({int? regulationResult, String? title, bool? open, List<String>? texts}) => Regulation(regulationResult: regulationResult ?? this.regulationResult, title: title ?? this.title, texts: texts ?? this.texts);

  factory Regulation.fromJson(Map<String, dynamic> json) =>
      Regulation(open: json["open"] ?? false, regulationResult: json["regulationResult"], title: json["title"], texts: json["texts"] == null ? [] : List<String>.from(json["texts"]!.map((x) => x)));

  Map<String, dynamic> toJson() => {"regulationResult": regulationResult, "title": title, "open": open, "texts": texts == null ? [] : List<dynamic>.from(texts!.map((x) => x))};

  // EvalResult get evaluationResult => EvalResult.values.firstWhere((a) => a.index == regulationResult-1, orElse: () => EvalResult.UNKNOWN);

  TimaticResult get getRes => BasicClass.getResultOfCode(regulationResult);
}
