import 'package:abds/core/constants/ui.dart';
import 'package:flutter/material.dart';

class Server {
  final String id;
  final String title;
  final String apiAddress;
  final String? color;
  final String? name;
  final bool active;
  final bool serverDefault;

  Server({
    required this.id,
    required this.title,
    required this.apiAddress,
    required this.active,
    required this.serverDefault,
    required this.color,
    required this.name,
  });

  Server copyWith({
    String? id,
    String? title,
    String? apiAddress,
    String? color,
    String? name,
    bool? active,
    bool? serverDefault,
  }) =>
      Server(
        id: id ?? this.id,
        title: title ?? this.title,
        apiAddress: apiAddress ?? this.apiAddress,
        color: color ?? this.color,
        name: name ?? this.name,
        active: active ?? this.active,
        serverDefault: serverDefault ?? this.serverDefault,
      );

  factory Server.fromJson(Map<String, dynamic> json) => Server(
    id: json["_id"],
    title: json["title"],
    apiAddress: json["apiAddress"],
    color: json["color"],
    name: json["name"],
    active: json["active"],
    serverDefault: json["default"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "color": color,
    "apiAddress": apiAddress,
    "name": name,
    "active": active,
    "default": serverDefault,
  };

  Color get getColor => color == null?Colors.transparent:HexColor(color!);
}