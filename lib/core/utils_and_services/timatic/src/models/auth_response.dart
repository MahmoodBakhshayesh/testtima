// auth_response.dart

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
  final List<UserPermission> permissions;


  const LoginData({
    this.versionCheck,
    required this.profile,
    required this.setPassword,
    required this.token,
    required this.permissions,
    required this.constData,
  });

  LoginData copyWith({
    dynamic versionCheck,
    Profile? profile,
    bool? setPassword,
    String? token,
    ConstData? constData,
    List<UserPermission>? permissions,

  }) {
    return LoginData(
      versionCheck: versionCheck ?? this.versionCheck,
      profile: profile ?? this.profile,
      setPassword: setPassword ?? this.setPassword,
      token: token ?? this.token,
      permissions: permissions ?? this.permissions,

      constData: constData ?? this.constData,
    );
  }

  factory LoginData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> fixedPermissions = json["permissions"]??[];
    for(var fp in fixedPermissions){
      Map<String,dynamic> fixedPermission = Map<String,dynamic>.from(fp);
      fixedPermission["allPermissions"] = json["constData"]["permission"];
      fp["allPermissions"] = json["constData"]["permission"];
      fixedPermission.forEach((k,v){
        if(v is List<dynamic>){
          for (var a in v) {
            a["allPermissions"] = json["constData"]["permission"];
          }
        }
      });
    }
    return LoginData(
      versionCheck: json['versionCheck'],
      profile: Profile.fromJson(json['profile'] ?? {}),
      setPassword: json['setPassword'] ?? false,
      token: json['token'] ?? '',
      permissions: List<UserPermission>.from((fixedPermissions).map((a)=>UserPermission.fromJson(a))),
      constData: ConstData.fromJson(json['constData'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'versionCheck': versionCheck,
    'profile': profile.toJson(),
    'setPassword': setPassword,
    'token': token,
    'constData': constData.toJson(),
    "permissions": permissions.map((a)=>a.toJson()).toList(),

  };
}

class Profile {
  final String? username;
  final String? email;
  final String? firstname;
  final String? middlename;
  final String? lastname;
  final bool? hasImage;
  final int? gender;

  const Profile({
    this.username,
    this.email,
    this.firstname,
    this.middlename,
    this.lastname,
    this.hasImage,
    this.gender,
  });

  Profile copyWith({
    String? username,
    String? email,
    String? firstname,
    String? middlename,
    String? lastname,
    bool? hasImage,
    int? gender,
  }) {
    return Profile(
      username: username ?? this.username,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
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
      hasImage: json['hasImage'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'firstname': firstname,
    'middlename': middlename,
    'lastname': lastname,
    'hasImage': hasImage,
    'gender': gender,
  };
}

class ConstData {
  AllPermissions userPermissionAttributes;


  ConstData({
    required this.userPermissionAttributes,
  });

  ConstData copyWith({
    AllPermissions? userPermissionAttributes,

  }) =>
      ConstData(
        userPermissionAttributes: userPermissionAttributes ?? this.userPermissionAttributes,
      );

  factory ConstData.fromJson(Map<String, dynamic> json) => ConstData(
    userPermissionAttributes: AllPermissions.fromJson(json["permission"]),
  );

  Map<String, dynamic> toJson() => {
    "permission": userPermissionAttributes.toJson(),
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
