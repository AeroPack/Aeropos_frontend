import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:ezo/features/pos/state/pos_category_state.dart';

// 1. Models
class CartItem {
  final ProductEntity product;
  final int quantity;
  final double manualDiscount; // The value (either Rs or %)
  final bool isPercentDiscount;

  const CartItem({
    required this.product,
    this.quantity = 1,
    this.manualDiscount = 0.0,
    this.isPercentDiscount = false,
  });

  double get taxRate {
    final rateStr = product.gstRate?.replaceAll('%', '') ?? '0';
    return double.tryParse(rateStr) ?? 0.0;
  }

  double get tax {
    final rate = taxRate;
    double discountAmount = manualDiscount;
    if (isPercentDiscount) {
      discountAmount = (product.price * quantity) * (manualDiscount / 100);
    }
    final totalBeforeTax = ((product.price) * quantity) - discountAmount;

    if (product.gstType?.toLowerCase() == 'exclusive' ||
        product.gstType?.toLowerCase() == 'excluding') {
      return (totalBeforeTax * rate) / 100;
    } else {
      // Inclusive case: tax = (total * rate) / (100 + rate)
      return (totalBeforeTax * rate) / (100 + rate);
    }
  }

  double get subtotal {
    double discountAmount = manualDiscount;
    if (isPercentDiscount) {
      discountAmount = (product.price * quantity) * (manualDiscount / 100);
    }
    final totalBeforeTax = ((product.price) * quantity) - discountAmount;
    if (product.gstType?.toLowerCase() == 'exclusive' ||
        product.gstType?.toLowerCase() == 'excluding') {
      return totalBeforeTax;
    } else {
      // For inclusive, the unit price already contains the tax
      return totalBeforeTax - tax;
    }
  }

  double get total => (subtotal) + (tax);

  CartItem copyWith({
    ProductEntity? product,
    int? quantity,
    double? manualDiscount,
    bool? isPercentDiscount,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      manualDiscount: manualDiscount ?? this.manualDiscount,
      isPercentDiscount: isPercentDiscount ?? this.isPercentDiscount,
    );
  }
}

class CartState {
  final List<CartItem> items;
  final CustomerEntity? selectedCustomer;
  final double overallDiscount; // The value (either Rs or %)
  final bool isOverallPercent;

  const CartState({
    this.items = const [],
    this.selectedCustomer,
    this.overallDiscount = 0.0,
    this.isOverallPercent = false,
  });

  double get itemDiscounts => items.fold(0.0, (sum, item) {
    if (item.isPercentDiscount) {
      return sum +
          (item.product.price * item.quantity * (item.manualDiscount / 100));
    }
    return sum + item.manualDiscount;
  });

  double get overallDiscountAmount {
    final itemTotal = items.fold(0.0, (sum, item) => (sum) + (item.total));
    if (isOverallPercent) {
      return itemTotal * (overallDiscount / 100);
    }
    return overallDiscount;
  }

  double get totalDiscount => itemDiscounts + overallDiscountAmount;

  double get subtotal =>
      items.fold(0.0, (sum, item) => (sum) + (item.subtotal));
  double get taxAmount => items.fold(0.0, (sum, item) => (sum) + (item.tax));
  double get total {
    final itemTotal = items.fold(0.0, (sum, item) => (sum) + (item.total));
    return itemTotal - overallDiscountAmount;
  }

  CartState copyWith({
    List<CartItem>? items,
    CustomerEntity? selectedCustomer,
    double? overallDiscount,
    bool? isOverallPercent,
  }) {
    return CartState(
      items: items ?? this.items,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      overallDiscount: overallDiscount ?? this.overallDiscount,
      isOverallPercent: isOverallPercent ?? this.isOverallPercent,
    );
  }
}

// 2. Notifier
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  void addProduct(ProductEntity product) {
    final existingIndex = state.items.indexWhere(
      (i) => i.product.id == product.id,
    );

    if (existingIndex >= 0) {
      // Increment
      final newItems = List<CartItem>.from(state.items);
      final newItem = newItems[existingIndex].copyWith(
        quantity: newItems[existingIndex].quantity + 1,
      );
      newItems[existingIndex] = newItem;
      state = state.copyWith(items: newItems);
    } else {
      double validDiscount = product.discount;
      if (product.isPercentDiscount) {
        if (validDiscount > 100) validDiscount = 100;
      } else {
        if (validDiscount > product.price) validDiscount = product.price;
      }
      if (validDiscount < 0) validDiscount = 0;

      state = state.copyWith(
        items: [
          ...state.items,
          CartItem(
            product: product,
            manualDiscount: validDiscount,
            isPercentDiscount: product.isPercentDiscount,
          ),
        ],
      );
    }
  }

  void removeProduct(ProductEntity product) {
    state = state.copyWith(
      items: state.items.where((i) => i.product.id != product.id).toList(),
    );
  }

  void updateQuantity(ProductEntity product, int quantity) {
    if (quantity <= 0) {
      removeProduct(product);
      return;
    }

    final index = state.items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      final newItems = List<CartItem>.from(state.items);
      newItems[index] = newItems[index].copyWith(quantity: quantity);
      state = state.copyWith(items: newItems);
    }
  }

  void updateItemDiscount(
    ProductEntity product,
    double discount,
    bool isPercent,
  ) {
    final index = state.items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      double validDiscount = discount;
      final itemSubtotal =
          state.items[index].product.price * state.items[index].quantity;

      if (isPercent) {
        if (validDiscount > 100) validDiscount = 100;
      } else {
        if (validDiscount > itemSubtotal) validDiscount = itemSubtotal;
      }

      if (validDiscount < 0) validDiscount = 0;

      final newItems = List<CartItem>.from(state.items);
      newItems[index] = newItems[index].copyWith(
        manualDiscount: validDiscount,
        isPercentDiscount: isPercent,
      );
      state = state.copyWith(items: newItems);
    }
  }

  void setOverallDiscount(double discount, bool isPercent) {
    double validDiscount = discount;
    final currentTotal = state.items.fold(0.0, (sum, item) => sum + item.total);

    if (isPercent) {
      if (validDiscount > 100) validDiscount = 100;
    } else {
      if (validDiscount > currentTotal) validDiscount = currentTotal;
    }

    if (validDiscount < 0) validDiscount = 0;

    state = state.copyWith(
      overallDiscount: validDiscount,
      isOverallPercent: isPercent,
    );
  }

  void clearCart() {
    state = const CartState();
  }

  void setCustomer(CustomerEntity? customer) {
    state = state.copyWith(selectedCustomer: customer);
  }
}

// 3. Providers
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

// A provider to search/filter products for the POS Grid
final productSearchProvider = StateProvider<String>((ref) => '');

final posProductListProvider = StreamProvider<List<ProductEntity>>((ref) {
  final query = ref.watch(productSearchProvider).toLowerCase();
  final selectedCategoryId = ref.watch(selectedCategoryProvider);
  final database = ServiceLocator.instance.database;

  return database.select(database.products).watch().map((products) {
    return products.where((p) {
      final matchesQuery =
          query.isEmpty ||
          p.name.toLowerCase().contains(query) ||
          (p.sku?.toLowerCase().contains(query) ?? false);

      final matchesCategory =
          selectedCategoryId == null || p.categoryId == selectedCategoryId;

      return matchesQuery && matchesCategory;
    }).toList();
  });
});

final customerSearchProvider = StateProvider<String>((ref) => '');

final posCustomerListProvider = StreamProvider<List<CustomerEntity>>((ref) {
  final query = ref.watch(customerSearchProvider).toLowerCase();
  final database = ServiceLocator.instance.database;

  // Only customers
  return database.select(database.customers).watch().map((customers) {
    return customers
        .where(
          (u) =>
              (query.isEmpty ||
              u.name.toLowerCase().contains(query) ||
              (u.phone?.toLowerCase().contains(query) ?? false)),
        )
        .toList();
  });
});
