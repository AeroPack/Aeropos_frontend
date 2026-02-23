import 'package:drift/drift.dart';

@DataClassName('SkuCounterEntity')
class SkuCounters extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get prefix => text().withDefault(const Constant('SKU'))();
  TextColumn get deviceId => text()();
  IntColumn get currentNumber => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
