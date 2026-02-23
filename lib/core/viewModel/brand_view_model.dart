import 'package:drift/drift.dart' as drift;
import 'package:ezo/core/database/app_database.dart';
import '../services/sync_service.dart';
import 'package:uuid/uuid.dart';

class BrandViewModel {
  final AppDatabase _database;
  final SyncService _syncService;
  final _uuid = const Uuid();

  BrandViewModel(this._database, this._syncService);

  // Expose stream of brands from DB
  Stream<List<BrandEntity>> get allBrands => _database.watchAllBrands();

  Future<void> addBrand({required String name, String? description}) async {
    final entry = BrandsCompanion(
      uuid: drift.Value(_uuid.v4()),
      name: drift.Value(name),
      description: drift.Value(description),
      isActive: const drift.Value(true),
      tenantId: const drift.Value(1),
      syncStatus: const drift.Value(1), // Pending
      isDeleted: const drift.Value(false),
      createdAt: drift.Value(DateTime.now()),
      updatedAt: drift.Value(DateTime.now()),
    );

    await _database.insertBrand(entry);
  }

  Future<void> updateBrand(BrandEntity brand) async {
    await _database.updateBrand(brand);
  }

  Future<void> deleteBrand(int id) async {
    await _database.deleteBrand(id);
  }

  Future<void> syncPendingBrands() async {
    await _syncService.push();
  }

  Future<void> fetchAndSync() async {
    await _syncService.pull();
  }
}
