import 'package:drift/drift.dart';

@DataClassName('ProductEntity')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get sku => text().unique().nullable()();
  // Simplified for Product Master only - removing foreign keys to missing tables
  IntColumn get categoryId => integer().nullable()();
  IntColumn get unitId => integer().nullable()();
  IntColumn get brandId => integer().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get packSize => text().nullable()();
  RealColumn get price => real()();
  RealColumn get cost => real().nullable()();
  IntColumn get stockQuantity => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  IntColumn get tenantId => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  // GST Fields
  TextColumn get gstType => text().nullable()();
  TextColumn get gstRate => text().nullable()();

  // Image Fields
  TextColumn get imageUrl => text().nullable()(); // Remote URL
  TextColumn get localPath =>
      text().nullable()(); // Local path (temporary/cache)
  TextColumn get description => text().nullable()();

  // Default Discount fields
  RealColumn get discount => real().withDefault(const Constant(0.0))();
  BoolColumn get isPercentDiscount =>
      boolean().withDefault(const Constant(false))();

  // Sync columns
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
