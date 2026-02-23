import 'package:drift/drift.dart';

@DataClassName('SyncMetadataEntity')
class SyncMetadata extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {key};
}
