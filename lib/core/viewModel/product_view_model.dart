import 'package:drift/drift.dart' as drift;
import '../database/app_database.dart';
import '../services/sync_service.dart';
import 'package:uuid/uuid.dart';
import '../repositories/category_repository.dart';
import '../repositories/unit_repository.dart';
import '../repositories/brand_repository.dart'; // Added
import '../models/category.dart';
import '../models/unit.dart';
import '../models/brand.dart'; // Added
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'dart:convert';
import 'dart:io';
import '../../config/app_config.dart';
import '../services/device_id_service.dart';

class ProductViewModel {
  final AppDatabase _database;
  final CategoryRepository _categoryRepository;
  final UnitRepository _unitRepository;
  final BrandRepository _brandRepository; // Added
  final SyncService _syncService;
  final _uuid = const Uuid();

  ProductViewModel(
    this._database,
    this._categoryRepository,
    this._unitRepository,
    this._brandRepository, // Added
    this._syncService,
  );

  // Expose database for table access
  AppDatabase get database => _database;

  // Expose stream of products from DB
  Stream<List<ProductEntity>> get allProducts => _database.watchAllProducts();

  // Expose stream of products with category names
  Stream<List<drift.TypedResult>> get allProductsWithCategory =>
      _database.watchProductsWithCategory();

  // Expose streams from repositories
  Stream<List<Category>> get allCategories =>
      _categoryRepository.watchAllCategories();
  Stream<List<Unit>> get allUnits => _unitRepository.watchAllUnits();
  Stream<List<Brand>> get allBrands =>
      _brandRepository.watchAllBrands(); // Added

  Future<void> addProduct({
    required String name,
    required String sku,
    required double price,
    required double stockQuantity,
    double? cost, // Added cost
    int? categoryId,
    int? unitId,
    int? brandId, // Added
    String? gstType,
    String? gstRate,
    String? description,
    String? localPath,
    String? imageUrl, // Remote URL or Base64 data URI (for web)
    double discount = 0.0,
    bool isPercentDiscount = false,
  }) async {
    final entry = ProductsCompanion(
      uuid: drift.Value(_uuid.v4()),
      name: drift.Value(name),
      sku: sku.isEmpty ? const drift.Value(null) : drift.Value(sku),
      price: drift.Value(price),
      stockQuantity: drift.Value(stockQuantity.toInt()),
      cost: drift.Value(cost), // Added cost
      categoryId: drift.Value(categoryId),
      unitId: drift.Value(unitId),
      brandId: drift.Value(brandId), // Added
      gstType: drift.Value(gstType),
      gstRate: drift.Value(gstRate),
      description: drift.Value(description),
      localPath: drift.Value(localPath),
      imageUrl: drift.Value(imageUrl),
      discount: drift.Value(discount),
      isPercentDiscount: drift.Value(isPercentDiscount),
      isActive: const drift.Value(true),
      tenantId: const drift.Value(1), // Default tenant ID
      syncStatus: const drift.Value(1), // Pending
      isDeleted: const drift.Value(false),
      createdAt: drift.Value(DateTime.now()),
      updatedAt: drift.Value(DateTime.now()),
    );

    try {
      await _database.insertProduct(entry);
      print('Product added successfully');
    } catch (e, s) {
      print('Error adding product: $e');
      print('Stack trace: $s');
      rethrow;
    }
  }

  Future<bool> isSkuUnique(String sku, {int? excludeId}) async {
    final query = _database.select(_database.products)
      ..where((tbl) => tbl.sku.equals(sku))
      ..where((tbl) => tbl.isDeleted.equals(false));
    if (excludeId != null) {
      query.where((tbl) => tbl.id.isNotValue(excludeId));
    }
    final result = await query.getSingleOrNull();
    return result == null;
  }

  Future<bool> isNameUnique(String name, {int? excludeId}) async {
    final query = _database.select(_database.products)
      ..where((tbl) => tbl.name.equals(name))
      ..where((tbl) => tbl.isDeleted.equals(false));
    if (excludeId != null) {
      query.where((tbl) => tbl.id.isNotValue(excludeId));
    }
    final result = await query.getSingleOrNull();
    return result == null;
  }

  Future<void> updateProduct(ProductEntity product) async {
    await _database.updateProduct(product);
  }

  Future<void> deleteProduct(int id) async {
    await _database.deleteProduct(id);
  }

  Future<String?> _uploadImage(String localPath) async {
    final d = dio.Dio();
    try {
      String fileName = localPath.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(localPath, filename: fileName),
      });

      // Replace with actual media endpoint
      final response = await d.post(
        "${AppConfig.apiBaseUrl}/media/upload",
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['url'] as String;
      }
    } catch (e) {
      print("Image upload failed: $e");
    }
    return null;
  }

  Future<void> syncPendingProducts() async {
    await _syncService.push();
  }

  Future<void> fetchAndSync() async {
    await _syncService.pull();
  }

  Future<String> generateNextSku() async {
    // Get device ID
    final deviceIdService = DeviceIdService(_database);
    final deviceId = await deviceIdService.getDeviceId();

    // Generate SKU with device ID
    return await _database.getNextSku(deviceId);
  }
}
