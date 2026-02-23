import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/user.dart'; // Using User model as temporary placeholder, ideally should be Employee
import '../models/enums/sync_status.dart';
import '../di/service_locator.dart';

class EmployeeRepository {
  final AppDatabase _database;

  EmployeeRepository(this._database);

  Future<List<User>> getAllEmployees() async {
    final entities = await (_database.select(
      _database.employees,
    )..where((t) => t.isDeleted.equals(false))).get();
    return entities.map(_mapToDomain).toList();
  }

  Stream<List<User>> watchAllEmployees() {
    return (_database.select(_database.employees)
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map((entities) => entities.map(_mapToDomain).toList());
  }

  Future<User?> getEmployeeById(int id) async {
    try {
      final entity = await (_database.select(
        _database.employees,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
      return entity != null ? _mapToDomain(entity) : null;
    } catch (e) {
      return null;
    }
  }

  Future<int> createEmployee(User user, {String? authMethod}) async {
    final companion = EmployeesCompanion(
      uuid: Value(user.uuid),
      name: Value(user.name),
      phone: Value(user.phone),
      email: Value(user.email),
      address: Value(user.address),
      role: Value(user.role),
      password: Value(user.password),
      googleAuth: Value(authMethod == 'google'),
      tenantId: const Value(1),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(user.isDeleted),
    );
    final id = await _database.into(_database.employees).insert(companion);
    ServiceLocator.instance.syncService.sync();
    return id;
  }

  Future<bool> updateEmployee(User user) async {
    final companion = EmployeesCompanion(
      id: Value(user.id),
      uuid: Value(user.uuid),
      name: Value(user.name),
      phone: Value(user.phone),
      email: Value(user.email),
      address: Value(user.address),
      role: Value(user.role),
      updatedAt: Value(DateTime.now()),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(user.isDeleted),
    );
    final success = await _database
        .update(_database.employees)
        .replace(companion);
    if (success) {
      ServiceLocator.instance.syncService.sync();
    }
    return success;
  }

  Future<int> deleteEmployee(int id) async {
    final result =
        await (_database.update(
          _database.employees,
        )..where((t) => t.id.equals(id))).write(
          EmployeesCompanion(
            isDeleted: const Value(true),
            syncStatus: Value(SyncStatus.pending.value),
            updatedAt: Value(DateTime.now()),
          ),
        );
    if (result > 0) {
      ServiceLocator.instance.syncService.sync();
    }
    return result;
  }

  User _mapToDomain(EmployeeEntity entity) {
    return User(
      id: entity.id,
      uuid: entity.uuid,
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      address: entity.address,
      role: entity.role,
      creditLimit: 0,
      currentBalance: 0,
      syncStatus: SyncStatus.fromValue(entity.syncStatus),
      isDeleted: entity.isDeleted,
    );
  }
}
