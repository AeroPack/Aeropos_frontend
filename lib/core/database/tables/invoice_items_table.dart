import 'package:drift/drift.dart';

@DataClassName('InvoiceItemEntity')
class InvoiceItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  IntColumn get invoiceId => integer()(); // Reference to Invoices table id
  IntColumn get productId => integer()(); // Reference to Products table id
  IntColumn get quantity => integer()();
  IntColumn get bonus => integer().withDefault(const Constant(0))();
  RealColumn get unitPrice => real()();
  RealColumn get discount => real().withDefault(const Constant(0.0))();
  RealColumn get totalPrice => real()();

  IntColumn get tenantId => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  // Sync columns
  IntColumn get syncStatus => integer().withDefault(
    const Constant(0),
  )(); // 0: synched, 1: pending, 2: error
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
