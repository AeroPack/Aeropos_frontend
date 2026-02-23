import 'package:flutter/material.dart';
import '../state/cart_notifier.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  late final CartNotifier _cartNotifier;

  @override
  void initState() {
    super.initState();
    _cartNotifier = CartNotifier();
  }

  @override
  void dispose() {
    _cartNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Point of Sale'),
      ),
      body: Row(
        children: [
          // Product selector (left side)
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[100],
              child: const Center(
                child: Text('Product Selector'),
              ),
            ),
          ),

          // Cart (right side)
          Expanded(
            child: ListenableBuilder(
              listenable: _cartNotifier,
              builder: (context, _) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cart (${_cartNotifier.itemCount} items)',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _cartNotifier.items.isEmpty
                            ? const Center(child: Text('Cart is empty'))
                            : ListView.builder(
                                itemCount: _cartNotifier.items.length,
                                  itemBuilder: (context, index) {
                                    final item = _cartNotifier.items[index];
                                    final product = item.product;
                                    final gstInfo = (product.gstRate != null && product.gstType != null)
                                        ? ' | GST: ${product.gstRate} (${product.gstType})'
                                        : '';
                                    return ListTile(
                                      title: Text(product.name),
                                      subtitle: Text(
                                        'Qty: ${item.quantity} | SKU: ${product.sku}\n$gstInfo',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      isThreeLine: gstInfo.isNotEmpty,
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text('₹${item.total.toStringAsFixed(2)}', 
                                            style: const TextStyle(fontWeight: FontWeight.bold)),
                                          if (item.tax > 0)
                                            Text('GST: ₹${item.tax.toStringAsFixed(2)}',
                                              style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                                        ],
                                      ),
                                    );
                                  },
                              ),
                      ),
                      const Divider(),
                      _buildTotals(),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _cartNotifier.items.isEmpty ? null : _handleCheckout,
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotals() {
    return Column(
      children: [
        _buildTotalRow('Subtotal', _cartNotifier.subtotal),
        _buildTotalRow('GST', _cartNotifier.tax),
        const Divider(),
        _buildTotalRow('Total', _cartNotifier.total, isBold: true),
      ],
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _handleCheckout() {
    // Implement checkout logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checkout functionality coming soon')),
    );
  }
}
