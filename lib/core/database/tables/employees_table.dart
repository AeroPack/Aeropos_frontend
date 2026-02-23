import 'package:drift/drift.dart';

@DataClassName('EmployeeEntity')
class Employees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get position => text().nullable()();
  RealColumn get salary => real().nullable()();
  TextColumn get role => text().withDefault(const Constant('employee'))();
  TextColumn get password => text().nullable()();
  BoolColumn get googleAuth => boolean().withDefault(const Constant(false))();

  IntColumn get tenantId => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
