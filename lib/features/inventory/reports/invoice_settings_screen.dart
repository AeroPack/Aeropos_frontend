import 'package:flutter/material.dart'; // Re-saved to trigger reload
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/invoice_template.dart';

class InvoiceSettingsScreen extends ConsumerStatefulWidget {
  const InvoiceSettingsScreen({super.key});

  @override
  ConsumerState<InvoiceSettingsScreen> createState() =>
      _InvoiceSettingsScreenState();
}

class _InvoiceSettingsScreenState extends ConsumerState<InvoiceSettingsScreen> {
  final _footerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final current = ref.read(invoiceTemplateProvider);
    _footerController.text = current.footerMessage;
  }

  @override
  Widget build(BuildContext context) {
    final currentTemplate = ref.watch(invoiceTemplateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Settings"),
        backgroundColor: const Color(0xFF002140),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Template Selection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 1. Template Grid/List
            Row(
              children: [
                _templateCard(
                  "Thermal",
                  Icons.receipt,
                  InvoiceLayout.thermal,
                  currentTemplate.layout == InvoiceLayout.thermal,
                ),
                const SizedBox(width: 16),
                _templateCard(
                  "Modern A4",
                  Icons.description,
                  InvoiceLayout.modern,
                  currentTemplate.layout == InvoiceLayout.modern,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Footer Message
            TextField(
              controller: _footerController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Footer Message",
                border: OutlineInputBorder(),
                hintText: "e.g. Thank you for shopping!",
              ),
              onChanged: (val) => _updateTemplate(),
            ),

            const SizedBox(height: 40),

            // 4. Visual Preview Hint
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "The selected layout will be used for all future printouts and digital PDFs.",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _templateCard(
    String title,
    IconData icon,
    InvoiceLayout layout,
    bool isSelected,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref
              .read(invoiceTemplateProvider.notifier)
              .updateTemplate(layout: layout);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF002140).withOpacity(0.05)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF002140)
                  : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: isSelected ? const Color(0xFF002140) : Colors.grey,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? const Color(0xFF002140) : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTemplate() {
    ref
        .read(invoiceTemplateProvider.notifier)
        .updateTemplate(footerMessage: _footerController.text);
  }
}
