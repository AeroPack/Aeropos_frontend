import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:drift/drift.dart' hide Column;
import '../state/invoice_history_state.dart';
import './invoice_preview_screen.dart';
import 'package:intl/intl.dart';
import 'package:ezo/core/widgets/generic_data_table.dart';

class InvoiceHistoryScreen extends ConsumerStatefulWidget {
  const InvoiceHistoryScreen({super.key});

  @override
  ConsumerState<InvoiceHistoryScreen> createState() =>
      _InvoiceHistoryScreenState();
}

class _InvoiceHistoryScreenState extends ConsumerState<InvoiceHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh data on entry to ensure fresh state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(salesHistoryProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(salesHistoryProvider);
    final notifier = ref.read(salesHistoryProvider.notifier);

    return Scaffold(
      backgroundColor: PosColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GenericDataTable<TypedResult>(
          title: "Sales History",
          subtitle: "Detailed view of all transactions and line items",
          data: state.items,
          isLoading: state.isLoading,
          totalItems: state.totalItems,
          currentPage:
              state.page + 1, // Convert 0-indexed state to 1-indexed UI
          rowsPerPage: state.limit,
          onPageChanged: (page) => notifier.setPage(
            page - 1,
          ), // Convert 1-indexed UI to 0-indexed state
          onSearch: (val) => notifier.setQuery(val),
          onRefresh: () => notifier.refresh(),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                // Future: Implement advanced filters
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: PosColors.navy,
                elevation: 0,
                side: const BorderSide(color: PosColors.border),
              ),
              icon: const Icon(Icons.filter_list, size: 18),
              label: const Text("Filter"),
            ),
          ],
          columns: const [
            DataColumnConfig(label: "S.No", flex: 1),
            DataColumnConfig(label: "Invoice #", flex: 2),
            DataColumnConfig(label: "Date", flex: 2),
            DataColumnConfig(label: "Product", flex: 3),
            DataColumnConfig(label: "Qty", flex: 1),
            DataColumnConfig(label: "Price", flex: 1),
            DataColumnConfig(label: "Customer", flex: 2),
            DataColumnConfig(
              label: "Action",
              flex: 1,
              alignment: Alignment.centerRight,
            ),
          ],
          rowBuilder: (res, index) {
            try {
              final inv = res.readTable(
                ServiceLocator.instance.database.invoices,
              );
              final item = res.readTable(
                ServiceLocator.instance.database.invoiceItems,
              );
              final prod = res.readTable(
                ServiceLocator.instance.database.products,
              );
              final cust = res.readTableOrNull(
                ServiceLocator.instance.database.customers,
              );

              // Calculate global serial number based on page and index
              final serialNumber = (state.page * state.limit) + index + 1;

              return _InvoiceTableRow(
                serialNumber: serialNumber,
                invoice: inv,
                item: item,
                product: prod,
                customer: cust,
              );
            } catch (e) {
              print('Error rendering invoice row: $e');
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class _InvoiceTableRow extends StatelessWidget {
  final int serialNumber;
  final InvoiceEntity invoice;
  final InvoiceItemEntity item;
  final ProductEntity product;
  final CustomerEntity? customer;

  const _InvoiceTableRow({
    required this.serialNumber,
    required this.invoice,
    required this.item,
    required this.product,
    this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "$serialNumber",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              invoice.invoiceNumber,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              DateFormat('dd MMM, yy').format(invoice.date),
              style: const TextStyle(color: PosColors.textLight, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${item.quantity}",
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Rs ${item.unitPrice.toInt()}",
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              customer?.name ?? 'Walk-in',
              style: const TextStyle(color: PosColors.textLight, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () async {
                  final db = ServiceLocator.instance.database;
                  final items = await db.getInvoiceItemsWithProduct(invoice.id);
                  if (context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InvoicePreviewScreen(
                          invoiceEntity: invoice,
                          customer: customer,
                          items: items,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.blue,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
