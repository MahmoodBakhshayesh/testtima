import 'package:get/get.dart';

class TimaticLog {
  final String? id;
  final String? inputUrl;
  final String? inputData;
  final String? outputData;
  final bool result;
  final bool? cache;
  final DateTime? createdAt;
  final String? username;

  TimaticLog({
    this.id,
    this.inputUrl,
    this.inputData,
    this.outputData,
    this.result = false,
    this.cache,
    this.createdAt,
    this.username,
  });

  factory TimaticLog.fromJson(Map<String, dynamic> json) => TimaticLog(
    id: json["_id"],
    inputUrl: json["inputUrl"],
    inputData: json["inputData"],
    outputData: json["outputData"],
    result: json["result"]??false,
    cache: json["cache"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    username: json["username"],
  );

  String? get title => inputUrl?.split("/?").first.split("/").last;

  Map<String, dynamic> toJson() => {
    "_id": id,
    "inputUrl": inputUrl,
    "inputData": inputData,
    "outputData": outputData,
    "result": result,
    "cache": cache,
    "createdAt": createdAt?.toIso8601String(),
    "username": username,
  };
}