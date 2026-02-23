class AppConstants {
  // App Info
  static const String appName = 'Ezo POS';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'ezo_pos.db';
  static const int databaseVersion = 1;

  // Sync
  static const Duration syncInterval = Duration(minutes: 15);
  static const int maxRetryAttempts = 3;

  // Pagination
  static const int defaultPageSize = 50;

  // Stock
  static const int lowStockThreshold = 10;

  // Tax
  static const double defaultTaxRate = 0.18; // 18%
}
