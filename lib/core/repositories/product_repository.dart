import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/product.dart';
import '../models/enums/sync_status.dart';
import '../di/service_locator.dart';
import 'package:uuid/uuid.dart';

class ProductRepository {
  final AppDatabase db;

  ProductRepository(this.db);

  Future<List<Product>> getAllProducts() async {
    final entities = await (db.select(
      db.products,
    )..where((t) => t.isDeleted.equals(false))).get();
    return entities.map(_mapToDomain).toList();
  }

  Stream<List<Product>> watchAllProducts() {
    return (db.select(db.products)..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map((entities) => entities.map(_mapToDomain).toList());
  }

  Future<Product?> getProductById(int id) async {
    final entity = await (db.select(
      db.products,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return entity != null ? _mapToDomain(entity) : null;
  }

  Future<int> createProduct(Product product) async {
    final companion = _mapToCompanion(
      product,
    ).copyWith(syncStatus: Value(SyncStatus.pending.value));
    final id = await db.into(db.products).insert(companion);
    // Trigger sync
    ServiceLocator.instance.syncService.sync();
    return id;
  }

  Future<bool> updateProduct(Product product) async {
    final companion = _mapToCompanion(product).copyWith(
      syncStatus: Value(SyncStatus.pending.value),
      updatedAt: Value(DateTime.now()),
    );
    final success = await db.update(db.products).replace(companion);
    if (success) {
      ServiceLocator.instance.syncService.sync();
    }
    return success;
  }

  Future<int> deleteProduct(int id) async {
    final result = await (db.update(db.products)..where((t) => t.id.equals(id)))
        .write(
          ProductsCompanion(
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

  Stream<List<Product>> watchProductsByCategory(int categoryId) {
    return (db.select(db.products)..where(
          (t) => t.categoryId.equals(categoryId) & t.isDeleted.equals(false),
        ))
        .watch()
        .map((entities) => entities.map(_mapToDomain).toList());
  }

  // Mapping Helpers
  Product _mapToDomain(ProductEntity entity) {
    return Product(
      id: entity.id,
      uuid: entity.uuid,
      name: entity.name,
      sku: entity.sku ?? '',
      categoryId: entity.categoryId,
      unitId: entity.unitId,
      type: entity.type,
      packSize: entity.packSize,
      price: entity.price,
      cost: entity.cost,
      stockQuantity: entity.stockQuantity,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      syncStatus: SyncStatus.fromValue(entity.syncStatus),
      isDeleted: entity.isDeleted,
      imageUrl: entity.imageUrl,
      localPath: entity.localPath,
      brandId: entity.brandId,
      description: entity.description,
      gstType: entity.gstType,
      gstRate: entity.gstRate,
      discount: entity.discount,
      isPercentDiscount: entity.isPercentDiscount,
    );
  }

  ProductsCompanion _mapToCompanion(Product product) {
    return ProductsCompanion(
      id: product.id == 0 ? const Value.absent() : Value(product.id),
      uuid: Value(product.uuid),
      name: Value(product.name),
      sku: Value(product.sku),
      categoryId: Value(product.categoryId),
      unitId: Value(product.unitId),
      type: Value(product.type),
      packSize: Value(product.packSize),
      price: Value(product.price),
      cost: Value(product.cost),
      stockQuantity: Value(product.stockQuantity),
      isActive: Value(product.isActive),
      tenantId: const Value(1), // Default tenant ID
      createdAt: Value(product.createdAt),
      updatedAt: Value(product.updatedAt),
      syncStatus: Value(product.syncStatus.value),
      isDeleted: Value(product.isDeleted),
      imageUrl: Value(product.imageUrl),
      localPath: Value(product.localPath),
      brandId: Value(product.brandId),
      description: Value(product.description),
      gstType: Value(product.gstType),
      gstRate: Value(product.gstRate),
      discount: Value(product.discount),
      isPercentDiscount: Value(product.isPercentDiscount),
    );
  }
}
