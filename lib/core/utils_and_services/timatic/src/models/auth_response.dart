// auth_response.dart

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

  const LoginData({
    this.versionCheck,
    required this.profile,
    required this.setPassword,
    required this.token,
    required this.constData,
  });

  LoginData copyWith({
    dynamic versionCheck,
    Profile? profile,
    bool? setPassword,
    String? token,
    ConstData? constData,
  }) {
    return LoginData(
      versionCheck: versionCheck ?? this.versionCheck,
      profile: profile ?? this.profile,
      setPassword: setPassword ?? this.setPassword,
      token: token ?? this.token,
      constData: constData ?? this.constData,
    );
  }

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      versionCheck: json['versionCheck'],
      profile: Profile.fromJson(json['profile'] ?? {}),
      setPassword: json['setPassword'] ?? false,
      token: json['token'] ?? '',
      constData: ConstData.fromJson(json['constData'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'versionCheck': versionCheck,
    'profile': profile.toJson(),
    'setPassword': setPassword,
    'token': token,
    'constData': constData.toJson(),
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
  final Map<String, List<PermissionEntry>> permission;

  const ConstData({required this.permission});

  ConstData copyWith({
    Map<String, List<PermissionEntry>>? permission,
  }) {
    return ConstData(
      permission: permission ?? this.permission,
    );
  }

  factory ConstData.fromJson(Map<String, dynamic> json) {
    final permMap = <String, List<PermissionEntry>>{};
    if (json['permission'] is Map) {
      (json['permission'] as Map).forEach((key, value) {
        if (value is List) {
          permMap[key.toString()] = value
              .whereType<Map<String, dynamic>>()
              .map((e) => PermissionEntry.fromJson(e))
              .toList();
        }
      });
    }
    return ConstData(permission: permMap);
  }

  Map<String, dynamic> toJson() {
    return {
      'permission': permission.map(
            (key, list) => MapEntry(
          key,
          list.map((e) => e.toJson()).toList(),
        ),
      ),
    };
  }
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
