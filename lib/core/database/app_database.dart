import 'package:drift/drift.dart';
import 'connection/connection.dart' as impl;

import 'tables/products_table.dart';
import 'tables/categories_table.dart';
import 'tables/units_table.dart';
import 'tables/tenants_table.dart';
import 'tables/customers_table.dart';
import 'tables/suppliers_table.dart';
import 'tables/employees_table.dart';
import 'tables/invoice_settings.dart';
import 'tables/invoices_table.dart';
import 'tables/invoice_items_table.dart';
import 'tables/sync_metadata.dart';
import 'tables/brands_table.dart';
import 'tables/sku_counter_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Products,
    Categories,
    Units,
    Tenants,
    Customers,
    Suppliers,
    Employees,
    InvoiceSettings,
    Invoices,
    InvoiceItems,
    Brands,
    SyncMetadata,
    SkuCounters,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? impl.connect());

  @override
  int get schemaVersion => 25;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // Existing migrations...
        if (from < 18) {
          // ... (keep existing logic if possible, but for simplicity relying on previous state)
          // If we are at 18, we don't need to repeat.
        }

        if (from < 19) {
          // Rename users to tenants
          try {
            await customStatement('ALTER TABLE users RENAME TO tenants');
          } catch (e) {
            print('Error renaming users table: $e');
            // Attempt to create tenants if rename failed (maybe users didn't exist)
            await m.createTable(tenants);
          }

          // Create new tables
          await m.createTable(customers);
          await m.createTable(suppliers);
          await m.createTable(employees);

          // Add tenantId to existing tables
          final tablesWithTenantId = [
            products,
            categories,
            units,
            brands,
            invoices,
            invoiceItems,
          ];
          for (final table in tablesWithTenantId) {
            // Cast to dynamic to access tenantId property which exists on all these tables
            await _safeAddColumn(
              m,
              table,
              'tenant_id',
              (table as dynamic).tenantId,
            );
          }
        }

        if (from < 20) {
          // Backfill tenant_id for existing rows that might be NULL
          // We default to 1 as the primary tenant
          final tablesToCheck = [
            'products',
            'categories',
            'units',
            'brands',
            'invoices',
            'invoice_items',
          ];

          for (final tableName in tablesToCheck) {
            try {
              await customStatement(
                'UPDATE "$tableName" SET tenant_id = 1 WHERE tenant_id IS NULL',
              );
              print('Backfilled tenant_id for $tableName');
            } catch (e) {
              print('Error backfilling tenant_id for $tableName: $e');
            }
          }
        }

        if (from < 21) {
          // Add role column to employees table
          await _safeAddColumn(m, employees, 'role', employees.role);
        }

        if (from < 22) {
          // Add password column to employees table
          await _safeAddColumn(m, employees, 'password', employees.password);
        }

        if (from < 23) {
          // Create SKU counter table
          await m.createTable(skuCounters);
        }

        if (from < 24) {
          // Add device_id column to sku_counters table
          await _safeAddColumn(
            m,
            skuCounters,
            'device_id',
            skuCounters.deviceId,
          );
        }

        if (from < 25) {
          // Add google_auth column to employees table
          await _safeAddColumn(
            m,
            employees,
            'google_auth',
            employees.googleAuth,
          );
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _safeAddColumn(
    Migrator m,
    dynamic table,
    String columnName,
    GeneratedColumn column,
  ) async {
    try {
      final tableName = (table as TableInfo).actualTableName;
      final result = await customSelect("PRAGMA table_info($tableName)").get();
      final columnNames = result
          .map((row) => row.read<String>('name'))
          .toList();

      if (!columnNames.contains(columnName)) {
        // SQLite doesn't support adding UNIQUE or NOT NULL without default via ALTER TABLE easily
        // We add it as a plain nullable column first to ensure the column exists for queries
        String sql = 'ALTER TABLE "$tableName" ADD COLUMN "$columnName" ';
        if (column.type == DriftSqlType.string) {
          sql += 'TEXT';
        } else if (column.type == DriftSqlType.int ||
            column.type == DriftSqlType.bool ||
            column.type == DriftSqlType.dateTime) {
          sql += 'INTEGER';
        } else if (column.type == DriftSqlType.double) {
          sql += 'REAL';
        } else {
          sql += 'TEXT';
        }

        await customStatement(sql);
        print(
          'Successfully added column $columnName to $tableName via raw SQL',
        );
      }
    } catch (e) {
      print('Error adding column $columnName: $e');
    }
  }

  // Basic CRUD for Products
  Future<List<ProductEntity>> getAllProducts() => select(products).get();
  Stream<List<ProductEntity>> watchAllProducts() =>
      (select(products)..where((tbl) => tbl.isDeleted.equals(false))).watch();
  Future<int> insertProduct(ProductsCompanion entry) =>
      into(products).insert(entry);
  Future<bool> updateProduct(ProductEntity entry) =>
      update(products).replace(entry);
  Future<int> deleteProduct(int id) async {
    final product = await (select(
      products,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    final updated = product.copyWith(
      isDeleted: true,
      syncStatus: 1,
      updatedAt: DateTime.now(),
    );
    final success = await update(products).replace(updated);
    return success ? 1 : 0;
  }

  // Products with category names
  Stream<List<TypedResult>> watchProductsWithCategory() {
    final query = select(products).join([
      leftOuterJoin(categories, categories.id.equalsExp(products.categoryId)),
      leftOuterJoin(brands, brands.id.equalsExp(products.brandId)),
    ])..where(products.isDeleted.equals(false));
    return query.watch();
  }

  // Basic CRUD for Categories
  Future<List<CategoryEntity>> getAllCategories() => select(categories).get();
  Stream<List<CategoryEntity>> watchAllCategories() =>
      (select(categories)..where((tbl) => tbl.isDeleted.equals(false))).watch();
  Future<int> insertCategory(CategoriesCompanion entry) =>
      into(categories).insert(entry);
  Future<bool> updateCategory(CategoryEntity entry) =>
      update(categories).replace(entry);
  Future<int> deleteCategory(int id) async {
    final category = await (select(
      categories,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    final updated = category.copyWith(
      isDeleted: true,
      syncStatus: 1,
      updatedAt: DateTime.now(),
    );
    final success = await update(categories).replace(updated);
    return success ? 1 : 0;
  }

  // Basic CRUD for Units
  Future<List<UnitEntity>> getAllUnits() => select(units).get();
  Stream<List<UnitEntity>> watchAllUnits() =>
      (select(units)..where((tbl) => tbl.isDeleted.equals(false))).watch();
  Future<int> insertUnit(UnitsCompanion entry) => into(units).insert(entry);
  Future<bool> updateUnit(UnitEntity entry) => update(units).replace(entry);
  Future<int> deleteUnit(int id) async {
    final unit = await (select(
      units,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    final updated = unit.copyWith(
      isDeleted: true,
      syncStatus: 1,
      updatedAt: DateTime.now(),
    );
    final success = await update(units).replace(updated);
    return success ? 1 : 0;
  }

  // Basic CRUD for Tenants
  Future<TenantEntity?> getCurrentTenant() => select(tenants).getSingleOrNull();
  Future<int> insertTenant(TenantsCompanion entry) =>
      into(tenants).insert(entry);
  Future<bool> updateTenant(TenantEntity entry) =>
      update(tenants).replace(entry);

  // Basic CRUD for Customers
  Future<List<CustomerEntity>> getAllCustomers() => select(customers).get();
  Stream<List<CustomerEntity>> watchAllCustomers() =>
      (select(customers)..where((tbl) => tbl.isDeleted.equals(false))).watch();
  Future<int> insertCustomer(CustomersCompanion entry) =>
      into(customers).insert(entry);
  Future<bool> updateCustomer(CustomerEntity entry) =>
      update(customers).replace(entry);
  Future<int> deleteCustomer(int id) async {
    final item = await (select(
      customers,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    final updated = item.copyWith(
      isDeleted: true,
      syncStatus: 1,
      updatedAt: DateTime.now(),
    );
    return (await update(customers).replace(updated)) ? 1 : 0;
  }

  // Basic CRUD for Suppliers
  Future<List<SupplierEntity>> getAllSuppliers() => select(suppliers).get();
  Stream<List<SupplierEntity>> watchAllSuppliers() =>
      (select(suppliers)..where((tbl) => tbl.isDeleted.equals(false))).watch();
  Future<int> insertSupplier(SuppliersCompanion entry) =>
      into(suppliers).insert(entry);
  Future<bool> updateSupplier(SupplierEntity entry) =>
      update(suppliers).replace(entry);
  Future<int> deleteSupplier(int id) async {
    final item = await (select(
      suppliers,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    final updated = item.copyWith(
      isDeleted: true,
      syncStatus: 1,
      updatedAt: DateTime.now(),
    );
    return (await update(suppliers).replace(updated)) ? 1 : 0;
  }

  // Basic CRUD for Employees
  Future<List<EmployeeEntity>> getAllEmployees() => select(employees).get();
  Stream<List<EmployeeEntity>> watchAllEmployees() =>
      (select(employees)..where((tbl) => tbl.isDeleted.equals(false))).watch();
  Future<int> insertEmployee(EmployeesCompanion entry) =>
      into(employees).insert(entry);
  Future<bool> updateEmployee(EmployeeEntity entry) =>
      update(employees).replace(entry);
  Future<int> deleteEmployee(int id) async {
    final item = await (select(
      employees,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    final updated = item.copyWith(
      isDeleted: true,
      syncStatus: 1,
      updatedAt: DateTime.now(),
    );
    return (await update(employees).replace(updated)) ? 1 : 0;
  }

  // Basic CRUD for Brands
  Future<List<BrandEntity>> getAllBrands() => select(brands).get();
  Stream<List<BrandEntity>> watchAllBrands() =>
      (select(brands)..where((tbl) => tbl.isDeleted.equals(false))).watch();
  Future<int> insertBrand(BrandsCompanion entry) => into(brands).insert(entry);
  Future<bool> updateBrand(BrandEntity entry) => update(brands).replace(entry);
  Future<int> deleteBrand(int id) async {
    final brand = await (select(
      brands,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    final updated = brand.copyWith(
      isDeleted: true,
      syncStatus: 1,
      updatedAt: DateTime.now(),
    );
    final success = await update(brands).replace(updated);
    return success ? 1 : 0;
  }

  // Invoice Settings CRUD
  Future<InvoiceSettingEntity?> getInvoiceSettings() =>
      select(invoiceSettings).getSingleOrNull();
  Future<int> upsertInvoiceSettings(InvoiceSettingsCompanion entry) =>
      into(invoiceSettings).insertOnConflictUpdate(entry);

  // Invoice CRUD
  Future<int> insertInvoice(InvoicesCompanion entry) =>
      into(invoices).insert(entry);
  Future<void> insertInvoiceItems(List<InvoiceItemsCompanion> entries) async {
    await batch((batch) {
      batch.insertAll(invoiceItems, entries);
    });
  }

  Future<List<InvoiceEntity>> getAllInvoices() => select(invoices).get();
  Stream<List<InvoiceEntity>> watchAllInvoices() => select(invoices).watch();

  Future<List<InvoiceItemEntity>> getInvoiceItems(int invoiceId) => (select(
    invoiceItems,
  )..where((tbl) => tbl.invoiceId.equals(invoiceId))).get();

  Future<List<TypedResult>> getInvoiceItemsWithProduct(int invoiceId) {
    final query = select(invoiceItems).join([
      innerJoin(products, products.id.equalsExp(invoiceItems.productId)),
    ])..where(invoiceItems.invoiceId.equals(invoiceId));
    return query.get();
  }

  // Joined query for history
  Stream<List<TypedResult>> watchInvoicesWithCustomer() {
    final query = select(invoices).join([
      leftOuterJoin(customers, customers.id.equalsExp(invoices.customerId)),
    ]);
    query.orderBy([OrderingTerm.desc(invoices.date)]);
    return query.watch();
  }

  Stream<List<TypedResult>> watchInvoiceItemsDetailed() {
    final query = select(invoiceItems).join([
      innerJoin(invoices, invoices.id.equalsExp(invoiceItems.invoiceId)),
      innerJoin(products, products.id.equalsExp(invoiceItems.productId)),
      leftOuterJoin(customers, customers.id.equalsExp(invoices.customerId)),
    ]);
    query.orderBy([
      OrderingTerm.desc(invoices.date),
      OrderingTerm.desc(invoiceItems.id),
    ]);
    return query.watch();
  }

  Future<List<TypedResult>> getInvoiceItemsDetailedPaginated({
    required int limit,
    required int offset,
    String? queryStr,
  }) {
    final query = select(invoiceItems).join([
      innerJoin(invoices, invoices.id.equalsExp(invoiceItems.invoiceId)),
      innerJoin(products, products.id.equalsExp(invoiceItems.productId)),
      leftOuterJoin(customers, customers.id.equalsExp(invoices.customerId)),
    ]);

    if (queryStr != null && queryStr.isNotEmpty) {
      final q = queryStr.toLowerCase();
      query.where(
        invoices.invoiceNumber.lower().contains(q) |
            products.name.lower().contains(q) |
            customers.name.lower().contains(q),
      );
    }

    query.orderBy([
      OrderingTerm.desc(invoices.date),
      OrderingTerm.desc(invoiceItems.id),
    ]);

    query.limit(limit, offset: offset);

    return query.get();
  }

  Future<int> getInvoiceItemsCount({String? queryStr}) async {
    final countExp = invoiceItems.id.count();
    final query = selectOnly(invoiceItems)..addColumns([countExp]);

    query.join([
      innerJoin(invoices, invoices.id.equalsExp(invoiceItems.invoiceId)),
      innerJoin(products, products.id.equalsExp(invoiceItems.productId)),
      leftOuterJoin(customers, customers.id.equalsExp(invoices.customerId)),
    ]);

    if (queryStr != null && queryStr.isNotEmpty) {
      final q = queryStr.toLowerCase();
      query.where(
        invoices.invoiceNumber.lower().contains(q) |
            products.name.lower().contains(q) |
            customers.name.lower().contains(q),
      );
    }

    final result = await query.map((row) => row.read(countExp)).getSingle();
    return result ?? 0;
  }

  // Clear all data from the database
  Future<void> clearAllData() async {
    await transaction(() async {
      // Delete in order respecting foreign key constraints
      // Child tables first
      await delete(invoiceItems).go();
      await delete(invoices).go();

      // Then main entity tables
      await delete(products).go();
      await delete(tenants).go();
      await delete(customers).go();
      await delete(suppliers).go();
      await delete(employees).go();
      await delete(brands).go();
      await delete(units).go();
      await delete(categories).go();

      // Clear sync metadata to force full sync
      await delete(syncMetadata).go();

      print('All data cleared from local database');
    });
  }

  // SKU Counter methods
  Future<SkuCounterEntity?> getSkuCounter(String deviceId) async {
    return await (select(
      skuCounters,
    )..where((t) => t.deviceId.equals(deviceId))).getSingleOrNull();
  }

  Future<String> getNextSku(String deviceId) async {
    return await transaction(() async {
      // Get or create counter for this device
      var counter = await getSkuCounter(deviceId);

      if (counter == null) {
        // Initialize counter for this device
        await into(skuCounters).insert(
          SkuCountersCompanion(
            prefix: const Value('SKU'),
            deviceId: Value(deviceId),
            currentNumber: const Value(1),
            updatedAt: Value(DateTime.now()),
          ),
        );
        return 'SKU-$deviceId-0001';
      }

      // Increment counter
      final nextNumber = counter.currentNumber + 1;
      final updated = counter.copyWith(
        currentNumber: nextNumber,
        updatedAt: DateTime.now(),
      );
      await update(skuCounters).replace(updated);

      // Format SKU with device ID and leading zeros (e.g., SKU-DEV1-0001)
      return '${counter.prefix}-$deviceId-${nextNumber.toString().padLeft(4, '0')}';
    });
  }
}
