// To parse this JSON data, do
//
//     final refHistory = refHistoryFromJson(jsonString);

import 'dart:convert';

RefHistory refHistoryFromJson(String str) => RefHistory.fromJson(json.decode(str));

String refHistoryToJson(RefHistory data) => json.encode(data.toJson());

class RefHistory {
  final String? refCode;
  final String? showCode;
  final List<RefHistoryLog>? logs;

  RefHistory({
    this.logs,
    this.refCode,
    this.showCode,
  });

  RefHistory copyWith({
    List<RefHistoryLog>? logs,
   String? refCode,
    String? showCode,
  }) =>
      RefHistory(
        logs: logs ?? this.logs,
        refCode: refCode ?? this.refCode,
        showCode: showCode ?? this.showCode,
      );

  factory RefHistory.fromJson(Map<String, dynamic> json) => RefHistory(
    logs: json["logs"] == null ? [] : List<RefHistoryLog>.from(json["logs"]!.map((x) => RefHistoryLog.fromJson(x))),
    refCode: json["refCode"].toString(),
    showCode: json["showCode"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "logs": logs == null ? [] : List<dynamic>.from(logs!.map((x) => x.toJson())),
    "refCode": refCode,
    "showCode":showCode
  };
}

class RefHistoryLog {
  final RefHistoryUser? user;
  final String? type;
  final String? id;
  final DateTime? at;
  final Payload? payload;

  RefHistoryLog({
    this.user,
    this.type,
    this.at,
    required this.id,
    this.payload,
  });

  RefHistoryLog copyWith({
    RefHistoryUser? user,
    String? type,
    String? id,
    DateTime? at,
    Payload? payload,
  }) =>
      RefHistoryLog(
        user: user ?? this.user,
        type: type ?? this.type,
        at: at ?? this.at,
        id: id ?? this.id,
        payload: payload ?? this.payload,
      );

  factory RefHistoryLog.fromJson(Map<String, dynamic> json) => RefHistoryLog(
    user: json["user_"] == null ? null : RefHistoryUser.fromJson(json["user_"]),
    type: json["type"],
    id: json["_id"],
    at: json["at"] == null ? null : DateTime.parse(json["at"]),
    payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "user_": user?.toJson(),
    "type": type,
    "_id": id,
    "at": at?.toIso8601String(),
    "payload": payload?.toJson(),
  };
}

class Payload {
  final String? url;
  final String? input;
  final String? askId;
  final String? output;
  final bool? result;
  final bool? cache;
  final bool? approved;
  final int? locked;
  final int? status;
  final int? actionId;
  final String? title;
  final String? description;
  final String? airline;
  final String? message;
  final String? flightNumber;
  final String? supervisorId;
  final String? action;
  final String? comment;
  final String? name;
  final List<String>? attachFiles;

  Payload({
    this.url,
    this.input,
    this.askId,
    this.output,
    this.status,
    this.result,
    this.actionId,
    this.cache,
    this.locked,
    this.title,
    this.approved,
    this.description,
    this.attachFiles,
    this.airline,
    this.message,
    this.comment,
    this.flightNumber,
    this.supervisorId,
    this.name,
    this.action,
  });

  Payload copyWith({
    String? url,
    String? input,
    String? output,
    String? askId,
    bool? result,
    bool? cache,
    int? locked,
    bool? approved,
    int? status,
    int? actionId,
    String? title,
    String? description,
    String? airline,
    String? message,
    String? flightNumber,
    String? supervisorId,
    String? action,
    String? comment,
    String? name,
    List<String>? attachFiles,
  }) =>
      Payload(
        url: url ?? this.url,
        input: input ?? this.input,
        output: output ?? this.output,
        askId: askId ?? this.askId,
        result: result ?? this.result,
        cache: cache ?? this.cache,
        locked: locked ?? this.locked,
        status: status ?? this.status,
        actionId: actionId ?? this.actionId,
        approved: approved ?? this.approved,
        title: title ?? this.title,
        description: description ?? this.description,
        attachFiles: attachFiles ?? this.attachFiles,
        airline: airline ?? this.airline,
        message: message ?? this.message,
        flightNumber: flightNumber ?? this.flightNumber,
        supervisorId: supervisorId ?? this.supervisorId,
        comment: comment ?? this.comment,
        name: name ?? this.name,
        action: action ?? this.action,
      );

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    url: json["url"],
    input: json["input"],
    askId: json["askId"],
    output: json["output"],
    result: json["result"],
    cache: json["cache"],
    locked: json["lock"],
    status: json["status"],
    actionId: json["actionId"],
    approved: json["approved"],
    title: json["title"],
    description: json["description"],
    airline: json["airline"],
    message: json["message"],
    flightNumber: json["flightNumber"],
    supervisorId: json["supervisorId"],
    action: json["action"],
    comment: json["comment"],
    name: json["name"],
    attachFiles: json["attachFiles"] == null ? [] :(json["attachFiles"] is String)?[json["attachFiles"]]: List<String>.from(json["attachFiles"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "input": input,
    "output": output,
    "askId": askId,
    "result": result,
    "status": status,
    "cache": cache,
    "lock": locked,
    "approved": approved,
    "title": title,
    "description": description,
    "airline": airline,
    "message": message,
    "flightNumber": flightNumber,
    "supervisorId": supervisorId,
    "action": action,
    "comment": comment,
    "name": name,
    "attachFiles": attachFiles == null ? [] : List<dynamic>.from(attachFiles!.map((x) => x)),
  };
}

class RefHistoryUser {
  final String? username;
  final String? email;

  RefHistoryUser({
    this.username,
    this.email,
  });

  RefHistoryUser copyWith({
    String? username,
    String? email,
  }) =>
      RefHistoryUser(
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory RefHistoryUser.fromJson(Map<String, dynamic> json) => RefHistoryUser(
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
  };
}
