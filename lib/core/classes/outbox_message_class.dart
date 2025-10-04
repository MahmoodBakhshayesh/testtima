// To parse this JSON data, do
//
//     final inboxMessage = inboxMessageFromJson(jsonString);

import 'dart:convert';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/utils_and_services/timatic/src/models/auth_response.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';

OutboxMessage inboxMessageFromJson(String str) => OutboxMessage.fromJson(json.decode(str));

String inboxMessageToJson(OutboxMessage data) => json.encode(data.toJson());

class OutboxMessage {
  final String? code;
  final DateTime? createdAt;
  final List<InboxSupervisor>? supervisor;
  final bool? read;
  final String? airline;
  final DateTime? flightDt;
  final String? flightNumber;
  final String? from;
  final String? to;
  final String? employeeId;
  final InboxMessageUser? user;

  OutboxMessage({
    this.code,
    this.createdAt,
    this.supervisor,
    this.read,
    this.airline,
    this.flightDt,
    this.flightNumber,
    this.from,
    this.to,
    this.user,
    this.employeeId,
  });

  OutboxMessage copyWith({
    String? code,
    DateTime? createdAt,
    List<InboxSupervisor>? supervisor,
    bool? read,
    String? airline,
    DateTime? flightDt,
    String? flightNumber,
    String? from,
    String? to,
    String? employeeId,
    InboxMessageUser? user,
  }) =>
      OutboxMessage(
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
        supervisor: supervisor ?? this.supervisor,
        read: read ?? this.read,
        airline: airline ?? this.airline,
        flightDt: flightDt ?? this.flightDt,
        flightNumber: flightNumber ?? this.flightNumber,
        from: from ?? this.from,
        to: to ?? this.to,
        employeeId: employeeId ?? this.employeeId,
        user: user ?? this.user,
      );

  factory OutboxMessage.fromJson(Map<String, dynamic> json) => OutboxMessage(
    code: json["code"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    supervisor: json["supervisor"] == null ? [] : List<InboxSupervisor>.from(json["supervisor"]!.map((x) => InboxSupervisor.fromJson(x))),
    read: json["read"],
    airline: json["airline"],
    flightDt: json["flightDT"] == null ? null : DateTime.parse(json["flightDT"]),
    flightNumber: json["flightNumber"],
    from: json["from"],
    to: json["to"],
    employeeId: json["employeeId"],
    user: json["user_"] == null ? null : InboxMessageUser.fromJson(json["user_"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "createdAt": createdAt?.toIso8601String(),
    "supervisor": supervisor == null ? [] : List<dynamic>.from(supervisor!.map((x) => x.toJson())),
    "read": read,
    "airline": airline,
    "flightDT": flightDt?.toIso8601String(),
    "flightNumber": flightNumber,
    "from": from,
    "to": to,
    "employeeId": employeeId,
    "user_": user?.toJson(),
  };
}

class InboxSupervisor {
  final InboxMessageUser? id;
  final int? action;

  InboxSupervisor({
    this.id,
    this.action,
  });

  InboxSupervisor copyWith({
    InboxMessageUser? id,
    int? action,
  }) =>
      InboxSupervisor(
        id: id ?? this.id,
        action: action ?? this.action,
      );

  factory InboxSupervisor.fromJson(Map<String, dynamic> json) => InboxSupervisor(
    id: json["id"] == null ? null : InboxMessageUser.fromJson(json["id"]),
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "id": id?.toJson(),
    "action": action,
  };

  SupervisorResponse? get getRes => BasicClass.user?.setting?.supervisorResponse?.firstWhereOrNull((a)=>a.actionId == action);
}

class InboxMessageUser {
  final String? username;
  final String? email;

  InboxMessageUser({
    this.username,
    this.email,
  });

  InboxMessageUser copyWith({
    String? username,
    dynamic email,
  }) =>
      InboxMessageUser(
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory InboxMessageUser.fromJson(Map<String, dynamic> json) => InboxMessageUser(
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
  };
}
