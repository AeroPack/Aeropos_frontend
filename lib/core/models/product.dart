import 'enums/sync_status.dart';

class Product {
  final int id;
  final String uuid;
  final String name;
  final String sku;
  final int? categoryId;
  final int? unitId;
  final String? type;
  final String? packSize;
  final double price;
  final double? cost;
  final int stockQuantity;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SyncStatus syncStatus;
  final bool isDeleted;
  final String? imageUrl;
  final String? localPath;
  final int? brandId;
  final String? description;

  final String? gstType;
  final String? gstRate;
  final double discount;
  final bool isPercentDiscount;
  final int? tenantId;

  Product({
    required this.id,
    required this.uuid,
    required this.name,
    required this.sku,
    this.categoryId,
    this.unitId,
    this.type,
    this.packSize,
    required this.price,
    this.cost,
    this.stockQuantity = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.syncStatus = SyncStatus.synced,
    this.isDeleted = false,
    this.imageUrl,
    this.localPath,
    this.brandId,
    this.description,
    this.gstType,
    this.gstRate,
    this.discount = 0.0,
    this.isPercentDiscount = false,
    this.tenantId,
  });

  Product copyWith({
    int? id,
    String? uuid,
    String? name,
    String? sku,
    int? categoryId,
    int? unitId,
    String? type,
    String? packSize,
    double? price,
    double? cost,
    int? stockQuantity,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
    bool? isDeleted,
    String? imageUrl,
    String? localPath,
    int? brandId,
    String? description,
    String? gstType,
    String? gstRate,
    double? discount,
    bool? isPercentDiscount,
    int? tenantId,
  }) {
    return Product(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      categoryId: categoryId ?? this.categoryId,
      unitId: unitId ?? this.unitId,
      type: type ?? this.type,
      packSize: packSize ?? this.packSize,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      imageUrl: imageUrl ?? this.imageUrl,
      localPath: localPath ?? this.localPath,
      brandId: brandId ?? this.brandId,
      description: description ?? this.description,
      gstType: gstType ?? this.gstType,
      gstRate: gstRate ?? this.gstRate,
      discount: discount ?? this.discount,
      isPercentDiscount: isPercentDiscount ?? this.isPercentDiscount,
      tenantId: tenantId ?? this.tenantId,
    );
  }
}
