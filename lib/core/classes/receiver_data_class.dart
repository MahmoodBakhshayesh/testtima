class ReceiverData {
  final String url;
  final String token;
  final String yourId;

  ReceiverData({
    required this.url,
    required this.token,
    required this.yourId,
  });

  ReceiverData copyWith({
    String? url,
    String? token,
    String? yourId,
  }) =>
      ReceiverData(
        url: url ?? this.url,
        token: token ?? this.token,
        yourId: yourId ?? this.yourId,
      );

  factory ReceiverData.fromJson(Map<String, dynamic> json) => ReceiverData(
    url: json["url"],
    token: json["token"],
    yourId: json["yourId"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "token": token,
    "yourId": yourId,
  };
}
