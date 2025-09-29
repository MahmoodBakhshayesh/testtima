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
import 'constant_data_class.dart';
import 'people_class.dart';
import 'user_class.dart';
import 'user_permission_class.dart';

class BasicClass {
  BasicClass._();

  factory BasicClass() {
    return instance;
  }

  static final BasicClass instance = BasicClass._();
  static late bool initialized;
  String? _username;
  // TimaticData? _timaticData;
  LoginData? _loginData;
  // ConstData? _constData;
  VersionedConstantData? _versionedConstantData;
  PackageInfo? _packageInfo;
  UserPermission? _userPermission;
  Config? _appConfig;

  static void initialize(LoginData user) {
    // instance._timaticData = timaticData;
    instance._loginData = user;
    // instance._constData = user.constData;
    instance._userPermission = user.permission;
  }

  static void setVersionedConstData(VersionedConstantData data) {
    instance._versionedConstantData = data;
    // instance._timaticData = TimaticData(params: params, locations: locations);
  }

  static void setConfig(Config config) {
    instance._appConfig = config;
  }

  static VersionedConstantData get constData => instance._versionedConstantData!;

  static LoginData? get user => instance._loginData;

  static Config get config => instance._appConfig ?? Config.def();

  // static TimaticData get timData => instance._timaticData!;

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

  static Country? getLocationWithCode(String code) {
    return constData.data.country.firstWhereOrNull((a) => a.code3 == code);
    // return timData.locations.of(LocationType.country).firstWhereOrNull((a) => a.code3 == code);
  }

  static ParameterValue? getAirlineWithCode(String code) {
    return constData.data.carrier.firstWhereOrNull((a) => a.code == code);

    // return timData.params.of(ParameterType.carrier).firstWhereOrNull((a) => a.code == code);
  }

  static bool validatePermission(UiPermission? permission) {
    if (permission == null) return true;
    // if (instance._userPermission!.isEmpty) return true;
    final up = instance._userPermission!;

    if (permission is UserUiPermission) {
      return up.maskOf("user")>0;
      // return up.user.isGreaterThan(0);
    }

    if (permission is LogUiPermission) {
      // return up.log.isGreaterThan(0);
    }

    return false;
  }
}

extension MyDeviceInfoDetails on MyDeviceInfo {}
