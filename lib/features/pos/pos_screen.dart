import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:ezo/features/pos/state/cart_state.dart';
import 'package:ezo/features/pos/state/pos_category_state.dart';
import '../../core/models/sale.dart';
import '../../core/models/invoice_template.dart';
import '../../core/services/invoice_service.dart';
import '../inventory/reports/invoice_settings_screen.dart';
import '../../core/widgets/product_image.dart';
import '../../core/widgets/pos_toast.dart';
import '../../core/widgets/customer_form_dialog.dart';
import '../../core/di/service_locator.dart';
import '../../core/database/app_database.dart';
import '../../core/exceptions/sale_validation_exception.dart';
import '../sales/screens/invoice_preview_screen.dart';

class PosScreen extends ConsumerStatefulWidget {
  const PosScreen({super.key});
  @override
  ConsumerState<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends ConsumerState<PosScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _discountRateController = TextEditingController();
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _discountRateController.text = "0";
    // Trigger sync on page entry
    ServiceLocator.instance.syncService.pull();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _discountRateController.dispose();
    super.dispose();
  }

  // --- CHECKOUT & PRINTING LOGIC ---

  Future<void> _handleCheckout({bool shouldSave = true}) async {
    final cartState = ref.read(cartProvider);
    if (cartState.items.isEmpty) return;

    final sale = Sale(
      uuid: _uuid.v4(),
      invoiceNumber: "INV-${DateTime.now().millisecondsSinceEpoch}",
      customerId: cartState.selectedCustomer?.id,
      items: cartState.items
          .map(
            (cartItem) => SaleItem(
              uuid: _uuid.v4(),
              productId: cartItem.product.id,
              product: cartItem.product,
              quantity: cartItem.quantity,
              unitPrice: cartItem.product.price,
              discount: cartItem.manualDiscount,
              total: cartItem.total,
            ),
          )
          .toList(),
      total: cartState.total,
      subtotal: cartState.subtotal,
      tax: cartState.taxAmount,
      discount: cartState.totalDiscount,
      createdAt: DateTime.now(),
    );

    try {
      // 1. Save to database via repository ONLY if shouldSave is true
      if (shouldSave) {
        await ServiceLocator.instance.saleRepository.createSale(sale);
      }

      // 2. Prepare PDF Generation
      final template = ref.read(invoiceTemplateProvider);

      // 3. Navigate to Preview (Modal)
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.5),
        builder: (context) => InvoicePreviewScreen(
          invoiceNumber: sale.invoiceNumber,
          onLayout: (format) async {
            final pdf = await InvoiceService().generateInvoice(sale, template);
            return pdf.save();
          },
          onPrintComplete: () {
            if (shouldSave) {
              ref.read(cartProvider.notifier).clearCart();
              PosToast.showSuccess(context, "Checkout completed");
            }
            if (mounted) Navigator.pop(context); // Close dialog
          },
        ),
      );
    } on SaleValidationException catch (e) {
      // Show detailed validation error dialog
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 8),
              Text('Invalid Products'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.message),
              if (e.invalidProducts.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text(
                  'The following products have issues:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...e.invalidProducts.map(
                  (product) => Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.close, size: 16, color: Colors.red),
                        const SizedBox(width: 4),
                        Expanded(child: Text(product)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Please remove these items from your cart or sync products from the server.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                // Trigger product sync
                PosToast.showInfo(context, 'Syncing products...');
                final success = await ServiceLocator.instance.syncService
                    .syncProducts();
                if (mounted) {
                  if (success) {
                    PosToast.showSuccess(
                      context,
                      'Products synced successfully',
                    );
                  } else {
                    PosToast.showError(context, 'Failed to sync products');
                  }
                }
              },
              child: const Text('Sync Products'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      PosToast.showError(context, "Failed to process sale: $e");
    }
  }

  void _openInvoiceSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InvoiceSettingsScreen()),
    );
  }

  void _openSalesHistory() {
    context.go('/sales-history');
  }

  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (context) => CustomerFormDialog(
        onSubmit:
            ({
              required name,
              phone,
              address,
              required creditLimit,
              email,
            }) async {
              final customer = await ServiceLocator.instance.customerViewModel
                  .addCustomer(
                    name: name,
                    phone: phone,
                    email: email,
                    address: address,
                    creditLimit: creditLimit,
                  );
              if (mounted) {
                ref.read(cartProvider.notifier).setCustomer(customer);
                PosToast.showSuccess(context, "Customer created and selected");
              }
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(cartProvider, (previous, next) {
      if (next.items.isEmpty &&
          (previous != null && previous.items.isNotEmpty)) {
        _discountRateController.text = "0";
      }
    });

    final cartState = ref.watch(cartProvider);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Row(
        children: [
          // --- LEFT SIDE: PRODUCTS & CATEGORIES ---
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopToolbar(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildCategoryList(),
                _buildProductGridHeader(width),
                Expanded(child: _buildProductGrid(ref, width)),
                if (isMobile)
                  const SizedBox(height: 80), // Space for bottom bar
              ],
            ),
          ),

          // --- RIGHT SIDE: BILLING SIDEBAR (Desktop/Tablet) ---
          if (!isMobile)
            Container(
              width: 420,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: _buildCartSidebar(false),
            ),
        ],
      ),
      bottomNavigationBar: isMobile ? _buildMobileBottomBar(cartState) : null,
    );
  }

  Widget _buildCartSidebar(bool isMobile) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Column(
      children: [
        _buildOrderListHeader(cartState.items.length),
        _buildCustomerSearch(),
        const Divider(height: 1),
        Expanded(
          child: cartState.items.isEmpty
              ? _buildEmptyCart()
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartState.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = cartState.items[index];
                    return _buildCartItem(item, cartNotifier);
                  },
                ),
        ),
        // Summary Section at the bottom
        _buildSummarySection(cartState),
      ],
    );
  }

  Widget _buildCustomerSearch() {
    final cartState = ref.watch(cartProvider);
    final customerSearch = ref.watch(customerSearchProvider);
    final customersAsync = ref.watch(posCustomerListProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cartState.selectedCustomer != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                border: Border.all(color: const Color(0xFFBBF7D0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person, color: Color(0xFF16A34A), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      cartState.selectedCustomer!.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF166534),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).setCustomer(null);
                      ref.read(customerSearchProvider.notifier).state = '';
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                      color: Color(0xFF166534),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                TextField(
                  onChanged: (val) =>
                      ref.read(customerSearchProvider.notifier).state = val,
                  decoration: InputDecoration(
                    hintText: "Search Customer...",
                    prefixIcon: const Icon(Icons.person_search, size: 18),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF007AFF),
                        size: 20,
                      ),
                      onPressed: _showAddCustomerDialog,
                      tooltip: "Add New Customer",
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                ),
                if (customerSearch.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    constraints: const BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: customersAsync.when(
                      data: (customers) {
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.person_outline,
                                size: 20,
                              ),
                              title: const Text(
                                "Walk-in Customer",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .setCustomer(null);
                                ref
                                        .read(customerSearchProvider.notifier)
                                        .state =
                                    '';
                              },
                            ),
                            const Divider(height: 1),
                            if (customers.isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  "No registered customers found",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            else
                              ...customers.map(
                                (customer) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        customer.name,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      subtitle: customer.phone != null
                                          ? Text(
                                              customer.phone!,
                                              style: const TextStyle(
                                                fontSize: 11,
                                              ),
                                            )
                                          : null,
                                      onTap: () {
                                        ref
                                            .read(cartProvider.notifier)
                                            .setCustomer(customer);
                                        ref
                                                .read(
                                                  customerSearchProvider
                                                      .notifier,
                                                )
                                                .state =
                                            '';
                                      },
                                    ),
                                    const Divider(height: 1),
                                  ],
                                ),
                              ),
                          ],
                        );
                      },
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      error: (err, _) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Error: $err"),
                      ),
                    ),
                  ),
                if (customerSearch.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Default: Walk-in Customer",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMobileBottomBar(CartState cartState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${cartState.items.length} Items",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                "Rs ${cartState.total.toInt()}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF002140),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => DraggableScrollableSheet(
                  initialChildSize: 0.9,
                  minChildSize: 0.5,
                  maxChildSize: 0.95,
                  expand: false,
                  builder: (context, scrollController) => Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Expanded(child: _buildCartSidebar(true)),
                    ],
                  ),
                ),
              );
            },
            child: const Text(
              "View Cart",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- RIGHT SIDE COMPONENTS ---

  Widget _buildSummarySection(CartState cartState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment Summary",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 12),
          _summaryRow(
            "Sub Total",
            "Rs ${cartState.subtotal.toStringAsFixed(2)}",
          ),
          _summaryRow("GST", "Rs ${cartState.taxAmount.toStringAsFixed(2)}"),
          _summaryRow(
            "Total Discount",
            "Rs ${cartState.totalDiscount.toStringAsFixed(2)}",
            isRed: cartState.totalDiscount > 0,
          ),
          const SizedBox(height: 12),

          // Bill Discount Input
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _discountRateController,
                    decoration: InputDecoration(
                      labelText: "Add Bill Discount",
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      final d = double.tryParse(val) ?? 0.0;
                      ref
                          .read(cartProvider.notifier)
                          .setOverallDiscount(d, cartState.isOverallPercent);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _discountTypeToggle("Rs", !cartState.isOverallPercent, () {
                      ref
                          .read(cartProvider.notifier)
                          .setOverallDiscount(cartState.overallDiscount, false);
                    }),
                    VerticalDivider(width: 1, color: Colors.grey.shade300),
                    _discountTypeToggle("%", cartState.isOverallPercent, () {
                      ref
                          .read(cartProvider.notifier)
                          .setOverallDiscount(cartState.overallDiscount, true);
                    }),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Amount to be Paid",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "Rs ${cartState.total.toInt()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Main Action Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: cartState.items.isEmpty
                  ? null
                  : () => _handleCheckout(shouldSave: true),
              child: const Text(
                "Checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Button Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2.5,
            children: [
              _gridActionBtn(
                "Print",
                Icons.print,
                onTap: cartState.items.isEmpty
                    ? null
                    : () => _handleCheckout(shouldSave: false),
              ),
              _gridActionBtn(
                "Invoice",
                Icons.receipt_outlined,
                onTap: cartState.items.isEmpty
                    ? null
                    : () => _handleCheckout(shouldSave: false),
              ),
              _gridActionBtn(
                "Settings",
                Icons.settings,
                onTap: _openInvoiceSettings,
              ),
              _gridActionBtn("Cancel", Icons.close),
              _gridActionBtn("Void", Icons.bolt),
              _gridActionBtn(
                "Sales History",
                Icons.list_alt,
                onTap: _openSalesHistory,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gridActionBtn(String label, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade700),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI HELPERS ---

  Widget _summaryRow(
    String label,
    String value, {
    bool isBold = false,
    bool isRed = false,
    double fontSize = 16,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isRed
                  ? Colors.red
                  : (isBold ? const Color(0xFF1E293B) : Colors.grey.shade600),
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: fontSize,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isRed
                  ? Colors.red
                  : (isBold ? const Color(0xFF1E293B) : Colors.grey.shade600),
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _discountTypeToggle(
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        color: isSelected ? const Color(0xFF007AFF) : Colors.transparent,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTopToolbar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
            onPressed: () => context.go('/dashboard'), // Navigate to dashboard
            tooltip: 'Back',
          ),
          const SizedBox(width: 8),
          _actionButton("Orders", Icons.receipt_long, const Color(0xFF00A78E)),
          const SizedBox(width: 8),
          _actionButton("Reset", Icons.refresh, const Color(0xFF6366F1)),
          const Spacer(),
          const Text(
            "09:25",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF00A78E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    final categoriesAsync = ref.watch(categoryStreamProvider);
    final selectedCategoryId = ref.watch(selectedCategoryProvider);

    return categoriesAsync.when(
      data: (categories) => SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: categories.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildCategoryItem(
                name: "All",
                count: "${categories.length}",
                icon: Icons.grid_view,
                isActive: selectedCategoryId == null,
                onTap: () =>
                    ref.read(selectedCategoryProvider.notifier).state = null,
              );
            }
            final category = categories[index - 1];
            return _buildCategoryItem(
              name: category.name,
              count: "-",
              icon: Icons.category_outlined,
              isActive: selectedCategoryId == category.id,
              onTap: () => ref.read(selectedCategoryProvider.notifier).state =
                  category.id,
            );
          },
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
    );
  }

  Widget _buildCategoryItem({
    required String name,
    required String count,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? Colors.orange : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? Colors.orange : Colors.black54),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "$count items",
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGridHeader(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: [
          const Text(
            "Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: screenWidth < 600 ? double.infinity : 200,
            height: 36,
            child: TextField(
              controller: _searchController,
              onChanged: (val) =>
                  ref.read(productSearchProvider.notifier).state = val,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search, size: 18),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(WidgetRef ref, double screenWidth) {
    final List<ProductEntity> productList =
        ref.watch(posProductListProvider).value ?? [];
    int crossAxisCount = 6;
    if (screenWidth < 600) {
      crossAxisCount = 3;
    } else if (screenWidth < 900) {
      crossAxisCount = 4;
    } else if (screenWidth < 1200) {
      crossAxisCount = 5;
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.8,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return InkWell(
          onTap: () => ref.read(cartProvider.notifier).addProduct(product),
          child: _productCard(product),
        );
      },
    );
  }

  Widget _buildOrderListHeader(int itemCount) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Ordered Menus",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Text(
                  "Total Menus : ",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  "$itemCount",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item, CartNotifier cartNotifier) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF007AFF).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ProductImage(product: item.product, size: 50),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "SKU: ${item.product.sku ?? 'N/A'}",
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    if (item.product.gstRate != null)
                      Text(
                        "GST: ${item.product.gstRate} (${item.product.gstType})",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
              _qtyControl(item, cartNotifier),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text("Add Note", style: TextStyle(fontSize: 11)),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _showItemDiscountDialog(item),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: item.manualDiscount > 0
                          ? Colors.red.shade300
                          : Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    color: item.manualDiscount > 0 ? Colors.red.shade50 : null,
                  ),
                  child: Text(
                    item.manualDiscount > 0
                        ? "-${item.isPercentDiscount ? '${item.manualDiscount.toInt()}%' : 'Rs ${item.manualDiscount.toInt()}'}"
                        : "Discount",
                    style: TextStyle(
                      fontSize: 11,
                      color: item.manualDiscount > 0
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => cartNotifier.removeProduct(item.product),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.close, size: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _itemDetailCol(
                "Item Rate",
                "Rs ${item.product.price.toStringAsFixed(2)}",
              ),
              _itemDetailCol(
                "Amount",
                "Rs ${item.subtotal.toStringAsFixed(2)}",
              ),
              _itemDetailCol(
                "Total",
                "Rs ${item.total.toStringAsFixed(2)}",
                isBold: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemDetailCol(String label, String value, {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _qtyControl(CartItem item, CartNotifier cartNotifier) {
    return Row(
      children: [
        _circleBtn(
          Icons.remove,
          () => cartNotifier.updateQuantity(item.product, item.quantity - 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "${item.quantity}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        _circleBtn(
          Icons.add,
          () => cartNotifier.updateQuantity(item.product, item.quantity + 1),
        ),
      ],
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 14),
      ),
    );
  }

  Widget _actionButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(ProductEntity product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.zero,
              child: Center(child: ProductImage(product: product, size: 150)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              "Rs ${product.price.toInt()}",
              style: const TextStyle(
                color: Color(0xFF00A78E),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return const Center(
      child: Text("No products in cart", style: TextStyle(color: Colors.grey)),
    );
  }

  void _showItemDiscountDialog(CartItem item) {
    bool isPercent = item.isPercentDiscount;
    final controller = TextEditingController(
      text: item.manualDiscount.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Discount for ${item.product.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text("Rs"),
                    selected: !isPercent,
                    onSelected: (val) => setState(() => isPercent = !val),
                  ),
                  const SizedBox(width: 12),
                  ChoiceChip(
                    label: const Text("%"),
                    selected: isPercent,
                    onSelected: (val) => setState(() => isPercent = val),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: isPercent
                      ? 'Discount Percentage (%)'
                      : 'Discount Amount (Rs)',
                  hintText: 'Enter value',
                  prefixText: isPercent ? null : 'Rs ',
                  suffixText: isPercent ? ' %' : null,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final d = double.tryParse(controller.text) ?? 0.0;
                ref
                    .read(cartProvider.notifier)
                    .updateItemDiscount(item.product, d, isPercent);
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOverallDiscountDialog(
    double currentDiscount,
    bool currentlyPercent,
  ) {
    bool isPercent = currentlyPercent;
    final controller = TextEditingController(text: currentDiscount.toString());

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Overall Discount'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text("Rs"),
                    selected: !isPercent,
                    onSelected: (val) => setState(() => isPercent = !val),
                  ),
                  const SizedBox(width: 12),
                  ChoiceChip(
                    label: const Text("%"),
                    selected: isPercent,
                    onSelected: (val) => setState(() => isPercent = val),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: isPercent
                      ? 'Discount Percentage (%)'
                      : 'Discount Amount (Rs)',
                  hintText: 'Enter value',
                  prefixText: isPercent ? null : 'Rs ',
                  suffixText: isPercent ? ' %' : null,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final discount = double.tryParse(controller.text) ?? 0.0;
                ref
                    .read(cartProvider.notifier)
                    .setOverallDiscount(discount, isPercent);
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
