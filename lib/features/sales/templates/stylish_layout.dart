import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/invoice.dart';
import '../../../core/models/invoice_template.dart';
import '../../../core/database/app_database.dart';
import 'template_helper.dart';

class StylishLayout {
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
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: pw.BoxDecoration(color: accentColor),
                        child: pw.Text(
                          "INVOICE",
                          style: TemplateHelper.getStyle(
                            template: template,
                            color: PdfColors.white,
                            isBold: true,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 16),
                      pw.Text(
                        (profile?['businessName'] ?? profile?['companyName'] ?? 'Business'),
                        style: TemplateHelper.getStyle(
                          template: template,
                          fontSize: 18,
                          isBold: true,
                        ),
                      ),
                      if (template.showAddress &&
                          profile?['businessAddress'] != null)
                        pw.Text(
                          profile?['businessAddress']!,
                          style: TemplateHelper.getStyle(
                            template: template,
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                      if (profile?['phone'] != null)
                        pw.Text(
                          "Phone: ${profile?['phone']}",
                          style: TemplateHelper.getStyle(
                            template: template,
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                    ],
                  ),
                ),
                pw.Expanded(
                  flex: 1,
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
            pw.SizedBox(height: 48),
            if (template.showCustomerDetails)
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "BILL TO",
                          style: TemplateHelper.getStyle(
                            template: template,
                            fontSize: 10,
                            isBold: true,
                            color: accentColor,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          customer?.name ?? "Guest Customer",
                          style: TemplateHelper.getStyle(
                            template: template,
                            isBold: true,
                          ),
                        ),
                        if (customer?.phone != null)
                          pw.Text(
                            customer?.phone ?? '',
                            style: TemplateHelper.getStyle(template: template),
                          ),
                        if (customer?.address != null)
                          pw.Text(
                            customer?.address ?? '',
                            style: TemplateHelper.getStyle(template: template),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            pw.SizedBox(height: 40),
            pw.TableHelper.fromTextArray(
              headers: ['ITEM', 'PRICE', 'QTY', 'TOTAL'],
              data: invoice.items.map((item) {
                return [
                  item.productName ?? "",
                  "Rs ${item.unitPrice.toStringAsFixed(2)}",
                  item.quantity.toString(),
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
                3: pw.Alignment.centerRight,
              },
              border: null,
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    _summaryRow(
                      template,
                      "Subtotal",
                      "Rs ${invoice.subtotal.toStringAsFixed(2)}",
                    ),
                    if (invoice.discount > 0)
                      _summaryRow(
                        template,
                        "Discount",
                        "Rs ${invoice.discount.toStringAsFixed(2)}",
                      ),
                    _summaryRow(
                      template,
                      "CGST",
                      "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                    ),
                    _summaryRow(
                      template,
                      "SGST",
                      "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                    ),
                    pw.Container(
                      margin: const pw.EdgeInsets.only(top: 8),
                      padding: const pw.EdgeInsets.all(12),
                      decoration: pw.BoxDecoration(color: accentColor),
                      child: pw.Row(
                        mainAxisSize: pw.MainAxisSize.min,
                        children: [
                          pw.Text(
                            "GRAND TOTAL: ",
                            style: TemplateHelper.getStyle(
                              template: template,
                              color: PdfColors.white,
                              isBold: true,
                            ),
                          ),
                          pw.Text(
                            "Rs ${invoice.total.toStringAsFixed(2)}",
                            style: TemplateHelper.getStyle(
                              template: template,
                              color: PdfColors.white,
                              isBold: true,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ];
        },
        footer: (pw.Context context) {
          if (!template.showFooter) return pw.Container();
          return pw.Column(
            children: [
              pw.Divider(color: accentColor),
              pw.SizedBox(height: 10),
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
          );
        },
      ),
    );
    return pdf;
  }

  static pw.Widget _summaryRow(
    InvoiceTemplate template,
    String label,
    String value,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(
            "$label: ",
            style: TemplateHelper.getStyle(template: template, fontSize: 10),
          ),
          pw.SizedBox(width: 20),
          pw.Text(
            value,
            style: TemplateHelper.getStyle(template: template, isBold: true),
          ),
        ],
      ),
    );
  }
}
