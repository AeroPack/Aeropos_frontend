import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/invoice_template.dart';

/// Dynamic renderer for custom invoice templates
/// Reads JSON configuration and builds layout accordingly
class CustomLayout {
  static pw.Widget buildPdf(
    InvoiceTemplate template,
    Map<String, dynamic> invoiceData,
  ) {
    if (template.customConfig == null || template.customConfig!.isEmpty) {
      return pw.Center(child: pw.Text('No custom configuration found'));
    }

    try {
      final config = jsonDecode(template.customConfig!);
      final sections = (config['sections'] as List)
          .map((s) => s as Map<String, dynamic>)
          .toList();

      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: sections
            .where((s) => s['visible'] as bool? ?? true)
            .map((section) => _buildSection(section, template, invoiceData))
            .toList(),
      );
    } catch (e) {
      return pw.Center(child: pw.Text('Error rendering custom template: $e'));
    }
  }

  static pw.Widget _buildSection(
    Map<String, dynamic> section,
    InvoiceTemplate template,
    Map<String, dynamic> invoiceData,
  ) {
    final type = section['type'] as String;
    final properties = section['properties'] as Map<String, dynamic>? ?? {};
    final useRichText = section['useRichText'] as bool? ?? false;
    final richTextContent = section['richTextContent'] as String?;

    // If rich text mode is enabled and content exists, render it
    if (useRichText && richTextContent != null && richTextContent.isNotEmpty) {
      return _convertQuillDeltaToPdfWidget(richTextContent);
    }

    // Otherwise, use default rendering
    switch (type) {
      case 'header':
        return _buildHeader(template, properties);
      case 'customer':
        return _buildCustomer(invoiceData, properties);
      case 'items':
        return _buildItems(invoiceData, properties);
      case 'footer':
        return _buildFooter(template, properties);
      case 'rich_text':
        return _buildRichText(properties);
      default:
        return pw.SizedBox();
    }
  }

  static pw.Widget _buildHeader(
    InvoiceTemplate template,
    Map<String, dynamic> properties,
  ) {
    final alignment = properties['alignment'] as String? ?? 'center';
    final showLogo = properties['showLogo'] as bool? ?? true;

    pw.CrossAxisAlignment crossAlignment;
    switch (alignment) {
      case 'left':
        crossAlignment = pw.CrossAxisAlignment.start;
        break;
      case 'right':
        crossAlignment = pw.CrossAxisAlignment.end;
        break;
      default:
        crossAlignment = pw.CrossAxisAlignment.center;
    }

    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: crossAlignment,
        children: [
          if (showLogo)
            pw.Container(
              width: 60,
              height: 60,
              decoration: pw.BoxDecoration(
                color: PdfColors.blue100,
                shape: pw.BoxShape.circle,
              ),
              child: pw.Center(
                child: pw.Text(
                  'LOGO',
                  style: pw.TextStyle(
                    color: PdfColors.blue,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (showLogo) pw.SizedBox(height: 12),
          pw.Text(
            (profile?['businessName'] ?? profile?['companyName'] ?? 'Business'),
            style: pw.TextStyle(
              fontSize: 24 * template.fontSizeMultiplier,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          if (template.showAddress && profile?['businessAddress'] != null)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 4),
              child: pw.Text(
                profile?['businessAddress']!,
                style: pw.TextStyle(
                  fontSize: 10 * template.fontSizeMultiplier,
                  color: PdfColors.grey700,
                ),
              ),
            ),
          if (profile?['phone'] != null)
            pw.Text(
              profile?['phone']!,
              style: pw.TextStyle(
                fontSize: 10 * template.fontSizeMultiplier,
                color: PdfColors.grey700,
              ),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildCustomer(
    Map<String, dynamic> invoiceData,
    Map<String, dynamic> properties,
  ) {
    final customerName = invoiceData['customerName'] as String? ?? 'Customer';
    final customerAddress = invoiceData['customerAddress'] as String? ?? '';
    final customerPhone = invoiceData['customerPhone'] as String? ?? '';

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Bill To:',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
          ),
          pw.SizedBox(height: 8),
          pw.Text(customerName, style: const pw.TextStyle(fontSize: 11)),
          if (customerAddress.isNotEmpty)
            pw.Text(customerAddress, style: const pw.TextStyle(fontSize: 10)),
          if (customerPhone.isNotEmpty)
            pw.Text(
              'Phone: $customerPhone',
              style: const pw.TextStyle(fontSize: 10),
            ),
        ],
      ),
    );
  }

  static pw.Widget _buildItems(
    Map<String, dynamic> invoiceData,
    Map<String, dynamic> properties,
  ) {
    final showBorder = properties['showBorder'] as bool? ?? true;
    final items = invoiceData['items'] as List<Map<String, dynamic>>? ?? [];

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 16),
      child: pw.Table(
        border: showBorder
            ? pw.TableBorder.all(color: PdfColors.grey300)
            : null,
        children: [
          // Header row
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.grey100),
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  'Item',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  'Qty',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  'Price',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  'Total',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
            ],
          ),
          // Item rows
          ...items.map((item) {
            return pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    item['name'] as String? ?? '',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    '${item['quantity'] ?? 0}',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    '\$${item['price'] ?? 0}',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    '\$${(item['quantity'] ?? 0) * (item['price'] ?? 0)}',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter(
    InvoiceTemplate template,
    Map<String, dynamic> properties,
  ) {
    final alignment = properties['alignment'] as String? ?? 'center';

    pw.Alignment pdfAlignment;
    switch (alignment) {
      case 'left':
        pdfAlignment = pw.Alignment.centerLeft;
        break;
      case 'right':
        pdfAlignment = pw.Alignment.centerRight;
        break;
      default:
        pdfAlignment = pw.Alignment.center;
    }

    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 20),
      alignment: pdfAlignment,
      child: pw.Text(
        template.footerMessage,
        style: pw.TextStyle(
          fontSize: 10 * template.fontSizeMultiplier,
          fontStyle: pw.FontStyle.italic,
        ),
      ),
    );
  }

  static pw.Widget _buildRichText(Map<String, dynamic> properties) {
    final delta = properties['delta'] as String? ?? '';

    if (delta.isEmpty) {
      return pw.SizedBox();
    }

    return _convertQuillDeltaToPdfWidget(delta);
  }

  /// Converts Flutter Quill delta JSON to PDF widgets
  static pw.Widget _convertQuillDeltaToPdfWidget(String delta) {
    try {
      final deltaJson = jsonDecode(delta);
      final ops = deltaJson['ops'] as List?;

      if (ops == null || ops.isEmpty) return pw.SizedBox();

      final textSpans = <pw.TextSpan>[];

      for (final op in ops) {
        if (op is! Map || !op.containsKey('insert')) continue;

        final text = op['insert'].toString();
        final attributes = op['attributes'] as Map<String, dynamic>?;

        // Build text style from attributes
        pw.TextStyle style = const pw.TextStyle(fontSize: 11);

        if (attributes != null) {
          pw.FontWeight? fontWeight;
          pw.FontStyle? fontStyle;
          PdfColor? color;
          double? fontSize;

          if (attributes['bold'] == true) {
            fontWeight = pw.FontWeight.bold;
          }
          if (attributes['italic'] == true) {
            fontStyle = pw.FontStyle.italic;
          }
          if (attributes['size'] != null) {
            final sizeStr = attributes['size'].toString();
            // Map Quill sizes to PDF font sizes
            fontSize = _mapQuillSizeToPdfSize(sizeStr);
          }
          if (attributes['color'] != null) {
            color = _parseColor(attributes['color'].toString());
          }

          style = pw.TextStyle(
            fontSize: fontSize ?? 11,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
          );
        }

        textSpans.add(pw.TextSpan(text: text, style: style));
      }

      return pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 16),
        child: pw.RichText(text: pw.TextSpan(children: textSpans)),
      );
    } catch (e) {
      return pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 16),
        child: pw.Text(
          'Error rendering rich text: $e',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.red),
        ),
      );
    }
  }

  /// Map Quill font sizes to PDF font sizes
  static double _mapQuillSizeToPdfSize(String size) {
    switch (size) {
      case 'small':
        return 9;
      case 'large':
        return 14;
      case 'huge':
        return 18;
      default:
        return 11;
    }
  }

  /// Parse color string to PdfColor
  static PdfColor _parseColor(String colorStr) {
    try {
      // Remove '#' if present
      final hex = colorStr.replaceAll('#', '');

      if (hex.length == 6) {
        final r = int.parse(hex.substring(0, 2), radix: 16) / 255;
        final g = int.parse(hex.substring(2, 4), radix: 16) / 255;
        final b = int.parse(hex.substring(4, 6), radix: 16) / 255;
        return PdfColor(r, g, b);
      }
    } catch (e) {
      // Return black as default
    }
    return PdfColors.black;
  }
}
