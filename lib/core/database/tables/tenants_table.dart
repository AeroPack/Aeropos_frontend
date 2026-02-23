import 'package:drift/drift.dart';

@DataClassName('TenantEntity')
class Tenants extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get email => text().nullable()();
  TextColumn get businessName => text().nullable()();
  TextColumn get businessAddress => text().nullable()();
  TextColumn get taxId => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  // Sync columns - keeping them consistent with other tables for potential sync
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
