import 'package:flutter/foundation.dart';
import '../../../core/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final double unitPrice;
  final double discount;

  CartItem({
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.discount = 0.0,
  });

  double get taxRate {
    final rateStr = product.gstRate?.replaceAll('%', '') ?? '0';
    return double.tryParse(rateStr) ?? 0.0;
  }

  double get tax {
    final rate = taxRate;
    final totalBeforeTax = (unitPrice * quantity) - discount;
    
    if (product.gstType?.toLowerCase() == 'exclusive' || product.gstType?.toLowerCase() == 'excluding') {
      return (totalBeforeTax * rate) / 100;
    } else {
      // Inclusive case: tax = (total * rate) / (100 + rate)
      return (totalBeforeTax * rate) / (100 + rate);
    }
  }

  double get subtotal {
    final totalBeforeTax = (unitPrice * quantity) - discount;
    if (product.gstType?.toLowerCase() == 'exclusive' || product.gstType?.toLowerCase() == 'excluding') {
      return totalBeforeTax;
    } else {
      // For inclusive, the unit price already contains the tax
      return totalBeforeTax - tax;
    }
  }

  double get total {
    final totalBeforeTax = (unitPrice * quantity) - discount;
    if (product.gstType?.toLowerCase() == 'exclusive' || product.gstType?.toLowerCase() == 'excluding') {
      return totalBeforeTax + tax;
    } else {
      return totalBeforeTax;
    }
  }

  CartItem copyWith({
    Product? product,
    int? quantity,
    double? unitPrice,
    double? discount,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discount: discount ?? this.discount,
    );
  }
}

class CartNotifier extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.subtotal);

  double get tax => _items.fold(0.0, (sum, item) => sum + item.tax);

  double get total => _items.fold(0.0, (sum, item) => sum + item.total);

  void addItem(Product product, int quantity) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + quantity,
      );
    } else {
      _items.add(CartItem(
        product: product,
        quantity: quantity,
        unitPrice: product.price,
      ));
    }

    notifyListeners();
  }

  void removeItem(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        removeItem(productId);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
        notifyListeners();
      }
    }
  }

  void updateDiscount(int productId, double discount) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(discount: discount);
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
