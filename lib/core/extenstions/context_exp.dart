import 'dart:io';
import 'dart:math';
import 'package:abds/core/utils_and_services/platform_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';

extension BuldContextMore on BuildContext {
  // bool get isMyTablet {
  //   if (isDesktop) return false;
  //   var size = MediaQuery.of(this).size;
  //   var diagonal = sqrt((size.width * size.width) + (size.height * size.height));
  //
  //   var isTablet = diagonal > 1100.0;
  //   return isTablet;
  //
  //   double width = MediaQuery.of(this).size.width;
  //   print(width);
  //
  //   return (Platform.isIOS || Platform.isAndroid) && width > 600;
  // }

  // bool get isDesktop {
  //   if (kIsWeb && !PlatformHelper.isMobileWeb) return true;
  //   return Platform.isMacOS || Platform.isWindows;
  // }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  double get height {
    return MediaQuery.of(this).size.height;
  }

  EdgeInsets? get getDialogPadding {
    return EdgeInsets.symmetric(
      horizontal: isMyTablet
          ? width * 0.25
          : isDesktop
          ? width * .3
          : 12,
      vertical: isDesktop ? (height * 0.25) : 0,
    );
  }

  EdgeInsets? get getBigDialogPadding {
    return EdgeInsets.symmetric(
      horizontal: isMyTablet
          ? width * 0.10
          : isDesktop
          ? width * .3
          : 12,
    );
  }

  EdgeInsets? get horizontalPadding {
    return EdgeInsets.symmetric(
      horizontal: isMyTablet
          ? 16
          : isDesktop
          ? 16
          : 12,
    );
  }

  EdgeInsetsGeometry get getDrawerPadding {
    return EdgeInsets.all(
      isMyTablet
          ? 24
          : isDesktop
          ? 24
          : 16,
    );
  }

  Color get mainColor => Theme.of(this).primaryColor;
}

enum DeviceClass { phone, tablet, desktop }

class DeviceBreakpoints {
  /// Tweak to your taste
  static const double phoneMaxShortestSide = 600; // < 600 => phone
  static const double tabletMinWidth = 700; // >= 700 && < 1100 => tablet
  static const double desktopMinWidth = 1100; // >= 1100 => desktop
  static const double desktopMinAspect = 1.2; // wide enough to be "desktop-like"
}

extension ResponsiveX on BuildContext {
  MediaQueryData get _mq => MediaQuery.of(this);

  double get _w => _mq.size.width;

  double get _h => _mq.size.height;

  double get _short => _mq.size.shortestSide;

  double get _aspect => _w / _h;

  /// On Flutter Web, this is `true` when the browser runs on a mobile OS.
  bool get isWebMobileUa => kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android);

  /// Heuristics that work well across platforms, including web-on-mobile.
  DeviceClass get deviceClass {
    // 1) Anything on a mobile browser is at least "phone-like"
    if (isWebMobileUa) {
      // But allow promotion to tablet if it’s really large (iPad in landscape)
      if (_w >= DeviceBreakpoints.tabletMinWidth && _aspect >= 1.0) {
        return DeviceClass.tablet;
      }
      return DeviceClass.phone;
    }

    // 2) Use size + ratio for everything else
    if (_short < DeviceBreakpoints.phoneMaxShortestSide) {
      return DeviceClass.phone;
    }

    final looksDesktop = (_w >= DeviceBreakpoints.desktopMinWidth && _aspect >= DeviceBreakpoints.desktopMinAspect);

    if (looksDesktop) return DeviceClass.desktop;

    // Middle ground → tablet
    return DeviceClass.tablet;
  }

  bool get isPhone => deviceClass == DeviceClass.phone;

  bool get isMyTablet => deviceClass == DeviceClass.tablet;

  bool get isDesktop => deviceClass == DeviceClass.desktop;

  /// Handy helper for values per form-factor
  T pick<T>({required T phone, T? tablet, T? desktop}) {
    switch (deviceClass) {
      case DeviceClass.phone:
        return phone;
      case DeviceClass.tablet:
        return (tablet ?? phone);
      case DeviceClass.desktop:
        return (desktop ?? tablet ?? phone);
    }
  }
}
