import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/invoice.dart';
import '../../../core/models/invoice_template.dart';
import '../../../core/database/app_database.dart';
import 'template_helper.dart';

class LuxuryLayout {
  static Future<pw.Document> generate(
    Invoice invoice,
    CustomerEntity? customer,
    InvoiceTemplate template,
    Map<String, dynamic>? profile,
  ) async {
    final pdf = pw.Document();
    final accentColor = TemplateHelper.getColor(template.accentColor);
    const borderGold = PdfColor.fromInt(0xFFD4AF37);
    const lightBeige = PdfColor.fromInt(0xFFFAF9F4);

    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(30),
      buildBackground: (context) {
        return pw.FullPage(
          ignoreMargins: true,
          child: pw.Container(
            margin: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: borderGold, width: 1),
            ),
            child: pw.Container(
              margin: const pw.EdgeInsets.all(3),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: borderGold, width: 0.5),
              ),
            ),
          ),
        );
      },
    );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        build: (pw.Context context) {
          return [
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      (profile?['businessName'] ?? profile?['companyName'] ?? 'Business').toUpperCase(),
                      style: TemplateHelper.getStyle(
                        template: template,
                        fontSize: 24,
                        isBold: true,
                        color: accentColor,
                      ),
                    ),
                    if (template.showAddress &&
                        profile?['businessAddress'] != null)
                      pw.Text(
                        profile?['businessAddress']!,
                        style: TemplateHelper.getStyle(
                          template: template,
                          fontSize: 9,
                        ),
                      ),
                    if (profile?['phone'] != null)
                      pw.Text(
                        "Phone: ${profile?['phone']}",
                        style: TemplateHelper.getStyle(
                          template: template,
                          fontSize: 9,
                        ),
                      ),
                  ],
                ),
                pw.Text(
                  "TAX INVOICE",
                  style: TemplateHelper.getStyle(
                    template: template,
                    fontSize: 16,
                    isBold: true,
                    color: accentColor,
                  ),
                ),
              ],
            ),
            pw.Divider(color: accentColor, thickness: 0.5),

            // Info Strip
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _infoCol(template, "Invoice No.", invoice.invoiceNumber),
                _infoCol(
                  template,
                  "Date",
                  invoice.date.toString().split(' ')[0],
                ),
                _infoCol(template, "Currency", "INR"),
              ],
            ),
            pw.Divider(color: accentColor, thickness: 0.5),
            pw.SizedBox(height: 10),

            // Address Section
            if (template.showCustomerDetails)
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: _addressBlock(template, "Bill To", customer),
                  ),
                  pw.SizedBox(width: 20),
                  pw.Container(
                    width: 0.5,
                    height: 80,
                    color: PdfColors.grey300,
                  ),
                  pw.SizedBox(width: 20),
                  pw.Expanded(
                    child: _addressBlock(
                      template,
                      "Ship To",
                      customer,
                      isShipping: true,
                    ),
                  ),
                ],
              ),
            pw.SizedBox(height: 20),

            // Table
            pw.TableHelper.fromTextArray(
              headers: ['No', 'Item Name', 'Qty', 'Rate', 'Total'],
              headerStyle: TemplateHelper.getStyle(
                template: template,
                fontSize: 8,
                isBold: true,
                color: accentColor,
              ),
              headerDecoration: const pw.BoxDecoration(color: lightBeige),
              cellStyle: TemplateHelper.getStyle(
                template: template,
                fontSize: 8,
              ),
              data: List.generate(invoice.items.length, (index) {
                final item = invoice.items[index];
                return [
                  '${index + 1}',
                  item.productName ?? "Product",
                  '${item.quantity}',
                  item.unitPrice.toStringAsFixed(2),
                  item.totalPrice.toStringAsFixed(2),
                ];
              }),
            ),

            // Totals
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Container(
                  width: 200,
                  margin: const pw.EdgeInsets.only(top: 20),
                  child: pw.Column(
                    children: [
                      _calcRow(
                        template,
                        "Taxable Amount",
                        "Rs ${invoice.subtotal.toStringAsFixed(2)}",
                      ),
                      if (invoice.discount > 0)
                        _calcRow(
                          template,
                          "Discount",
                          "Rs ${invoice.discount.toStringAsFixed(2)}",
                        ),
                      _calcRow(
                        template,
                        "CGST",
                        "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                      ),
                      _calcRow(
                        template,
                        "SGST",
                        "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                      ),
                      pw.Divider(color: accentColor),
                      _calcRow(
                        template,
                        "Total Amount",
                        "Rs ${invoice.total.toStringAsFixed(2)}",
                        isBold: true,
                        isLarge: true,
                      ),
                    ],
                  ),
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

  static pw.Widget _infoCol(
    InvoiceTemplate template,
    String label,
    String value,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: TemplateHelper.getStyle(
            template: template,
            fontSize: 8,
            isBold: true,
            color: TemplateHelper.getColor(template.accentColor),
          ),
        ),
        pw.Text(
          value,
          style: TemplateHelper.getStyle(template: template, fontSize: 8),
        ),
      ],
    );
  }

  static pw.Widget _addressBlock(
    InvoiceTemplate template,
    String label,
    CustomerEntity? customer, {
    bool isShipping = false,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: TemplateHelper.getStyle(
            template: template,
            fontSize: 10,
            isBold: true,
            color: TemplateHelper.getColor(template.accentColor),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          customer?.name ?? "Sample Party",
          style: TemplateHelper.getStyle(
            template: template,
            fontSize: 10,
            isBold: true,
          ),
        ),
        pw.Text(
          customer?.address ??
              (isShipping ? "Shipping Address" : "Billing Address"),
          style: TemplateHelper.getStyle(
            template: template,
            fontSize: 9,
            color: PdfColors.grey700,
          ),
        ),
      ],
    );
  }

  static pw.Widget _calcRow(
    InvoiceTemplate template,
    String label,
    String value, {
    bool isBold = false,
    bool isLarge = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: TemplateHelper.getStyle(
              template: template,
              fontSize: isLarge ? 10 : 9,
              isBold: isBold,
            ),
          ),
          pw.Text(
            value,
            style: TemplateHelper.getStyle(
              template: template,
              fontSize: isLarge ? 10 : 9,
              isBold: isBold,
            ),
          ),
        ],
      ),
    );
  }
}
