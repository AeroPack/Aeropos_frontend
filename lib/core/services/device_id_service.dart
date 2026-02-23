import 'dart:io';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart';

class DeviceIdService {
  static const String _deviceIdKey = 'device_id';
  final AppDatabase _database;

  DeviceIdService(this._database);

  String? _cachedDeviceId;

  /// Get a unique device identifier
  /// Format: First 4 chars of hostname or platform + random suffix
  Future<String> getDeviceId() async {
    if (_cachedDeviceId != null) {
      return _cachedDeviceId!;
    }

    // Check database for existing device ID
    final record = await (_database.select(
      _database.syncMetadata,
    )..where((t) => t.key.equals(_deviceIdKey))).getSingleOrNull();

    String deviceId;
    if (record == null || record.value == null) {
      // Generate new device ID
      deviceId = await _generateDeviceId();
      // Store in database
      await _database
          .into(_database.syncMetadata)
          .insertOnConflictUpdate(
            SyncMetadataCompanion(
              key: const Value(_deviceIdKey),
              value: Value(deviceId),
              updatedAt: Value(DateTime.now()),
            ),
          );
    } else {
      deviceId = record.value!;
    }

    _cachedDeviceId = deviceId;
    return deviceId;
  }

  Future<String> _generateDeviceId() async {
    try {
      // Try to get hostname
      final hostname = Platform.localHostname;
      // Take first 4 characters of hostname, uppercase, alphanumeric only
      final cleaned = hostname.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
      final prefix = cleaned.isEmpty
          ? 'DEV'
          : cleaned.toUpperCase().substring(
              0,
              cleaned.length >= 4 ? 4 : cleaned.length,
            );

      // Add a random suffix to ensure uniqueness
      final uuid = const Uuid();
      final suffix = uuid.v4().substring(0, 4).toUpperCase();

      return '$prefix$suffix';
    } catch (e) {
      // Fallback: use platform name + random ID
      final platform = Platform.operatingSystem.substring(0, 3).toUpperCase();
      final uuid = const Uuid();
      final suffix = uuid.v4().substring(0, 5).toUpperCase();
      return '$platform$suffix';
    }
  }

  /// Reset device ID (useful for testing)
  Future<void> resetDeviceId() async {
    await (_database.delete(
      _database.syncMetadata,
    )..where((t) => t.key.equals(_deviceIdKey))).go();
    _cachedDeviceId = null;
  }
}
