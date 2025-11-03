import 'package:flutter/foundation.dart';

/// Fallback for non-web platforms.
class PlatformHelper {
  /// True if running on web (always false in native builds).
  static bool get isWeb => kIsWeb;

  /// Always false on native.
  static bool get isMobileWeb => false;

  /// Always false on native.
  static bool get isDesktopWeb => false;
}
