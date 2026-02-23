import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/user.dart'; // Retaining User model for now but ideally should be Customer
import '../models/enums/sync_status.dart';
import '../di/service_locator.dart';

class CustomerRepository {
  final AppDatabase _database;

  CustomerRepository(this._database);

  Future<List<User>> getAllCustomers() async {
    final entities = await (_database.select(
      _database.customers,
    )..where((t) => t.isDeleted.equals(false))).get();
    return entities.map(_mapToDomain).toList();
  }

  Stream<List<User>> watchAllCustomers() {
    return (_database.select(_database.customers)
          ..where((t) => t.isDeleted.equals(false)))
        .watch()
        .map((entities) => entities.map(_mapToDomain).toList());
  }

  Future<User?> getCustomerById(int id) async {
    try {
      final entity = await (_database.select(
        _database.customers,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
      return entity != null ? _mapToDomain(entity) : null;
    } catch (e) {
      return null;
    }
  }

  Future<int> createCustomer(User user) async {
    final companion = CustomersCompanion(
      uuid: Value(user.uuid),
      name: Value(user.name),
      phone: Value(user.phone),
      email: Value(user.email),
      address: Value(user.address),
      creditLimit: Value(user.creditLimit),
      currentBalance: Value(user.currentBalance),
      // Default tenantId to 1 for now until we handle multi-tenancy context
      tenantId: const Value(1),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(user.isDeleted),
    );
    final id = await _database.into(_database.customers).insert(companion);
    ServiceLocator.instance.syncService.sync();
    return id;
  }

  Future<bool> updateCustomer(User user) async {
    final companion = CustomersCompanion(
      id: Value(user.id),
      uuid: Value(user.uuid),
      name: Value(user.name),
      phone: Value(user.phone),
      email: Value(user.email),
      address: Value(user.address),
      creditLimit: Value(user.creditLimit),
      currentBalance: Value(user.currentBalance),
      updatedAt: Value(DateTime.now()),
      syncStatus: Value(SyncStatus.pending.value),
      isDeleted: Value(user.isDeleted),
    );
    final success = await _database
        .update(_database.customers)
        .replace(companion);
    if (success) {
      ServiceLocator.instance.syncService.sync();
    }
    return success;
  }

  Future<int> deleteCustomer(int id) async {
    final result =
        await (_database.update(
          _database.customers,
        )..where((t) => t.id.equals(id))).write(
          CustomersCompanion(
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

  User _mapToDomain(CustomerEntity entity) {
    return User(
      id: entity.id,
      uuid: entity.uuid,
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      address: entity.address,
      role: 'customer', // Hardcoded as we are in CustomerRepository
      creditLimit: entity.creditLimit,
      currentBalance: entity.currentBalance,
      syncStatus: SyncStatus.fromValue(entity.syncStatus),
      isDeleted: entity.isDeleted,
    );
  }
}
