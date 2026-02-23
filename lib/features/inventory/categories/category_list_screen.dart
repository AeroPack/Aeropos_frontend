import 'package:flutter/material.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/widgets/category_form_dialog.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:ezo/core/widgets/delete_confirmation_dialog.dart';
import 'package:ezo/core/widgets/generic_data_table.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final _viewModel = ServiceLocator.instance.categoryViewModel;

  @override
  void initState() {
    super.initState();
    _handleSync();
  }

  void _handleSync() async {
    await _viewModel.syncPendingCategories();
    await _viewModel.fetchAndSync();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sync completed"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PosColors.background,
      body: StreamBuilder<List<CategoryEntity>>(
        stream: _viewModel.allCategories,
        builder: (context, snapshot) {
          final allCategories = snapshot.data ?? [];
          final bool isLoading =
              snapshot.connectionState == ConnectionState.waiting;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: GenericDataTable<CategoryEntity>(
              data: allCategories,
              isLoading: isLoading,
              title: "Category List",
              subtitle: "Manage your product categories",
              onRefresh: _handleSync,
              searchPredicate: (item, query) {
                return item.name.toLowerCase().contains(query.toLowerCase());
              },
              actions: [
                ElevatedButton.icon(
                  onPressed: () => _showFormDialog(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PosColors.blue,
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
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text("Add Category"),
                ),
              ],
              emptyState: _buildEmptyState(),
              columns: const [
                DataColumnConfig(label: "#ID", flex: 1),
                DataColumnConfig(label: "Name", flex: 3),
                DataColumnConfig(label: "Description", flex: 4),
                DataColumnConfig(label: "Status", flex: 2),
                DataColumnConfig(label: "Sync", flex: 1),
                DataColumnConfig(
                  label: "Action",
                  flex: 2,
                  alignment: Alignment.centerRight,
                ),
              ],
              rowBuilder: (category, index) {
                return _CategoryTableRow(
                  serialNumber: index + 1,
                  category: category,
                  onEdit: () => _showFormDialog(category: category),
                  onDelete: () => _showDeleteConfirmation(context, category),
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
                Icons.category_outlined,
                size: 48,
                color: PosColors.textLight,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No categories found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: PosColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your first category to get started',
              style: TextStyle(color: PosColors.textLight),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showFormDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: PosColors.blue,
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
              label: const Text("Add Category"),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormDialog({CategoryEntity? category}) {
    showDialog(
      context: context,
      builder: (context) => CategoryFormDialog(
        category: category,
        onSubmit: (name, desc) async {
          if (category == null) {
            await _viewModel.addCategory(name: name, description: desc);
          } else {
            final updated = category.copyWith(
              name: name,
              description: drift.Value(desc),
              syncStatus: 1,
              updatedAt: DateTime.now(),
            );
            await _viewModel.updateCategory(updated);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, CategoryEntity category) {
    DeleteConfirmationDialog.show(
      context: context,
      itemName: category.name,
      itemType: 'Category',
      onConfirm: () async {
        await _viewModel.deleteCategory(category.id);
      },
    );
  }
}

class _CategoryTableRow extends StatelessWidget {
  final int serialNumber;
  final CategoryEntity category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CategoryTableRow({
    required this.serialNumber,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "$serialNumber",
              style: const TextStyle(fontSize: 13, color: PosColors.textLight),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              category.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: PosColors.textMain,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              category.description ?? '-',
              style: const TextStyle(fontSize: 13, color: PosColors.textLight),
            ),
          ),
          Expanded(flex: 2, child: _statusBadge(category.isActive)),
          Expanded(
            flex: 1,
            child: Icon(
              category.syncStatus == 0
                  ? Icons.check_circle
                  : Icons.cloud_upload,
              color: category.syncStatus == 0 ? Colors.green : Colors.orange,
              size: 18,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _actionIcon(Icons.edit_outlined, Colors.blue, onEdit),
                const SizedBox(width: 8),
                _actionIcon(Icons.delete_outline, Colors.red, onDelete),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(bool isActive) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.green.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isActive ? Colors.green : Colors.red),
        ),
        child: Text(
          isActive ? "Active" : "Inactive",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
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
