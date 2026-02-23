import 'package:drift/drift.dart';

@DataClassName('InvoiceEntity')
class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get invoiceNumber => text()();
  IntColumn get customerId =>
      integer().nullable()(); // Reference to Customers table id
  DateTimeColumn get date => dateTime()();
  RealColumn get subtotal => real()();
  RealColumn get tax => real()();
  RealColumn get discount => real().withDefault(const Constant(0.0))();
  RealColumn get total => real()();
  TextColumn get signUrl => text().nullable()();

  IntColumn get tenantId => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  // Sync columns
  IntColumn get syncStatus => integer().withDefault(
    const Constant(0),
  )(); // 0: synched, 1: pending, 2: error
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
