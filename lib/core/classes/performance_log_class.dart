class PerformanceLog {
  final DateTime? dateTime;
  final String? from;
  final String? to;
  final String? code;
  final String? result;

  PerformanceLog({this.dateTime, this.from, this.to, this.code, this.result});

  PerformanceLog copyWith({DateTime? dateTime, String? from, String? to, String? code, String? result}) =>
      PerformanceLog(dateTime: dateTime ?? this.dateTime, from: from ?? this.from, to: to ?? this.to, code: code ?? this.code, result: result ?? this.result);

  factory PerformanceLog.fromJson(Map<String, dynamic> json) =>
      PerformanceLog(dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]), from: json["from"], to: json["to"], code: json["code"], result: json["result"]);

  factory PerformanceLog.test() => PerformanceLog(dateTime: DateTime.now(), from: "CPH", to: "JPY", code: "2355", result: "ALLOWED");

  Map<String, dynamic> toJson() => {"dateTime": dateTime?.toIso8601String(), "from": from, "to": to, "code": code, "result": result};
}
