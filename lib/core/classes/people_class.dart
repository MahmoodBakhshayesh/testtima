import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/people_class.dart';
import 'package:artemis_utils/artemis_utils.dart';

class People {
  String uId;
  String? username;
  String? email;
  String? firstname;
  String? middlename;
  String? lastname;
  bool enable;
  bool hasImage;
  UserPermission permission;

  People({required this.uId, required this.username, required this.email, required this.hasImage, required this.firstname, required this.middlename, required this.lastname, required this.enable, required this.permission});

  factory People.fromJson(Map<String, dynamic> json) {

    final p = People(
      uId: json["uId"],
      username: json["username"],
      email: json["email"],
      firstname: json["firstname"],
      middlename: json["middlename"],
      lastname: json["lastname"],
      hasImage: json["hasImage"] ?? false,
      enable: json["enable"],
      permission: UserPermission.fromJson(json["permission"]),
    );
    log("-"*100);
    log(jsonEncode(json["permission"]));
    log(jsonEncode(UserPermission.fromJson(json["permission"]).toJson()));
    log("-"*100);
    return p;
  }

  Map<String, dynamic> toJson() => {
    "uId": uId,
    "username": username,
    "email": email,
    "hasImage": hasImage,
    "firstname": firstname,
    "middlename": middlename,
    "lastname": lastname,
    "enable": enable,
    "permission": permission.toJson(),
  };

  bool validateSearch(String text) {
    return "${username ?? ''} ${email ?? ''} ${firstname ?? ''} ${lastname ?? ''}".toLowerCase().contains(text.toLowerCase());
  }
}

class UserPermission {
  ActivePermissions permission;
  String name;
  String id;
  AllPermissions allPermissions;

  UserPermission({required this.allPermissions, required this.permission, required this.id, required this.name});

  factory UserPermission.fromJson(Map<String, dynamic> json) {
    log("allpermissionts ${json["allPermissions"]}");
    return UserPermission(
      allPermissions: json["allPermissions"] == null ? AllPermissions({}) : AllPermissions.fromJson(json["allPermissions"]),
      permission: ActivePermissions.fromBitmask(json["allPermissions"] == null ? AllPermissions({}) : AllPermissions.fromJson(json["allPermissions"]), json["permission"]),
      name: json["name"] ?? '-',
      id: json["permissionId"] ?? '-',
    );
  }

  Map<String, dynamic> toJson() => {"permission": permission.toJson(), "name": name, "permissionId": id,'allPermissions':allPermissions.toJson()};
}

class AllPermissions {
  final Map<String, List<PermissionCategory>> _categoryPermissions;

  AllPermissions(this._categoryPermissions);

  List<String> get categories => _categoryPermissions.keys.toList();

  List<PermissionCategory> get all => _categoryPermissions.values.expand((e) => e).toList();

  List<PermissionCategory> getPermissionsFor(String category) => _categoryPermissions[category] ?? [];

  factory AllPermissions.fromJson(Map<String, dynamic> json) {
    final Map<String, List<PermissionCategory>> result = {};
    json.forEach((category, value) {
      // if(value is Map<String,dynamic> ){
      //   log("value is map");
      //   result[category] = PermissionCategory.fromJson(value, category);
      // }else{
      //   log("value is not map ${value.runtimeType}");
      // }
      if (value is List) {
        result[category] = value.whereType<Map<String, dynamic>>().map((e) => PermissionCategory.fromJson(e, category)).toList();
      }
    });
    // log("all from json $json");
    // log("all from json result  $result");
    return AllPermissions(result);
  }

  List<PermissionCategory> get flight => getPermissionsFor("flight");

  List<PermissionCategory> get seat => getPermissionsFor("seat");

  List<PermissionCategory> get checkin => getPermissionsFor("checkin");

  List<PermissionCategory> get board => getPermissionsFor("board");

  List<PermissionCategory> get bag => getPermissionsFor("bag");

  List<PermissionCategory> get document => getPermissionsFor("document");

  List<PermissionCategory> get user => getPermissionsFor("user");

  List<PermissionCategory> get passenger => getPermissionsFor("passenger");

  List<PermissionCategory> get history => getPermissionsFor("history");

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    for (final entry in _categoryPermissions.entries) {
      json[entry.key] = entry.value.map((perm) => perm.toJson()).toList();
    }

    return json;
  }
}

class PermissionCategory {
  final String category;
  final int flag;
  final String value;

  PermissionCategory({required this.category, required this.flag, required this.value});

  factory PermissionCategory.fromJson(Map<String, dynamic> json, String category) {
    return PermissionCategory(category: category, flag: json['flag'], value: json['value']);
  }

  factory PermissionCategory.empty(String category) {
    return PermissionCategory(category: category, flag: 0, value: '');
  }

  bool get isEmpty => flag == 0;

  @override
  String toString() => 'Permission(category: $category, flag: $flag, value: $value)';

  Map<String, dynamic> toJson() {
    return {'flag': flag, 'value': value};
  }

  void add(ap) {}
}

class ActivePermissions {
  final Map<String, List<PermissionCategory>> _activePermissions;

  ActivePermissions(this._activePermissions);

  factory ActivePermissions.fromBitmask(AllPermissions all, Map<String, dynamic> bitmaskJson) {
    final Map<String, List<PermissionCategory>> result = {};

    // log("all Categories => ${all.categories}");
    // log("bitmaskJson => ${bitmaskJson}");
    for (final category in all.categories) {
      final allPerms = all.getPermissionsFor(category);
      final bitmask = bitmaskJson[category] ?? 0;
      // final bitmask =( bitmaskJson[category] as List).map((a)=>int.tryParse(a["flag"].toString())??0).sum.toInt() ;
      // final bitmask = 0 ;
      // log("bitmasssk of $category ==> ${bitmaskJson}");
      result[category] = allPerms.where((perm) => (bitmask & perm.flag) != 0).toList();
    }
    return ActivePermissions(result);
  }

  List<PermissionCategory> get all => _activePermissions.values.expand((e) => e).toList();

  List<PermissionCategory> getPermissionsFor(String category) => _activePermissions[category] ?? [];

  void setPermissionsFor(String category, List<PermissionCategory> pers) {
    _activePermissions[category] = pers;
  }

  List<String> get categories => _activePermissions.keys.toList();


  List<PermissionCategory> get getUserPermissions => getPermissionsFor('user');
  List<PermissionCategory> get getLogPermissions => getPermissionsFor('log');


  bool get hasAnyPermission => all.any((a) => a.flag > 0);

  Map<String, dynamic> toJson() {
    final Map<String, int> json = {};
    for (final entry in _activePermissions.entries) {
      int bitmask = entry.value.fold(0, (sum, perm) => sum | perm.flag);
      json[entry.key] = bitmask;
    }

    return json;
  }
}
