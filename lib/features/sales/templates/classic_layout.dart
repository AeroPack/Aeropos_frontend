import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/invoice.dart';
import '../../../core/models/invoice_template.dart';
import '../../../core/database/app_database.dart';
import 'template_helper.dart';

class ClassicLayout {
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
                      (profile?['businessName'] ?? profile?['companyName'] ?? 'Business').toUpperCase(),
                      style: TemplateHelper.getStyle(
                        template: template,
                        fontSize: 20,
                        isBold: true,
                        color: accentColor,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    if (template.showAddress &&
                        profile?['businessAddress'] != null)
                      pw.Text(
                        profile?['businessAddress']!,
                        style: TemplateHelper.getStyle(
                          template: template,
                          fontSize: 10,
                        ),
                      ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "INVOICE",
                      style: TemplateHelper.getStyle(
                        template: template,
                        isBold: true,
                      ),
                    ),
                    pw.Text(
                      "Invoice #: ${invoice.invoiceNumber}",
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
                        "BILL TO",
                        style: TemplateHelper.getStyle(
                          template: template,
                          isBold: true,
                        ),
                      ),
                      pw.Text(
                        customer?.name ?? "Guest Customer",
                        style: TemplateHelper.getStyle(template: template),
                      ),
                      if (customer?.phone != null)
                        pw.Text(
                          "Phone: ${customer?.phone}",
                          style: TemplateHelper.getStyle(template: template),
                        ),
                      if (customer?.address != null)
                        pw.Text(
                          customer?.address ?? '',
                          style: TemplateHelper.getStyle(template: template),
                        ),
                    ],
                  ),
              ],
            ),
            pw.SizedBox(height: 40),

            // Items Table
            pw.TableHelper.fromTextArray(
              headers: ['Description', 'Price', 'Qty', 'Total'],
              data: invoice.items.map((item) {
                return [
                  item.productName ?? "Product #${item.productId}",
                  "Rs ${item.unitPrice.toStringAsFixed(2)}",
                  "${item.quantity}",
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
              cellHeight: 25,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.center,
                3: pw.Alignment.centerRight,
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
                    _row(
                      template,
                      "Subtotal",
                      "Rs ${invoice.subtotal.toStringAsFixed(2)}",
                    ),
                    if (invoice.discount > 0)
                      _row(
                        template,
                        "Discount",
                        "Rs ${invoice.discount.toStringAsFixed(2)}",
                      ),
                    _row(
                      template,
                      "CGST",
                      "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                    ),
                    _row(
                      template,
                      "SGST",
                      "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                    ),
                    pw.Divider(color: accentColor),
                    _row(
                      template,
                      "Total Amount",
                      "Rs ${invoice.total.toStringAsFixed(2)}",
                      isBold: true,
                    ),
                  ],
                ),
              ],
            ),

            if (template.showFooter) ...[
              pw.Spacer(),
              pw.Center(
                child: pw.Text(
                  template.footerMessage,
                  style: TemplateHelper.getStyle(
                    template: template,
                    fontSize: 10,
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

  static pw.Widget _row(
    InvoiceTemplate template,
    String label,
    String value, {
    bool isBold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(
            "$label: ",
            style: TemplateHelper.getStyle(template: template, isBold: isBold),
          ),
          pw.SizedBox(width: 20),
          pw.Text(
            value,
            style: TemplateHelper.getStyle(template: template, isBold: isBold),
          ),
        ],
      ),
    );
  }
}
