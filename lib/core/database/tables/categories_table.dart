import 'package:drift/drift.dart';

@DataClassName('CategoryEntity')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get subcategory => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  IntColumn get tenantId => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  // Sync columns
  IntColumn get syncStatus => integer().withDefault(
    const Constant(0),
  )(); // 0: synched, 1: pending, 2: error
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
