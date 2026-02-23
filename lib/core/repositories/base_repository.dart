import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/enums/sync_status.dart';

abstract class BaseRepository<
  T,
  E extends DataClass,
  C extends UpdateCompanion<E>
> {
  final AppDatabase db;
  final TableInfo<Table, E> table;

  BaseRepository(this.db, this.table);

  // Convert Drift entity to Domain model
  T toDomain(E entity);

  // Convert Domain model to Drift companion for insert
  C toCompanion(T domain);

  // Common sync-aware operations
  Future<int> insert(T domain) async {
    final companion = toCompanion(domain);
    // Ensure sync status is pending and timestamps are set
    // This depends on the specific companion type, usually handled in specific repos
    return await db.into(table as dynamic).insert(companion);
  }

  Future<bool> updateRecord(T domain) async {
    final companion = toCompanion(domain);
    return await db.update(table as dynamic).replace(companion as dynamic);
  }

  Future<int> softDelete(String uuid);
}
