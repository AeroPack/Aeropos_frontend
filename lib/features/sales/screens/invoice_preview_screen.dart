import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class InvoicePreviewScreen extends StatelessWidget {
  final Future<Uint8List> Function(PdfPageFormat) onLayout;
  final String invoiceNumber;
  final VoidCallback onPrintComplete;

  const InvoicePreviewScreen({
    super.key,
    required this.onLayout,
    required this.invoiceNumber,
    required this.onPrintComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Container(
        width: 800,
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // --- HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Invoice",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            
            // --- BODY (PDF Preview) ---
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: PdfPreview(
                  build: onLayout,
                  allowPrinting: false, // We'll use our own button
                  allowSharing: false,
                  canChangePageFormat: false,
                  useActions: false, // Hide top action bar
                  initialPageFormat: PdfPageFormat.a4,
                  onPrinted: (context) => onPrintComplete(),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            const Divider(),
            
            // --- FOOTER ---
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () async {
                      final pdf = await onLayout(PdfPageFormat.a4);
                      await Printing.sharePdf(bytes: pdf, filename: 'Invoice_$invoiceNumber.pdf');
                    },
                    icon: const Icon(Icons.download, size: 20),
                    label: const Text("Download PDF", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      final pdf = await onLayout(PdfPageFormat.a4);
                      await Printing.layoutPdf(
                        name: 'Invoice_$invoiceNumber',
                        onLayout: (PdfPageFormat format) async => pdf,
                      );
                      onPrintComplete();
                    },
                    icon: const Icon(Icons.print, size: 20),
                    label: const Text("Print Invoice", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
