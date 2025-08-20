import 'dart:developer';
import 'dart:ui';
import 'package:abds/core/utils_and_services/time_picker/ui_permission.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../classes/config_class.dart';
import '../constants/ui.dart';
import '../utils_and_services/settings_class.dart';
import '../utils_and_services/timatic/artemis_timatic.dart';
import '../utils_and_services/timatic/src/models/aggregates.dart';
import 'people_class.dart';
import 'user_class.dart';

class BasicClass {
  BasicClass._();

  factory BasicClass() {
    return instance;
  }

  static final BasicClass instance = BasicClass._();
  static late bool initialized;
  String? _username;
  TimaticData? _timaticData;
  LoginData? _loginData;
  ConstData? _constData;
  PackageInfo? _packageInfo;
  List<UserPermission>? _userPermission;
  Config? _appConfig;




  static void initialize(LoginData user, TimaticData timaticData) {
    instance._timaticData = timaticData;
    instance._loginData = user;
    instance._constData = user.constData;
    instance._userPermission = user.permissions;
  }

  static void setConfig(Config config) {
    instance._appConfig = config;
  }

  static ConstData get constData => instance._constData!;
  static LoginData? get user => instance._loginData;

  static Config get config => instance._appConfig ?? Config.def();

  static TimaticData get timData => instance._timaticData!;

  static Color getColorForEvaluationResult(String evaluationResult) {
    switch (evaluationResult.toUpperCase()) {
      case 'YES':
        return MyColors.green2;
      case 'NO':
        return MyColors.red;
      case 'CONDITIONAL':
        return Colors.orange;
    }
    return Colors.grey;
  }

  static Location? getLocationWithCode(String code) {
    return timData.locations.of(LocationType.country).firstWhereOrNull((a)=>a.code3 == code);
  }

  static ParameterValue? getAirlineWithCode(String code) {
    return timData.params.of(ParameterType.carrier).firstWhereOrNull((a)=>a.code == code);
  }

  static bool validatePermission(UiPermission? permission) {
    if (permission == null) return true;
    if (instance._userPermission!.isEmpty) return true;
    final up = instance._userPermission!;

     if (permission is UserUiPermission) {
      return up.any((a) => a.permission.getUserPermissions.isNotEmpty);
    }


    return false;
  }


}

extension MyDeviceInfoDetails on MyDeviceInfo {}
