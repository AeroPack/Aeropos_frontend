import 'package:flutter/material.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/widgets/unit_form_dialog.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/widgets/delete_confirmation_dialog.dart';
import 'package:ezo/core/widgets/generic_data_table.dart';

class UnitListScreen extends StatefulWidget {
  const UnitListScreen({super.key});

  @override
  State<UnitListScreen> createState() => _UnitListScreenState();
}

class _UnitListScreenState extends State<UnitListScreen> {
  final _viewModel = ServiceLocator.instance.unitViewModel;

  @override
  void initState() {
    super.initState();
    _handleSync();
  }

  void _handleSync() async {
    await _viewModel.syncPendingUnits();
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
      body: StreamBuilder<List<UnitEntity>>(
        stream: _viewModel.allUnits,
        builder: (context, snapshot) {
          final allUnits = snapshot.data ?? [];
          final bool isLoading =
              snapshot.connectionState == ConnectionState.waiting;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: GenericDataTable<UnitEntity>(
              data: allUnits,
              isLoading: isLoading,
              title: "Unit List",
              subtitle: "Manage measurement units",
              onRefresh: _handleSync,
              searchPredicate: (item, query) {
                final q = query.toLowerCase();
                return item.name.toLowerCase().contains(q) ||
                    item.symbol.toLowerCase().contains(q);
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
                  label: const Text("Add Unit"),
                ),
              ],
              emptyState: _buildEmptyState(),
              columns: const [
                DataColumnConfig(label: "#ID", flex: 1),
                DataColumnConfig(label: "Name", flex: 3),
                DataColumnConfig(label: "Symbol", flex: 2),
                DataColumnConfig(label: "Status", flex: 2),
                DataColumnConfig(label: "Sync", flex: 1),
                DataColumnConfig(
                  label: "Action",
                  flex: 2,
                  alignment: Alignment.centerRight,
                ),
              ],
              rowBuilder: (unit, index) {
                return _UnitTableRow(
                  serialNumber: index + 1,
                  unit: unit,
                  onEdit: () => _showFormDialog(unit: unit),
                  onDelete: () => _showDeleteConfirmation(context, unit),
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
                Icons.straighten,
                size: 48,
                color: PosColors.textLight,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No units found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: PosColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your first unit to get started',
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
              label: const Text("Add Unit"),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormDialog({UnitEntity? unit}) {
    showDialog(
      context: context,
      builder: (context) => UnitFormDialog(
        unit: unit,
        onSubmit: (name, symbol) async {
          if (unit == null) {
            await _viewModel.addUnit(name: name, symbol: symbol);
          } else {
            final updated = unit.copyWith(
              name: name,
              symbol: symbol,
              syncStatus: 1,
              updatedAt: DateTime.now(),
            );
            await _viewModel.updateUnit(updated);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, UnitEntity unit) {
    DeleteConfirmationDialog.show(
      context: context,
      itemName: unit.name,
      itemType: 'Unit',
      onConfirm: () async {
        await _viewModel.deleteUnit(unit.id);
      },
    );
  }
}

class _UnitTableRow extends StatelessWidget {
  final int serialNumber;
  final UnitEntity unit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _UnitTableRow({
    required this.serialNumber,
    required this.unit,
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
              unit.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: PosColors.textMain,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              unit.symbol,
              style: const TextStyle(fontSize: 13, color: PosColors.textLight),
            ),
          ),
          Expanded(flex: 2, child: _statusBadge(unit.isActive)),
          Expanded(
            flex: 1,
            child: Icon(
              unit.syncStatus == 0 ? Icons.check_circle : Icons.cloud_upload,
              color: unit.syncStatus == 0 ? Colors.green : Colors.orange,
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
