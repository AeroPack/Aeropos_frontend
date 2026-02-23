import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/database/app_database.dart';
import '../state/invoice_state.dart';

class InvoiceFormScreen extends ConsumerStatefulWidget {
  const InvoiceFormScreen({super.key});

  @override
  ConsumerState<InvoiceFormScreen> createState() => _InvoiceFormScreenState();
}

class _InvoiceFormScreenState extends ConsumerState<InvoiceFormScreen> {
  final _invoiceNoController = TextEditingController();
  final _qtyController = TextEditingController(text: '1');
  final _bonusController = TextEditingController(text: '0');

  ProductEntity? _selectedProduct;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _invoiceNoController.text = ref.read(invoiceProvider).invoiceNumber;
    });
  }

  @override
  void dispose() {
    _invoiceNoController.dispose();
    _qtyController.dispose();
    _bonusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceState = ref.watch(invoiceProvider);
    final productsAsync = ref.watch(productListProvider);
    final customersAsync = ref.watch(customerListProvider);

    return Scaffold(
      backgroundColor: PosColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PosPageHeader(
              title: "Create New Invoice",
              subTitle: "Generate a new billing transaction for a customer",
              onBack: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 32),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Panel: Form
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildInfoSection(customersAsync, invoiceState),
                      const SizedBox(height: 24),
                      _buildProductSection(productsAsync),
                      const SizedBox(height: 24),
                      _buildItemsTable(invoiceState),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Right Panel: Summary
                Expanded(flex: 1, child: _buildSummarySection(invoiceState)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    AsyncValue<List<CustomerEntity>> customersAsync,
    InvoiceState state,
  ) {
    return PosContentCard(
      title: "Invoice Information",
      child: PosFormGrid(
        children: [
          customersAsync.when(
            data: (customers) {
              final customerItems = customers
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                  .toList();
              return PosDropdown<CustomerEntity>(
                label: "Customer Name",
                items: customerItems,
                value: state.selectedCustomer,
                onChanged: (val) =>
                    ref.read(invoiceProvider.notifier).setCustomer(val),
                isRequired: true,
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Text("Error: $e"),
          ),
          PosTextInput(
            label: "Invoice No.",
            controller: _invoiceNoController,
            onChanged: (val) =>
                ref.read(invoiceProvider.notifier).setInvoiceNumber(val),
            isRequired: true,
            placeholder: "INV-0000",
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection(AsyncValue<List<ProductEntity>> productsAsync) {
    return PosContentCard(
      title: "Add Product",
      child: Column(
        children: [
          PosFormGrid(
            children: [
              productsAsync.when(
                data: (products) => PosDropdown<ProductEntity>(
                  label: "Product Name",
                  items: products
                      .map(
                        (p) => DropdownMenuItem(value: p, child: Text(p.name)),
                      )
                      .toList(),
                  value: _selectedProduct,
                  onChanged: (val) => setState(() => _selectedProduct = val),
                  isRequired: true,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Text("Error: $e"),
              ),
              PosTextInput(
                label: "Pack Size",
                placeholder: "Auto-filled",
                controller: TextEditingController(
                  text: _selectedProduct?.packSize ?? '',
                ),
              ),
            ],
          ),
          PosFormGrid(
            children: [
              PosTextInput(
                label: "Quantity",
                controller: _qtyController,
                placeholder: "1",
              ),
              PosTextInput(
                label: "Bonus",
                controller: _bonusController,
                placeholder: "0",
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_selectedProduct != null) {
                  final qty = int.tryParse(_qtyController.text) ?? 1;
                  final bonus = int.tryParse(_bonusController.text) ?? 0;
                  ref
                      .read(invoiceProvider.notifier)
                      .addItem(_selectedProduct!, qty, bonus);
                  setState(() {
                    _selectedProduct = null;
                    _qtyController.text = '1';
                    _bonusController.text = '0';
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PosColors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.add, size: 20),
              label: const Text("Add Item"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsTable(InvoiceState state) {
    return PosContentCard(
      title: "Invoice Items",
      child: state.items.isEmpty
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(
                  "No items added yet",
                  style: TextStyle(color: PosColors.textLight),
                ),
              ),
            )
          : DataTable(
              columnSpacing: 24,
              columns: const [
                DataColumn(label: Text("Product")),
                DataColumn(label: Text("Price")),
                DataColumn(label: Text("Qty")),
                DataColumn(label: Text("Bonus")),
                DataColumn(label: Text("Total")),
                DataColumn(label: Text("")),
              ],
              rows: state.items.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                return DataRow(
                  cells: [
                    DataCell(Text(item.product.name)),
                    DataCell(Text("\$${item.unitPrice.toStringAsFixed(2)}")),
                    DataCell(Text(item.quantity.toString())),
                    DataCell(Text(item.bonus.toString())),
                    DataCell(Text("\$${item.totalPrice.toStringAsFixed(2)}")),
                    DataCell(
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () =>
                            ref.read(invoiceProvider.notifier).removeItem(idx),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
    );
  }

  Widget _buildSummarySection(InvoiceState state) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PosColors.navy,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment Summary",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _summaryRow("Subtotal", state.subtotal),
          _summaryRow("VAT (15%)", state.taxAmount),
          const Divider(color: Colors.white24, height: 32),
          _summaryRow("Total Payable", state.total, isTotal: true),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.items.isEmpty
                  ? null
                  : () async {
                      await ref.read(invoiceProvider.notifier).saveInvoice();
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invoice Saved Successfully!"),
                          ),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: PosColors.navy,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Save & Print",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => ref.read(invoiceProvider.notifier).reset(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Reset Form"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "\$${value.toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: isTotal ? 20 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
