import 'package:drift/drift.dart' as drift;
import 'package:ezo/core/database/app_database.dart';
import '../services/sync_service.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/app_config.dart';

class UnitViewModel {
  final AppDatabase _database;
  final SyncService _syncService;
  final _uuid = const Uuid();

  UnitViewModel(this._database, this._syncService);

  // Expose stream of units from DB
  Stream<List<UnitEntity>> get allUnits => _database.watchAllUnits();

  Future<void> addUnit({required String name, required String symbol}) async {
    final entry = UnitsCompanion(
      uuid: drift.Value(_uuid.v4()),
      name: drift.Value(name),
      symbol: drift.Value(symbol),
      isActive: const drift.Value(true),
      tenantId: const drift.Value(1),
      syncStatus: const drift.Value(1), // Pending
      isDeleted: const drift.Value(false),
      createdAt: drift.Value(DateTime.now()),
      updatedAt: drift.Value(DateTime.now()),
    );

    await _database.insertUnit(entry);
  }

  Future<void> updateUnit(UnitEntity unit) async {
    await _database.updateUnit(unit);
  }

  Future<void> deleteUnit(int id) async {
    await _database.deleteUnit(id);
  }

  Future<void> syncPendingUnits() async {
    await _syncService.push();
  }

  Future<void> fetchAndSync() async {
    await _syncService.pull();
  }
}
