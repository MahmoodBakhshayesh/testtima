// auth_response.dart

import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:abds/core/constants/ui.dart';
import 'package:flutter/cupertino.dart';

import '../../../../classes/constant_data_class.dart';
import '../../../../classes/people_class.dart';
import '../../../../classes/user_permission_class.dart';
import '../../../artemis_icons_icons.dart';

class LoginEnvelope {
  final bool success;
  final int? errorCode;
  final String? message;
  final LoginData? data;

  const LoginEnvelope({required this.success, this.errorCode, this.message, this.data});

  LoginEnvelope copyWith({bool? success, int? errorCode, String? message, LoginData? data}) {
    return LoginEnvelope(success: success ?? this.success, errorCode: errorCode ?? this.errorCode, message: message ?? this.message, data: data ?? this.data);
  }

  factory LoginEnvelope.fromJson(Map<String, dynamic> json) {
    return LoginEnvelope(success: json['success'] ?? false, errorCode: json['errorCode'], message: json['message'], data: json['data'] != null ? LoginData.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() => {'success': success, 'errorCode': errorCode, 'message': message, 'data': data?.toJson()};
}

class LoginData {
  final dynamic versionCheck; // can be null or any type
  final Profile profile;
  final Map<String,dynamic> attributes;
  final bool setPassword;
  final String token;
  final String constDataVersion;
  final Device? device;
  final Setting? setting;
  // final ConstData constData;
  final UserPermission permission;

  const LoginData({
    this.versionCheck,
    required this.profile,
    required this.attributes,
    required this.setPassword,
    required this.token,
    required this.constDataVersion,
    required this.permission,
    this.device,
    this.setting,
    // required this.constData,
  });

  LoginData copyWith({
    dynamic versionCheck,
    Profile? profile,
    Map<String,dynamic>? attributes,
    bool? setPassword,
    String? token,
    String? constDataVersion,
    // ConstData? constData,
    UserPermission? permission,
    Device? device,
    Setting? setting,
  }) {
    return LoginData(
      versionCheck: versionCheck ?? this.versionCheck,
      profile: profile ?? this.profile,
      attributes: attributes ?? this.attributes,
      setPassword: setPassword ?? this.setPassword,
      token: token ?? this.token,
      constDataVersion: constDataVersion ?? this.constDataVersion,
      permission: permission ?? this.permission,
      device: device ?? this.device,
      setting: setting ?? this.setting,

      // constData: constData ?? this.constData,
    );
  }

  factory LoginData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> fixedPermission = Map<String, dynamic>.from({});
    // fixedPermission["allPermissions"] = json["constData"]["permission"];
    fixedPermission["permission"] = json["permission"];
    // log("fixed permission \n${jsonEncode(fixedPermission)}");
    return LoginData(
      versionCheck: json['versionCheck'],
      profile: Profile.fromJson(json['profile'] ?? {}),
      attributes: json['attributes'] ?? {},
      setPassword: json['setPassword'] ?? false,
      token: json['token'] ?? '',
      constDataVersion: json['constDataVersion'] ?? '',
      permission: UserPermission.fromRootJson(fixedPermission),
      device: json["device"] == null ? null : Device.fromJson(json["device"]),
      setting: json["setting"] == null ? null : Setting.fromJson(json["setting"]),
      // constData: ConstData.fromJson(json['constData'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'versionCheck': versionCheck,
    'profile': profile.toJson(),
    'attributes': attributes,
    'setPassword': setPassword,
    'token': token,
    'constDataVersion': constDataVersion,
    // 'constData': constData.toJson(),
    "permissions": permission,
    "device": device?.toJson(),
    "setting": setting?.toJson(),
  };
}

class Profile {
  final String? id;
  final String? username;
  final String? email;
  final String? firstname;
  final String? middlename;
  final String? lastname;
  final String? defaultAirport;
  final bool hasImage;
  final int? gender;

  const Profile({this.id, this.username, this.email, this.firstname, this.middlename, this.lastname, this.hasImage = false, this.gender, this.defaultAirport});

  Profile copyWith({String? username, String? email, String? firstname, String? middlename, String? lastname, String? defaultAirport, bool? hasImage, int? gender}) {
    return Profile(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      defaultAirport: defaultAirport ?? this.defaultAirport,
      middlename: middlename ?? this.middlename,
      lastname: lastname ?? this.lastname,
      hasImage: hasImage ?? this.hasImage,
      gender: gender ?? this.gender,
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      firstname: json['firstname'],
      middlename: json['middlename'],
      lastname: json['lastname'],
      defaultAirport: json['defaultAirport'],
      hasImage: json['hasImage'] ?? false,
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id":id,
    'username': username, 'email': email, 'firstname': firstname, 'middlename': middlename, 'defaultAirport': defaultAirport, 'lastname': lastname, 'hasImage': hasImage, 'gender': gender};
}


class Device {
  final bool? multiuser;

  Device({this.multiuser});

  Device copyWith({bool? multiuser}) => Device(multiuser: multiuser ?? this.multiuser);

  factory Device.fromJson(Map<String, dynamic> json) => Device(multiuser: json["multiuser"]);

  Map<String, dynamic> toJson() => {"multiuser": multiuser};
}

class Setting {
  final int? refreshInboxTimer;
  final List<SupervisorResponse>? supervisorResponse;
  final Map<String,dynamic> more;

  Setting({this.refreshInboxTimer, this.supervisorResponse,this.more = const{}});

  Setting copyWith({int? refreshInboxTimer, List<SupervisorResponse>? supervisorResponse}) =>
      Setting(refreshInboxTimer: refreshInboxTimer ?? this.refreshInboxTimer, supervisorResponse: supervisorResponse ?? this.supervisorResponse);

  factory Setting.fromJson(Map<String, dynamic> json) =>
      Setting(
          more: json,
          refreshInboxTimer: json["refreshInboxTimer"], supervisorResponse: json["supervisorResponse"] == null ? [] : List<SupervisorResponse>.from(json["supervisorResponse"]!.map((x) => SupervisorResponse.fromJson(x))));

  Map<String, dynamic> toJson() => more;

}

class SupervisorResponse {
  final int? actionId;
  final String? name;
  final String? name2;
  final bool textEntry;
  final List<String>? message;

  SupervisorResponse({this.actionId, this.name, this.name2, this.message,this.textEntry = false});

  SupervisorResponse copyWith({int? actionId, String? name,  String? name2, List<String>? message}) => SupervisorResponse(actionId: actionId ?? this.actionId, name: name ?? this.name, name2: name2 ?? this.name2, message: message ?? this.message);

  factory SupervisorResponse.fromJson(Map<String, dynamic> json) => SupervisorResponse(actionId: json["actionId"], textEntry: json["textEntry"]??false, name: json["name"], name2: json["name2"], message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)));

  Color get getColor => [Color(0xff08AB7D),Color(0xffFF3F42),Color(0xff2D2D2D),Color(0xff2D2D2D),Color(0xff2D2D2D)][actionId!-1];
  IconData get getIcon=> [ArtemisIcons.tick_square,ArtemisIcons.close_square,ArtemisIcons.warning_2,ArtemisIcons.warning_2,ArtemisIcons.warning_2][actionId!-1];

  Map<String, dynamic> toJson() => {"actionId": actionId, "name": name, "name2": name2, "textEntry": textEntry, "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x))};
}

