import 'package:flutter/foundation.dart';

class PosPlatform {
  /// Returns true if the app is running on Linux, Windows, Mac, or Web (Desktop-sized)
  static bool get isDesktop {
    if (kIsWeb) {
      // On web, we assume desktop layout unless strictly mobile user agent (optional)
      // For now, we treat Web as a Desktop-class interface.
      return true; 
    }
    return defaultTargetPlatform == TargetPlatform.linux ||
           defaultTargetPlatform == TargetPlatform.windows ||
           defaultTargetPlatform == TargetPlatform.macOS;
  }

  /// Returns true if running on Android or iOS
  static bool get isMobile {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
           defaultTargetPlatform == TargetPlatform.iOS;
  }
}