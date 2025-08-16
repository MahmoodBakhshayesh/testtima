class Server {
  final String id;
  final String title;
  final String apiAddress;
  final bool active;
  final bool serverDefault;

  Server({
    required this.id,
    required this.title,
    required this.apiAddress,
    required this.active,
    required this.serverDefault,
  });

  Server copyWith({
    String? id,
    String? title,
    String? apiAddress,
    bool? active,
    bool? serverDefault,
  }) =>
      Server(
        id: id ?? this.id,
        title: title ?? this.title,
        apiAddress: apiAddress ?? this.apiAddress,
        active: active ?? this.active,
        serverDefault: serverDefault ?? this.serverDefault,
      );

  factory Server.fromJson(Map<String, dynamic> json) => Server(
    id: json["_id"],
    title: json["title"],
    apiAddress: json["apiAddress"],
    active: json["active"],
    serverDefault: json["default"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "apiAddress": apiAddress,
    "active": active,
    "default": serverDefault,
  };
}