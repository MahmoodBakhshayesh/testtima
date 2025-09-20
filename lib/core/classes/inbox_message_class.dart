class InboxMessage {
  final String? code;
  final DateTime? createdAt;
  final bool? read;
  final DateTime? flightDt;
  final String? from;
  final String? to;
  final User? user;
  final String? airline;
  final String? flightNumber;

  InboxMessage({
    this.code,
    this.createdAt,
    this.read,
    this.flightDt,
    this.from,
    this.to,
    this.user,
    this.airline,
    this.flightNumber,
  });

  InboxMessage copyWith({
    String? code,
    DateTime? createdAt,
    bool? read,
    DateTime? flightDt,
    String? from,
    String? to,
    User? user,
    String? airline,
    String? flightNumber,
  }) =>
      InboxMessage(
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
        read: read ?? this.read,
        flightDt: flightDt ?? this.flightDt,
        from: from ?? this.from,
        to: to ?? this.to,
        user: user ?? this.user,
        airline: airline ?? this.airline,
        flightNumber: flightNumber ?? this.flightNumber,
      );

  factory InboxMessage.fromJson(Map<String, dynamic> json) => InboxMessage(
    code: json["code"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    read: json["read"],
    flightDt: json["flightDT"] == null ? null : DateTime.parse(json["flightDT"]),
    from: json["from"],
    to: json["to"],
    user: json["user_"] == null ? null : User.fromJson(json["user_"]),
    airline: json["airline"],
    flightNumber: json["flightNumber"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "createdAt": createdAt?.toIso8601String(),
    "read": read,
    "flightDT": flightDt?.toIso8601String(),
    "from": from,
    "to": to,
    "user_": user?.toJson(),
    "airline": airline,
    "flightNumber": flightNumber,
  };
}

class User {
  final String? username;
  final String? email;

  User({
    this.username,
    this.email,
  });

  User copyWith({
    String? username,
    String? email,
  }) =>
      User(
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
  };
}