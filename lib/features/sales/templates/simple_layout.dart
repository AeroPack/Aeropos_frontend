import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/invoice.dart';
import '../../../core/models/invoice_template.dart';
import '../../../core/database/app_database.dart';
import 'template_helper.dart';

class SimpleLayout {
  static Future<pw.Document> generate(
    Invoice invoice,
    CustomerEntity? customer,
    InvoiceTemplate template,
    Map<String, dynamic>? profile,
  ) async {
    final pdf = pw.Document();
    final accentColor = TemplateHelper.getColor(template.accentColor);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(50),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                (profile?['businessName'] ?? profile?['companyName'] ?? 'Business'),
                style: TemplateHelper.getStyle(
                  template: template,
                  fontSize: 16,
                  isBold: true,
                  color: accentColor,
                ),
              ),
              if (template.showAddress && profile?['businessAddress'] != null)
                pw.Text(
                  profile?['businessAddress']!,
                  style: TemplateHelper.getStyle(
                    template: template,
                    fontSize: 9,
                  ),
                ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  if (template.showCustomerDetails)
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "To:",
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
                            customer?.phone ?? '',
                            style: TemplateHelper.getStyle(template: template),
                          ),
                      ],
                    ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        "Invoice #${invoice.invoiceNumber}",
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
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Divider(color: accentColor),
              pw.SizedBox(height: 10),
              ...invoice.items.map(
                (item) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          item.productName ?? "",
                          style: TemplateHelper.getStyle(
                            template: template,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Text(
                        "${item.quantity} x Rs ${item.unitPrice.toStringAsFixed(2)}",
                        style: TemplateHelper.getStyle(template: template),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Text(
                        "Rs ${item.totalPrice.toStringAsFixed(2)}",
                        style: TemplateHelper.getStyle(
                          template: template,
                          isBold: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Divider(color: accentColor),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        "Subtotal: Rs ${invoice.subtotal.toStringAsFixed(2)}",
                        style: TemplateHelper.getStyle(template: template),
                      ),
                      if (invoice.discount > 0)
                        pw.Text(
                          "Discount: Rs ${invoice.discount.toStringAsFixed(2)}",
                          style: TemplateHelper.getStyle(template: template),
                        ),
                      pw.Text(
                        "CGST: Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                        style: TemplateHelper.getStyle(template: template),
                      ),
                      pw.Text(
                        "SGST: Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                        style: TemplateHelper.getStyle(template: template),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "Total: Rs ${invoice.total.toStringAsFixed(2)}",
                        style: TemplateHelper.getStyle(
                          template: template,
                          isBold: true,
                          fontSize: 14,
                        ),
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
                      fontSize: 9,
                      color: PdfColors.grey700,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
    return pdf;
  }
}
