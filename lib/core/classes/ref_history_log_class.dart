// To parse this JSON data, do
//
//     final refHistory = refHistoryFromJson(jsonString);

import 'dart:convert';

RefHistory refHistoryFromJson(String str) => RefHistory.fromJson(json.decode(str));

String refHistoryToJson(RefHistory data) => json.encode(data.toJson());

class RefHistory {
  final List<RefHistoryLog>? logs;

  RefHistory({
    this.logs,
  });

  RefHistory copyWith({
    List<RefHistoryLog>? logs,
  }) =>
      RefHistory(
        logs: logs ?? this.logs,
      );

  factory RefHistory.fromJson(Map<String, dynamic> json) => RefHistory(
    logs: json["logs"] == null ? [] : List<RefHistoryLog>.from(json["logs"]!.map((x) => RefHistoryLog.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "logs": logs == null ? [] : List<dynamic>.from(logs!.map((x) => x.toJson())),
  };
}

class RefHistoryLog {
  final RefHistoryUser? user;
  final String? type;
  final DateTime? at;
  final Payload? payload;

  RefHistoryLog({
    this.user,
    this.type,
    this.at,
    this.payload,
  });

  RefHistoryLog copyWith({
    RefHistoryUser? user,
    String? type,
    DateTime? at,
    Payload? payload,
  }) =>
      RefHistoryLog(
        user: user ?? this.user,
        type: type ?? this.type,
        at: at ?? this.at,
        payload: payload ?? this.payload,
      );

  factory RefHistoryLog.fromJson(Map<String, dynamic> json) => RefHistoryLog(
    user: json["user_"] == null ? null : RefHistoryUser.fromJson(json["user_"]),
    type: json["type"],
    at: json["at"] == null ? null : DateTime.parse(json["at"]),
    payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "user_": user?.toJson(),
    "type": type,
    "at": at?.toIso8601String(),
    "payload": payload?.toJson(),
  };
}

class Payload {
  final String? url;
  final String? input;
  final String? output;
  final bool? result;
  final bool? cache;
  final bool? approved;
  final int? status;
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
    this.output,
    this.status,
    this.result,
    this.cache,
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
    bool? result,
    bool? cache,
    bool? approved,
    int? status,
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
        result: result ?? this.result,
        cache: cache ?? this.cache,
        status: status ?? this.status,
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
    output: json["output"],
    result: json["result"],
    cache: json["cache"],
    status: json["status"],
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
    attachFiles: json["attachFiles"] == null ? [] : List<String>.from(json["attachFiles"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "input": input,
    "output": output,
    "result": result,
    "status": status,
    "cache": cache,
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
