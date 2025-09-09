// To parse this JSON data, do
//
//     final performanceLog = performanceLogFromJson(jsonString);

import 'dart:convert';

PerformanceLog performanceLogFromJson(String str) => PerformanceLog.fromJson(json.decode(str));

String performanceLogToJson(PerformanceLog data) => json.encode(data.toJson());

class PerformanceLog {
  final int? total;
  final int? allowes;
  final int? notAllowed;
  final int? conditional;
  final int? forceApproved;
  final List<PerformanceLogDetail>? details;

  PerformanceLog({
    this.total,
    this.allowes,
    this.notAllowed,
    this.conditional,
    this.forceApproved,
    this.details,
  });

  PerformanceLog copyWith({
    int? total,
    int? allowes,
    int? notAllowed,
    int? conditional,
    int? forceApproved,
    List<PerformanceLogDetail>? details,
  }) =>
      PerformanceLog(
        total: total ?? this.total,
        allowes: allowes ?? this.allowes,
        notAllowed: notAllowed ?? this.notAllowed,
        conditional: conditional ?? this.conditional,
        forceApproved: forceApproved ?? this.forceApproved,
        details: details ?? this.details,
      );

  factory PerformanceLog.fromJson(Map<String, dynamic> json) => PerformanceLog(
    total: json["total"],
    allowes: json["allowes"],
    notAllowed: json["notAllowed"],
    conditional: json["conditional"],
    forceApproved: json["forceApproved"],
    details: json["details"] == null ? [] : List<PerformanceLogDetail>.from(json["details"]!.map((x) => PerformanceLogDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "allowes": allowes,
    "notAllowed": notAllowed,
    "conditional": conditional,
    "forceApproved": forceApproved,
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class PerformanceLogDetail {
  final String? dateTime;
  final String? agent;
  final String? route;
  final String? code;
  final int? result;

  PerformanceLogDetail({
    this.dateTime,
    this.agent,
    this.route,
    this.code,
    this.result,
  });

  PerformanceLogDetail copyWith({
    String? dateTime,
    String? agent,
    String? route,
    String? code,
    int? result,
  }) =>
      PerformanceLogDetail(
        dateTime: dateTime ?? this.dateTime,
        agent: agent ?? this.agent,
        route: route ?? this.route,
        code: code ?? this.code,
        result: result ?? this.result,
      );

  factory PerformanceLogDetail.fromJson(Map<String, dynamic> json) => PerformanceLogDetail(
    dateTime: json["dateTime"],
    agent: json["agent"],
    route: json["route"],
    code: json["code"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "dateTime": dateTime,
    "agent": agent,
    "route": route,
    "code": code,
    "result": result,
  };

  String get getResultText => result == 1 ?"Allowed":result == 2? "Not Allowed":"Conditional";
  String get getResultColor => result == 1 ?"Allowed":result == 2? "Not Allowed":"Conditional";
}
