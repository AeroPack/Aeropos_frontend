import 'package:flutter/material.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/widgets/brand_form_dialog.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:ezo/core/widgets/delete_confirmation_dialog.dart';
import 'package:ezo/core/widgets/generic_data_table.dart';

class BrandListScreen extends StatefulWidget {
  const BrandListScreen({super.key});

  @override
  State<BrandListScreen> createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  final _viewModel = ServiceLocator.instance.brandViewModel;

  @override
  void initState() {
    super.initState();
    _handleSync();
  }

  void _handleSync() async {
    await _viewModel.syncPendingBrands();
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
      body: StreamBuilder<List<BrandEntity>>(
        stream: _viewModel.allBrands,
        builder: (context, snapshot) {
          final allBrands = snapshot.data ?? [];
          final bool isLoading =
              snapshot.connectionState == ConnectionState.waiting;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: GenericDataTable<BrandEntity>(
              data: allBrands,
              isLoading: isLoading,
              title: "Brand List",
              subtitle: "Manage your product brands",
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
                  label: const Text("Add Brand"),
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
              rowBuilder: (brand, index) {
                return _BrandTableRow(
                  serialNumber: index + 1,
                  brand: brand,
                  onEdit: () => _showFormDialog(brand: brand),
                  onDelete: () => _showDeleteConfirmation(context, brand),
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
                Icons.branding_watermark_outlined,
                size: 48,
                color: PosColors.textLight,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No brands found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: PosColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your first brand to get started',
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
              label: const Text("Add Brand"),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormDialog({BrandEntity? brand}) {
    showDialog(
      context: context,
      builder: (context) => BrandFormDialog(
        brand: brand,
        onSubmit: (name, desc) async {
          if (brand == null) {
            await _viewModel.addBrand(name: name, description: desc);
          } else {
            final updated = brand.copyWith(
              name: name,
              description: drift.Value(desc),
              syncStatus: 1,
              updatedAt: DateTime.now(),
            );
            await _viewModel.updateBrand(updated);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, BrandEntity brand) {
    DeleteConfirmationDialog.show(
      context: context,
      itemName: brand.name,
      itemType: 'Brand',
      onConfirm: () async {
        await _viewModel.deleteBrand(brand.id);
      },
    );
  }
}

class _BrandTableRow extends StatelessWidget {
  final int serialNumber;
  final BrandEntity brand;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _BrandTableRow({
    required this.serialNumber,
    required this.brand,
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
              brand.name,
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
              brand.description ?? '-',
              style: const TextStyle(fontSize: 13, color: PosColors.textLight),
            ),
          ),
          Expanded(flex: 2, child: _statusBadge(brand.isActive)),
          Expanded(
            flex: 1,
            child: Icon(
              brand.syncStatus == 0 ? Icons.check_circle : Icons.cloud_upload,
              color: brand.syncStatus == 0 ? Colors.green : Colors.orange,
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
