import 'package:drift/drift.dart' as drift;
import 'package:ezo/core/database/app_database.dart';
import '../services/sync_service.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/app_config.dart';

class CategoryViewModel {
  final AppDatabase _database;
  final SyncService _syncService;
  final _uuid = const Uuid();

  CategoryViewModel(this._database, this._syncService);

  // Expose stream of products from DB
  Stream<List<CategoryEntity>> get allCategories =>
      _database.watchAllCategories();

  Future<void> addCategory({
    required String name,
    String? subcategory,
    String? description,
  }) async {
    final entry = CategoriesCompanion(
      uuid: drift.Value(_uuid.v4()),
      name: drift.Value(name),
      subcategory: drift.Value(subcategory),
      description: drift.Value(description),
      isActive: const drift.Value(true),
      tenantId: const drift.Value(1),
      syncStatus: const drift.Value(1), // Pending
      isDeleted: const drift.Value(false),
      createdAt: drift.Value(DateTime.now()),
      updatedAt: drift.Value(DateTime.now()),
    );

    await _database.insertCategory(entry);
  }

  Future<void> updateCategory(CategoryEntity category) async {
    await _database.updateCategory(category);
  }

  Future<void> deleteCategory(int id) async {
    await _database.deleteCategory(id);
  }

  Future<void> syncPendingCategories() async {
    await _syncService.push();
  }

  Future<void> fetchAndSync() async {
    await _syncService.pull();
  }
}
