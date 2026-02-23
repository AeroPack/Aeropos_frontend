import 'package:flutter_test/flutter_test.dart';
import 'package:ezo/features/sales/state/cart_notifier.dart';
import 'package:ezo/core/models/product.dart';
import 'package:ezo/core/models/enums/sync_status.dart';

void main() {
  group('Cart GST Calculations', () {
    final productExclusive = Product(
      id: 1,
      uuid: 'p1',
      name: 'Test Product Exclusive',
      sku: 'SKU001',
      price: 100.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      gstType: 'Exclusive',
      gstRate: '18%',
    );

    final productInclusive = Product(
      id: 2,
      uuid: 'p2',
      name: 'Test Product Inclusive',
      sku: 'SKU002',
      price: 118.0, 
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      gstType: 'Inclusive',
      gstRate: '18%',
    );

    test('Exclusive GST calculation', () {
      final notifier = CartNotifier();
      notifier.addItem(productExclusive, 1);
      
      expect(notifier.tax, closeTo(18.0, 0.01));
      expect(notifier.subtotal, closeTo(100.0, 0.01));
      expect(notifier.total, closeTo(118.0, 0.01));
    });

    test('Inclusive GST calculation', () {
      final notifier = CartNotifier();
      notifier.addItem(productInclusive, 1);
      
      expect(notifier.tax, closeTo(18.0, 0.01));
      expect(notifier.subtotal, closeTo(100.0, 0.01));
      expect(notifier.total, closeTo(118.0, 0.01));
    });

    test('Multiple items GST calculation', () {
      final notifier = CartNotifier();
      notifier.addItem(productExclusive, 1); // 100 + 18
      notifier.addItem(productInclusive, 1); // 100 + 18 (price 118)
      
      expect(notifier.tax, closeTo(36.0, 0.01));
      expect(notifier.subtotal, closeTo(200.0, 0.01));
      expect(notifier.total, closeTo(236.0, 0.01));
    });
    
    test('Excluding keyword support', () {
        final productExcluding = productExclusive.copyWith(gstType: 'excluding');
        final notifier = CartNotifier();
        notifier.addItem(productExcluding, 1);
        
        expect(notifier.tax, closeTo(18.0, 0.01));
    });
  });
}
