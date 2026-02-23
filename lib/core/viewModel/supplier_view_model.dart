import 'package:drift/drift.dart' as drift;
import 'package:ezo/core/database/app_database.dart';
import '../services/sync_service.dart';
import '../repositories/supplier_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/app_config.dart';
import '../../core/models/user.dart';
import '../../core/models/enums/sync_status.dart';

class SupplierViewModel {
  final AppDatabase _database;
  final SupplierRepository _supplierRepository;
  final SyncService _syncService;
  final _uuid = const Uuid();

  SupplierViewModel(
    this._database,
    this._supplierRepository,
    this._syncService,
  );

  // Expose stream of suppliers
  Stream<List<SupplierEntity>> get allSuppliers => _database
      .select(_database.suppliers)
      .watch()
      .map(
        (suppliers) => suppliers.where((s) => s.isDeleted == false).toList(),
      );

  Future<void> addSupplier({
    required String name,
    String? phone,
    String? email,
    String? address,
    // No credit limit for suppliers as per requirement
  }) async {
    // Using repo
    await _supplierRepository.createSupplier(
      User(
        id: 0,
        uuid: _uuid.v4(),
        name: name,
        phone: phone ?? '',
        email: email ?? '',
        address: address ?? '',
        role: 'supplier',
        currentBalance: 0,
      ),
    );
  }

  Future<void> updateSupplier(SupplierEntity user) async {
    final domainUser = User(
      id: user.id,
      uuid: user.uuid,
      name: user.name,
      phone: user.phone,
      email: user.email,
      address: user.address,
      role: 'supplier',
      currentBalance:
          0, // Suppliers in this schema don't have balance in User model?
      syncStatus: SyncStatus.fromValue(user.syncStatus),
      isDeleted: user.isDeleted,
    );
    await _supplierRepository.updateSupplier(domainUser);
  }

  Future<void> deleteSupplier(int id) async {
    await _supplierRepository.deleteSupplier(id);
  }

  Future<void> syncPendingSuppliers() async {
    await _syncService.push();
  }

  Future<void> fetchAndSync() async {
    await _syncService.pull();
  }
}
