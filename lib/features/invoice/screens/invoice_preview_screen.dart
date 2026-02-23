import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/services/invoice_service.dart';
import 'package:ezo/core/models/invoice.dart';
import 'package:ezo/core/models/invoice_template.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:drift/drift.dart' show TypedResult;

class InvoicePreviewScreen extends ConsumerWidget {
  final InvoiceEntity invoiceEntity;
  final CustomerEntity? customer;
  final List<TypedResult> items;

  const InvoicePreviewScreen({
    super.key,
    required this.invoiceEntity,
    this.customer,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final template = ref.watch(invoiceTemplateProvider);

    // Map database items to InvoiceItem models
    final mappedItems = items.map((res) {
      final item = res.readTable(ServiceLocator.instance.database.invoiceItems);
      final product = res.readTable(ServiceLocator.instance.database.products);
      return InvoiceItem(
        id: item.id,
        invoiceId: item.invoiceId,
        productId: item.productId,
        productName: product.name,
        quantity: item.quantity,
        bonus: item.bonus,
        unitPrice: item.unitPrice,
        totalPrice: item.totalPrice,
      );
    }).toList();

    final invoice = Invoice(
      id: invoiceEntity.id,
      uuid: invoiceEntity.uuid,
      invoiceNumber: invoiceEntity.invoiceNumber,
      customerId: invoiceEntity.customerId,
      date: invoiceEntity.date,
      subtotal: invoiceEntity.subtotal,
      tax: invoiceEntity.tax,
      total: invoiceEntity.total,
      signUrl: invoiceEntity.signUrl,
      items: mappedItems,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Preview: ${invoice.invoiceNumber}"),
        backgroundColor: PosColors.navy,
        foregroundColor: Colors.white,
      ),
      body: PdfPreview(
        build: (format) async {
          final doc = await InvoiceService().generateInvoicePdf(
            invoice,
            customer,
            template,
          );
          return doc.save();
        },
        canDebug: false,
        canChangePageFormat: false,
        onPrinted: (context) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invoice sent to printer")),
          );
        },
      ),
    );
  }
}
