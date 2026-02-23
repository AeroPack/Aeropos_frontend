import 'package:uuid/uuid.dart';
import 'enums/sync_status.dart';

class Invoice {
  final int? id;
  final String uuid;
  final String invoiceNumber;
  final int? customerId;
  final DateTime date;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;
  final String? signUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SyncStatus syncStatus;
  final bool isDeleted;
  final List<InvoiceItem> items;

  Invoice({
    this.id,
    String? uuid,
    required this.invoiceNumber,
    this.customerId,
    required this.date,
    required this.subtotal,
    required this.tax,
    this.discount = 0.0,
    required this.total,
    this.signUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.syncStatus = SyncStatus.synced,
    this.isDeleted = false,
    this.items = const [],
  })  : uuid = uuid ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Invoice copyWith({
    int? id,
    String? uuid,
    String? invoiceNumber,
    int? customerId,
    DateTime? date,
    double? subtotal,
    double? tax,
    double? discount,
    double? total,
    String? signUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
    bool? isDeleted,
    List<InvoiceItem>? items,
  }) {
    return Invoice(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      customerId: customerId ?? this.customerId,
      date: date ?? this.date,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      signUrl: signUrl ?? this.signUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      items: items ?? this.items,
    );
  }
}

class InvoiceItem {
  final int? id;
  final String uuid;
  final int? invoiceId;
  final int productId;
  final int quantity;
  final int bonus;
  final double unitPrice;
  final double discount;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SyncStatus syncStatus;
  final bool isDeleted;
  
  // Helper field for UI display, not stored in InvoiceItems table directly
  final String? productName;

  InvoiceItem({
    this.id,
    this.invoiceId,
    required this.productId,
    required this.quantity,
    this.bonus = 0,
    required this.unitPrice,
    this.discount = 0.0,
    required this.totalPrice,
    String? uuid,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.syncStatus = SyncStatus.synced,
    this.isDeleted = false,
    this.productName,
  })  : uuid = uuid ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  InvoiceItem copyWith({
    int? id,
    int? invoiceId,
    int? productId,
    int? quantity,
    int? bonus,
    double? unitPrice,
    double? discount,
    double? totalPrice,
    String? uuid,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
    bool? isDeleted,
    String? productName,
  }) {
    return InvoiceItem(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      bonus: bonus ?? this.bonus,
      unitPrice: unitPrice ?? this.unitPrice,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      productName: productName ?? this.productName,
    );
  }
}
