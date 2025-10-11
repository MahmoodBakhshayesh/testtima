// To parse this JSON data, do
//
//     final inboxMessage = inboxMessageFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_utils/get_utils.dart';

import '../utils_and_services/timatic/src/models/auth_response.dart';
import 'basic_class.dart';
import 'constant_data_class.dart';

OutboxMessage inboxMessageFromJson(String str) => OutboxMessage.fromJson(json.decode(str));

String inboxMessageToJson(OutboxMessage data) => json.encode(data.toJson());

class OutboxMessage {
  final String id;
  final String type;
  final bool read;
  final DateTime createdAt;
  final String user;
  final String showCode;
  final int status;
  final String airline;
  final String employeeId;
  final DateTime flightDt;
  final String flightNumber;
  final String from;
  final String nationality;
  final String to;
  final int totalResult;
  final int timaticResult;
  final int? airlineApproval;
  final List<OutboxSupervisor> supervisor;

  OutboxMessage({
    required this.id,
    required this.type,
    required this.read,
    required this.createdAt,
    required this.user,
    required this.showCode,
    required this.status,
    required this.airline,
    required this.employeeId,
    required this.flightDt,
    required this.flightNumber,
    required this.from,
    required this.nationality,
    required this.to,
    required this.totalResult,
    required this.timaticResult,
    this.airlineApproval,
    required this.supervisor,
  });

  OutboxMessage copyWith({
    String? id,
    String? type,
    bool? read,
    DateTime? createdAt,
    String? user,
    String? showCode,
    int? status,
    String? airline,
    String? employeeId,
    DateTime? flightDt,
    String? flightNumber,
    String? from,
    String? nationality,
    String? to,
    int? totalResult,
    int? timaticResult,
    int? airlineApproval,
    List<OutboxSupervisor>? supervisor,
  }) =>
      OutboxMessage(
        id: id ?? this.id,
        type: type ?? this.type,
        read: read ?? this.read,
        createdAt: createdAt ?? this.createdAt,
        user: user ?? this.user,
        showCode: showCode ?? this.showCode,
        status: status ?? this.status,
        airline: airline ?? this.airline,
        employeeId: employeeId ?? this.employeeId,
        flightDt: flightDt ?? this.flightDt,
        flightNumber: flightNumber ?? this.flightNumber,
        from: from ?? this.from,
        nationality: nationality ?? this.nationality,
        to: to ?? this.to,
        totalResult: totalResult ?? this.totalResult,
        timaticResult: timaticResult ?? this.timaticResult,
        airlineApproval: airlineApproval ?? this.airlineApproval,
        supervisor: supervisor ?? this.supervisor,
      );

  factory OutboxMessage.fromJson(Map<String, dynamic> json) => OutboxMessage(
    id: json["_id"],
    type: json["type"],
    read: json["read"],
    createdAt: DateTime.parse(json["createdAt"]),
    user: json["user"],
    showCode: json["showCode"].toString(),
    status: json["status"],
    airline: json["airline"]??'',
    employeeId: json["employeeId"],
    flightDt: DateTime.parse(json["flightDT"]),
    flightNumber: json["flightNumber"]??'',
    from: json["from"],
    nationality: json["nationality"]??'',
    to: json["to"],
    totalResult: json["totalResult"],
    timaticResult: json["timaticResult"],
    airlineApproval: json["airlineApproval"],
    supervisor: List<OutboxSupervisor>.from(json["supervisor"].map((x) => OutboxSupervisor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "read": read,
    "createdAt": createdAt.toIso8601String(),
    "user": user,
    "showCode": showCode,
    "status": status,
    "airline": airline,
    "employeeId": employeeId,
    "flightDT": flightDt.toIso8601String(),
    "flightNumber": flightNumber,
    "from": from,
    "nationality": nationality,
    "to": to,
    "totalResult": totalResult,
    "airlineApproval": airlineApproval,
    "timaticResult": timaticResult,
    "supervisor": List<dynamic>.from(supervisor.map((x) => x.toJson())),
  };

  bool validateSearch(String text) {
    if(text.isEmpty) return true;
    return "$showCode ${employeeId}".toLowerCase().contains(text.toLowerCase());
  }}

class OutboxSupervisor {
  final String id;
  final int action;
  final String name;

  OutboxSupervisor({
    required this.id,
    required this.action,
    required this.name,
  });

  OutboxSupervisor copyWith({
    String? id,
    int? action,
    String? name,
  }) =>
      OutboxSupervisor(
        id: id ?? this.id,
        action: action ?? this.action,
        name: name ?? this.name,
      );

  factory OutboxSupervisor.fromJson(Map<String, dynamic> json) => OutboxSupervisor(
    id: json["id"],
    action: json["action"],
    name: json["name"],
  );

  SupervisorResponse? get getRes => BasicClass.user?.setting?.supervisorResponse?.firstWhereOrNull((a)=>a.actionId == action);

  Map<String, dynamic> toJson() => {
    "id": id,
    "action": action,
    "name": name,
  };
}
