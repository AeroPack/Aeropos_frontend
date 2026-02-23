import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

part 'repro_create_background.g.dart';

// Copy of the table definition
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get sku => text().unique()();
  IntColumn get categoryId => integer().nullable()();
  IntColumn get unitId => integer().nullable()();
  RealColumn get price => real()();
  RealColumn get cost => real().nullable()();
  IntColumn get stockQuantity => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Products])
class TestDatabase extends _$TestDatabase {
  TestDatabase(super.e);
  @override
  int get schemaVersion => 1;
}

void main() {
  test('NativeDatabase.createInBackground works', () async {
    // Mimic the path logic
    final dbFolder = Directory.systemTemp.createTempSync('ezo_test');
    final file = File(p.join(dbFolder.path, 'test_db.sqlite'));
    // ignore: avoid_print
    print('Testing DB at: ${file.path}');

    final db = TestDatabase(NativeDatabase.createInBackground(file));

    try {
      // Try to open and query
      await db.customSelect('SELECT 1').get();
      // ignore: avoid_print
      print('Connection successful');

      // Try insert
      await db
          .into(db.products)
          .insert(
            ProductsCompanion.insert(
              uuid: '123',
              name: 'Test',
              sku: 'SKU123',
              price: 10.0,
            ),
          );
      // ignore: avoid_print
      print('Insert successful');
    } catch (e, s) {
      // ignore: avoid_print
      print('ERROR: $e');
      // ignore: avoid_print
      print('STACK: $s');
      rethrow;
    } finally {
      await db.close();
    }
  });
}
