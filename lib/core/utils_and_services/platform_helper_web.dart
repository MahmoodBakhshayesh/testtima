import 'package:flutter/foundation.dart';
import 'dart:ui_web' as ui_web;

/// Web-only implementation using `dart:ui_web`.
class PlatformHelper {
  /// True when the app is running in a web environment.
  static bool get isWeb => kIsWeb;

  /// Detect if the web app is opened from a mobile browser (Android/iOS).
  static bool get isMobileWeb {
    if (!kIsWeb) return false;

    final ua = ui_web.platformViewRegistry.registerViewFactory.toString().toLowerCase();


    // Detect iPadOS 13+ (which reports as "Macintosh" but has touch points)


    return ua.contains('iphone') ||
        ua.contains('ipad') ||
        ua.contains('android') ||
        ua.contains('mobile');
  }

  /// Detect if running on desktop browser (Web but not mobile).
  static bool get isDesktopWeb => isWeb && !isMobileWeb;
}
