import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/invoice.dart';
import '../../../core/models/invoice_template.dart';
import '../../../core/database/app_database.dart';
import 'template_helper.dart';

class ModernLayout {
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
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      (profile?['businessName'] ??
                              profile?['companyName'] ??
                              'Business')
                          .toUpperCase(),
                      style: TemplateHelper.getStyle(
                        template: template,
                        fontSize: 24,
                        isBold: true,
                        color: accentColor,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    if (template.showAddress &&
                        profile?['businessAddress'] != null)
                      pw.Text(
                        profile!['businessAddress'],
                        style: TemplateHelper.getStyle(
                          template: template,
                          fontSize: 8,
                        ),
                      ),
                    if (profile?['phone'] != null)
                      pw.Text(
                        "Phone: ${profile!['phone']}",
                        style: TemplateHelper.getStyle(
                          template: template,
                          fontSize: 8,
                        ),
                      ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      "Invoice Number: ${invoice.invoiceNumber}",
                      style: TemplateHelper.getStyle(template: template),
                    ),
                    pw.Text(
                      "Date: ${invoice.date.toString().split(' ')[0]}",
                      style: TemplateHelper.getStyle(template: template),
                    ),
                  ],
                ),
                if (template.showCustomerDetails)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        "BILL TO:",
                        style: TemplateHelper.getStyle(
                          template: template,
                          fontSize: 10,
                          isBold: true,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.Text(
                        customer?.name ?? "Guest Customer",
                        style: TemplateHelper.getStyle(
                          template: template,
                          fontSize: 14,
                          isBold: true,
                        ),
                      ),
                      if (customer?.phone != null)
                        pw.Text(
                          "Phone: ${customer?.phone}",
                          style: TemplateHelper.getStyle(template: template),
                        ),
                      if (customer?.address != null)
                        pw.Text(
                          customer?.address ?? '',
                          style: TemplateHelper.getStyle(
                            template: template,
                            fontSize: 10,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            pw.SizedBox(height: 40),

            // Items Table
            pw.TableHelper.fromTextArray(
              headers: ['Product', 'Unit Price', 'Qty', 'Bonus', 'Total'],
              data: invoice.items.map((item) {
                return [
                  item.productName ?? "Product #${item.productId}",
                  "Rs ${item.unitPrice.toStringAsFixed(2)}",
                  "${item.quantity}",
                  "${item.bonus}",
                  "Rs ${item.totalPrice.toStringAsFixed(2)}",
                ];
              }).toList(),
              headerStyle: TemplateHelper.getStyle(
                template: template,
                isBold: true,
                color: PdfColors.white,
              ),
              headerDecoration: pw.BoxDecoration(color: accentColor),
              cellStyle: TemplateHelper.getStyle(template: template),
              cellHeight: 30,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.center,
                3: pw.Alignment.center,
                4: pw.Alignment.centerRight,
              },
            ),

            pw.SizedBox(height: 20),

            // Totals
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    _totalRow(
                      template,
                      "Subtotal",
                      "Rs ${invoice.subtotal.toStringAsFixed(2)}",
                    ),
                    if (invoice.discount > 0)
                      _totalRow(
                        template,
                        "Discount",
                        "Rs ${invoice.discount.toStringAsFixed(2)}",
                      ),
                    _totalRow(
                      template,
                      "CGST",
                      "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                    ),
                    _totalRow(
                      template,
                      "SGST",
                      "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                    ),
                    pw.Divider(color: PdfColors.grey400),
                    _totalRow(
                      template,
                      "TOTAL PAYABLE",
                      "Rs ${invoice.total.toStringAsFixed(2)}",
                      isBold: true,
                      fontSize: 16,
                    ),
                  ],
                ),
              ],
            ),

            if (template.showFooter) ...[
              pw.Spacer(),
              pw.Divider(color: PdfColors.grey300),
              pw.Center(
                child: pw.Text(
                  template.footerMessage,
                  style: TemplateHelper.getStyle(
                    template: template,
                    fontSize: 10,
                    color: PdfColors.grey600,
                  ),
                ),
              ),
            ],
          ];
        },
      ),
    );
    return pdf;
  }

  static pw.Widget _totalRow(
    InvoiceTemplate template,
    String label,
    String value, {
    bool isBold = false,
    double fontSize = 12,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(
            "$label: ",
            style: TemplateHelper.getStyle(
              template: template,
              fontSize: 10,
              isBold: isBold,
            ),
          ),
          pw.SizedBox(width: 20),
          pw.Text(
            value,
            style: TemplateHelper.getStyle(
              template: template,
              fontSize: fontSize,
              isBold: true,
            ),
          ),
        ],
      ),
    );
  }
}
