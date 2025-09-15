// auth_response.dart

import 'dart:convert';
import 'dart:developer';

import '../../../../classes/people_class.dart';

class LoginEnvelope {
  final bool success;
  final int? errorCode;
  final String? message;
  final LoginData? data;

  const LoginEnvelope({
    required this.success,
    this.errorCode,
    this.message,
    this.data,
  });

  LoginEnvelope copyWith({
    bool? success,
    int? errorCode,
    String? message,
    LoginData? data,
  }) {
    return LoginEnvelope(
      success: success ?? this.success,
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory LoginEnvelope.fromJson(Map<String, dynamic> json) {
    return LoginEnvelope(
      success: json['success'] ?? false,
      errorCode: json['errorCode'],
      message: json['message'],
      data: json['data'] != null
          ? LoginData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'errorCode': errorCode,
    'message': message,
    'data': data?.toJson(),
  };
}

class LoginData {
  final dynamic versionCheck; // can be null or any type
  final Profile profile;
  final bool setPassword;
  final String token;
  final ConstData constData;
  final UserPermission permission;


  const LoginData({
    this.versionCheck,
    required this.profile,
    required this.setPassword,
    required this.token,
    required this.permission,
    required this.constData,
  });

  LoginData copyWith({
    dynamic versionCheck,
    Profile? profile,
    bool? setPassword,
    String? token,
    ConstData? constData,
    UserPermission? permission,

  }) {
    return LoginData(
      versionCheck: versionCheck ?? this.versionCheck,
      profile: profile ?? this.profile,
      setPassword: setPassword ?? this.setPassword,
      token: token ?? this.token,
      permission: permission ?? this.permission,

      constData: constData ?? this.constData,
    );
  }

  factory LoginData.fromJson(Map<String, dynamic> json) {
      Map<String,dynamic> fixedPermission = Map<String,dynamic>.from({});
      fixedPermission["allPermissions"] = json["constData"]["permission"];
      fixedPermission["permission"] = json["permission"];
      log("fixed permission \n${jsonEncode(fixedPermission)}");
    return LoginData(
      versionCheck: json['versionCheck'],
      profile: Profile.fromJson(json['profile'] ?? {}),
      setPassword: json['setPassword'] ?? false,
      token: json['token'] ?? '',
      permission: UserPermission.fromJson(fixedPermission),
      constData: ConstData.fromJson(json['constData'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'versionCheck': versionCheck,
    'profile': profile.toJson(),
    'setPassword': setPassword,
    'token': token,
    'constData': constData.toJson(),
    "permissions": permission

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

  const Profile({
    this.username,
    this.email,
    this.firstname,
    this.middlename,
    this.lastname,
    this.hasImage = false,
    this.gender,
    this.defaultAirport,
  });

  Profile copyWith({
    String? username,
    String? email,
    String? firstname,
    String? middlename,
    String? lastname,
    String? defaultAirport,
    bool? hasImage,
    int? gender,
  }) {
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
      hasImage: json['hasImage']??false,
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'firstname': firstname,
    'middlename': middlename,
    'defaultAirport': defaultAirport,
    'lastname': lastname,
    'hasImage': hasImage,
    'gender': gender,
  };
}

class ConstData {
  AllPermissions userPermissionAttributes;
  List<DocumentTypeMapper> documentTypeMappers;
  List<String> logNoteTypes;

  ConstData({
    required this.userPermissionAttributes,
    required this.documentTypeMappers,
    required this.logNoteTypes,
  });

  ConstData copyWith({
    AllPermissions? userPermissionAttributes,
    List<DocumentTypeMapper>? documentTypeMappers,
    List<String>? logNoteTypes,

  }) =>
      ConstData(
        userPermissionAttributes: userPermissionAttributes ?? this.userPermissionAttributes,
        documentTypeMappers: documentTypeMappers ?? this.documentTypeMappers,
        logNoteTypes: logNoteTypes ?? this.logNoteTypes,
      );

  factory ConstData.fromJson(Map<String, dynamic> json) => ConstData(
    userPermissionAttributes: AllPermissions.fromJson(json["permission"]),
    documentTypeMappers:List<DocumentTypeMapper>.from((json["documentDetailType"]??[]).map((a)=>DocumentTypeMapper.fromJson(a))),
    logNoteTypes:List<String>.from((json["logNoteType"]??[])),
  );

  Map<String, dynamic> toJson() => {
    "permission": userPermissionAttributes.toJson(),
    "documentDetailType": documentTypeMappers.map((a)=>a.toJson()).toList(),
    "logNoteTypes": logNoteTypes,
  };
}


class PermissionEntry {
  final int flag;
  final String value;

  const PermissionEntry({
    required this.flag,
    required this.value,
  });

  PermissionEntry copyWith({
    int? flag,
    String? value,
  }) {
    return PermissionEntry(
      flag: flag ?? this.flag,
      value: value ?? this.value,
    );
  }

  factory PermissionEntry.fromJson(Map<String, dynamic> json) {
    return PermissionEntry(
      flag: json['flag'] ?? 0,
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'flag': flag,
    'value': value,
  };
}

class DocumentTypeMapper {
  final String? type;
  final String? subType;
  final String? country;
  final String? code;
  final String? title;

  DocumentTypeMapper({
    this.type,
    this.subType,
    this.country,
    this.code,
    this.title,
  });

  DocumentTypeMapper copyWith({
    String? type,
    String? subType,
    String? country,
    String? code,
    String? title,
  }) =>
      DocumentTypeMapper(
        type: type ?? this.type,
        subType: subType ?? this.subType,
        country: country ?? this.country,
        code: code ?? this.code,
        title: title ?? this.title,
      );

  factory DocumentTypeMapper.fromJson(Map<String, dynamic> json) => DocumentTypeMapper(
    type: json["type"],
    subType: json["subType"],
    country: json["country"],
    code: json["code"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "subType": subType,
    "country": country,
    "code": code,
    "title": title,
  };
}
