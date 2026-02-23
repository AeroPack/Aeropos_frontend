import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/invoice.dart';
import '../../../core/models/invoice_template.dart';
import '../../../core/database/app_database.dart';
import 'template_helper.dart';

class ThermalLayout {
  static Future<pw.Document> generate(
    Invoice invoice,
    CustomerEntity? customer,
    InvoiceTemplate template,
    Map<String, dynamic>? profile,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80, // Standard 80mm thermal
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  (profile?['businessName'] ??
                          profile?['companyName'] ??
                          'Business')
                      .toUpperCase(),
                  style: TemplateHelper.getStyle(
                    template: template,
                    isBold: true,
                    fontSize: 16,
                  ),
                ),
              ),
              if (template.showAddress && profile?['businessAddress'] != null)
                pw.Center(
                  child: pw.Text(
                    profile!['businessAddress'],
                    style: TemplateHelper.getStyle(
                      template: template,
                      fontSize: 8,
                    ),
                  ),
                ),
              pw.SizedBox(height: 10),
              pw.Text(
                "Invoice: ${invoice.invoiceNumber}",
                style: TemplateHelper.getStyle(template: template),
              ),
              pw.Text(
                "Date: ${invoice.date.toString().split('.')[0]}",
                style: TemplateHelper.getStyle(template: template),
              ),
              if (template.showCustomerDetails && customer != null) ...[
                pw.Text(
                  "Customer: ${customer.name}",
                  style: TemplateHelper.getStyle(template: template),
                ),
                if (customer.phone != null)
                  pw.Text(
                    "Phone: ${customer.phone}",
                    style: TemplateHelper.getStyle(template: template),
                  ),
              ],
              pw.Divider(borderStyle: pw.BorderStyle.dashed),

              // Table Headers
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      "Item",
                      style: TemplateHelper.getStyle(
                        template: template,
                        isBold: true,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      "Qty",
                      style: TemplateHelper.getStyle(
                        template: template,
                        isBold: true,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      "Total",
                      textAlign: pw.TextAlign.right,
                      style: TemplateHelper.getStyle(
                        template: template,
                        isBold: true,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Divider(borderStyle: pw.BorderStyle.dashed),

              // Sale Items
              ...invoice.items.map((item) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          item.productName ?? "Product",
                          style: TemplateHelper.getStyle(template: template),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                          "${item.quantity}",
                          style: TemplateHelper.getStyle(template: template),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          item.totalPrice.toStringAsFixed(2),
                          textAlign: pw.TextAlign.right,
                          style: TemplateHelper.getStyle(template: template),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              pw.Divider(borderStyle: pw.BorderStyle.dashed),
              _thermalRow(
                template,
                "Subtotal",
                invoice.subtotal.toStringAsFixed(2),
              ),
              if (invoice.discount > 0)
                _thermalRow(
                  template,
                  "Discount",
                  "-${invoice.discount.toStringAsFixed(2)}",
                ),
              _thermalRow(
                template,
                "CGST",
                (invoice.tax / 2).toStringAsFixed(2),
              ),
              _thermalRow(
                template,
                "SGST",
                (invoice.tax / 2).toStringAsFixed(2),
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "GRAND TOTAL",
                    style: TemplateHelper.getStyle(
                      template: template,
                      isBold: true,
                      fontSize: 13,
                    ),
                  ),
                  pw.Text(
                    "Rs ${invoice.total.toStringAsFixed(2)}",
                    style: TemplateHelper.getStyle(
                      template: template,
                      isBold: true,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              if (template.showFooter) ...[
                pw.SizedBox(height: 20),
                pw.Center(
                  child: pw.Text(
                    template.footerMessage,
                    style: TemplateHelper.getStyle(
                      template: template,
                      fontSize: 9,
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

  static pw.Widget _thermalRow(
    InvoiceTemplate template,
    String label,
    String value,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: TemplateHelper.getStyle(template: template, fontSize: 9),
          ),
          pw.Text(
            value,
            style: TemplateHelper.getStyle(template: template, fontSize: 9),
          ),
        ],
      ),
    );
  }
}
