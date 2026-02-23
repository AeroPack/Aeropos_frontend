import 'package:drift/drift.dart';
import 'package:dio/dio.dart';
import '../models/sale.dart';
import '../models/enums/sync_status.dart';
import '../database/app_database.dart';
import '../di/service_locator.dart';
import '../exceptions/sale_validation_exception.dart';
import 'package:uuid/uuid.dart';

class SaleRepository {
  final AppDatabase _db;
  SaleRepository(this._db);

  Future<List<Sale>> getAllSales() async {
    final invoiceEntities = await _db.getAllInvoices();
    List<Sale> sales = [];
    for (var entity in invoiceEntities) {
      final items = await getSaleItems(entity.id);
      sales.add(
        Sale(
          id: entity.id,
          uuid: entity.uuid,
          invoiceNumber: entity.invoiceNumber,
          customerId: entity.customerId,
          subtotal: entity.subtotal,
          tax: entity.tax,
          discount: entity.discount,
          total: entity.total,
          createdAt: entity.date,
          syncStatus: SyncStatus.fromValue(entity.syncStatus),
          isDeleted: entity.isDeleted,
          items: items,
        ),
      );
    }
    return sales;
  }

  Stream<List<Sale>> watchAllSales() {
    return _db.watchAllInvoices().map((entities) {
      return entities
          .map(
            (entity) => Sale(
              id: entity.id,
              uuid: entity.uuid,
              invoiceNumber: entity.invoiceNumber,
              customerId: entity.customerId,
              subtotal: entity.subtotal,
              tax: entity.tax,
              discount: entity.discount,
              total: entity.total,
              createdAt: entity.date,
              syncStatus: SyncStatus.fromValue(entity.syncStatus),
              isDeleted: entity.isDeleted,
              items: [],
            ),
          )
          .toList();
    });
  }

  Stream<List<TypedResult>> watchSalesWithCustomer() {
    return _db.watchInvoicesWithCustomer();
  }

  Future<Sale?> getSaleById(int id) async {
    final sales = await getAllSales();
    try {
      return sales.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<int> createSale(Sale sale) async {
    // Validate products before creating sale
    final validationErrors = await validateSaleProducts(sale);
    if (validationErrors.isNotEmpty) {
      throw SaleValidationException(
        'Cannot create sale with invalid products',
        invalidProducts: validationErrors,
      );
    }

    final invoiceId = await _db.transaction(() async {
      final invoiceId = await _db.insertInvoice(
        InvoicesCompanion.insert(
          uuid: sale.uuid,
          invoiceNumber: sale.invoiceNumber,
          date: sale.createdAt,
          subtotal: sale.subtotal,
          tax: sale.tax,
          discount: Value(sale.discount),
          total: sale.total,
          customerId: Value(sale.customerId),
          syncStatus: Value(SyncStatus.pending.value),
          isDeleted: Value(false),
          updatedAt: Value(DateTime.now()),
          tenantId: 1,
        ),
      );

      final itemCompanions = sale.items
          .map(
            (item) => InvoiceItemsCompanion.insert(
              invoiceId: invoiceId,
              productId: item.productId,
              quantity: item.quantity,
              unitPrice: item.unitPrice,
              discount: Value(item.discount),
              totalPrice: item.total,
              uuid: item.uuid.isEmpty ? const Uuid().v4() : item.uuid,
              syncStatus: Value(SyncStatus.pending.value),
              isDeleted: Value(false),
              updatedAt: Value(DateTime.now()),
              tenantId: 1,
            ),
          )
          .toList();

      await _db.insertInvoiceItems(itemCompanions);
      return invoiceId;
    });

    // Trigger sync and handle errors
    try {
      ServiceLocator.instance.syncService.sync();
    } catch (e) {
      print('Sync error after creating sale: $e');
      if (e is DioException && e.response?.statusCode == 400) {
        final errorData = e.response?.data;
        if (errorData is Map && errorData.containsKey('invalidProducts')) {
          final invalidProducts = (errorData['invalidProducts'] as List)
              .map((p) => p.toString())
              .toList();
          throw SaleValidationException(
            'Server rejected invoice due to invalid products',
            invalidProducts: invalidProducts,
          );
        }
        throw SaleValidationException(
          'Server validation failed: ${errorData.toString()}',
        );
      }
      // Re-throw other errors
      rethrow;
    }

    return invoiceId;
  }

  Future<List<SaleItem>> getSaleItems(int saleId) async {
    final results = await _db.getInvoiceItemsWithProduct(saleId);
    return results.map((row) {
      final item = row.readTable(_db.invoiceItems);
      final product = row.readTable(_db.products);
      return SaleItem(
        id: item.id,
        uuid: "",
        saleId: item.invoiceId,
        productId: item.productId,
        product: product,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        discount: item.discount,
        total: item.totalPrice,
        syncStatus: SyncStatus.fromValue(item.syncStatus),
        isDeleted: item.isDeleted,
      );
    }).toList();
  }

  /// Validate that all products in the sale exist and are active
  Future<List<String>> validateSaleProducts(Sale sale) async {
    final errors = <String>[];

    for (final item in sale.items) {
      final product = await (_db.select(
        _db.products,
      )..where((t) => t.id.equals(item.productId))).getSingleOrNull();

      if (product == null) {
        errors.add('Product ID ${item.productId} not found');
      } else if (product.isDeleted) {
        errors.add('${product.name} (deleted)');
      } else if (!product.isActive) {
        errors.add('${product.name} (inactive)');
      }
    }

    return errors;
  }
}
