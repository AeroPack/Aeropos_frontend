import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/category.dart';
import '../models/enums/sync_status.dart';
import '../di/service_locator.dart';

class CategoryRepository {
  final AppDatabase _database;

  CategoryRepository(this._database);

  Future<List<Category>> getAllCategories() async {
    final entities = await (_database.select(
      _database.categories,
    )..where((t) => t.isDeleted.equals(false))).get();
    return entities.map(_mapToDomain).toList();
  }

  Stream<List<Category>> watchAllCategories() {
    return (_database.select(_database.categories)
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map((entities) => entities.map(_mapToDomain).toList());
  }

  Future<Category?> getCategoryById(int id) async {
    // This method is not directly supported by the basic DAO generated,
    // but we can filter the list or add a specific query in DAO if needed.
    // For now, implementing via getAll for simplicity, optimizing later if needed.
    final all = await getAllCategories();
    try {
      return all.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<int> createCategory(Category category) async {
    final companion = CategoriesCompanion(
      uuid: Value(category.uuid),
      name: Value(category.name),
      subcategory: Value(category.subcategory),
      description: Value(category.description),
      isActive: Value(category.isActive),
      tenantId: const Value(1),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(category.isDeleted),
    );
    final id = await _database.into(_database.categories).insert(companion);
    ServiceLocator.instance.syncService.sync();
    return id;
  }

  Future<bool> updateCategory(Category category) async {
    final companion = CategoriesCompanion(
      id: Value(category.id),
      uuid: Value(category.uuid),
      name: Value(category.name),
      subcategory: Value(category.subcategory),
      description: Value(category.description),
      isActive: Value(category.isActive),
      updatedAt: Value(DateTime.now()),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(category.isDeleted),
    );
    final success = await _database
        .update(_database.categories)
        .replace(companion);
    if (success) {
      ServiceLocator.instance.syncService.sync();
    }
    return success;
  }

  Future<int> deleteCategory(int id) async {
    final result =
        await (_database.update(
          _database.categories,
        )..where((t) => t.id.equals(id))).write(
          CategoriesCompanion(
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

  Category _mapToDomain(CategoryEntity entity) {
    return Category(
      id: entity.id,
      uuid: entity.uuid,
      name: entity.name,
      subcategory: entity.subcategory,
      description: entity.description,
      isActive: entity.isActive,
      syncStatus: SyncStatus.fromValue(entity.syncStatus),
      isDeleted: entity.isDeleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
