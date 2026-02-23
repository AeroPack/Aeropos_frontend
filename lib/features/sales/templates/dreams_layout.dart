import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../../../core/models/invoice.dart';
import '../../../core/models/invoice_template.dart';
import '../../../core/database/app_database.dart';
import 'template_helper.dart';

class DreamsLayout {
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
            // Top Section: Invoice # and Logo
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Invoice Number: ${invoice.invoiceNumber}",
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey800,
                      ),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      "Invoice Date: ${DateFormat('dd-MM-yyyy').format(invoice.date)}",
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey800,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      (profile?['businessName'] ?? profile?['companyName'] ?? 'Business'),
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
                // Placeholder for Logo/Business Name on right
                pw.Text(
                  "Aero Pos",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: accentColor,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(color: PdfColors.grey200, thickness: 1),
            pw.SizedBox(height: 20),

            // Middle Section: From and Bill To
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Invoice From",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        (profile?['businessName'] ?? profile?['companyName'] ?? 'Business'),
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      if (profile?['businessAddress'] != null)
                        pw.Text(
                          profile?['businessAddress']!,
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                      if (profile?['phone'] != null)
                        pw.Text(
                          "Phone: ${profile?['phone']}",
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                    ],
                  ),
                ),
                pw.SizedBox(width: 40),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Bill To",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        customer?.name ?? "Customer Name",
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      if (customer?.address != null)
                        pw.Text(
                          customer?.address ?? '',
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                      if (customer?.phone != null)
                        pw.Text(
                          "Phone: ${customer?.phone}",
                          style: const pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey700,
                          ),
                        ),
                    ],
                  ),
                ),
                // Paid Stamp Placeholder
                pw.Container(
                  width: 80,
                  height: 80,
                  decoration: pw.BoxDecoration(
                    shape: pw.BoxShape.circle,
                    border: pw.Border.all(color: PdfColors.green600, width: 3),
                  ),
                  child: pw.Center(
                    child: pw.Transform.rotate(
                      angle: -0.2,
                      child: pw.Text(
                        "PAID",
                        style: pw.TextStyle(
                          color: PdfColors.green600,
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 30),

            // Items Details Header
            pw.Text(
              "Items Details",
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 10),

            // Items Table
            pw.TableHelper.fromTextArray(
              headers: ['#', 'Item Details', 'Quantity', 'Rate', 'Amount'],
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 10,
              ),
              cellStyle: const pw.TextStyle(fontSize: 10),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.grey50),
              data: List.generate(invoice.items.length, (index) {
                final item = invoice.items[index];
                return [
                  '${index + 1}',
                  item.productName ?? "Product",
                  '${item.quantity}',
                  'Rs ${item.unitPrice.toStringAsFixed(2)}',
                  'Rs ${item.totalPrice.toStringAsFixed(2)}',
                ];
              }),
              columnWidths: {
                0: const pw.FixedColumnWidth(40),
                1: const pw.FlexColumnWidth(),
                2: const pw.FixedColumnWidth(80),
                3: const pw.FixedColumnWidth(80),
                4: const pw.FixedColumnWidth(80),
              },
              cellAlignments: {
                0: pw.Alignment.center,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.center,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
              },
            ),

            pw.SizedBox(height: 20),

            // Bottom Section
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Left: Terms and Conditions
                pw.Expanded(
                  flex: 3,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Terms and Conditions",
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        "1. Goods once sold cannot be taken back or exchanged.",
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                      pw.Text(
                        "2. We are not the manufacturers the company provides warranty",
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(10),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.grey50,
                        ),
                        child: pw.Text(
                          "Note: Please ensure payment is made within 7 days of invoice date.",
                          style: const pw.TextStyle(fontSize: 9),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(width: 40),
                // Right: Calculations
                pw.Expanded(
                  flex: 2,
                  child: pw.Column(
                    children: [
                      _buildSummaryRow(
                        "Subtotal",
                        "Rs ${invoice.subtotal.toStringAsFixed(2)}",
                      ),
                      if (invoice.discount > 0)
                        _buildSummaryRow(
                          "Discount",
                          "Rs ${invoice.discount.toStringAsFixed(2)}",
                        ),
                      _buildSummaryRow(
                        "CGST",
                        "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                      ),
                      _buildSummaryRow(
                        "SGST",
                        "Rs ${(invoice.tax / 2).toStringAsFixed(2)}",
                      ),
                      pw.Divider(color: PdfColors.grey300),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Total (Rs)",
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            "Rs ${invoice.total.toStringAsFixed(2)}",
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    );
    return pdf;
  }

  static pw.Widget _buildSummaryRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.black),
          ),
          pw.Text(
            value,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.black),
          ),
        ],
      ),
    );
  }
}
