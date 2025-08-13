
import '../interfaces/response_int.dart';

class ResponseImplementation extends ResponseInterface {
  ResponseImplementation({required super.message, required super.body, required super.status});

  factory ResponseImplementation.fromJson(Map<String, dynamic> json) {
    // JsonValidator.initialCheckInFromJson(json, ["Status","Message"], "Response");
    return ResponseImplementation(
      status: json['Status'] ?? json["ResultCode"] ?? 5,
      message: json['Message'] ?? json["ResultText"] ?? "Done",
      body: json['Body'] ?? json["data"] ?? json["response"] ?? json["result"] ?? json,
    );
  }
}

class RawResponse {
  final int status;
  final String message;
  final dynamic body;

  RawResponse({required this.message, required this.body, required this.status});

  factory RawResponse.fromJson(Map<String, dynamic> json) {
    // JsonValidator.initialCheckInFromJson(json, ["Status","Message"], "Response");
    return RawResponse(
      status: int.tryParse((json['Status'] ?? json["ResultCode"] ?? 5).toString())??5,
      message: json['Message'] ?? json["ResultText"] ?? "Done",
      body: json['Body'] ?? json["data"] ?? json["response"] ?? json["result"] ?? json,
    );
  }
}
