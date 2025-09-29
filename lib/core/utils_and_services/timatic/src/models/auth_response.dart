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
  final UserAttribute attributes;
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
    UserAttribute? attributes,
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
      attributes: UserAttribute.fromJson(json['attribute'] ?? {}),
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
    'attribute': attributes.toJson(),
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
  final String? username;
  final String? email;
  final String? firstname;
  final String? middlename;
  final String? lastname;
  final String? defaultAirport;
  final bool hasImage;
  final int? gender;

  const Profile({this.username, this.email, this.firstname, this.middlename, this.lastname, this.hasImage = false, this.gender, this.defaultAirport});

  Profile copyWith({String? username, String? email, String? firstname, String? middlename, String? lastname, String? defaultAirport, bool? hasImage, int? gender}) {
    return Profile(
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

  Map<String, dynamic> toJson() => {'username': username, 'email': email, 'firstname': firstname, 'middlename': middlename, 'defaultAirport': defaultAirport, 'lastname': lastname, 'hasImage': hasImage, 'gender': gender};
}

class UserAttribute {
  final String? region;
  final String? defaultAirport;
  final String? type;
  final String? defaultLanguage;
  final bool? rtlLanguage;

  UserAttribute({this.region, this.defaultAirport, this.type, this.defaultLanguage, this.rtlLanguage});

  UserAttribute copyWith({String? region, String? defaultAirport, String? type, String? defaultLanguage, bool? rtlLanguage}) => UserAttribute(
    region: region ?? this.region,
    defaultAirport: defaultAirport ?? this.defaultAirport,
    type: type ?? this.type,
    defaultLanguage: defaultLanguage ?? this.defaultLanguage,
    rtlLanguage: rtlLanguage ?? this.rtlLanguage,
  );

  factory UserAttribute.fromJson(Map<String, dynamic> json) =>
      UserAttribute(region: json["region"], defaultAirport: json["defaultAirport"], type: json["type"], defaultLanguage: json["defaultLanguage"], rtlLanguage: json["rtlLanguage"]);

  Map<String, dynamic> toJson() => {"region": region, "defaultAirport": defaultAirport, "type": type, "defaultLanguage": defaultLanguage, "rtlLanguage": rtlLanguage};
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

  Setting({this.refreshInboxTimer, this.supervisorResponse});

  Setting copyWith({int? refreshInboxTimer, List<SupervisorResponse>? supervisorResponse}) =>
      Setting(refreshInboxTimer: refreshInboxTimer ?? this.refreshInboxTimer, supervisorResponse: supervisorResponse ?? this.supervisorResponse);

  factory Setting.fromJson(Map<String, dynamic> json) =>
      Setting(refreshInboxTimer: json["refreshInboxTimer"], supervisorResponse: json["supervisorResponse"] == null ? [] : List<SupervisorResponse>.from(json["supervisorResponse"]!.map((x) => SupervisorResponse.fromJson(x))));

  Map<String, dynamic> toJson() => {"refreshInboxTimer": refreshInboxTimer, "supervisorResponse": supervisorResponse == null ? [] : List<dynamic>.from(supervisorResponse!.map((x) => x.toJson()))};
}

class SupervisorResponse {
  final int? actionId;
  final String? name;
  final List<String>? message;

  SupervisorResponse({this.actionId, this.name, this.message});

  SupervisorResponse copyWith({int? actionId, String? name, List<String>? message}) => SupervisorResponse(actionId: actionId ?? this.actionId, name: name ?? this.name, message: message ?? this.message);

  factory SupervisorResponse.fromJson(Map<String, dynamic> json) => SupervisorResponse(actionId: json["actionId"], name: json["name"], message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)));

  Color get getColor => [Color(0xff08AB7D),Color(0xffFF3F42),Color(0xff2D2D2D)][(actionId??1)-1];
  IconData get getIcon=> [ArtemisIcons.tick_square,ArtemisIcons.close_square,ArtemisIcons.warning_2][(actionId??1)-1];

  Map<String, dynamic> toJson() => {"actionId": actionId, "name": name, "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x))};
}

// class ConstData {
//   AllPermissions userPermissionAttributes;
//   List<DocumentTypeDetailsMapper> documentTypeDetailsMappers;
//   List<DocumentTypeMapper> documentTypes;
//   List<String> logNoteTypes;
//   List<String> textMessage;
//
//   ConstData({required this.userPermissionAttributes, required this.documentTypeDetailsMappers, required this.logNoteTypes, required this.documentTypes, required this.textMessage});
//
//   ConstData copyWith({AllPermissions? userPermissionAttributes, List<DocumentTypeDetailsMapper>? documentTypeDetailsMappers, List<DocumentTypeMapper>? documentTypes, List<String>? logNoteTypes, List<String>? textMessage}) =>
//       ConstData(
//         userPermissionAttributes: userPermissionAttributes ?? this.userPermissionAttributes,
//         documentTypeDetailsMappers: documentTypeDetailsMappers ?? this.documentTypeDetailsMappers,
//         documentTypes: documentTypes ?? this.documentTypes,
//         logNoteTypes: logNoteTypes ?? this.logNoteTypes,
//         textMessage: textMessage ?? this.textMessage,
//       );
//
//   factory ConstData.fromJson(Map<String, dynamic> json) => ConstData(
//     userPermissionAttributes: AllPermissions.fromJson(json["permission"]),
//     documentTypeDetailsMappers: List<DocumentTypeDetailsMapper>.from((json["documentDetailType"] ?? []).map((a) => DocumentTypeDetailsMapper.fromJson(a))),
//     documentTypes: List<DocumentTypeMapper>.from((json["documentType"] ?? []).map((a) => DocumentTypeMapper.fromJson(a))),
//     logNoteTypes: List<String>.from((json["logNoteType"] ?? [])),
//     textMessage: List<String>.from((json["textMessage"] ?? [])),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "permission": userPermissionAttributes.toJson(),
//     "documentDetailType": documentTypeDetailsMappers.map((a) => a.toJson()).toList(),
//     "documentType": documentTypes.map((a) => a.toJson()).toList(),
//     "logNoteTypes": logNoteTypes,
//     "textMessage": textMessage,
//   };
// }
//
// class PermissionEntry {
//   final int flag;
//   final String value;
//
//   const PermissionEntry({required this.flag, required this.value});
//
//   PermissionEntry copyWith({int? flag, String? value}) {
//     return PermissionEntry(flag: flag ?? this.flag, value: value ?? this.value);
//   }
//
//   factory PermissionEntry.fromJson(Map<String, dynamic> json) {
//     return PermissionEntry(flag: json['flag'] ?? 0, value: json['value'] ?? '');
//   }
//
//   Map<String, dynamic> toJson() => {'flag': flag, 'value': value};
// }
//
// class DocumentTypeDetailsMapper {
//   final String? type;
//   final String? subType;
//   final String? country;
//   final String? code;
//   final String? title;
//   final String? note;
//
//   DocumentTypeDetailsMapper({this.type, this.subType, this.country, this.code, this.title, this.note});
//
//   DocumentTypeDetailsMapper copyWith({String? type, String? subType, String? country, String? code, String? title, String? note}) =>
//       DocumentTypeDetailsMapper(type: type ?? this.type, subType: subType ?? this.subType, country: country ?? this.country, code: code ?? this.code, title: title ?? this.title, note: note ?? this.note);
//
//   factory DocumentTypeDetailsMapper.fromJson(Map<String, dynamic> json) =>
//       DocumentTypeDetailsMapper(type: json["type"], subType: json["subType"], country: json["country"], code: json["code"], title: json["title"], note: json["note"]);
//
//   Map<String, dynamic> toJson() => {"type": type, "subType": subType, "country": country, "code": code, "title": title, "note": note};
// }
//
// class DocumentTypeMapper {
//   final String? type;
//   final String? color;
//   final String? code;
//   final String? title;
//
//   DocumentTypeMapper({this.type, this.color, this.code, this.title});
//
//   DocumentTypeMapper copyWith({String? type, String? color, String? code, String? title}) => DocumentTypeMapper(type: type ?? this.type, color: color ?? this.color, code: code ?? this.code, title: title ?? this.title);
//
//   factory DocumentTypeMapper.fromJson(Map<String, dynamic> json) => DocumentTypeMapper(type: json["type"], color: json["color"], code: json["code"], title: json["title"]);
//
//   Color get getColor => HexColor(color!);
//
//   Map<String, dynamic> toJson() => {"type": type, "color": color, "code": code, "title": title};
// }
//
// class Attributes {
//   final String? region;
//   final String? type;
//   final String? defaultAirport;
//   final String? defaultLanguage;
//   final bool? rtlLanguage;
//
//   Attributes({this.region, this.type, this.defaultAirport, this.defaultLanguage, this.rtlLanguage});
//
//   // CopyWith
//   Attributes copyWith({String? region, String? type, String? defaultAirport, String? defaultLanguage, bool? rtlLanguage}) {
//     return Attributes(
//       region: region ?? this.region,
//       type: type ?? this.type,
//       defaultAirport: defaultAirport ?? this.defaultAirport,
//       defaultLanguage: defaultLanguage ?? this.defaultLanguage,
//       rtlLanguage: rtlLanguage ?? this.rtlLanguage,
//     );
//   }
//
//   // From JSON
//   factory Attributes.fromJson(Map<String, dynamic> json) {
//     return Attributes(
//       region: json['region'] as String?,
//       type: json['type'] as String?,
//       defaultAirport: json['defaultAirport'] as String?,
//       defaultLanguage: json['defaultLanguage'] as String?,
//       rtlLanguage: json['rtlLanguage'] as bool?,
//     );
//   }
//
//   // To JSON
//   Map<String, dynamic> toJson() {
//     return {'region': region, 'type': type, 'defaultAirport': defaultAirport, 'defaultLanguage': defaultLanguage, 'rtlLanguage': rtlLanguage};
//   }
// }
