// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
    'unit_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brandIdMeta = const VerificationMeta(
    'brandId',
  );
  @override
  late final GeneratedColumn<int> brandId = GeneratedColumn<int>(
    'brand_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _packSizeMeta = const VerificationMeta(
    'packSize',
  );
  @override
  late final GeneratedColumn<String> packSize = GeneratedColumn<String>(
    'pack_size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockQuantityMeta = const VerificationMeta(
    'stockQuantity',
  );
  @override
  late final GeneratedColumn<int> stockQuantity = GeneratedColumn<int>(
    'stock_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _gstTypeMeta = const VerificationMeta(
    'gstType',
  );
  @override
  late final GeneratedColumn<String> gstType = GeneratedColumn<String>(
    'gst_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gstRateMeta = const VerificationMeta(
    'gstRate',
  );
  @override
  late final GeneratedColumn<String> gstRate = GeneratedColumn<String>(
    'gst_rate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isPercentDiscountMeta = const VerificationMeta(
    'isPercentDiscount',
  );
  @override
  late final GeneratedColumn<bool> isPercentDiscount = GeneratedColumn<bool>(
    'is_percent_discount',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_percent_discount" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    sku,
    categoryId,
    unitId,
    brandId,
    type,
    packSize,
    price,
    cost,
    stockQuantity,
    isActive,
    tenantId,
    createdAt,
    updatedAt,
    gstType,
    gstRate,
    imageUrl,
    localPath,
    description,
    discount,
    isPercentDiscount,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    }
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('pack_size')) {
      context.handle(
        _packSizeMeta,
        packSize.isAcceptableOrUnknown(data['pack_size']!, _packSizeMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('stock_quantity')) {
      context.handle(
        _stockQuantityMeta,
        stockQuantity.isAcceptableOrUnknown(
          data['stock_quantity']!,
          _stockQuantityMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('gst_type')) {
      context.handle(
        _gstTypeMeta,
        gstType.isAcceptableOrUnknown(data['gst_type']!, _gstTypeMeta),
      );
    }
    if (data.containsKey('gst_rate')) {
      context.handle(
        _gstRateMeta,
        gstRate.isAcceptableOrUnknown(data['gst_rate']!, _gstRateMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('is_percent_discount')) {
      context.handle(
        _isPercentDiscountMeta,
        isPercentDiscount.isAcceptableOrUnknown(
          data['is_percent_discount']!,
          _isPercentDiscountMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_id'],
      ),
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brand_id'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      packSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pack_size'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      ),
      stockQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_quantity'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      gstType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gst_type'],
      ),
      gstRate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gst_rate'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      isPercentDiscount: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_percent_discount'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductEntity extends DataClass implements Insertable<ProductEntity> {
  final int id;
  final String uuid;
  final String name;
  final String? sku;
  final int? categoryId;
  final int? unitId;
  final int? brandId;
  final String? type;
  final String? packSize;
  final double price;
  final double? cost;
  final int stockQuantity;
  final bool isActive;
  final int tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? gstType;
  final String? gstRate;
  final String? imageUrl;
  final String? localPath;
  final String? description;
  final double discount;
  final bool isPercentDiscount;
  final int syncStatus;
  final bool isDeleted;
  const ProductEntity({
    required this.id,
    required this.uuid,
    required this.name,
    this.sku,
    this.categoryId,
    this.unitId,
    this.brandId,
    this.type,
    this.packSize,
    required this.price,
    this.cost,
    required this.stockQuantity,
    required this.isActive,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    this.gstType,
    this.gstRate,
    this.imageUrl,
    this.localPath,
    this.description,
    required this.discount,
    required this.isPercentDiscount,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || unitId != null) {
      map['unit_id'] = Variable<int>(unitId);
    }
    if (!nullToAbsent || brandId != null) {
      map['brand_id'] = Variable<int>(brandId);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || packSize != null) {
      map['pack_size'] = Variable<String>(packSize);
    }
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    map['stock_quantity'] = Variable<int>(stockQuantity);
    map['is_active'] = Variable<bool>(isActive);
    map['tenant_id'] = Variable<int>(tenantId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || gstType != null) {
      map['gst_type'] = Variable<String>(gstType);
    }
    if (!nullToAbsent || gstRate != null) {
      map['gst_rate'] = Variable<String>(gstRate);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['discount'] = Variable<double>(discount);
    map['is_percent_discount'] = Variable<bool>(isPercentDiscount);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      unitId: unitId == null && nullToAbsent
          ? const Value.absent()
          : Value(unitId),
      brandId: brandId == null && nullToAbsent
          ? const Value.absent()
          : Value(brandId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      packSize: packSize == null && nullToAbsent
          ? const Value.absent()
          : Value(packSize),
      price: Value(price),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      stockQuantity: Value(stockQuantity),
      isActive: Value(isActive),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      gstType: gstType == null && nullToAbsent
          ? const Value.absent()
          : Value(gstType),
      gstRate: gstRate == null && nullToAbsent
          ? const Value.absent()
          : Value(gstRate),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      discount: Value(discount),
      isPercentDiscount: Value(isPercentDiscount),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory ProductEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String?>(json['sku']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      unitId: serializer.fromJson<int?>(json['unitId']),
      brandId: serializer.fromJson<int?>(json['brandId']),
      type: serializer.fromJson<String?>(json['type']),
      packSize: serializer.fromJson<String?>(json['packSize']),
      price: serializer.fromJson<double>(json['price']),
      cost: serializer.fromJson<double?>(json['cost']),
      stockQuantity: serializer.fromJson<int>(json['stockQuantity']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      gstType: serializer.fromJson<String?>(json['gstType']),
      gstRate: serializer.fromJson<String?>(json['gstRate']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      description: serializer.fromJson<String?>(json['description']),
      discount: serializer.fromJson<double>(json['discount']),
      isPercentDiscount: serializer.fromJson<bool>(json['isPercentDiscount']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String?>(sku),
      'categoryId': serializer.toJson<int?>(categoryId),
      'unitId': serializer.toJson<int?>(unitId),
      'brandId': serializer.toJson<int?>(brandId),
      'type': serializer.toJson<String?>(type),
      'packSize': serializer.toJson<String?>(packSize),
      'price': serializer.toJson<double>(price),
      'cost': serializer.toJson<double?>(cost),
      'stockQuantity': serializer.toJson<int>(stockQuantity),
      'isActive': serializer.toJson<bool>(isActive),
      'tenantId': serializer.toJson<int>(tenantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'gstType': serializer.toJson<String?>(gstType),
      'gstRate': serializer.toJson<String?>(gstRate),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'localPath': serializer.toJson<String?>(localPath),
      'description': serializer.toJson<String?>(description),
      'discount': serializer.toJson<double>(discount),
      'isPercentDiscount': serializer.toJson<bool>(isPercentDiscount),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  ProductEntity copyWith({
    int? id,
    String? uuid,
    String? name,
    Value<String?> sku = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    Value<int?> unitId = const Value.absent(),
    Value<int?> brandId = const Value.absent(),
    Value<String?> type = const Value.absent(),
    Value<String?> packSize = const Value.absent(),
    double? price,
    Value<double?> cost = const Value.absent(),
    int? stockQuantity,
    bool? isActive,
    int? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> gstType = const Value.absent(),
    Value<String?> gstRate = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> localPath = const Value.absent(),
    Value<String?> description = const Value.absent(),
    double? discount,
    bool? isPercentDiscount,
    int? syncStatus,
    bool? isDeleted,
  }) => ProductEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    sku: sku.present ? sku.value : this.sku,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    unitId: unitId.present ? unitId.value : this.unitId,
    brandId: brandId.present ? brandId.value : this.brandId,
    type: type.present ? type.value : this.type,
    packSize: packSize.present ? packSize.value : this.packSize,
    price: price ?? this.price,
    cost: cost.present ? cost.value : this.cost,
    stockQuantity: stockQuantity ?? this.stockQuantity,
    isActive: isActive ?? this.isActive,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    gstType: gstType.present ? gstType.value : this.gstType,
    gstRate: gstRate.present ? gstRate.value : this.gstRate,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    localPath: localPath.present ? localPath.value : this.localPath,
    description: description.present ? description.value : this.description,
    discount: discount ?? this.discount,
    isPercentDiscount: isPercentDiscount ?? this.isPercentDiscount,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  ProductEntity copyWithCompanion(ProductsCompanion data) {
    return ProductEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      type: data.type.present ? data.type.value : this.type,
      packSize: data.packSize.present ? data.packSize.value : this.packSize,
      price: data.price.present ? data.price.value : this.price,
      cost: data.cost.present ? data.cost.value : this.cost,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      gstType: data.gstType.present ? data.gstType.value : this.gstType,
      gstRate: data.gstRate.present ? data.gstRate.value : this.gstRate,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      description: data.description.present
          ? data.description.value
          : this.description,
      discount: data.discount.present ? data.discount.value : this.discount,
      isPercentDiscount: data.isPercentDiscount.present
          ? data.isPercentDiscount.value
          : this.isPercentDiscount,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitId: $unitId, ')
          ..write('brandId: $brandId, ')
          ..write('type: $type, ')
          ..write('packSize: $packSize, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('isActive: $isActive, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('gstType: $gstType, ')
          ..write('gstRate: $gstRate, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localPath: $localPath, ')
          ..write('description: $description, ')
          ..write('discount: $discount, ')
          ..write('isPercentDiscount: $isPercentDiscount, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    uuid,
    name,
    sku,
    categoryId,
    unitId,
    brandId,
    type,
    packSize,
    price,
    cost,
    stockQuantity,
    isActive,
    tenantId,
    createdAt,
    updatedAt,
    gstType,
    gstRate,
    imageUrl,
    localPath,
    description,
    discount,
    isPercentDiscount,
    syncStatus,
    isDeleted,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.categoryId == this.categoryId &&
          other.unitId == this.unitId &&
          other.brandId == this.brandId &&
          other.type == this.type &&
          other.packSize == this.packSize &&
          other.price == this.price &&
          other.cost == this.cost &&
          other.stockQuantity == this.stockQuantity &&
          other.isActive == this.isActive &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.gstType == this.gstType &&
          other.gstRate == this.gstRate &&
          other.imageUrl == this.imageUrl &&
          other.localPath == this.localPath &&
          other.description == this.description &&
          other.discount == this.discount &&
          other.isPercentDiscount == this.isPercentDiscount &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class ProductsCompanion extends UpdateCompanion<ProductEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> sku;
  final Value<int?> categoryId;
  final Value<int?> unitId;
  final Value<int?> brandId;
  final Value<String?> type;
  final Value<String?> packSize;
  final Value<double> price;
  final Value<double?> cost;
  final Value<int> stockQuantity;
  final Value<bool> isActive;
  final Value<int> tenantId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> gstType;
  final Value<String?> gstRate;
  final Value<String?> imageUrl;
  final Value<String?> localPath;
  final Value<String?> description;
  final Value<double> discount;
  final Value<bool> isPercentDiscount;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.brandId = const Value.absent(),
    this.type = const Value.absent(),
    this.packSize = const Value.absent(),
    this.price = const Value.absent(),
    this.cost = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.isActive = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.gstType = const Value.absent(),
    this.gstRate = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    this.description = const Value.absent(),
    this.discount = const Value.absent(),
    this.isPercentDiscount = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.sku = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.brandId = const Value.absent(),
    this.type = const Value.absent(),
    this.packSize = const Value.absent(),
    required double price,
    this.cost = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.isActive = const Value.absent(),
    required int tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.gstType = const Value.absent(),
    this.gstRate = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    this.description = const Value.absent(),
    this.discount = const Value.absent(),
    this.isPercentDiscount = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       price = Value(price),
       tenantId = Value(tenantId);
  static Insertable<ProductEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<int>? categoryId,
    Expression<int>? unitId,
    Expression<int>? brandId,
    Expression<String>? type,
    Expression<String>? packSize,
    Expression<double>? price,
    Expression<double>? cost,
    Expression<int>? stockQuantity,
    Expression<bool>? isActive,
    Expression<int>? tenantId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? gstType,
    Expression<String>? gstRate,
    Expression<String>? imageUrl,
    Expression<String>? localPath,
    Expression<String>? description,
    Expression<double>? discount,
    Expression<bool>? isPercentDiscount,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (categoryId != null) 'category_id': categoryId,
      if (unitId != null) 'unit_id': unitId,
      if (brandId != null) 'brand_id': brandId,
      if (type != null) 'type': type,
      if (packSize != null) 'pack_size': packSize,
      if (price != null) 'price': price,
      if (cost != null) 'cost': cost,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
      if (isActive != null) 'is_active': isActive,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (gstType != null) 'gst_type': gstType,
      if (gstRate != null) 'gst_rate': gstRate,
      if (imageUrl != null) 'image_url': imageUrl,
      if (localPath != null) 'local_path': localPath,
      if (description != null) 'description': description,
      if (discount != null) 'discount': discount,
      if (isPercentDiscount != null) 'is_percent_discount': isPercentDiscount,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? sku,
    Value<int?>? categoryId,
    Value<int?>? unitId,
    Value<int?>? brandId,
    Value<String?>? type,
    Value<String?>? packSize,
    Value<double>? price,
    Value<double?>? cost,
    Value<int>? stockQuantity,
    Value<bool>? isActive,
    Value<int>? tenantId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? gstType,
    Value<String?>? gstRate,
    Value<String?>? imageUrl,
    Value<String?>? localPath,
    Value<String?>? description,
    Value<double>? discount,
    Value<bool>? isPercentDiscount,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      categoryId: categoryId ?? this.categoryId,
      unitId: unitId ?? this.unitId,
      brandId: brandId ?? this.brandId,
      type: type ?? this.type,
      packSize: packSize ?? this.packSize,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isActive: isActive ?? this.isActive,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gstType: gstType ?? this.gstType,
      gstRate: gstRate ?? this.gstRate,
      imageUrl: imageUrl ?? this.imageUrl,
      localPath: localPath ?? this.localPath,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      isPercentDiscount: isPercentDiscount ?? this.isPercentDiscount,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (brandId.present) {
      map['brand_id'] = Variable<int>(brandId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (packSize.present) {
      map['pack_size'] = Variable<String>(packSize.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<int>(stockQuantity.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (gstType.present) {
      map['gst_type'] = Variable<String>(gstType.value);
    }
    if (gstRate.present) {
      map['gst_rate'] = Variable<String>(gstRate.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (isPercentDiscount.present) {
      map['is_percent_discount'] = Variable<bool>(isPercentDiscount.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('categoryId: $categoryId, ')
          ..write('unitId: $unitId, ')
          ..write('brandId: $brandId, ')
          ..write('type: $type, ')
          ..write('packSize: $packSize, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('isActive: $isActive, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('gstType: $gstType, ')
          ..write('gstRate: $gstRate, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localPath: $localPath, ')
          ..write('description: $description, ')
          ..write('discount: $discount, ')
          ..write('isPercentDiscount: $isPercentDiscount, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subcategoryMeta = const VerificationMeta(
    'subcategory',
  );
  @override
  late final GeneratedColumn<String> subcategory = GeneratedColumn<String>(
    'subcategory',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    subcategory,
    description,
    isActive,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('subcategory')) {
      context.handle(
        _subcategoryMeta,
        subcategory.isAcceptableOrUnknown(
          data['subcategory']!,
          _subcategoryMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      subcategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subcategory'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryEntity extends DataClass implements Insertable<CategoryEntity> {
  final int id;
  final String uuid;
  final String name;
  final String? subcategory;
  final String? description;
  final bool isActive;
  final int tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncStatus;
  final bool isDeleted;
  const CategoryEntity({
    required this.id,
    required this.uuid,
    required this.name,
    this.subcategory,
    this.description,
    required this.isActive,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || subcategory != null) {
      map['subcategory'] = Variable<String>(subcategory);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['tenant_id'] = Variable<int>(tenantId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      subcategory: subcategory == null && nullToAbsent
          ? const Value.absent()
          : Value(subcategory),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory CategoryEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      subcategory: serializer.fromJson<String?>(json['subcategory']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'subcategory': serializer.toJson<String?>(subcategory),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'tenantId': serializer.toJson<int>(tenantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  CategoryEntity copyWith({
    int? id,
    String? uuid,
    String? name,
    Value<String?> subcategory = const Value.absent(),
    Value<String?> description = const Value.absent(),
    bool? isActive,
    int? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatus,
    bool? isDeleted,
  }) => CategoryEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    subcategory: subcategory.present ? subcategory.value : this.subcategory,
    description: description.present ? description.value : this.description,
    isActive: isActive ?? this.isActive,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  CategoryEntity copyWithCompanion(CategoriesCompanion data) {
    return CategoryEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      subcategory: data.subcategory.present
          ? data.subcategory.value
          : this.subcategory,
      description: data.description.present
          ? data.description.value
          : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('subcategory: $subcategory, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    subcategory,
    description,
    isActive,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.subcategory == this.subcategory &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class CategoriesCompanion extends UpdateCompanion<CategoryEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> subcategory;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<int> tenantId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.subcategory = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.subcategory = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    required int tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       tenantId = Value(tenantId);
  static Insertable<CategoryEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? subcategory,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<int>? tenantId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (subcategory != null) 'subcategory': subcategory,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? subcategory,
    Value<String?>? description,
    Value<bool>? isActive,
    Value<int>? tenantId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      subcategory: subcategory ?? this.subcategory,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (subcategory.present) {
      map['subcategory'] = Variable<String>(subcategory.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('subcategory: $subcategory, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $UnitsTable extends Units with TableInfo<$UnitsTable, UnitEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    symbol,
    isActive,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'units';
  @override
  VerificationContext validateIntegrity(
    Insertable<UnitEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UnitEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $UnitsTable createAlias(String alias) {
    return $UnitsTable(attachedDatabase, alias);
  }
}

class UnitEntity extends DataClass implements Insertable<UnitEntity> {
  final int id;
  final String uuid;
  final String name;
  final String symbol;
  final bool isActive;
  final int tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncStatus;
  final bool isDeleted;
  const UnitEntity({
    required this.id,
    required this.uuid,
    required this.name,
    required this.symbol,
    required this.isActive,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['symbol'] = Variable<String>(symbol);
    map['is_active'] = Variable<bool>(isActive);
    map['tenant_id'] = Variable<int>(tenantId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  UnitsCompanion toCompanion(bool nullToAbsent) {
    return UnitsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      symbol: Value(symbol),
      isActive: Value(isActive),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory UnitEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      symbol: serializer.fromJson<String>(json['symbol']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'symbol': serializer.toJson<String>(symbol),
      'isActive': serializer.toJson<bool>(isActive),
      'tenantId': serializer.toJson<int>(tenantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  UnitEntity copyWith({
    int? id,
    String? uuid,
    String? name,
    String? symbol,
    bool? isActive,
    int? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatus,
    bool? isDeleted,
  }) => UnitEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    symbol: symbol ?? this.symbol,
    isActive: isActive ?? this.isActive,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  UnitEntity copyWithCompanion(UnitsCompanion data) {
    return UnitEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('isActive: $isActive, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    symbol,
    isActive,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.symbol == this.symbol &&
          other.isActive == this.isActive &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class UnitsCompanion extends UpdateCompanion<UnitEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String> symbol;
  final Value<bool> isActive;
  final Value<int> tenantId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const UnitsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.symbol = const Value.absent(),
    this.isActive = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  UnitsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    required String symbol,
    this.isActive = const Value.absent(),
    required int tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       symbol = Value(symbol),
       tenantId = Value(tenantId);
  static Insertable<UnitEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? symbol,
    Expression<bool>? isActive,
    Expression<int>? tenantId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (symbol != null) 'symbol': symbol,
      if (isActive != null) 'is_active': isActive,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  UnitsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String>? symbol,
    Value<bool>? isActive,
    Value<int>? tenantId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return UnitsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      isActive: isActive ?? this.isActive,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('isActive: $isActive, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $TenantsTable extends Tenants
    with TableInfo<$TenantsTable, TenantEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TenantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _businessNameMeta = const VerificationMeta(
    'businessName',
  );
  @override
  late final GeneratedColumn<String> businessName = GeneratedColumn<String>(
    'business_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _businessAddressMeta = const VerificationMeta(
    'businessAddress',
  );
  @override
  late final GeneratedColumn<String> businessAddress = GeneratedColumn<String>(
    'business_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxIdMeta = const VerificationMeta('taxId');
  @override
  late final GeneratedColumn<String> taxId = GeneratedColumn<String>(
    'tax_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    email,
    businessName,
    businessAddress,
    taxId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tenants';
  @override
  VerificationContext validateIntegrity(
    Insertable<TenantEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('business_name')) {
      context.handle(
        _businessNameMeta,
        businessName.isAcceptableOrUnknown(
          data['business_name']!,
          _businessNameMeta,
        ),
      );
    }
    if (data.containsKey('business_address')) {
      context.handle(
        _businessAddressMeta,
        businessAddress.isAcceptableOrUnknown(
          data['business_address']!,
          _businessAddressMeta,
        ),
      );
    }
    if (data.containsKey('tax_id')) {
      context.handle(
        _taxIdMeta,
        taxId.isAcceptableOrUnknown(data['tax_id']!, _taxIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TenantEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TenantEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      businessName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_name'],
      ),
      businessAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_address'],
      ),
      taxId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $TenantsTable createAlias(String alias) {
    return $TenantsTable(attachedDatabase, alias);
  }
}

class TenantEntity extends DataClass implements Insertable<TenantEntity> {
  final int id;
  final String uuid;
  final String name;
  final String? email;
  final String? businessName;
  final String? businessAddress;
  final String? taxId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncStatus;
  final bool isDeleted;
  const TenantEntity({
    required this.id,
    required this.uuid,
    required this.name,
    this.email,
    this.businessName,
    this.businessAddress,
    this.taxId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || businessName != null) {
      map['business_name'] = Variable<String>(businessName);
    }
    if (!nullToAbsent || businessAddress != null) {
      map['business_address'] = Variable<String>(businessAddress);
    }
    if (!nullToAbsent || taxId != null) {
      map['tax_id'] = Variable<String>(taxId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  TenantsCompanion toCompanion(bool nullToAbsent) {
    return TenantsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      businessName: businessName == null && nullToAbsent
          ? const Value.absent()
          : Value(businessName),
      businessAddress: businessAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(businessAddress),
      taxId: taxId == null && nullToAbsent
          ? const Value.absent()
          : Value(taxId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory TenantEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TenantEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      businessName: serializer.fromJson<String?>(json['businessName']),
      businessAddress: serializer.fromJson<String?>(json['businessAddress']),
      taxId: serializer.fromJson<String?>(json['taxId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'businessName': serializer.toJson<String?>(businessName),
      'businessAddress': serializer.toJson<String?>(businessAddress),
      'taxId': serializer.toJson<String?>(taxId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  TenantEntity copyWith({
    int? id,
    String? uuid,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> businessName = const Value.absent(),
    Value<String?> businessAddress = const Value.absent(),
    Value<String?> taxId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatus,
    bool? isDeleted,
  }) => TenantEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    businessName: businessName.present ? businessName.value : this.businessName,
    businessAddress: businessAddress.present
        ? businessAddress.value
        : this.businessAddress,
    taxId: taxId.present ? taxId.value : this.taxId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  TenantEntity copyWithCompanion(TenantsCompanion data) {
    return TenantEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      businessName: data.businessName.present
          ? data.businessName.value
          : this.businessName,
      businessAddress: data.businessAddress.present
          ? data.businessAddress.value
          : this.businessAddress,
      taxId: data.taxId.present ? data.taxId.value : this.taxId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TenantEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('businessName: $businessName, ')
          ..write('businessAddress: $businessAddress, ')
          ..write('taxId: $taxId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    email,
    businessName,
    businessAddress,
    taxId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TenantEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.email == this.email &&
          other.businessName == this.businessName &&
          other.businessAddress == this.businessAddress &&
          other.taxId == this.taxId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class TenantsCompanion extends UpdateCompanion<TenantEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> businessName;
  final Value<String?> businessAddress;
  final Value<String?> taxId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const TenantsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.businessName = const Value.absent(),
    this.businessAddress = const Value.absent(),
    this.taxId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  TenantsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.email = const Value.absent(),
    this.businessName = const Value.absent(),
    this.businessAddress = const Value.absent(),
    this.taxId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name);
  static Insertable<TenantEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? businessName,
    Expression<String>? businessAddress,
    Expression<String>? taxId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (businessName != null) 'business_name': businessName,
      if (businessAddress != null) 'business_address': businessAddress,
      if (taxId != null) 'tax_id': taxId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  TenantsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? businessName,
    Value<String?>? businessAddress,
    Value<String?>? taxId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return TenantsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      email: email ?? this.email,
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      taxId: taxId ?? this.taxId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (businessName.present) {
      map['business_name'] = Variable<String>(businessName.value);
    }
    if (businessAddress.present) {
      map['business_address'] = Variable<String>(businessAddress.value);
    }
    if (taxId.present) {
      map['tax_id'] = Variable<String>(taxId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TenantsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('businessName: $businessName, ')
          ..write('businessAddress: $businessAddress, ')
          ..write('taxId: $taxId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, CustomerEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creditLimitMeta = const VerificationMeta(
    'creditLimit',
  );
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
    'credit_limit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _currentBalanceMeta = const VerificationMeta(
    'currentBalance',
  );
  @override
  late final GeneratedColumn<double> currentBalance = GeneratedColumn<double>(
    'current_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    email,
    phone,
    address,
    creditLimit,
    currentBalance,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
        _creditLimitMeta,
        creditLimit.isAcceptableOrUnknown(
          data['credit_limit']!,
          _creditLimitMeta,
        ),
      );
    }
    if (data.containsKey('current_balance')) {
      context.handle(
        _currentBalanceMeta,
        currentBalance.isAcceptableOrUnknown(
          data['current_balance']!,
          _currentBalanceMeta,
        ),
      );
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      creditLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_limit'],
      )!,
      currentBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_balance'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class CustomerEntity extends DataClass implements Insertable<CustomerEntity> {
  final int id;
  final String uuid;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final double creditLimit;
  final double currentBalance;
  final int tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncStatus;
  final bool isDeleted;
  const CustomerEntity({
    required this.id,
    required this.uuid,
    required this.name,
    this.email,
    this.phone,
    this.address,
    required this.creditLimit,
    required this.currentBalance,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['credit_limit'] = Variable<double>(creditLimit);
    map['current_balance'] = Variable<double>(currentBalance);
    map['tenant_id'] = Variable<int>(tenantId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      creditLimit: Value(creditLimit),
      currentBalance: Value(currentBalance),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory CustomerEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      creditLimit: serializer.fromJson<double>(json['creditLimit']),
      currentBalance: serializer.fromJson<double>(json['currentBalance']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'creditLimit': serializer.toJson<double>(creditLimit),
      'currentBalance': serializer.toJson<double>(currentBalance),
      'tenantId': serializer.toJson<int>(tenantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  CustomerEntity copyWith({
    int? id,
    String? uuid,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    double? creditLimit,
    double? currentBalance,
    int? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatus,
    bool? isDeleted,
  }) => CustomerEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    creditLimit: creditLimit ?? this.creditLimit,
    currentBalance: currentBalance ?? this.currentBalance,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  CustomerEntity copyWithCompanion(CustomersCompanion data) {
    return CustomerEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      creditLimit: data.creditLimit.present
          ? data.creditLimit.value
          : this.creditLimit,
      currentBalance: data.currentBalance.present
          ? data.currentBalance.value
          : this.currentBalance,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    email,
    phone,
    address,
    creditLimit,
    currentBalance,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.creditLimit == this.creditLimit &&
          other.currentBalance == this.currentBalance &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class CustomersCompanion extends UpdateCompanion<CustomerEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<double> creditLimit;
  final Value<double> currentBalance;
  final Value<int> tenantId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.currentBalance = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.currentBalance = const Value.absent(),
    required int tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       tenantId = Value(tenantId);
  static Insertable<CustomerEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<double>? creditLimit,
    Expression<double>? currentBalance,
    Expression<int>? tenantId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (currentBalance != null) 'current_balance': currentBalance,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? address,
    Value<double>? creditLimit,
    Value<double>? currentBalance,
    Value<int>? tenantId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      creditLimit: creditLimit ?? this.creditLimit,
      currentBalance: currentBalance ?? this.currentBalance,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    if (currentBalance.present) {
      map['current_balance'] = Variable<double>(currentBalance.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, SupplierEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    email,
    phone,
    address,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class SupplierEntity extends DataClass implements Insertable<SupplierEntity> {
  final int id;
  final String uuid;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final int tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncStatus;
  final bool isDeleted;
  const SupplierEntity({
    required this.id,
    required this.uuid,
    required this.name,
    this.email,
    this.phone,
    this.address,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['tenant_id'] = Variable<int>(tenantId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory SupplierEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'tenantId': serializer.toJson<int>(tenantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  SupplierEntity copyWith({
    int? id,
    String? uuid,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    int? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatus,
    bool? isDeleted,
  }) => SupplierEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  SupplierEntity copyWithCompanion(SuppliersCompanion data) {
    return SupplierEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    email,
    phone,
    address,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class SuppliersCompanion extends UpdateCompanion<SupplierEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<int> tenantId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    required int tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       tenantId = Value(tenantId);
  static Insertable<SupplierEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<int>? tenantId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  SuppliersCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? address,
    Value<int>? tenantId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, EmployeeEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _salaryMeta = const VerificationMeta('salary');
  @override
  late final GeneratedColumn<double> salary = GeneratedColumn<double>(
    'salary',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('employee'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _googleAuthMeta = const VerificationMeta(
    'googleAuth',
  );
  @override
  late final GeneratedColumn<bool> googleAuth = GeneratedColumn<bool>(
    'google_auth',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("google_auth" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    email,
    phone,
    address,
    position,
    salary,
    role,
    password,
    googleAuth,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmployeeEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('salary')) {
      context.handle(
        _salaryMeta,
        salary.isAcceptableOrUnknown(data['salary']!, _salaryMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    }
    if (data.containsKey('google_auth')) {
      context.handle(
        _googleAuthMeta,
        googleAuth.isAcceptableOrUnknown(data['google_auth']!, _googleAuthMeta),
      );
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmployeeEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeeEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      ),
      salary: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}salary'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      ),
      googleAuth: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}google_auth'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class EmployeeEntity extends DataClass implements Insertable<EmployeeEntity> {
  final int id;
  final String uuid;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? position;
  final double? salary;
  final String role;
  final String? password;
  final bool googleAuth;
  final int tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncStatus;
  final bool isDeleted;
  const EmployeeEntity({
    required this.id,
    required this.uuid,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.position,
    this.salary,
    required this.role,
    this.password,
    required this.googleAuth,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    if (!nullToAbsent || salary != null) {
      map['salary'] = Variable<double>(salary);
    }
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    map['google_auth'] = Variable<bool>(googleAuth);
    map['tenant_id'] = Variable<int>(tenantId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      salary: salary == null && nullToAbsent
          ? const Value.absent()
          : Value(salary),
      role: Value(role),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      googleAuth: Value(googleAuth),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory EmployeeEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeeEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      position: serializer.fromJson<String?>(json['position']),
      salary: serializer.fromJson<double?>(json['salary']),
      role: serializer.fromJson<String>(json['role']),
      password: serializer.fromJson<String?>(json['password']),
      googleAuth: serializer.fromJson<bool>(json['googleAuth']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'position': serializer.toJson<String?>(position),
      'salary': serializer.toJson<double?>(salary),
      'role': serializer.toJson<String>(role),
      'password': serializer.toJson<String?>(password),
      'googleAuth': serializer.toJson<bool>(googleAuth),
      'tenantId': serializer.toJson<int>(tenantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  EmployeeEntity copyWith({
    int? id,
    String? uuid,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> position = const Value.absent(),
    Value<double?> salary = const Value.absent(),
    String? role,
    Value<String?> password = const Value.absent(),
    bool? googleAuth,
    int? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatus,
    bool? isDeleted,
  }) => EmployeeEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    position: position.present ? position.value : this.position,
    salary: salary.present ? salary.value : this.salary,
    role: role ?? this.role,
    password: password.present ? password.value : this.password,
    googleAuth: googleAuth ?? this.googleAuth,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  EmployeeEntity copyWithCompanion(EmployeesCompanion data) {
    return EmployeeEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      position: data.position.present ? data.position.value : this.position,
      salary: data.salary.present ? data.salary.value : this.salary,
      role: data.role.present ? data.role.value : this.role,
      password: data.password.present ? data.password.value : this.password,
      googleAuth: data.googleAuth.present
          ? data.googleAuth.value
          : this.googleAuth,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('position: $position, ')
          ..write('salary: $salary, ')
          ..write('role: $role, ')
          ..write('password: $password, ')
          ..write('googleAuth: $googleAuth, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    email,
    phone,
    address,
    position,
    salary,
    role,
    password,
    googleAuth,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeeEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.position == this.position &&
          other.salary == this.salary &&
          other.role == this.role &&
          other.password == this.password &&
          other.googleAuth == this.googleAuth &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class EmployeesCompanion extends UpdateCompanion<EmployeeEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> position;
  final Value<double?> salary;
  final Value<String> role;
  final Value<String?> password;
  final Value<bool> googleAuth;
  final Value<int> tenantId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.position = const Value.absent(),
    this.salary = const Value.absent(),
    this.role = const Value.absent(),
    this.password = const Value.absent(),
    this.googleAuth = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.position = const Value.absent(),
    this.salary = const Value.absent(),
    this.role = const Value.absent(),
    this.password = const Value.absent(),
    this.googleAuth = const Value.absent(),
    required int tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       tenantId = Value(tenantId);
  static Insertable<EmployeeEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? position,
    Expression<double>? salary,
    Expression<String>? role,
    Expression<String>? password,
    Expression<bool>? googleAuth,
    Expression<int>? tenantId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (position != null) 'position': position,
      if (salary != null) 'salary': salary,
      if (role != null) 'role': role,
      if (password != null) 'password': password,
      if (googleAuth != null) 'google_auth': googleAuth,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  EmployeesCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? address,
    Value<String?>? position,
    Value<double?>? salary,
    Value<String>? role,
    Value<String?>? password,
    Value<bool>? googleAuth,
    Value<int>? tenantId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return EmployeesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      position: position ?? this.position,
      salary: salary ?? this.salary,
      role: role ?? this.role,
      password: password ?? this.password,
      googleAuth: googleAuth ?? this.googleAuth,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (salary.present) {
      map['salary'] = Variable<double>(salary.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (googleAuth.present) {
      map['google_auth'] = Variable<bool>(googleAuth.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('position: $position, ')
          ..write('salary: $salary, ')
          ..write('role: $role, ')
          ..write('password: $password, ')
          ..write('googleAuth: $googleAuth, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $InvoiceSettingsTable extends InvoiceSettings
    with TableInfo<$InvoiceSettingsTable, InvoiceSettingEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _layoutMeta = const VerificationMeta('layout');
  @override
  late final GeneratedColumn<String> layout = GeneratedColumn<String>(
    'layout',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _footerMessageMeta = const VerificationMeta(
    'footerMessage',
  );
  @override
  late final GeneratedColumn<String> footerMessage = GeneratedColumn<String>(
    'footer_message',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accentColorMeta = const VerificationMeta(
    'accentColor',
  );
  @override
  late final GeneratedColumn<String> accentColor = GeneratedColumn<String>(
    'accent_color',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#2A2D64'),
  );
  static const VerificationMeta _fontFamilyMeta = const VerificationMeta(
    'fontFamily',
  );
  @override
  late final GeneratedColumn<String> fontFamily = GeneratedColumn<String>(
    'font_family',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Roboto'),
  );
  static const VerificationMeta _fontSizeMultiplierMeta =
      const VerificationMeta('fontSizeMultiplier');
  @override
  late final GeneratedColumn<double> fontSizeMultiplier =
      GeneratedColumn<double>(
        'font_size_multiplier',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(1.0),
      );
  static const VerificationMeta _showAddressMeta = const VerificationMeta(
    'showAddress',
  );
  @override
  late final GeneratedColumn<bool> showAddress = GeneratedColumn<bool>(
    'show_address',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_address" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showCustomerDetailsMeta =
      const VerificationMeta('showCustomerDetails');
  @override
  late final GeneratedColumn<bool> showCustomerDetails = GeneratedColumn<bool>(
    'show_customer_details',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_customer_details" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _showFooterMeta = const VerificationMeta(
    'showFooter',
  );
  @override
  late final GeneratedColumn<bool> showFooter = GeneratedColumn<bool>(
    'show_footer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_footer" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _customConfigMeta = const VerificationMeta(
    'customConfig',
  );
  @override
  late final GeneratedColumn<String> customConfig = GeneratedColumn<String>(
    'custom_config',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    layout,
    footerMessage,
    accentColor,
    fontFamily,
    fontSizeMultiplier,
    showAddress,
    showCustomerDetails,
    showFooter,
    customConfig,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceSettingEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('layout')) {
      context.handle(
        _layoutMeta,
        layout.isAcceptableOrUnknown(data['layout']!, _layoutMeta),
      );
    } else if (isInserting) {
      context.missing(_layoutMeta);
    }
    if (data.containsKey('footer_message')) {
      context.handle(
        _footerMessageMeta,
        footerMessage.isAcceptableOrUnknown(
          data['footer_message']!,
          _footerMessageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_footerMessageMeta);
    }
    if (data.containsKey('accent_color')) {
      context.handle(
        _accentColorMeta,
        accentColor.isAcceptableOrUnknown(
          data['accent_color']!,
          _accentColorMeta,
        ),
      );
    }
    if (data.containsKey('font_family')) {
      context.handle(
        _fontFamilyMeta,
        fontFamily.isAcceptableOrUnknown(data['font_family']!, _fontFamilyMeta),
      );
    }
    if (data.containsKey('font_size_multiplier')) {
      context.handle(
        _fontSizeMultiplierMeta,
        fontSizeMultiplier.isAcceptableOrUnknown(
          data['font_size_multiplier']!,
          _fontSizeMultiplierMeta,
        ),
      );
    }
    if (data.containsKey('show_address')) {
      context.handle(
        _showAddressMeta,
        showAddress.isAcceptableOrUnknown(
          data['show_address']!,
          _showAddressMeta,
        ),
      );
    }
    if (data.containsKey('show_customer_details')) {
      context.handle(
        _showCustomerDetailsMeta,
        showCustomerDetails.isAcceptableOrUnknown(
          data['show_customer_details']!,
          _showCustomerDetailsMeta,
        ),
      );
    }
    if (data.containsKey('show_footer')) {
      context.handle(
        _showFooterMeta,
        showFooter.isAcceptableOrUnknown(data['show_footer']!, _showFooterMeta),
      );
    }
    if (data.containsKey('custom_config')) {
      context.handle(
        _customConfigMeta,
        customConfig.isAcceptableOrUnknown(
          data['custom_config']!,
          _customConfigMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceSettingEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceSettingEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      layout: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}layout'],
      )!,
      footerMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}footer_message'],
      )!,
      accentColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent_color'],
      )!,
      fontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}font_family'],
      )!,
      fontSizeMultiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}font_size_multiplier'],
      )!,
      showAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_address'],
      )!,
      showCustomerDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_customer_details'],
      )!,
      showFooter: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_footer'],
      )!,
      customConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_config'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InvoiceSettingsTable createAlias(String alias) {
    return $InvoiceSettingsTable(attachedDatabase, alias);
  }
}

class InvoiceSettingEntity extends DataClass
    implements Insertable<InvoiceSettingEntity> {
  final int id;
  final String layout;
  final String footerMessage;
  final String accentColor;
  final String fontFamily;
  final double fontSizeMultiplier;
  final bool showAddress;
  final bool showCustomerDetails;
  final bool showFooter;
  final String? customConfig;
  final DateTime updatedAt;
  const InvoiceSettingEntity({
    required this.id,
    required this.layout,
    required this.footerMessage,
    required this.accentColor,
    required this.fontFamily,
    required this.fontSizeMultiplier,
    required this.showAddress,
    required this.showCustomerDetails,
    required this.showFooter,
    this.customConfig,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['layout'] = Variable<String>(layout);
    map['footer_message'] = Variable<String>(footerMessage);
    map['accent_color'] = Variable<String>(accentColor);
    map['font_family'] = Variable<String>(fontFamily);
    map['font_size_multiplier'] = Variable<double>(fontSizeMultiplier);
    map['show_address'] = Variable<bool>(showAddress);
    map['show_customer_details'] = Variable<bool>(showCustomerDetails);
    map['show_footer'] = Variable<bool>(showFooter);
    if (!nullToAbsent || customConfig != null) {
      map['custom_config'] = Variable<String>(customConfig);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InvoiceSettingsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceSettingsCompanion(
      id: Value(id),
      layout: Value(layout),
      footerMessage: Value(footerMessage),
      accentColor: Value(accentColor),
      fontFamily: Value(fontFamily),
      fontSizeMultiplier: Value(fontSizeMultiplier),
      showAddress: Value(showAddress),
      showCustomerDetails: Value(showCustomerDetails),
      showFooter: Value(showFooter),
      customConfig: customConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(customConfig),
      updatedAt: Value(updatedAt),
    );
  }

  factory InvoiceSettingEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceSettingEntity(
      id: serializer.fromJson<int>(json['id']),
      layout: serializer.fromJson<String>(json['layout']),
      footerMessage: serializer.fromJson<String>(json['footerMessage']),
      accentColor: serializer.fromJson<String>(json['accentColor']),
      fontFamily: serializer.fromJson<String>(json['fontFamily']),
      fontSizeMultiplier: serializer.fromJson<double>(
        json['fontSizeMultiplier'],
      ),
      showAddress: serializer.fromJson<bool>(json['showAddress']),
      showCustomerDetails: serializer.fromJson<bool>(
        json['showCustomerDetails'],
      ),
      showFooter: serializer.fromJson<bool>(json['showFooter']),
      customConfig: serializer.fromJson<String?>(json['customConfig']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'layout': serializer.toJson<String>(layout),
      'footerMessage': serializer.toJson<String>(footerMessage),
      'accentColor': serializer.toJson<String>(accentColor),
      'fontFamily': serializer.toJson<String>(fontFamily),
      'fontSizeMultiplier': serializer.toJson<double>(fontSizeMultiplier),
      'showAddress': serializer.toJson<bool>(showAddress),
      'showCustomerDetails': serializer.toJson<bool>(showCustomerDetails),
      'showFooter': serializer.toJson<bool>(showFooter),
      'customConfig': serializer.toJson<String?>(customConfig),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InvoiceSettingEntity copyWith({
    int? id,
    String? layout,
    String? footerMessage,
    String? accentColor,
    String? fontFamily,
    double? fontSizeMultiplier,
    bool? showAddress,
    bool? showCustomerDetails,
    bool? showFooter,
    Value<String?> customConfig = const Value.absent(),
    DateTime? updatedAt,
  }) => InvoiceSettingEntity(
    id: id ?? this.id,
    layout: layout ?? this.layout,
    footerMessage: footerMessage ?? this.footerMessage,
    accentColor: accentColor ?? this.accentColor,
    fontFamily: fontFamily ?? this.fontFamily,
    fontSizeMultiplier: fontSizeMultiplier ?? this.fontSizeMultiplier,
    showAddress: showAddress ?? this.showAddress,
    showCustomerDetails: showCustomerDetails ?? this.showCustomerDetails,
    showFooter: showFooter ?? this.showFooter,
    customConfig: customConfig.present ? customConfig.value : this.customConfig,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InvoiceSettingEntity copyWithCompanion(InvoiceSettingsCompanion data) {
    return InvoiceSettingEntity(
      id: data.id.present ? data.id.value : this.id,
      layout: data.layout.present ? data.layout.value : this.layout,
      footerMessage: data.footerMessage.present
          ? data.footerMessage.value
          : this.footerMessage,
      accentColor: data.accentColor.present
          ? data.accentColor.value
          : this.accentColor,
      fontFamily: data.fontFamily.present
          ? data.fontFamily.value
          : this.fontFamily,
      fontSizeMultiplier: data.fontSizeMultiplier.present
          ? data.fontSizeMultiplier.value
          : this.fontSizeMultiplier,
      showAddress: data.showAddress.present
          ? data.showAddress.value
          : this.showAddress,
      showCustomerDetails: data.showCustomerDetails.present
          ? data.showCustomerDetails.value
          : this.showCustomerDetails,
      showFooter: data.showFooter.present
          ? data.showFooter.value
          : this.showFooter,
      customConfig: data.customConfig.present
          ? data.customConfig.value
          : this.customConfig,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceSettingEntity(')
          ..write('id: $id, ')
          ..write('layout: $layout, ')
          ..write('footerMessage: $footerMessage, ')
          ..write('accentColor: $accentColor, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('fontSizeMultiplier: $fontSizeMultiplier, ')
          ..write('showAddress: $showAddress, ')
          ..write('showCustomerDetails: $showCustomerDetails, ')
          ..write('showFooter: $showFooter, ')
          ..write('customConfig: $customConfig, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    layout,
    footerMessage,
    accentColor,
    fontFamily,
    fontSizeMultiplier,
    showAddress,
    showCustomerDetails,
    showFooter,
    customConfig,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceSettingEntity &&
          other.id == this.id &&
          other.layout == this.layout &&
          other.footerMessage == this.footerMessage &&
          other.accentColor == this.accentColor &&
          other.fontFamily == this.fontFamily &&
          other.fontSizeMultiplier == this.fontSizeMultiplier &&
          other.showAddress == this.showAddress &&
          other.showCustomerDetails == this.showCustomerDetails &&
          other.showFooter == this.showFooter &&
          other.customConfig == this.customConfig &&
          other.updatedAt == this.updatedAt);
}

class InvoiceSettingsCompanion extends UpdateCompanion<InvoiceSettingEntity> {
  final Value<int> id;
  final Value<String> layout;
  final Value<String> footerMessage;
  final Value<String> accentColor;
  final Value<String> fontFamily;
  final Value<double> fontSizeMultiplier;
  final Value<bool> showAddress;
  final Value<bool> showCustomerDetails;
  final Value<bool> showFooter;
  final Value<String?> customConfig;
  final Value<DateTime> updatedAt;
  const InvoiceSettingsCompanion({
    this.id = const Value.absent(),
    this.layout = const Value.absent(),
    this.footerMessage = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.fontSizeMultiplier = const Value.absent(),
    this.showAddress = const Value.absent(),
    this.showCustomerDetails = const Value.absent(),
    this.showFooter = const Value.absent(),
    this.customConfig = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InvoiceSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String layout,
    required String footerMessage,
    this.accentColor = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.fontSizeMultiplier = const Value.absent(),
    this.showAddress = const Value.absent(),
    this.showCustomerDetails = const Value.absent(),
    this.showFooter = const Value.absent(),
    this.customConfig = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : layout = Value(layout),
       footerMessage = Value(footerMessage);
  static Insertable<InvoiceSettingEntity> custom({
    Expression<int>? id,
    Expression<String>? layout,
    Expression<String>? footerMessage,
    Expression<String>? accentColor,
    Expression<String>? fontFamily,
    Expression<double>? fontSizeMultiplier,
    Expression<bool>? showAddress,
    Expression<bool>? showCustomerDetails,
    Expression<bool>? showFooter,
    Expression<String>? customConfig,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (layout != null) 'layout': layout,
      if (footerMessage != null) 'footer_message': footerMessage,
      if (accentColor != null) 'accent_color': accentColor,
      if (fontFamily != null) 'font_family': fontFamily,
      if (fontSizeMultiplier != null)
        'font_size_multiplier': fontSizeMultiplier,
      if (showAddress != null) 'show_address': showAddress,
      if (showCustomerDetails != null)
        'show_customer_details': showCustomerDetails,
      if (showFooter != null) 'show_footer': showFooter,
      if (customConfig != null) 'custom_config': customConfig,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InvoiceSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? layout,
    Value<String>? footerMessage,
    Value<String>? accentColor,
    Value<String>? fontFamily,
    Value<double>? fontSizeMultiplier,
    Value<bool>? showAddress,
    Value<bool>? showCustomerDetails,
    Value<bool>? showFooter,
    Value<String?>? customConfig,
    Value<DateTime>? updatedAt,
  }) {
    return InvoiceSettingsCompanion(
      id: id ?? this.id,
      layout: layout ?? this.layout,
      footerMessage: footerMessage ?? this.footerMessage,
      accentColor: accentColor ?? this.accentColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSizeMultiplier: fontSizeMultiplier ?? this.fontSizeMultiplier,
      showAddress: showAddress ?? this.showAddress,
      showCustomerDetails: showCustomerDetails ?? this.showCustomerDetails,
      showFooter: showFooter ?? this.showFooter,
      customConfig: customConfig ?? this.customConfig,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (layout.present) {
      map['layout'] = Variable<String>(layout.value);
    }
    if (footerMessage.present) {
      map['footer_message'] = Variable<String>(footerMessage.value);
    }
    if (accentColor.present) {
      map['accent_color'] = Variable<String>(accentColor.value);
    }
    if (fontFamily.present) {
      map['font_family'] = Variable<String>(fontFamily.value);
    }
    if (fontSizeMultiplier.present) {
      map['font_size_multiplier'] = Variable<double>(fontSizeMultiplier.value);
    }
    if (showAddress.present) {
      map['show_address'] = Variable<bool>(showAddress.value);
    }
    if (showCustomerDetails.present) {
      map['show_customer_details'] = Variable<bool>(showCustomerDetails.value);
    }
    if (showFooter.present) {
      map['show_footer'] = Variable<bool>(showFooter.value);
    }
    if (customConfig.present) {
      map['custom_config'] = Variable<String>(customConfig.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceSettingsCompanion(')
          ..write('id: $id, ')
          ..write('layout: $layout, ')
          ..write('footerMessage: $footerMessage, ')
          ..write('accentColor: $accentColor, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('fontSizeMultiplier: $fontSizeMultiplier, ')
          ..write('showAddress: $showAddress, ')
          ..write('showCustomerDetails: $showCustomerDetails, ')
          ..write('showFooter: $showFooter, ')
          ..write('customConfig: $customConfig, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices
    with TableInfo<$InvoicesTable, InvoiceEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _signUrlMeta = const VerificationMeta(
    'signUrl',
  );
  @override
  late final GeneratedColumn<String> signUrl = GeneratedColumn<String>(
    'sign_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    invoiceNumber,
    customerId,
    date,
    subtotal,
    tax,
    discount,
    total,
    signUrl,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('sign_url')) {
      context.handle(
        _signUrlMeta,
        signUrl.isAcceptableOrUnknown(data['sign_url']!, _signUrlMeta),
      );
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      signUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sign_url'],
      ),
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class InvoiceEntity extends DataClass implements Insertable<InvoiceEntity> {
  final int id;
  final String uuid;
  final String invoiceNumber;
  final int? customerId;
  final DateTime date;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;
  final String? signUrl;
  final int tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncStatus;
  final bool isDeleted;
  const InvoiceEntity({
    required this.id,
    required this.uuid,
    required this.invoiceNumber,
    this.customerId,
    required this.date,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.total,
    this.signUrl,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['date'] = Variable<DateTime>(date);
    map['subtotal'] = Variable<double>(subtotal);
    map['tax'] = Variable<double>(tax);
    map['discount'] = Variable<double>(discount);
    map['total'] = Variable<double>(total);
    if (!nullToAbsent || signUrl != null) {
      map['sign_url'] = Variable<String>(signUrl);
    }
    map['tenant_id'] = Variable<int>(tenantId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      invoiceNumber: Value(invoiceNumber),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      date: Value(date),
      subtotal: Value(subtotal),
      tax: Value(tax),
      discount: Value(discount),
      total: Value(total),
      signUrl: signUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(signUrl),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory InvoiceEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      date: serializer.fromJson<DateTime>(json['date']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      tax: serializer.fromJson<double>(json['tax']),
      discount: serializer.fromJson<double>(json['discount']),
      total: serializer.fromJson<double>(json['total']),
      signUrl: serializer.fromJson<String?>(json['signUrl']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'customerId': serializer.toJson<int?>(customerId),
      'date': serializer.toJson<DateTime>(date),
      'subtotal': serializer.toJson<double>(subtotal),
      'tax': serializer.toJson<double>(tax),
      'discount': serializer.toJson<double>(discount),
      'total': serializer.toJson<double>(total),
      'signUrl': serializer.toJson<String?>(signUrl),
      'tenantId': serializer.toJson<int>(tenantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  InvoiceEntity copyWith({
    int? id,
    String? uuid,
    String? invoiceNumber,
    Value<int?> customerId = const Value.absent(),
    DateTime? date,
    double? subtotal,
    double? tax,
    double? discount,
    double? total,
    Value<String?> signUrl = const Value.absent(),
    int? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatus,
    bool? isDeleted,
  }) => InvoiceEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    customerId: customerId.present ? customerId.value : this.customerId,
    date: date ?? this.date,
    subtotal: subtotal ?? this.subtotal,
    tax: tax ?? this.tax,
    discount: discount ?? this.discount,
    total: total ?? this.total,
    signUrl: signUrl.present ? signUrl.value : this.signUrl,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  InvoiceEntity copyWithCompanion(InvoicesCompanion data) {
    return InvoiceEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      date: data.date.present ? data.date.value : this.date,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      tax: data.tax.present ? data.tax.value : this.tax,
      discount: data.discount.present ? data.discount.value : this.discount,
      total: data.total.present ? data.total.value : this.total,
      signUrl: data.signUrl.present ? data.signUrl.value : this.signUrl,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('customerId: $customerId, ')
          ..write('date: $date, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('discount: $discount, ')
          ..write('total: $total, ')
          ..write('signUrl: $signUrl, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    invoiceNumber,
    customerId,
    date,
    subtotal,
    tax,
    discount,
    total,
    signUrl,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.invoiceNumber == this.invoiceNumber &&
          other.customerId == this.customerId &&
          other.date == this.date &&
          other.subtotal == this.subtotal &&
          other.tax == this.tax &&
          other.discount == this.discount &&
          other.total == this.total &&
          other.signUrl == this.signUrl &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class InvoicesCompanion extends UpdateCompanion<InvoiceEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> invoiceNumber;
  final Value<int?> customerId;
  final Value<DateTime> date;
  final Value<double> subtotal;
  final Value<double> tax;
  final Value<double> discount;
  final Value<double> total;
  final Value<String?> signUrl;
  final Value<int> tenantId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.date = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.tax = const Value.absent(),
    this.discount = const Value.absent(),
    this.total = const Value.absent(),
    this.signUrl = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String invoiceNumber,
    this.customerId = const Value.absent(),
    required DateTime date,
    required double subtotal,
    required double tax,
    this.discount = const Value.absent(),
    required double total,
    this.signUrl = const Value.absent(),
    required int tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       invoiceNumber = Value(invoiceNumber),
       date = Value(date),
       subtotal = Value(subtotal),
       tax = Value(tax),
       total = Value(total),
       tenantId = Value(tenantId);
  static Insertable<InvoiceEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? invoiceNumber,
    Expression<int>? customerId,
    Expression<DateTime>? date,
    Expression<double>? subtotal,
    Expression<double>? tax,
    Expression<double>? discount,
    Expression<double>? total,
    Expression<String>? signUrl,
    Expression<int>? tenantId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (customerId != null) 'customer_id': customerId,
      if (date != null) 'date': date,
      if (subtotal != null) 'subtotal': subtotal,
      if (tax != null) 'tax': tax,
      if (discount != null) 'discount': discount,
      if (total != null) 'total': total,
      if (signUrl != null) 'sign_url': signUrl,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? invoiceNumber,
    Value<int?>? customerId,
    Value<DateTime>? date,
    Value<double>? subtotal,
    Value<double>? tax,
    Value<double>? discount,
    Value<double>? total,
    Value<String?>? signUrl,
    Value<int>? tenantId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      customerId: customerId ?? this.customerId,
      date: date ?? this.date,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      signUrl: signUrl ?? this.signUrl,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (signUrl.present) {
      map['sign_url'] = Variable<String>(signUrl.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('customerId: $customerId, ')
          ..write('date: $date, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('discount: $discount, ')
          ..write('total: $total, ')
          ..write('signUrl: $signUrl, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsTable extends InvoiceItems
    with TableInfo<$InvoiceItemsTable, InvoiceItemEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bonusMeta = const VerificationMeta('bonus');
  @override
  late final GeneratedColumn<int> bonus = GeneratedColumn<int>(
    'bonus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    invoiceId,
    productId,
    quantity,
    bonus,
    unitPrice,
    discount,
    totalPrice,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItemEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('bonus')) {
      context.handle(
        _bonusMeta,
        bonus.isAcceptableOrUnknown(data['bonus']!, _bonusMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItemEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItemEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      bonus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bonus'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $InvoiceItemsTable createAlias(String alias) {
    return $InvoiceItemsTable(attachedDatabase, alias);
  }
}

class InvoiceItemEntity extends DataClass
    implements Insertable<InvoiceItemEntity> {
  final int id;
  final String uuid;
  final int invoiceId;
  final int productId;
  final int quantity;
  final int bonus;
  final double unitPrice;
  final double discount;
  final double totalPrice;
  final int tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncStatus;
  final bool isDeleted;
  const InvoiceItemEntity({
    required this.id,
    required this.uuid,
    required this.invoiceId,
    required this.productId,
    required this.quantity,
    required this.bonus,
    required this.unitPrice,
    required this.discount,
    required this.totalPrice,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['bonus'] = Variable<int>(bonus);
    map['unit_price'] = Variable<double>(unitPrice);
    map['discount'] = Variable<double>(discount);
    map['total_price'] = Variable<double>(totalPrice);
    map['tenant_id'] = Variable<int>(tenantId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  InvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      invoiceId: Value(invoiceId),
      productId: Value(productId),
      quantity: Value(quantity),
      bonus: Value(bonus),
      unitPrice: Value(unitPrice),
      discount: Value(discount),
      totalPrice: Value(totalPrice),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory InvoiceItemEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItemEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      bonus: serializer.fromJson<int>(json['bonus']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      discount: serializer.fromJson<double>(json['discount']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'bonus': serializer.toJson<int>(bonus),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'discount': serializer.toJson<double>(discount),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'tenantId': serializer.toJson<int>(tenantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  InvoiceItemEntity copyWith({
    int? id,
    String? uuid,
    int? invoiceId,
    int? productId,
    int? quantity,
    int? bonus,
    double? unitPrice,
    double? discount,
    double? totalPrice,
    int? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatus,
    bool? isDeleted,
  }) => InvoiceItemEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    invoiceId: invoiceId ?? this.invoiceId,
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    bonus: bonus ?? this.bonus,
    unitPrice: unitPrice ?? this.unitPrice,
    discount: discount ?? this.discount,
    totalPrice: totalPrice ?? this.totalPrice,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  InvoiceItemEntity copyWithCompanion(InvoiceItemsCompanion data) {
    return InvoiceItemEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      bonus: data.bonus.present ? data.bonus.value : this.bonus,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      discount: data.discount.present ? data.discount.value : this.discount,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('bonus: $bonus, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discount: $discount, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    invoiceId,
    productId,
    quantity,
    bonus,
    unitPrice,
    discount,
    totalPrice,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItemEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.bonus == this.bonus &&
          other.unitPrice == this.unitPrice &&
          other.discount == this.discount &&
          other.totalPrice == this.totalPrice &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class InvoiceItemsCompanion extends UpdateCompanion<InvoiceItemEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<int> invoiceId;
  final Value<int> productId;
  final Value<int> quantity;
  final Value<int> bonus;
  final Value<double> unitPrice;
  final Value<double> discount;
  final Value<double> totalPrice;
  final Value<int> tenantId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const InvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.bonus = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.discount = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required int invoiceId,
    required int productId,
    required int quantity,
    this.bonus = const Value.absent(),
    required double unitPrice,
    this.discount = const Value.absent(),
    required double totalPrice,
    required int tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       invoiceId = Value(invoiceId),
       productId = Value(productId),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       totalPrice = Value(totalPrice),
       tenantId = Value(tenantId);
  static Insertable<InvoiceItemEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? invoiceId,
    Expression<int>? productId,
    Expression<int>? quantity,
    Expression<int>? bonus,
    Expression<double>? unitPrice,
    Expression<double>? discount,
    Expression<double>? totalPrice,
    Expression<int>? tenantId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (bonus != null) 'bonus': bonus,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (discount != null) 'discount': discount,
      if (totalPrice != null) 'total_price': totalPrice,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  InvoiceItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<int>? invoiceId,
    Value<int>? productId,
    Value<int>? quantity,
    Value<int>? bonus,
    Value<double>? unitPrice,
    Value<double>? discount,
    Value<double>? totalPrice,
    Value<int>? tenantId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return InvoiceItemsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      bonus: bonus ?? this.bonus,
      unitPrice: unitPrice ?? this.unitPrice,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (bonus.present) {
      map['bonus'] = Variable<int>(bonus.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('bonus: $bonus, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discount: $discount, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $BrandsTable extends Brands with TableInfo<$BrandsTable, BrandEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrandsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    name,
    description,
    isActive,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brands';
  @override
  VerificationContext validateIntegrity(
    Insertable<BrandEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BrandEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrandEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $BrandsTable createAlias(String alias) {
    return $BrandsTable(attachedDatabase, alias);
  }
}

class BrandEntity extends DataClass implements Insertable<BrandEntity> {
  final int id;
  final String uuid;
  final String name;
  final String? description;
  final bool isActive;
  final int tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncStatus;
  final bool isDeleted;
  const BrandEntity({
    required this.id,
    required this.uuid,
    required this.name,
    this.description,
    required this.isActive,
    required this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['tenant_id'] = Variable<int>(tenantId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  BrandsCompanion toCompanion(bool nullToAbsent) {
    return BrandsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      tenantId: Value(tenantId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      isDeleted: Value(isDeleted),
    );
  }

  factory BrandEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrandEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'tenantId': serializer.toJson<int>(tenantId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  BrandEntity copyWith({
    int? id,
    String? uuid,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isActive,
    int? tenantId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncStatus,
    bool? isDeleted,
  }) => BrandEntity(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    isActive: isActive ?? this.isActive,
    tenantId: tenantId ?? this.tenantId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  BrandEntity copyWithCompanion(BrandsCompanion data) {
    return BrandEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrandEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    name,
    description,
    isActive,
    tenantId,
    createdAt,
    updatedAt,
    syncStatus,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrandEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.tenantId == this.tenantId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.isDeleted == this.isDeleted);
}

class BrandsCompanion extends UpdateCompanion<BrandEntity> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<int> tenantId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> syncStatus;
  final Value<bool> isDeleted;
  const BrandsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  BrandsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required String name,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    required int tenantId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : uuid = Value(uuid),
       name = Value(name),
       tenantId = Value(tenantId);
  static Insertable<BrandEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<int>? tenantId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? syncStatus,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (tenantId != null) 'tenant_id': tenantId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  BrandsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isActive,
    Value<int>? tenantId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? syncStatus,
    Value<bool>? isDeleted,
  }) {
    return BrandsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      tenantId: tenantId ?? this.tenantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrandsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('tenantId: $tenantId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataEntity(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataEntity extends DataClass
    implements Insertable<SyncMetadataEntity> {
  final String key;
  final String? value;
  final DateTime updatedAt;
  const SyncMetadataEntity({
    required this.key,
    this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncMetadataEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataEntity(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncMetadataEntity copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
    DateTime? updatedAt,
  }) => SyncMetadataEntity(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncMetadataEntity copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataEntity(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataEntity(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataEntity &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataEntity> {
  final Value<String> key;
  final Value<String?> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<SyncMetadataEntity> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyncMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkuCountersTable extends SkuCounters
    with TableInfo<$SkuCountersTable, SkuCounterEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkuCountersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _prefixMeta = const VerificationMeta('prefix');
  @override
  late final GeneratedColumn<String> prefix = GeneratedColumn<String>(
    'prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SKU'),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentNumberMeta = const VerificationMeta(
    'currentNumber',
  );
  @override
  late final GeneratedColumn<int> currentNumber = GeneratedColumn<int>(
    'current_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    prefix,
    deviceId,
    currentNumber,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sku_counters';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkuCounterEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('prefix')) {
      context.handle(
        _prefixMeta,
        prefix.isAcceptableOrUnknown(data['prefix']!, _prefixMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('current_number')) {
      context.handle(
        _currentNumberMeta,
        currentNumber.isAcceptableOrUnknown(
          data['current_number']!,
          _currentNumberMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkuCounterEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkuCounterEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      prefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prefix'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      currentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_number'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SkuCountersTable createAlias(String alias) {
    return $SkuCountersTable(attachedDatabase, alias);
  }
}

class SkuCounterEntity extends DataClass
    implements Insertable<SkuCounterEntity> {
  final int id;
  final String prefix;
  final String deviceId;
  final int currentNumber;
  final DateTime updatedAt;
  const SkuCounterEntity({
    required this.id,
    required this.prefix,
    required this.deviceId,
    required this.currentNumber,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['prefix'] = Variable<String>(prefix);
    map['device_id'] = Variable<String>(deviceId);
    map['current_number'] = Variable<int>(currentNumber);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SkuCountersCompanion toCompanion(bool nullToAbsent) {
    return SkuCountersCompanion(
      id: Value(id),
      prefix: Value(prefix),
      deviceId: Value(deviceId),
      currentNumber: Value(currentNumber),
      updatedAt: Value(updatedAt),
    );
  }

  factory SkuCounterEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkuCounterEntity(
      id: serializer.fromJson<int>(json['id']),
      prefix: serializer.fromJson<String>(json['prefix']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      currentNumber: serializer.fromJson<int>(json['currentNumber']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prefix': serializer.toJson<String>(prefix),
      'deviceId': serializer.toJson<String>(deviceId),
      'currentNumber': serializer.toJson<int>(currentNumber),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SkuCounterEntity copyWith({
    int? id,
    String? prefix,
    String? deviceId,
    int? currentNumber,
    DateTime? updatedAt,
  }) => SkuCounterEntity(
    id: id ?? this.id,
    prefix: prefix ?? this.prefix,
    deviceId: deviceId ?? this.deviceId,
    currentNumber: currentNumber ?? this.currentNumber,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SkuCounterEntity copyWithCompanion(SkuCountersCompanion data) {
    return SkuCounterEntity(
      id: data.id.present ? data.id.value : this.id,
      prefix: data.prefix.present ? data.prefix.value : this.prefix,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      currentNumber: data.currentNumber.present
          ? data.currentNumber.value
          : this.currentNumber,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkuCounterEntity(')
          ..write('id: $id, ')
          ..write('prefix: $prefix, ')
          ..write('deviceId: $deviceId, ')
          ..write('currentNumber: $currentNumber, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, prefix, deviceId, currentNumber, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkuCounterEntity &&
          other.id == this.id &&
          other.prefix == this.prefix &&
          other.deviceId == this.deviceId &&
          other.currentNumber == this.currentNumber &&
          other.updatedAt == this.updatedAt);
}

class SkuCountersCompanion extends UpdateCompanion<SkuCounterEntity> {
  final Value<int> id;
  final Value<String> prefix;
  final Value<String> deviceId;
  final Value<int> currentNumber;
  final Value<DateTime> updatedAt;
  const SkuCountersCompanion({
    this.id = const Value.absent(),
    this.prefix = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.currentNumber = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SkuCountersCompanion.insert({
    this.id = const Value.absent(),
    this.prefix = const Value.absent(),
    required String deviceId,
    this.currentNumber = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : deviceId = Value(deviceId);
  static Insertable<SkuCounterEntity> custom({
    Expression<int>? id,
    Expression<String>? prefix,
    Expression<String>? deviceId,
    Expression<int>? currentNumber,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prefix != null) 'prefix': prefix,
      if (deviceId != null) 'device_id': deviceId,
      if (currentNumber != null) 'current_number': currentNumber,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SkuCountersCompanion copyWith({
    Value<int>? id,
    Value<String>? prefix,
    Value<String>? deviceId,
    Value<int>? currentNumber,
    Value<DateTime>? updatedAt,
  }) {
    return SkuCountersCompanion(
      id: id ?? this.id,
      prefix: prefix ?? this.prefix,
      deviceId: deviceId ?? this.deviceId,
      currentNumber: currentNumber ?? this.currentNumber,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (prefix.present) {
      map['prefix'] = Variable<String>(prefix.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (currentNumber.present) {
      map['current_number'] = Variable<int>(currentNumber.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkuCountersCompanion(')
          ..write('id: $id, ')
          ..write('prefix: $prefix, ')
          ..write('deviceId: $deviceId, ')
          ..write('currentNumber: $currentNumber, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $UnitsTable units = $UnitsTable(this);
  late final $TenantsTable tenants = $TenantsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $InvoiceSettingsTable invoiceSettings = $InvoiceSettingsTable(
    this,
  );
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceItemsTable invoiceItems = $InvoiceItemsTable(this);
  late final $BrandsTable brands = $BrandsTable(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  late final $SkuCountersTable skuCounters = $SkuCountersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    categories,
    units,
    tenants,
    customers,
    suppliers,
    employees,
    invoiceSettings,
    invoices,
    invoiceItems,
    brands,
    syncMetadata,
    skuCounters,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String?> sku,
      Value<int?> categoryId,
      Value<int?> unitId,
      Value<int?> brandId,
      Value<String?> type,
      Value<String?> packSize,
      required double price,
      Value<double?> cost,
      Value<int> stockQuantity,
      Value<bool> isActive,
      required int tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> gstType,
      Value<String?> gstRate,
      Value<String?> imageUrl,
      Value<String?> localPath,
      Value<String?> description,
      Value<double> discount,
      Value<bool> isPercentDiscount,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String?> sku,
      Value<int?> categoryId,
      Value<int?> unitId,
      Value<int?> brandId,
      Value<String?> type,
      Value<String?> packSize,
      Value<double> price,
      Value<double?> cost,
      Value<int> stockQuantity,
      Value<bool> isActive,
      Value<int> tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> gstType,
      Value<String?> gstRate,
      Value<String?> imageUrl,
      Value<String?> localPath,
      Value<String?> description,
      Value<double> discount,
      Value<bool> isPercentDiscount,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get brandId => $composableBuilder(
    column: $table.brandId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gstType => $composableBuilder(
    column: $table.gstType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPercentDiscount => $composableBuilder(
    column: $table.isPercentDiscount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get brandId => $composableBuilder(
    column: $table.brandId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packSize => $composableBuilder(
    column: $table.packSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gstType => $composableBuilder(
    column: $table.gstType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPercentDiscount => $composableBuilder(
    column: $table.isPercentDiscount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<int> get brandId =>
      $composableBuilder(column: $table.brandId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get packSize =>
      $composableBuilder(column: $table.packSize, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get gstType =>
      $composableBuilder(column: $table.gstType, builder: (column) => column);

  GeneratedColumn<String> get gstRate =>
      $composableBuilder(column: $table.gstRate, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<bool> get isPercentDiscount => $composableBuilder(
    column: $table.isPercentDiscount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductEntity,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (
            ProductEntity,
            BaseReferences<_$AppDatabase, $ProductsTable, ProductEntity>,
          ),
          ProductEntity,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> unitId = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> packSize = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                Value<int> stockQuantity = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> gstType = const Value.absent(),
                Value<String?> gstRate = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<bool> isPercentDiscount = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                uuid: uuid,
                name: name,
                sku: sku,
                categoryId: categoryId,
                unitId: unitId,
                brandId: brandId,
                type: type,
                packSize: packSize,
                price: price,
                cost: cost,
                stockQuantity: stockQuantity,
                isActive: isActive,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                gstType: gstType,
                gstRate: gstRate,
                imageUrl: imageUrl,
                localPath: localPath,
                description: description,
                discount: discount,
                isPercentDiscount: isPercentDiscount,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> sku = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> unitId = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> packSize = const Value.absent(),
                required double price,
                Value<double?> cost = const Value.absent(),
                Value<int> stockQuantity = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required int tenantId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> gstType = const Value.absent(),
                Value<String?> gstRate = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<bool> isPercentDiscount = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                sku: sku,
                categoryId: categoryId,
                unitId: unitId,
                brandId: brandId,
                type: type,
                packSize: packSize,
                price: price,
                cost: cost,
                stockQuantity: stockQuantity,
                isActive: isActive,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                gstType: gstType,
                gstRate: gstRate,
                imageUrl: imageUrl,
                localPath: localPath,
                description: description,
                discount: discount,
                isPercentDiscount: isPercentDiscount,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductEntity,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (
        ProductEntity,
        BaseReferences<_$AppDatabase, $ProductsTable, ProductEntity>,
      ),
      ProductEntity,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String?> subcategory,
      Value<String?> description,
      Value<bool> isActive,
      required int tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String?> subcategory,
      Value<String?> description,
      Value<bool> isActive,
      Value<int> tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          CategoryEntity,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (
            CategoryEntity,
            BaseReferences<_$AppDatabase, $CategoriesTable, CategoryEntity>,
          ),
          CategoryEntity,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> subcategory = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                uuid: uuid,
                name: name,
                subcategory: subcategory,
                description: description,
                isActive: isActive,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> subcategory = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required int tenantId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                subcategory: subcategory,
                description: description,
                isActive: isActive,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      CategoryEntity,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (
        CategoryEntity,
        BaseReferences<_$AppDatabase, $CategoriesTable, CategoryEntity>,
      ),
      CategoryEntity,
      PrefetchHooks Function()
    >;
typedef $$UnitsTableCreateCompanionBuilder =
    UnitsCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      required String symbol,
      Value<bool> isActive,
      required int tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$UnitsTableUpdateCompanionBuilder =
    UnitsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String> symbol,
      Value<bool> isActive,
      Value<int> tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$UnitsTableFilterComposer extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$UnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnitsTable,
          UnitEntity,
          $$UnitsTableFilterComposer,
          $$UnitsTableOrderingComposer,
          $$UnitsTableAnnotationComposer,
          $$UnitsTableCreateCompanionBuilder,
          $$UnitsTableUpdateCompanionBuilder,
          (UnitEntity, BaseReferences<_$AppDatabase, $UnitsTable, UnitEntity>),
          UnitEntity,
          PrefetchHooks Function()
        > {
  $$UnitsTableTableManager(_$AppDatabase db, $UnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => UnitsCompanion(
                id: id,
                uuid: uuid,
                name: name,
                symbol: symbol,
                isActive: isActive,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                required String symbol,
                Value<bool> isActive = const Value.absent(),
                required int tenantId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => UnitsCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                symbol: symbol,
                isActive: isActive,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnitsTable,
      UnitEntity,
      $$UnitsTableFilterComposer,
      $$UnitsTableOrderingComposer,
      $$UnitsTableAnnotationComposer,
      $$UnitsTableCreateCompanionBuilder,
      $$UnitsTableUpdateCompanionBuilder,
      (UnitEntity, BaseReferences<_$AppDatabase, $UnitsTable, UnitEntity>),
      UnitEntity,
      PrefetchHooks Function()
    >;
typedef $$TenantsTableCreateCompanionBuilder =
    TenantsCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String?> email,
      Value<String?> businessName,
      Value<String?> businessAddress,
      Value<String?> taxId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$TenantsTableUpdateCompanionBuilder =
    TenantsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String?> email,
      Value<String?> businessName,
      Value<String?> businessAddress,
      Value<String?> taxId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$TenantsTableFilterComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessAddress => $composableBuilder(
    column: $table.businessAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TenantsTableOrderingComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessAddress => $composableBuilder(
    column: $table.businessAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TenantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessAddress => $composableBuilder(
    column: $table.businessAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taxId =>
      $composableBuilder(column: $table.taxId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$TenantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TenantsTable,
          TenantEntity,
          $$TenantsTableFilterComposer,
          $$TenantsTableOrderingComposer,
          $$TenantsTableAnnotationComposer,
          $$TenantsTableCreateCompanionBuilder,
          $$TenantsTableUpdateCompanionBuilder,
          (
            TenantEntity,
            BaseReferences<_$AppDatabase, $TenantsTable, TenantEntity>,
          ),
          TenantEntity,
          PrefetchHooks Function()
        > {
  $$TenantsTableTableManager(_$AppDatabase db, $TenantsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TenantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TenantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TenantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> businessName = const Value.absent(),
                Value<String?> businessAddress = const Value.absent(),
                Value<String?> taxId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => TenantsCompanion(
                id: id,
                uuid: uuid,
                name: name,
                email: email,
                businessName: businessName,
                businessAddress: businessAddress,
                taxId: taxId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> businessName = const Value.absent(),
                Value<String?> businessAddress = const Value.absent(),
                Value<String?> taxId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => TenantsCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                email: email,
                businessName: businessName,
                businessAddress: businessAddress,
                taxId: taxId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TenantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TenantsTable,
      TenantEntity,
      $$TenantsTableFilterComposer,
      $$TenantsTableOrderingComposer,
      $$TenantsTableAnnotationComposer,
      $$TenantsTableCreateCompanionBuilder,
      $$TenantsTableUpdateCompanionBuilder,
      (
        TenantEntity,
        BaseReferences<_$AppDatabase, $TenantsTable, TenantEntity>,
      ),
      TenantEntity,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<double> creditLimit,
      Value<double> currentBalance,
      required int tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<double> creditLimit,
      Value<double> currentBalance,
      Value<int> tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentBalance => $composableBuilder(
    column: $table.currentBalance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          CustomerEntity,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (
            CustomerEntity,
            BaseReferences<_$AppDatabase, $CustomersTable, CustomerEntity>,
          ),
          CustomerEntity,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double> creditLimit = const Value.absent(),
                Value<double> currentBalance = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                uuid: uuid,
                name: name,
                email: email,
                phone: phone,
                address: address,
                creditLimit: creditLimit,
                currentBalance: currentBalance,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double> creditLimit = const Value.absent(),
                Value<double> currentBalance = const Value.absent(),
                required int tenantId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                email: email,
                phone: phone,
                address: address,
                creditLimit: creditLimit,
                currentBalance: currentBalance,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      CustomerEntity,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (
        CustomerEntity,
        BaseReferences<_$AppDatabase, $CustomersTable, CustomerEntity>,
      ),
      CustomerEntity,
      PrefetchHooks Function()
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      required int tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<int> tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          SupplierEntity,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (
            SupplierEntity,
            BaseReferences<_$AppDatabase, $SuppliersTable, SupplierEntity>,
          ),
          SupplierEntity,
          PrefetchHooks Function()
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                uuid: uuid,
                name: name,
                email: email,
                phone: phone,
                address: address,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                required int tenantId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                email: email,
                phone: phone,
                address: address,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      SupplierEntity,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (
        SupplierEntity,
        BaseReferences<_$AppDatabase, $SuppliersTable, SupplierEntity>,
      ),
      SupplierEntity,
      PrefetchHooks Function()
    >;
typedef $$EmployeesTableCreateCompanionBuilder =
    EmployeesCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> position,
      Value<double?> salary,
      Value<String> role,
      Value<String?> password,
      Value<bool> googleAuth,
      required int tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$EmployeesTableUpdateCompanionBuilder =
    EmployeesCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> position,
      Value<double?> salary,
      Value<String> role,
      Value<String?> password,
      Value<bool> googleAuth,
      Value<int> tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$EmployeesTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get salary => $composableBuilder(
    column: $table.salary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get googleAuth => $composableBuilder(
    column: $table.googleAuth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmployeesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get salary => $composableBuilder(
    column: $table.salary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get googleAuth => $composableBuilder(
    column: $table.googleAuth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmployeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<double> get salary =>
      $composableBuilder(column: $table.salary, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<bool> get googleAuth => $composableBuilder(
    column: $table.googleAuth,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$EmployeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmployeesTable,
          EmployeeEntity,
          $$EmployeesTableFilterComposer,
          $$EmployeesTableOrderingComposer,
          $$EmployeesTableAnnotationComposer,
          $$EmployeesTableCreateCompanionBuilder,
          $$EmployeesTableUpdateCompanionBuilder,
          (
            EmployeeEntity,
            BaseReferences<_$AppDatabase, $EmployeesTable, EmployeeEntity>,
          ),
          EmployeeEntity,
          PrefetchHooks Function()
        > {
  $$EmployeesTableTableManager(_$AppDatabase db, $EmployeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<double?> salary = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> password = const Value.absent(),
                Value<bool> googleAuth = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => EmployeesCompanion(
                id: id,
                uuid: uuid,
                name: name,
                email: email,
                phone: phone,
                address: address,
                position: position,
                salary: salary,
                role: role,
                password: password,
                googleAuth: googleAuth,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<double?> salary = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> password = const Value.absent(),
                Value<bool> googleAuth = const Value.absent(),
                required int tenantId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => EmployeesCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                email: email,
                phone: phone,
                address: address,
                position: position,
                salary: salary,
                role: role,
                password: password,
                googleAuth: googleAuth,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmployeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmployeesTable,
      EmployeeEntity,
      $$EmployeesTableFilterComposer,
      $$EmployeesTableOrderingComposer,
      $$EmployeesTableAnnotationComposer,
      $$EmployeesTableCreateCompanionBuilder,
      $$EmployeesTableUpdateCompanionBuilder,
      (
        EmployeeEntity,
        BaseReferences<_$AppDatabase, $EmployeesTable, EmployeeEntity>,
      ),
      EmployeeEntity,
      PrefetchHooks Function()
    >;
typedef $$InvoiceSettingsTableCreateCompanionBuilder =
    InvoiceSettingsCompanion Function({
      Value<int> id,
      required String layout,
      required String footerMessage,
      Value<String> accentColor,
      Value<String> fontFamily,
      Value<double> fontSizeMultiplier,
      Value<bool> showAddress,
      Value<bool> showCustomerDetails,
      Value<bool> showFooter,
      Value<String?> customConfig,
      Value<DateTime> updatedAt,
    });
typedef $$InvoiceSettingsTableUpdateCompanionBuilder =
    InvoiceSettingsCompanion Function({
      Value<int> id,
      Value<String> layout,
      Value<String> footerMessage,
      Value<String> accentColor,
      Value<String> fontFamily,
      Value<double> fontSizeMultiplier,
      Value<bool> showAddress,
      Value<bool> showCustomerDetails,
      Value<bool> showFooter,
      Value<String?> customConfig,
      Value<DateTime> updatedAt,
    });

class $$InvoiceSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceSettingsTable> {
  $$InvoiceSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get layout => $composableBuilder(
    column: $table.layout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get footerMessage => $composableBuilder(
    column: $table.footerMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fontSizeMultiplier => $composableBuilder(
    column: $table.fontSizeMultiplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showAddress => $composableBuilder(
    column: $table.showAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showCustomerDetails => $composableBuilder(
    column: $table.showCustomerDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showFooter => $composableBuilder(
    column: $table.showFooter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customConfig => $composableBuilder(
    column: $table.customConfig,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoiceSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceSettingsTable> {
  $$InvoiceSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get layout => $composableBuilder(
    column: $table.layout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get footerMessage => $composableBuilder(
    column: $table.footerMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fontSizeMultiplier => $composableBuilder(
    column: $table.fontSizeMultiplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showAddress => $composableBuilder(
    column: $table.showAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showCustomerDetails => $composableBuilder(
    column: $table.showCustomerDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showFooter => $composableBuilder(
    column: $table.showFooter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customConfig => $composableBuilder(
    column: $table.customConfig,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoiceSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceSettingsTable> {
  $$InvoiceSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get layout =>
      $composableBuilder(column: $table.layout, builder: (column) => column);

  GeneratedColumn<String> get footerMessage => $composableBuilder(
    column: $table.footerMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fontSizeMultiplier => $composableBuilder(
    column: $table.fontSizeMultiplier,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showAddress => $composableBuilder(
    column: $table.showAddress,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showCustomerDetails => $composableBuilder(
    column: $table.showCustomerDetails,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showFooter => $composableBuilder(
    column: $table.showFooter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customConfig => $composableBuilder(
    column: $table.customConfig,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$InvoiceSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceSettingsTable,
          InvoiceSettingEntity,
          $$InvoiceSettingsTableFilterComposer,
          $$InvoiceSettingsTableOrderingComposer,
          $$InvoiceSettingsTableAnnotationComposer,
          $$InvoiceSettingsTableCreateCompanionBuilder,
          $$InvoiceSettingsTableUpdateCompanionBuilder,
          (
            InvoiceSettingEntity,
            BaseReferences<
              _$AppDatabase,
              $InvoiceSettingsTable,
              InvoiceSettingEntity
            >,
          ),
          InvoiceSettingEntity,
          PrefetchHooks Function()
        > {
  $$InvoiceSettingsTableTableManager(
    _$AppDatabase db,
    $InvoiceSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> layout = const Value.absent(),
                Value<String> footerMessage = const Value.absent(),
                Value<String> accentColor = const Value.absent(),
                Value<String> fontFamily = const Value.absent(),
                Value<double> fontSizeMultiplier = const Value.absent(),
                Value<bool> showAddress = const Value.absent(),
                Value<bool> showCustomerDetails = const Value.absent(),
                Value<bool> showFooter = const Value.absent(),
                Value<String?> customConfig = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InvoiceSettingsCompanion(
                id: id,
                layout: layout,
                footerMessage: footerMessage,
                accentColor: accentColor,
                fontFamily: fontFamily,
                fontSizeMultiplier: fontSizeMultiplier,
                showAddress: showAddress,
                showCustomerDetails: showCustomerDetails,
                showFooter: showFooter,
                customConfig: customConfig,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String layout,
                required String footerMessage,
                Value<String> accentColor = const Value.absent(),
                Value<String> fontFamily = const Value.absent(),
                Value<double> fontSizeMultiplier = const Value.absent(),
                Value<bool> showAddress = const Value.absent(),
                Value<bool> showCustomerDetails = const Value.absent(),
                Value<bool> showFooter = const Value.absent(),
                Value<String?> customConfig = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => InvoiceSettingsCompanion.insert(
                id: id,
                layout: layout,
                footerMessage: footerMessage,
                accentColor: accentColor,
                fontFamily: fontFamily,
                fontSizeMultiplier: fontSizeMultiplier,
                showAddress: showAddress,
                showCustomerDetails: showCustomerDetails,
                showFooter: showFooter,
                customConfig: customConfig,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoiceSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceSettingsTable,
      InvoiceSettingEntity,
      $$InvoiceSettingsTableFilterComposer,
      $$InvoiceSettingsTableOrderingComposer,
      $$InvoiceSettingsTableAnnotationComposer,
      $$InvoiceSettingsTableCreateCompanionBuilder,
      $$InvoiceSettingsTableUpdateCompanionBuilder,
      (
        InvoiceSettingEntity,
        BaseReferences<
          _$AppDatabase,
          $InvoiceSettingsTable,
          InvoiceSettingEntity
        >,
      ),
      InvoiceSettingEntity,
      PrefetchHooks Function()
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      required String uuid,
      required String invoiceNumber,
      Value<int?> customerId,
      required DateTime date,
      required double subtotal,
      required double tax,
      Value<double> discount,
      required double total,
      Value<String?> signUrl,
      required int tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> invoiceNumber,
      Value<int?> customerId,
      Value<DateTime> date,
      Value<double> subtotal,
      Value<double> tax,
      Value<double> discount,
      Value<double> total,
      Value<String?> signUrl,
      Value<int> tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signUrl => $composableBuilder(
    column: $table.signUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signUrl => $composableBuilder(
    column: $table.signUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get signUrl =>
      $composableBuilder(column: $table.signUrl, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          InvoiceEntity,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (
            InvoiceEntity,
            BaseReferences<_$AppDatabase, $InvoicesTable, InvoiceEntity>,
          ),
          InvoiceEntity,
          PrefetchHooks Function()
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> tax = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<String?> signUrl = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                uuid: uuid,
                invoiceNumber: invoiceNumber,
                customerId: customerId,
                date: date,
                subtotal: subtotal,
                tax: tax,
                discount: discount,
                total: total,
                signUrl: signUrl,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String invoiceNumber,
                Value<int?> customerId = const Value.absent(),
                required DateTime date,
                required double subtotal,
                required double tax,
                Value<double> discount = const Value.absent(),
                required double total,
                Value<String?> signUrl = const Value.absent(),
                required int tenantId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                uuid: uuid,
                invoiceNumber: invoiceNumber,
                customerId: customerId,
                date: date,
                subtotal: subtotal,
                tax: tax,
                discount: discount,
                total: total,
                signUrl: signUrl,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      InvoiceEntity,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (
        InvoiceEntity,
        BaseReferences<_$AppDatabase, $InvoicesTable, InvoiceEntity>,
      ),
      InvoiceEntity,
      PrefetchHooks Function()
    >;
typedef $$InvoiceItemsTableCreateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      required String uuid,
      required int invoiceId,
      required int productId,
      required int quantity,
      Value<int> bonus,
      required double unitPrice,
      Value<double> discount,
      required double totalPrice,
      required int tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$InvoiceItemsTableUpdateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<int> invoiceId,
      Value<int> productId,
      Value<int> quantity,
      Value<int> bonus,
      Value<double> unitPrice,
      Value<double> discount,
      Value<double> totalPrice,
      Value<int> tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$InvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bonus => $composableBuilder(
    column: $table.bonus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bonus => $composableBuilder(
    column: $table.bonus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<int> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get bonus =>
      $composableBuilder(column: $table.bonus, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$InvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceItemsTable,
          InvoiceItemEntity,
          $$InvoiceItemsTableFilterComposer,
          $$InvoiceItemsTableOrderingComposer,
          $$InvoiceItemsTableAnnotationComposer,
          $$InvoiceItemsTableCreateCompanionBuilder,
          $$InvoiceItemsTableUpdateCompanionBuilder,
          (
            InvoiceItemEntity,
            BaseReferences<
              _$AppDatabase,
              $InvoiceItemsTable,
              InvoiceItemEntity
            >,
          ),
          InvoiceItemEntity,
          PrefetchHooks Function()
        > {
  $$InvoiceItemsTableTableManager(_$AppDatabase db, $InvoiceItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> bonus = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => InvoiceItemsCompanion(
                id: id,
                uuid: uuid,
                invoiceId: invoiceId,
                productId: productId,
                quantity: quantity,
                bonus: bonus,
                unitPrice: unitPrice,
                discount: discount,
                totalPrice: totalPrice,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required int invoiceId,
                required int productId,
                required int quantity,
                Value<int> bonus = const Value.absent(),
                required double unitPrice,
                Value<double> discount = const Value.absent(),
                required double totalPrice,
                required int tenantId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => InvoiceItemsCompanion.insert(
                id: id,
                uuid: uuid,
                invoiceId: invoiceId,
                productId: productId,
                quantity: quantity,
                bonus: bonus,
                unitPrice: unitPrice,
                discount: discount,
                totalPrice: totalPrice,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceItemsTable,
      InvoiceItemEntity,
      $$InvoiceItemsTableFilterComposer,
      $$InvoiceItemsTableOrderingComposer,
      $$InvoiceItemsTableAnnotationComposer,
      $$InvoiceItemsTableCreateCompanionBuilder,
      $$InvoiceItemsTableUpdateCompanionBuilder,
      (
        InvoiceItemEntity,
        BaseReferences<_$AppDatabase, $InvoiceItemsTable, InvoiceItemEntity>,
      ),
      InvoiceItemEntity,
      PrefetchHooks Function()
    >;
typedef $$BrandsTableCreateCompanionBuilder =
    BrandsCompanion Function({
      Value<int> id,
      required String uuid,
      required String name,
      Value<String?> description,
      Value<bool> isActive,
      required int tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });
typedef $$BrandsTableUpdateCompanionBuilder =
    BrandsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> name,
      Value<String?> description,
      Value<bool> isActive,
      Value<int> tenantId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> syncStatus,
      Value<bool> isDeleted,
    });

class $$BrandsTableFilterComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BrandsTableOrderingComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BrandsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$BrandsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrandsTable,
          BrandEntity,
          $$BrandsTableFilterComposer,
          $$BrandsTableOrderingComposer,
          $$BrandsTableAnnotationComposer,
          $$BrandsTableCreateCompanionBuilder,
          $$BrandsTableUpdateCompanionBuilder,
          (
            BrandEntity,
            BaseReferences<_$AppDatabase, $BrandsTable, BrandEntity>,
          ),
          BrandEntity,
          PrefetchHooks Function()
        > {
  $$BrandsTableTableManager(_$AppDatabase db, $BrandsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrandsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrandsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => BrandsCompanion(
                id: id,
                uuid: uuid,
                name: name,
                description: description,
                isActive: isActive,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required int tenantId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => BrandsCompanion.insert(
                id: id,
                uuid: uuid,
                name: name,
                description: description,
                isActive: isActive,
                tenantId: tenantId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BrandsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrandsTable,
      BrandEntity,
      $$BrandsTableFilterComposer,
      $$BrandsTableOrderingComposer,
      $$BrandsTableAnnotationComposer,
      $$BrandsTableCreateCompanionBuilder,
      $$BrandsTableUpdateCompanionBuilder,
      (BrandEntity, BaseReferences<_$AppDatabase, $BrandsTable, BrandEntity>),
      BrandEntity,
      PrefetchHooks Function()
    >;
typedef $$SyncMetadataTableCreateCompanionBuilder =
    SyncMetadataCompanion Function({
      required String key,
      Value<String?> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableUpdateCompanionBuilder =
    SyncMetadataCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SyncMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataTable,
          SyncMetadataEntity,
          $$SyncMetadataTableFilterComposer,
          $$SyncMetadataTableOrderingComposer,
          $$SyncMetadataTableAnnotationComposer,
          $$SyncMetadataTableCreateCompanionBuilder,
          $$SyncMetadataTableUpdateCompanionBuilder,
          (
            SyncMetadataEntity,
            BaseReferences<
              _$AppDatabase,
              $SyncMetadataTable,
              SyncMetadataEntity
            >,
          ),
          SyncMetadataEntity,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableManager(_$AppDatabase db, $SyncMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataTable,
      SyncMetadataEntity,
      $$SyncMetadataTableFilterComposer,
      $$SyncMetadataTableOrderingComposer,
      $$SyncMetadataTableAnnotationComposer,
      $$SyncMetadataTableCreateCompanionBuilder,
      $$SyncMetadataTableUpdateCompanionBuilder,
      (
        SyncMetadataEntity,
        BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataEntity>,
      ),
      SyncMetadataEntity,
      PrefetchHooks Function()
    >;
typedef $$SkuCountersTableCreateCompanionBuilder =
    SkuCountersCompanion Function({
      Value<int> id,
      Value<String> prefix,
      required String deviceId,
      Value<int> currentNumber,
      Value<DateTime> updatedAt,
    });
typedef $$SkuCountersTableUpdateCompanionBuilder =
    SkuCountersCompanion Function({
      Value<int> id,
      Value<String> prefix,
      Value<String> deviceId,
      Value<int> currentNumber,
      Value<DateTime> updatedAt,
    });

class $$SkuCountersTableFilterComposer
    extends Composer<_$AppDatabase, $SkuCountersTable> {
  $$SkuCountersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prefix => $composableBuilder(
    column: $table.prefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentNumber => $composableBuilder(
    column: $table.currentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkuCountersTableOrderingComposer
    extends Composer<_$AppDatabase, $SkuCountersTable> {
  $$SkuCountersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prefix => $composableBuilder(
    column: $table.prefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentNumber => $composableBuilder(
    column: $table.currentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkuCountersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkuCountersTable> {
  $$SkuCountersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get prefix =>
      $composableBuilder(column: $table.prefix, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get currentNumber => $composableBuilder(
    column: $table.currentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SkuCountersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkuCountersTable,
          SkuCounterEntity,
          $$SkuCountersTableFilterComposer,
          $$SkuCountersTableOrderingComposer,
          $$SkuCountersTableAnnotationComposer,
          $$SkuCountersTableCreateCompanionBuilder,
          $$SkuCountersTableUpdateCompanionBuilder,
          (
            SkuCounterEntity,
            BaseReferences<_$AppDatabase, $SkuCountersTable, SkuCounterEntity>,
          ),
          SkuCounterEntity,
          PrefetchHooks Function()
        > {
  $$SkuCountersTableTableManager(_$AppDatabase db, $SkuCountersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkuCountersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkuCountersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkuCountersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> prefix = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int> currentNumber = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SkuCountersCompanion(
                id: id,
                prefix: prefix,
                deviceId: deviceId,
                currentNumber: currentNumber,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> prefix = const Value.absent(),
                required String deviceId,
                Value<int> currentNumber = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SkuCountersCompanion.insert(
                id: id,
                prefix: prefix,
                deviceId: deviceId,
                currentNumber: currentNumber,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkuCountersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkuCountersTable,
      SkuCounterEntity,
      $$SkuCountersTableFilterComposer,
      $$SkuCountersTableOrderingComposer,
      $$SkuCountersTableAnnotationComposer,
      $$SkuCountersTableCreateCompanionBuilder,
      $$SkuCountersTableUpdateCompanionBuilder,
      (
        SkuCounterEntity,
        BaseReferences<_$AppDatabase, $SkuCountersTable, SkuCounterEntity>,
      ),
      SkuCounterEntity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$UnitsTableTableManager get units =>
      $$UnitsTableTableManager(_db, _db.units);
  $$TenantsTableTableManager get tenants =>
      $$TenantsTableTableManager(_db, _db.tenants);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
  $$InvoiceSettingsTableTableManager get invoiceSettings =>
      $$InvoiceSettingsTableTableManager(_db, _db.invoiceSettings);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  $$BrandsTableTableManager get brands =>
      $$BrandsTableTableManager(_db, _db.brands);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
  $$SkuCountersTableTableManager get skuCounters =>
      $$SkuCountersTableTableManager(_db, _db.skuCounters);
}
