import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/invoice.dart';
import '../../../core/models/invoice_template.dart';
import '../../../core/database/app_database.dart';
import 'template_helper.dart';

class AdvancedGstLayout {
  static Future<pw.Document> generate(
    Invoice invoice,
    CustomerEntity? customer,
    InvoiceTemplate template,
    Map<String, dynamic>? profile,
  ) async {
    final pdf = pw.Document();
    final accentColor = TemplateHelper.getColor(template.accentColor);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Text(
                "TAX INVOICE",
                style: TemplateHelper.getStyle(
                  template: template,
                  fontSize: 18,
                  isBold: true,
                  color: accentColor,
                ),
              ),
            ),
            pw.Divider(color: accentColor),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        (profile?['businessName'] ?? profile?['companyName'] ?? 'Business').toUpperCase(),
                        style: TemplateHelper.getStyle(
                          template: template,
                          isBold: true,
                        ),
                      ),
                      if (profile?['taxId'] != null)
                        pw.Text(
                          "GSTIN: ${profile?['taxId']}",
                          style: TemplateHelper.getStyle(
                            template: template,
                            fontSize: 10,
                          ),
                        ),
                      if (template.showAddress &&
                          profile?['businessAddress'] != null)
                        pw.Text(
                          profile?['businessAddress']!,
                          style: TemplateHelper.getStyle(
                            template: template,
                            fontSize: 10,
                          ),
                        ),
                    ],
                  ),
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        "Invoice No: ${invoice.invoiceNumber}",
                        style: TemplateHelper.getStyle(
                          template: template,
                          isBold: true,
                        ),
                      ),
                      pw.Text(
                        "Date: ${invoice.date.toString().split(' ')[0]}",
                        style: TemplateHelper.getStyle(template: template),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            if (template.showCustomerDetails)
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: accentColor),
                ),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(
                            right: pw.BorderSide(color: accentColor),
                          ),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Details of Receiver (Billed to):",
                              style: TemplateHelper.getStyle(
                                template: template,
                                isBold: true,
                                fontSize: 10,
                              ),
                            ),
                            pw.Text(
                              customer?.name ?? "Guest Customer",
                              style: TemplateHelper.getStyle(
                                template: template,
                                isBold: true,
                                fontSize: 12,
                              ),
                            ),
                            if (customer?.phone != null)
                              pw.Text(
                                "Contact: ${customer?.phone}",
                                style: TemplateHelper.getStyle(
                                  template: template,
                                ),
                              ),
                            if (customer?.address != null)
                              pw.Text(
                                customer?.address ?? '',
                                style: TemplateHelper.getStyle(
                                  template: template,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: [
                'No',
                'Item Name',
                'HSN/SAC',
                'Qty',
                'Rate',
                'Disc',
                'Taxable Value',
                'GST %',
                'Total',
              ],
              data: List.generate(invoice.items.length, (index) {
                final item = invoice.items[index];
                return [
                  "${index + 1}",
                  item.productName ?? "",
                  "8517",
                  "${item.quantity}",
                  item.unitPrice.toStringAsFixed(2),
                  "0.00",
                  item.totalPrice.toStringAsFixed(2),
                  "${invoice.items[index].productName != null ? 'GST' : ''}", // Simple placeholder or better logic needed if possible
                  item.totalPrice.toStringAsFixed(2),
                ];
              }),
              headerStyle: TemplateHelper.getStyle(
                template: template,
                isBold: true,
                fontSize: 8,
                color: PdfColors.white,
              ),
              headerDecoration: pw.BoxDecoration(color: accentColor),
              cellStyle: TemplateHelper.getStyle(
                template: template,
                fontSize: 8,
              ),
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                3: pw.Alignment.center,
                4: pw.Alignment.centerRight,
              },
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Table(
                  border: pw.TableBorder.all(color: accentColor),
                  children: [
                    _gstTotalRow(
                      template,
                      "Total Taxable Value",
                      invoice.subtotal.toStringAsFixed(2),
                    ),
                    if (invoice.discount > 0)
                      _gstTotalRow(
                        template,
                        "Discount",
                        invoice.discount.toStringAsFixed(2),
                      ),
                    _gstTotalRow(
                      template,
                      "CGST",
                      (invoice.tax / 2).toStringAsFixed(2),
                    ),
                    _gstTotalRow(
                      template,
                      "SGST",
                      (invoice.tax / 2).toStringAsFixed(2),
                    ),
                    _gstTotalRow(
                      template,
                      "Grand Total",
                      invoice.total.toStringAsFixed(2),
                      isBold: true,
                    ),
                  ],
                ),
              ],
            ),
          ];
        },
      ),
    );
    return pdf;
  }

  static pw.TableRow _gstTotalRow(
    InvoiceTemplate template,
    String label,
    String value, {
    bool isBold = false,
  }) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            label,
            style: TemplateHelper.getStyle(
              template: template,
              fontSize: 10,
              isBold: isBold,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            value,
            textAlign: pw.TextAlign.right,
            style: TemplateHelper.getStyle(
              template: template,
              fontSize: 10,
              isBold: isBold,
            ),
          ),
        ),
      ],
    );
  }
}
