import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/widgets/customer_form_dialog.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:drift/drift.dart' as drift;

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final _viewModel = ServiceLocator.instance.customerViewModel;

  String _searchQuery = "";
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _handleSync();
  }

  void _handleSync() async {
    setState(() => _isSyncing = true);
    await _viewModel.syncPendingCustomers();
    await _viewModel.fetchAndSync();
    if (mounted) {
      setState(() => _isSyncing = false);
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
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Scaffold(
      backgroundColor: PosColors.background,
      body: StreamBuilder<List<CustomerEntity>>(
        stream: _viewModel.allCustomers,
        builder: (context, snapshot) {
          final allEntities = snapshot.data ?? [];
          final bool isLoading =
              snapshot.connectionState == ConnectionState.waiting;

          final filteredData = allEntities.where((item) {
            return item.name.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                (item.phone ?? "").contains(_searchQuery) ||
                (item.email ?? "").toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                );
          }).toList();

          final bool isEmpty =
              filteredData.isEmpty && !isLoading && _searchQuery.isNotEmpty;
          final bool isTotallyEmpty = allEntities.isEmpty && !isLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopHeader(isMobile, showAddButton: !isTotallyEmpty),
                const SizedBox(height: 24),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: PosColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(40),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Column(
                          children: [
                            if (!isTotallyEmpty) ...[
                              _buildFilterBar(isMobile),
                              const Divider(height: 1, color: PosColors.border),
                            ],

                            if (isTotallyEmpty)
                              _buildEmptyState()
                            else if (isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(40),
                                child: Center(
                                  child: Text(
                                    "No customers found matching your search",
                                  ),
                                ),
                              )
                            else
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final double minTableWidth = 1000.0;
                                  final double tableWidth = math.max(
                                    constraints.maxWidth,
                                    minTableWidth,
                                  );

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      width: tableWidth,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          _buildTableHeader(),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: filteredData.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(
                                                      height: 1,
                                                      color: PosColors.border,
                                                    ),
                                            itemBuilder: (context, index) {
                                              return _CustomerTableRow(
                                                customer: filteredData[index],
                                                onEdit: () => _showFormDialog(
                                                  customer: filteredData[index],
                                                ),
                                                onDelete: () =>
                                                    _viewModel.deleteCustomer(
                                                      filteredData[index].id,
                                                    ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                            if (!isTotallyEmpty)
                              _buildPaginationFooter(filteredData.length),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopHeader(bool isMobile, {bool showAddButton = true}) {
    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _headerIconButton(
          _isSyncing ? Icons.sync : Icons.sync,
          Colors.blue.shade50,
          Colors.blue.shade700,
          onTap: _isSyncing ? null : _handleSync,
        ),
        const SizedBox(width: 8),
        if (showAddButton)
          ElevatedButton.icon(
            onPressed: () => _showFormDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: PosColors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Add Customer"),
          ),
      ],
    );

    final titleSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Customer List",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PosColors.textMain,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Manage customer profiles",
          style: TextStyle(fontSize: 14, color: PosColors.textLight),
        ),
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [titleSection, const SizedBox(height: 16), actions],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [titleSection, actions],
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
                Icons.people_outline,
                size: 48,
                color: PosColors.textLight,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No customers found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: PosColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your first customer to get started',
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
              label: const Text("Add Customer"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar(bool isMobile) {
    final searchField = SizedBox(
      height: 45,
      child: TextField(
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: PosColors.textLight,
          ),
          hintText: 'Search customers...',
          hintStyle: const TextStyle(fontSize: 14, color: PosColors.textLight),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: PosColors.border),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: PosColors.border),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );

    if (isMobile) {
      return Padding(padding: const EdgeInsets.all(16), child: searchField);
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(flex: 1, child: searchField),
          const Expanded(flex: 2, child: SizedBox()), // Spacer
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _col(flex: 1, text: "#ID"),
          _col(flex: 3, text: "Name"),
          _col(flex: 3, text: "Details"),
          _col(flex: 2, text: "Address"),
          _col(flex: 2, text: "Balance"),
          _col(flex: 1, text: "Sync"),
          _col(flex: 2, text: "Action", align: Alignment.centerRight),
        ],
      ),
    );
  }

  Widget _buildPaginationFooter(int count) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Showing $count items",
            style: const TextStyle(color: PosColors.textLight, fontSize: 13),
          ),
          const SizedBox(width: 16),
          // Mock pagination
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: PosColors.border),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: const [
                Icon(Icons.chevron_left, size: 20, color: PosColors.textLight),
                SizedBox(width: 8),
                Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: PosColors.blue,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.chevron_right, size: 20, color: PosColors.textLight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPERS ---

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

  Widget _col({
    required int flex,
    String? text,
    Alignment align = Alignment.centerLeft,
  }) {
    return Expanded(
      flex: flex,
      child: Align(
        alignment: align,
        child: Text(
          text ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: PosColors.textMain,
          ),
        ),
      ),
    );
  }

  void _showFormDialog({CustomerEntity? customer}) {
    showDialog(
      context: context,
      builder: (context) => CustomerFormDialog(
        customer: customer,
        onSubmit:
            ({
              required name,
              phone,
              email,
              address,
              required creditLimit,
            }) async {
              if (customer == null) {
                await _viewModel.addCustomer(
                  name: name,
                  phone: phone,
                  email: email,
                  address: address,
                  creditLimit: creditLimit,
                );
              } else {
                final updated = customer.copyWith(
                  name: name,
                  phone: drift.Value(phone),
                  email: drift.Value(email),
                  address: drift.Value(address),
                  creditLimit: creditLimit,
                  syncStatus: 1,
                  updatedAt: DateTime.now(),
                );
                await _viewModel.updateCustomer(updated);
              }
            },
      ),
    );
  }
}

class _CustomerTableRow extends StatelessWidget {
  final CustomerEntity customer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CustomerTableRow({
    required this.customer,
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
              "#${customer.id}",
              style: const TextStyle(fontSize: 13, color: PosColors.textLight),
            ),
          ),

          Expanded(
            flex: 3,
            child: Text(
              customer.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: PosColors.textMain,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (customer.phone != null)
                  Text(
                    customer.phone!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: PosColors.textMain,
                    ),
                  ),
                if (customer.email != null)
                  Text(
                    customer.email!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: PosColors.textLight,
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              customer.address ?? "-",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 13, color: PosColors.textLight),
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${customer.currentBalance.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "Limit: \$${customer.creditLimit.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: PosColors.textLight,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Icon(
              customer.syncStatus == 0
                  ? Icons.check_circle
                  : Icons.cloud_upload,
              color: customer.syncStatus == 0 ? Colors.green : Colors.orange,
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
