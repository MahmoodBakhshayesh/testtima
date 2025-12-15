
class SenderData {
  final bool success;
  final int errorCode;
  final String message;
  final Response response;

  SenderData({
    required this.success,
    required this.errorCode,
    required this.message,
    required this.response,
  });

  SenderData copyWith({
    bool? success,
    int? errorCode,
    String? message,
    Response? response,
  }) =>
      SenderData(
        success: success ?? this.success,
        errorCode: errorCode ?? this.errorCode,
        message: message ?? this.message,
        response: response ?? this.response,
      );

  factory SenderData.fromJson(Map<String, dynamic> json) => SenderData(
    success: json["success"],
    errorCode: json["errorCode"],
    message: json["message"],
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "errorCode": errorCode,
    "message": message,
    "response": response.toJson(),
  };
}

class Response {
  final Sender sender;

  Response({
    required this.sender,
  });

  Response copyWith({
    Sender? sender,
  }) =>
      Response(
        sender: sender ?? this.sender,
      );

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    sender: Sender.fromJson(json["sender"]),
  );

  Map<String, dynamic> toJson() => {
    "sender": sender.toJson(),
  };
}

class Sender {
  final String id;
  final String username;
  final String? email;
  final String firstname;
  final String middlename;
  final String lastname;

  Sender({
    required this.id,
    required this.username,
    required this.email,
    required this.firstname,
    required this.middlename,
    required this.lastname,
  });

  Sender copyWith({
    String? id,
    String? username,
    String? email,
    String? firstname,
    String? middlename,
    String? lastname,
  }) =>
      Sender(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        firstname: firstname ?? this.firstname,
        middlename: middlename ?? this.middlename,
        lastname: lastname ?? this.lastname,
      );

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    firstname: json["firstname"],
    middlename: json["middlename"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "firstname": firstname,
    "middlename": middlename,
    "lastname": lastname,
  };
}
