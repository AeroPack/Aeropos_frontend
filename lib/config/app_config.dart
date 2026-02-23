import 'dart:io';
import 'package:flutter/foundation.dart';

class AppConfig {
  // API Configuration
  static String get apiBaseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:5002';
    }
    try {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:5002';
      }
    } catch (e) {
      // Platform might not be available on some environments
    }
    return 'http://127.0.0.1:5002';
  }

  static const String apiVersion = 'v1';

  // Feature Flags
  static const bool enableSync = true;
  static const bool enableOfflineMode = true;
  static const bool enableBackup = true;

  // Environment
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'development',
  );

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';
}
