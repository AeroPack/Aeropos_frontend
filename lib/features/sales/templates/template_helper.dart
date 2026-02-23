import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/models/invoice_template.dart';

class TemplateHelper {
  static PdfColor getColor(String hex) {
    try {
      final colorCode = int.parse(hex.replaceFirst('#', ''), radix: 16);
      return PdfColor.fromInt(colorCode | 0xFF000000);
    } catch (_) {
      return PdfColors.blue900;
    }
  }

  static pw.TextStyle getStyle({
    required InvoiceTemplate template,
    double fontSize = 10,
    bool isBold = false,
    PdfColor? color,
  }) {
    // Note: We are using base fonts provided by the pdf package. 
    // In a real app, you might want to load external fonts.
    pw.Font font;
    if (template.fontFamily.toLowerCase().contains('times')) {
      font = isBold ? pw.Font.timesBold() : pw.Font.times();
    } else if (template.fontFamily.toLowerCase().contains('courier')) {
      font = isBold ? pw.Font.courierBold() : pw.Font.courier();
    } else {
      font = isBold ? pw.Font.helveticaBold() : pw.Font.helvetica();
    }

    return pw.TextStyle(
      font: font,
      fontSize: fontSize * template.fontSizeMultiplier,
      fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      color: color ?? PdfColors.black,
    );
  }

  static bool shouldShow(bool setting) => setting;
}
