// To parse this JSON data, do
//
//     final logReportDetail = logReportDetailFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../utils_and_services/artemis_icons_icons.dart';
import '../utils_and_services/timatic/src/models/auth_response.dart';
import 'basic_class.dart';
import 'constant_data_class.dart';

LogReportDetail logReportDetailFromJson(String str) => LogReportDetail.fromJson(json.decode(str));

String logReportDetailToJson(LogReportDetail data) => json.encode(data.toJson());

class LogReportDetail {
  final int refCode;
  final String user;
  final int showCode;
  final DateTime createdAt;
  final int status;
  final String airline;
  final String documentNumber;
  final String employeeId;
  final DateTime flightDt;
  final String flightNumber;
  final String from;
  final String nationality;
  final int timaticResult;
  final String to;
  final int totalResult;
  final String? totalResultRole;
  final String? airportAirline;
  final int? airlineApproval;
  final int? agentDecision;
  final List<ReportDetailSupervisor> supervisor;

  LogReportDetail({
    required this.refCode,
    required this.user,
    required this.showCode,
    required this.createdAt,
    required this.status,
    required this.airline,
    required this.documentNumber,
    required this.employeeId,
    required this.flightDt,
    required this.flightNumber,
    required this.airportAirline,
    required this.from,
    required this.nationality,
    required this.timaticResult,
    required this.to,
    required this.totalResult,
    required this.totalResultRole,
    required this.supervisor,
    required this.agentDecision,
    required this.airlineApproval,
  });

  LogReportDetail copyWith({
    int? refCode,
    String? user,
    int? showCode,
    DateTime? createdAt,
    int? status,
    String? airline,
    String? documentNumber,
    String? employeeId,
    String? airportAirline,
    DateTime? flightDt,
    String? flightNumber,
    String? from,
    String? nationality,
    String? totalResultRole,
    int? timaticResult,
    String? to,
    int? totalResult,
    int? airlineApproval,
    int? agentResult,
    List<ReportDetailSupervisor>? supervisor,
  }) =>
      LogReportDetail(
        refCode: refCode ?? this.refCode,
        user: user ?? this.user,
        showCode: showCode ?? this.showCode,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        airline: airline ?? this.airline,
        airportAirline: airportAirline ?? this.airportAirline,
        documentNumber: documentNumber ?? this.documentNumber,
        employeeId: employeeId ?? this.employeeId,
        flightDt: flightDt ?? this.flightDt,
        flightNumber: flightNumber ?? this.flightNumber,
        from: from ?? this.from,
        nationality: nationality ?? this.nationality,
        timaticResult: timaticResult ?? this.timaticResult,
        to: to ?? this.to,
        totalResult: totalResult ?? this.totalResult,
        agentDecision: agentResult ?? this.agentDecision,
        totalResultRole: totalResultRole ?? this.totalResultRole,
        airlineApproval: airlineApproval ?? this.airlineApproval,
        supervisor: supervisor ?? this.supervisor,
      );

  factory LogReportDetail.fromJson(Map<String, dynamic> json) => LogReportDetail(
    refCode: json["refCode"],
    user: json["user"],
    showCode: json["showCode"],
    createdAt: DateTime.parse(json["createdAt"]),
    status: json["status"],
    airline: json["airline"]??'',
    airportAirline: json["airportAirline"]??'',
    documentNumber: json["documentNumber"],
    employeeId: json["employeeId"],
    flightDt: DateTime.parse(json["flightDT"]),
    flightNumber: json["flightNumber"]??'',
    from: json["from"]??'',
    nationality: json["nationality"]??'',
    timaticResult: json["timaticResult"],
    to: json["to"]??'',
    totalResult: json["totalResult"],
    agentDecision: json["agentDecision"],
    totalResultRole: json["totalResultRole"],
    airlineApproval: json["airlineApproval"],
    supervisor: List<ReportDetailSupervisor>.from((json["supervisor"]??[]).map((x) => ReportDetailSupervisor.fromJson(x))),
  );

  Widget get getFlowWidget {
    return Row(
      children: [
        Row(spacing: 4, children: [BasicClass.getResultOfCode(timaticResult).getIconWidgetMini, Text(employeeId)]),
        agentDecision == null ? SizedBox() : Row(spacing: 4, children: [Icon(ArtemisIcons.arrow_right_1, size: 15), BasicClass.getResultOfCode(agentDecision).getIconWidgetMini, Text("Agent")]),
        supervisor.lastOrNull == null ? SizedBox() : Row(spacing: 4, children: [Icon(ArtemisIcons.arrow_right_1, size: 15), supervisor.lastOrNull!.getTimRes!.getIconWidgetMini, Text("Supervisor")]),
        airlineApproval == null
            ? SizedBox()
            : Row(spacing: 4, children: [Icon(ArtemisIcons.arrow_right_1, size: 15), BasicClass.getResultOfCode(airlineApproval).getIconWidgetMini, Text("Airline")]),
      ],
    );
  }

  Map<String, dynamic> toJson() => {
    "refCode": refCode,
    "user": user,
    "showCode": showCode,
    "createdAt": createdAt.toIso8601String(),
    "status": status,
    "airline": airline,
    "documentNumber": documentNumber,
    "employeeId": employeeId,
    "flightDT": flightDt.toIso8601String(),
    "flightNumber": flightNumber,
    "from": from,
    "nationality": nationality,
    "agentDecision": timaticResult,
    "totalResultRole": totalResultRole,
    "to": to,
    "totalResult": totalResult,
    "airlineApproval": airlineApproval,
    "supervisor":supervisor==null?null: List<dynamic>.from(supervisor!.map((x) => x.toJson())),
  };
  
  
}

class ReportDetailSupervisor {
  final String id;
  final int action;
  final String name;

  ReportDetailSupervisor({required this.id, required this.action, required this.name});

  ReportDetailSupervisor copyWith({String? id, int? action, String? name}) => ReportDetailSupervisor(id: id ?? this.id, action: action ?? this.action, name: name ?? this.name);

  factory ReportDetailSupervisor.fromJson(Map<String, dynamic> json) => ReportDetailSupervisor(id: json["id"], action: json["action"], name: json["name"]);

  SupervisorResponse? get getRes => BasicClass.user?.setting?.supervisorResponse?.firstWhereOrNull((a) => a.actionId == action);
  TimaticResult? get getTimRes => BasicClass.getResultOfCode(action);

  Map<String, dynamic> toJson() => {"id": id, "action": action, "name": name};
}
