import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/di/service_locator.dart';
import '../state/sales_state.dart';

class SalesListScreen extends ConsumerWidget {
  const SalesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesAsync = ref.watch(salesListStreamProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PosPageHeader(
            title: "Sales History",
            subTitle: "View all completed transactions",
            onBack: () {},
          ),
          const SizedBox(height: 24),

          Expanded(
            child: PosContentCard(
              title: "Rec`ent Sales",
              child: salesAsync.when(
                data: (results) {
                  if (results.isEmpty) {
                    return _buildEmptyState();
                  }
                  return ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final row = results[index];
                      final invoice = row.readTable(
                        ServiceLocator.instance.database.invoices,
                      );
                      final customer = row.readTableOrNull(
                        ServiceLocator.instance.database.customers,
                      );

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFF1F5F9),
                          child: Icon(
                            Icons.receipt,
                            color: Colors.blue.shade700,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          invoice.invoiceNumber,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${customer?.name ?? 'Walk-in Customer'} • ${DateFormat('dd MMM, yyyy HH:mm').format(invoice.date)}",
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Rs ${invoice.total.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00A78E),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          // TODO: Show invoice details or re-print
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Error: $err")),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            "Sales history will appear here.",
            style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Text(
            "Complete a transaction in POS to see it here.",
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
