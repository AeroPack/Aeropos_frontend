import '../database/app_database.dart'; // For ProductEntity
import 'enums/sync_status.dart';

class Sale {
  final int? id; // Nullable for new sales not yet persisted
  final String uuid;
  final String invoiceNumber;
  final int? customerId;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;
  final String? paymentMethod; // Made nullable to fit generic usage if needed
  final String? status;
  final String? notes;
  final DateTime createdAt;
  final SyncStatus syncStatus;
  final bool isDeleted;
  final List<SaleItem> items; // Added items list

  Sale({
    this.id,
    required this.uuid,
    required this.invoiceNumber,
    this.customerId,
    this.subtotal = 0.0, // Added defaults
    this.tax = 0.0,
    this.discount = 0.0,
    required this.total,
    this.paymentMethod,
    this.status,
    this.notes,
    required this.createdAt,
    this.syncStatus = SyncStatus.synced,
    this.isDeleted = false,
    required this.items,
  });
}

class SaleItem {
  final int? id;
  final String uuid;
  final int? saleId;
  final int productId; // Keep ID for DB reference
  final ProductEntity product; // Added for UI/Invoice generation
  final int quantity;
  final double unitPrice;
  final double discount;
  final double total;
  final SyncStatus syncStatus;
  final bool isDeleted;

  SaleItem({
    this.id,
    required this.uuid,
    this.saleId,
    required this.productId,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.discount = 0.0,
    required this.total,
    this.syncStatus = SyncStatus.synced,
    this.isDeleted = false,
  });
}
