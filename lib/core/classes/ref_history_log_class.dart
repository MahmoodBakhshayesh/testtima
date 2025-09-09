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
  final String? title;
  final String? description;
  final List<String>? attachFiles;

  Payload({
    this.url,
    this.input,
    this.output,
    this.result,
    this.cache,
    this.title,
    this.description,
    this.attachFiles,
  });

  Payload copyWith({
    String? url,
    String? input,
    String? output,
    bool? result,
    bool? cache,
    String? title,
    String? description,
    List<String>? attachFiles,
  }) =>
      Payload(
        url: url ?? this.url,
        input: input ?? this.input,
        output: output ?? this.output,
        result: result ?? this.result,
        cache: cache ?? this.cache,
        title: title ?? this.title,
        description: description ?? this.description,
        attachFiles: attachFiles ?? this.attachFiles,
      );

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    url: json["url"],
    input: json["input"],
    output: json["output"],
    result: json["result"],
    cache: json["cache"],
    title: json["title"],
    description: json["description"],
    attachFiles: json["attachFiles"] == null ? [] : List<String>.from(json["attachFiles"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "input": input,
    "output": output,
    "result": result,
    "cache": cache,
    "title": title,
    "description": description,
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
