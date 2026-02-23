import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/brand.dart';
import '../models/enums/sync_status.dart';
import '../di/service_locator.dart';

class BrandRepository {
  final AppDatabase _database;

  BrandRepository(this._database);

  Future<List<Brand>> getAllBrands() async {
    final entities = await (_database.select(
      _database.brands,
    )..where((t) => t.isDeleted.equals(false))).get();
    return entities.map(_mapToDomain).toList();
  }

  Stream<List<Brand>> watchAllBrands() {
    return (_database.select(_database.brands)
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map((entities) => entities.map(_mapToDomain).toList());
  }

  Future<int> createBrand(Brand brand) async {
    final companion = BrandsCompanion(
      uuid: Value(brand.uuid),
      name: Value(brand.name),
      description: Value(brand.description),
      isActive: Value(brand.isActive),
      tenantId: const Value(1),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(brand.isDeleted),
    );
    final id = await _database.into(_database.brands).insert(companion);
    ServiceLocator.instance.syncService.sync();
    return id;
  }

  Future<bool> updateBrand(Brand brand) async {
    final companion = BrandsCompanion(
      id: Value(brand.id),
      uuid: Value(brand.uuid),
      name: Value(brand.name),
      description: Value(brand.description),
      isActive: Value(brand.isActive),
      updatedAt: Value(DateTime.now()),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(brand.isDeleted),
    );
    final success = await _database.update(_database.brands).replace(companion);
    if (success) {
      ServiceLocator.instance.syncService.sync();
    }
    return success;
  }

  Future<Brand?> getBrandById(int id) async {
    final all = await getAllBrands();
    try {
      return all.firstWhere((b) => b.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<int> deleteBrand(int id) async {
    final result =
        await (_database.update(
          _database.brands,
        )..where((t) => t.id.equals(id))).write(
          BrandsCompanion(
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

  Brand _mapToDomain(BrandEntity entity) {
    return Brand(
      id: entity.id,
      uuid: entity.uuid,
      name: entity.name,
      description: entity.description,
      isActive: entity.isActive,
      syncStatus: SyncStatus.fromValue(entity.syncStatus),
      isDeleted: entity.isDeleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
