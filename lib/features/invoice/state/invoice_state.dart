import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class InvoiceItem {
  final ProductEntity product;
  final int quantity;
  final int bonus;
  final double unitPrice;

  const InvoiceItem({
    required this.product,
    this.quantity = 1,
    this.bonus = 0,
    required this.unitPrice,
  });

  double get totalPrice => unitPrice * quantity;

  InvoiceItem copyWith({
    ProductEntity? product,
    int? quantity,
    int? bonus,
    double? unitPrice,
  }) {
    return InvoiceItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      bonus: bonus ?? this.bonus,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }
}

class InvoiceState {
  final String invoiceNumber;
  final CustomerEntity? selectedCustomer;
  final List<InvoiceItem> items;
  final double taxRate; // 0.15 for 15% as per doc

  const InvoiceState({
    this.invoiceNumber = '',
    this.selectedCustomer,
    this.items = const [],
    this.taxRate = 0.15,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get taxAmount => subtotal * taxRate;
  double get total => subtotal + taxAmount;

  InvoiceState copyWith({
    String? invoiceNumber,
    CustomerEntity? selectedCustomer,
    List<InvoiceItem>? items,
    double? taxRate,
  }) {
    return InvoiceState(
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      items: items ?? this.items,
      taxRate: taxRate ?? this.taxRate,
    );
  }
}  

class InvoiceNotifier extends StateNotifier<InvoiceState> {
  InvoiceNotifier()
    : super(
        InvoiceState(
          invoiceNumber: 'INV-${DateTime.now().millisecondsSinceEpoch}',
        ),
      );

  void setInvoiceNumber(String value) {
    state = state.copyWith(invoiceNumber: value);
  }

  void setCustomer(CustomerEntity? customer) {
    state = state.copyWith(selectedCustomer: customer);
  }

  void addItem(ProductEntity product, int quantity, int bonus) {
    state = state.copyWith(
      items: [
        ...state.items,
        InvoiceItem(
          product: product,
          quantity: quantity,
          bonus: bonus,
          unitPrice: product.price,
        ),
      ],
    );
  }

  void removeItem(int index) {
    final newItems = List<InvoiceItem>.from(state.items);
    newItems.removeAt(index);
    state = state.copyWith(items: newItems);
  }

  void reset() {
    state = InvoiceState(
      invoiceNumber: 'INV-${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  Future<void> saveInvoice() async {
    final db = ServiceLocator.instance.database;

    // 1. Create Invoice Record
    final invoiceId = await db.insertInvoice(
      InvoicesCompanion(
        uuid: Value(const Uuid().v4()),
        invoiceNumber: Value(state.invoiceNumber),
        customerId: Value(state.selectedCustomer?.id),
        date: Value(DateTime.now()),
        subtotal: Value(state.subtotal),
        tax: Value(state.taxAmount),
        total: Value(state.total),
        syncStatus: const Value(1), // Pending
      ),
    );

    // 2. Create Invoice Items
    final itemCompanions = state.items
        .map(
          (item) => InvoiceItemsCompanion(
            invoiceId: Value(invoiceId),
            productId: Value(item.product.id),
            quantity: Value(item.quantity),
            bonus: Value(item.bonus),
            unitPrice: Value(item.unitPrice),
            totalPrice: Value(item.totalPrice),
          ),
        )
        .toList();

    await db.insertInvoiceItems(itemCompanions);

    reset();
  }
}

final invoiceProvider = StateNotifierProvider<InvoiceNotifier, InvoiceState>((
  ref,
) {
  return InvoiceNotifier();
});

final productListProvider = StreamProvider<List<ProductEntity>>((ref) {
  final database = ServiceLocator.instance.database;
  return database.watchAllProducts();
});

final customerListProvider = StreamProvider<List<CustomerEntity>>((ref) {
  final database = ServiceLocator.instance.database;
  return database.select(database.customers).watch();
});

final invoiceHistoryProvider = StreamProvider<List<TypedResult>>((ref) {
  final database = ServiceLocator.instance.database;
  return database.watchInvoicesWithCustomer();
});

final detailedInvoiceItemsProvider = StreamProvider<List<TypedResult>>((ref) {
  final database = ServiceLocator.instance.database;
  return database.watchInvoiceItemsDetailed();
});
