import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/unit.dart';
import '../models/enums/sync_status.dart';
import '../di/service_locator.dart';

class UnitRepository {
  final AppDatabase _database;

  UnitRepository(this._database);

  Future<List<Unit>> getAllUnits() async {
    final entities = await (_database.select(
      _database.units,
    )..where((t) => t.isDeleted.equals(false))).get();
    return entities.map(_mapToDomain).toList();
  }

  Stream<List<Unit>> watchAllUnits() {
    return (_database.select(_database.units)
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map((entities) => entities.map(_mapToDomain).toList());
  }

  Future<Unit?> getUnitById(int id) async {
    try {
      final all = await getAllUnits();
      return all.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<int> createUnit(Unit unit) async {
    final companion = UnitsCompanion(
      uuid: Value(unit.uuid),
      name: Value(unit.name),
      symbol: Value(unit.symbol),
      isActive: Value(unit.isActive),
      tenantId: const Value(1),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(unit.isDeleted),
    );
    final id = await _database.into(_database.units).insert(companion);
    ServiceLocator.instance.syncService.sync();
    return id;
  }

  Future<bool> updateUnit(Unit unit) async {
    final companion = UnitsCompanion(
      id: Value(unit.id),
      uuid: Value(unit.uuid),
      name: Value(unit.name),
      symbol: Value(unit.symbol),
      isActive: Value(unit.isActive),
      updatedAt: Value(DateTime.now()),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(unit.isDeleted),
    );
    final success = await _database.update(_database.units).replace(companion);
    if (success) {
      ServiceLocator.instance.syncService.sync();
    }
    return success;
  }

  Future<int> deleteUnit(int id) async {
    final result =
        await (_database.update(
          _database.units,
        )..where((t) => t.id.equals(id))).write(
          UnitsCompanion(
            isDeleted: const Value(true),
            syncStatus: Value(SyncStatus.pending.value),
            updatedAt: Value(DateTime.now()),
          ),
        );
    if (result > 0) {
      ServiceLocator.instance.syncService.sync();
    }
    return result;
  }

  Unit _mapToDomain(UnitEntity entity) {
    return Unit(
      id: entity.id,
      uuid: entity.uuid,
      name: entity.name,
      symbol: entity.symbol,
      isActive: entity.isActive,
      syncStatus: SyncStatus.fromValue(entity.syncStatus),
      isDeleted: entity.isDeleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
