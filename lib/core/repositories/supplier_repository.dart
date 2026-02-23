import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/user.dart';
import '../models/enums/sync_status.dart';
import '../di/service_locator.dart';

class SupplierRepository {
  final AppDatabase _database;

  SupplierRepository(this._database);

  Future<List<User>> getAllSuppliers() async {
    final entities = await (_database.select(
      _database.suppliers,
    )..where((t) => t.isDeleted.equals(false))).get();
    return entities.map(_mapToDomain).toList();
  }

  Stream<List<User>> watchAllSuppliers() {
    return (_database.select(_database.suppliers)
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map((entities) => entities.map(_mapToDomain).toList());
  }

  Future<User?> getSupplierById(int id) async {
    try {
      final entity = await (_database.select(
        _database.suppliers,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
      return entity != null ? _mapToDomain(entity) : null;
    } catch (e) {
      return null;
    }
  }

  Future<int> createSupplier(User user) async {
    final companion = SuppliersCompanion(
      uuid: Value(user.uuid),
      name: Value(user.name),
      phone: Value(user.phone),
      email: Value(user.email),
      address: Value(user.address),
      tenantId: const Value(1),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(user.isDeleted),
    );
    final id = await _database.into(_database.suppliers).insert(companion);
    ServiceLocator.instance.syncService.sync();
    return id;
  }

  Future<bool> updateSupplier(User user) async {
    final companion = SuppliersCompanion(
      id: Value(user.id),
      uuid: Value(user.uuid),
      name: Value(user.name),
      phone: Value(user.phone),
      email: Value(user.email),
      address: Value(user.address),
      updatedAt: Value(DateTime.now()),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(user.isDeleted),
    );
    final success = await _database
        .update(_database.suppliers)
        .replace(companion);
    if (success) {
      ServiceLocator.instance.syncService.sync();
    }
    return success;
  }

  Future<int> deleteSupplier(int id) async {
    final result =
        await (_database.update(
          _database.suppliers,
        )..where((t) => t.id.equals(id))).write(
          SuppliersCompanion(
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

  User _mapToDomain(SupplierEntity entity) {
    return User(
      id: entity.id,
      uuid: entity.uuid,
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      address: entity.address,
      role: 'supplier',
      creditLimit: 0,
      currentBalance: 0,
      syncStatus: SyncStatus.fromValue(entity.syncStatus),
      isDeleted: entity.isDeleted,
    );
  }
}
