import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:ezo/core/di/service_locator.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/widgets/product_image.dart';
import 'package:ezo/core/widgets/delete_confirmation_dialog.dart';
import 'package:ezo/core/widgets/generic_data_table.dart';
import '../../../../core/widgets/role_guard.dart';
import '../../../../core/models/user.dart'; // Added

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final viewModel = ServiceLocator.instance.productViewModel;
  User? _currentUser; // Added
  String? _fetchError;

  @override
  void initState() {
    super.initState();
    _handleSync();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final user = await ServiceLocator.instance.authRepository
          .getCurrentUser();
      if (mounted) {
        setState(() {
          _currentUser = user;
          _fetchError = user == null ? "User fetch returned null" : null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _fetchError = e.toString();
        });
      }
    }
  }

  void _handleSync() async {
    if (!mounted) return;
    await viewModel.syncPendingProducts();
    await viewModel.fetchAndSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PosColors.background,
      body: StreamBuilder<List<TypedResult>>(
        stream: viewModel.allProductsWithCategory,
        builder: (context, snapshot) {
          final results = snapshot.data ?? [];
          final bool isLoading =
              snapshot.connectionState == ConnectionState.waiting;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: GenericDataTable<TypedResult>(
              data: results,
              isLoading: isLoading,
              title: "Product List",
              subtitle: "Manage your products",
              onRefresh: _handleSync,
              searchPredicate: (item, query) {
                final product = item.readTable(viewModel.database.products);
                final q = query.toLowerCase();
                return product.name.toLowerCase().contains(q) ||
                    (product.sku?.toLowerCase().contains(q) ?? false);
              },
              filters: [
                // Category Filter - will be populated dynamically
                DataFilter<TypedResult>.dropdown(
                  label: "Category",
                  options: _buildCategoryOptions(results),
                  filter: (item, value) {
                    final category = item.readTableOrNull(
                      viewModel.database.categories,
                    );
                    return category?.id == value;
                  },
                ),
                // Price Range Slider Filter
                DataFilter<TypedResult>.range(
                  label: "Price Range",
                  rangeValueExtractor: (item) {
                    final product = item.readTable(viewModel.database.products);
                    return product.price;
                  },
                  filter: (item, value) {
                    final product = item.readTable(viewModel.database.products);
                    final range = value as RangeValues;
                    return product.price >= range.start &&
                        product.price <= range.end;
                  },
                ),
              ],
              actions: [
                _headerIconButton(
                  Icons.picture_as_pdf,
                  Colors.red.shade50,
                  Colors.red,
                ),
                const SizedBox(width: 8),
                _headerIconButton(
                  Icons.table_view,
                  Colors.green.shade50,
                  Colors.green,
                ),
                const SizedBox(width: 8),
                _headerIconButton(
                  Icons.print,
                  Colors.grey.shade100,
                  Colors.grey.shade700,
                ),
                const SizedBox(width: 16),
                RoleGuard(
                  allowedRoles: ['admin', 'manager'],
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/inventory/add'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9F43),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.add_circle_outline, size: 18),
                    label: const Text("Add Product"),
                  ),
                ),
              ],
              emptyState: _buildEmptyState(),
              columns: const [
                DataColumnConfig(label: "", flex: 1), // Checkbox
                DataColumnConfig(label: "Product Name", flex: 3),
                DataColumnConfig(label: "Category", flex: 2),
                DataColumnConfig(label: "Brand", flex: 2),
                DataColumnConfig(label: "Price", flex: 2),
                DataColumnConfig(label: "Created By", flex: 5),
                DataColumnConfig(
                  label: "Action",
                  flex: 2,
                  alignment: Alignment.centerRight,
                ),
              ],
              rowBuilder: (item, index) {
                final product = item.readTable(viewModel.database.products);
                final category = item.readTableOrNull(
                  viewModel.database.categories,
                );
                final brand = item.readTableOrNull(viewModel.database.brands);

                return _ProductTableRow(
                  product: product,
                  categoryName: category?.name,
                  brandName: brand?.name,
                  currentUser: _currentUser,
                  onDelete: () => _showDeleteConfirmation(context, product),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: PosColors.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 48,
                color: PosColors.textLight,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No products found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: PosColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your first product to get started',
              style: TextStyle(color: PosColors.textLight),
            ),
            const SizedBox(height: 24),
            RoleGuard(
              allowedRoles: ['admin', 'manager'],
              child: ElevatedButton.icon(
                onPressed: () => context.go('/inventory/add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9F43),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add, size: 18),
                label: const Text("Add Product"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FilterOption<int>> _buildCategoryOptions(List<TypedResult> results) {
    // Extract unique categories from the results
    final categoryMap = <int, String>{};
    for (final result in results) {
      final category = result.readTableOrNull(viewModel.database.categories);
      if (category != null) {
        categoryMap[category.id] = category.name;
      }
    }

    // Convert to FilterOption list
    return categoryMap.entries
        .map((entry) => FilterOption<int>(label: entry.value, value: entry.key))
        .toList()
      ..sort((a, b) => a.label.compareTo(b.label));
  }

  Widget _headerIconButton(
    IconData icon,
    Color bg,
    Color iconColor, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, ProductEntity product) {
    DeleteConfirmationDialog.show(
      context: context,
      itemName: product.name,
      itemType: 'Product',
      onConfirm: () async {
        final viewModel = ServiceLocator.instance.productViewModel;
        await viewModel.deleteProduct(product.id);
      },
    );
  }
}

class _ProductTableRow extends StatelessWidget {
  final ProductEntity product;
  final String? categoryName;
  final String? brandName;
  final User? currentUser;
  final VoidCallback onDelete;

  const _ProductTableRow({
    required this.product,
    this.categoryName,
    this.brandName,
    required this.currentUser,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Check permissions directly from currentUser
    final hasEditPermission =
        currentUser != null && ['admin', 'manager'].contains(currentUser!.role);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(alignment: Alignment.centerLeft, child: _checkbox()),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                ProductImage(product: product, size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: PosColors.textMain,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.sku ?? "No SKU",
                        style: const TextStyle(
                          fontSize: 12,
                          color: PosColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(categoryName ?? "-", style: _cellStyle()),
          ),
          Expanded(flex: 2, child: Text(brandName ?? "-", style: _cellStyle())),
          Expanded(
            flex: 2,
            child: Text(
              "₹${product.price.toStringAsFixed(2)}",
              style: _cellStyle(),
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?u=1',
                  ),
                ),
                const SizedBox(width: 8),
                Text(currentUser?.name ?? "Unknown", style: _cellStyle()),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _actionIcon(
                  icon: Icons.visibility_outlined,
                  color: Colors.blue,
                  onTap: () => context.go('/inventory/view', extra: product),
                ),
                if (hasEditPermission) ...[
                  const SizedBox(width: 8),
                  _actionIcon(
                    icon: Icons.edit_outlined,
                    color: Colors.orange,
                    onTap: () => context.go('/inventory/add', extra: product),
                  ),
                  const SizedBox(width: 8),
                  _actionIcon(
                    icon: Icons.delete_outline,
                    color: Colors.red,
                    onTap: onDelete,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkbox() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        border: Border.all(color: PosColors.textLight.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  TextStyle _cellStyle() =>
      const TextStyle(fontSize: 13, color: PosColors.textLight);

  Widget _actionIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: PosColors.border),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 14, color: color),
      ),
    );
  }
}
