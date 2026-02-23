import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/invoice_template.dart';
import 'custom_template_editor.dart';

class InvoiceTemplateScreen extends ConsumerWidget {
  const InvoiceTemplateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTemplate = ref.watch(invoiceTemplateProvider);

    final templates = [
      _TemplateInfo(
        layout: InvoiceLayout.thermal,
        name: "Thermal Receipt",
        description:
            "Optimized for 58mm/80mm thermal printers. Clean and compact.",
        icon: Icons.receipt_outlined,
      ),
      _TemplateInfo(
        layout: InvoiceLayout.modern,
        name: "Modern A4",
        description:
            "Professional full-page layout with a modern touch. Best for PDFs.",
        icon: Icons.description_outlined,
      ),
      _TemplateInfo(
        layout: InvoiceLayout.classic,
        name: "Classic A4",
        description: "Traditional corporate look. Familiar and standard.",
        icon: Icons.article_outlined,
      ),
      _TemplateInfo(
        layout: InvoiceLayout.luxury,
        name: "Luxury",
        description:
            "Elegant gold & beige design for premium brand experience.",
        icon: Icons.auto_awesome,
      ),
      _TemplateInfo(
        layout: InvoiceLayout.stylish,
        name: "Stylish",
        description: "Modern teal accents with a sleek asymmetrical layout.",
        icon: Icons.style,
      ),
      _TemplateInfo(
        layout: InvoiceLayout.advanced_gst,
        name: "Advanced GST",
        description: "Tax-compliant layout with detailed breakdown and GSTIN.",
        icon: Icons.request_quote,
      ),
      _TemplateInfo(
        layout: InvoiceLayout.simple,
        name: "Simple",
        description:
            "Minimalist minimalist layout focusing on essential details.",
        icon: Icons.horizontal_rule,
      ),
      _TemplateInfo(
        layout: InvoiceLayout.dreams,
        name: "Dreams POS",
        description:
            "Professional layout with circular PAID stamp and structured totals.",
        icon: Icons.auto_graph,
      ),
      _TemplateInfo(
        layout: InvoiceLayout.custom,
        name: "Custom Template",
        description: "Create your own template with drag-and-drop builder.",
        icon: Icons.edit_note,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Invoice Customization",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(title: "1. Choose Your Template"),
            const SizedBox(height: 16),
            SizedBox(
              height: 320,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: templates.length,
                separatorBuilder: (context, _) => const SizedBox(width: 24),
                itemBuilder: (context, index) {
                  final template = templates[index];
                  final isSelected = currentTemplate.layout == template.layout;
                  return SizedBox(
                    width: 350,
                    child: _TemplateCard(
                      template: template,
                      isSelected: isSelected,
                      onSelect: () {
                        if (template.layout == InvoiceLayout.custom) {
                          // Navigate to custom template editor
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CustomTemplateEditor(),
                            ),
                          );
                        } else {
                          ref
                              .read(invoiceTemplateProvider.notifier)
                              .updateTemplate(layout: template.layout);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 48),
            const _SectionTitle(title: "2. Visual Customization"),
            const SizedBox(height: 24),
            _CustomizationPanel(currentTemplate: currentTemplate),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Business Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Business name, address, phone, and tax ID are now managed in the Company Profile page. Update them there to see changes in your invoices.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0F172A),
      ),
    );
  }
}

class _CustomizationPanel extends ConsumerWidget {
  final InvoiceTemplate currentTemplate;
  const _CustomizationPanel({required this.currentTemplate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _SettingTile(
            title: "Theme Color",
            subtitle: "Accent color for headers and titles",
            trailing: InkWell(
              onTap: () {
                // Color picker would go here
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(
                    int.parse(
                          currentTemplate.accentColor.replaceFirst('#', ''),
                          radix: 16,
                        ) |
                        0xFF000000,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          const Divider(),
          _SettingTile(
            title: "Font Family",
            subtitle: "Style of the text on the invoice",
            trailing: DropdownButton<String>(
              value: currentTemplate.fontFamily,
              items: [
                "Roboto",
                "Helvetica",
                "Times",
                "Courier",
              ].map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
              onChanged: (val) {
                if (val != null) {
                  ref
                      .read(invoiceTemplateProvider.notifier)
                      .updateTemplate(fontFamily: val);
                }
              },
            ),
          ),
          const Divider(),
          _SettingTile(
            title: "Text Size Multiplier",
            subtitle: "Adjust overall scale of the text",
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => ref
                      .read(invoiceTemplateProvider.notifier)
                      .updateTemplate(
                        fontSizeMultiplier:
                            (currentTemplate.fontSizeMultiplier - 0.1).clamp(
                              0.5,
                              2.0,
                            ),
                      ),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  "${currentTemplate.fontSizeMultiplier.toStringAsFixed(1)}x",
                ),
                IconButton(
                  onPressed: () => ref
                      .read(invoiceTemplateProvider.notifier)
                      .updateTemplate(
                        fontSizeMultiplier:
                            (currentTemplate.fontSizeMultiplier + 0.1).clamp(
                              0.5,
                              2.0,
                            ),
                      ),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Show Address"),
            subtitle: const Text("Include business address in header"),
            value: currentTemplate.showAddress,
            onChanged: (val) => ref
                .read(invoiceTemplateProvider.notifier)
                .updateTemplate(showAddress: val),
          ),
          SwitchListTile(
            title: const Text("Show Customer Details"),
            subtitle: const Text("Include bill to/ship to section"),
            value: currentTemplate.showCustomerDetails,
            onChanged: (val) => ref
                .read(invoiceTemplateProvider.notifier)
                .updateTemplate(showCustomerDetails: val),
          ),
          SwitchListTile(
            title: const Text("Show Footer Message"),
            subtitle: const Text("Include the thank you message at the bottom"),
            value: currentTemplate.showFooter,
            onChanged: (val) => ref
                .read(invoiceTemplateProvider.notifier)
                .updateTemplate(showFooter: val),
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget trailing;
  const _SettingTile({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
      trailing: trailing,
    );
  }
}

class _TemplateInfo {
  final InvoiceLayout layout;
  final String name;
  final String description;
  final IconData icon;

  _TemplateInfo({
    required this.layout,
    required this.name,
    required this.description,
    required this.icon,
  });
}

class _TemplateCard extends StatelessWidget {
  final _TemplateInfo template;
  final bool isSelected;
  final VoidCallback onSelect;

  const _TemplateCard({
    required this.template,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      template.icon,
                      size: 64,
                      color: isSelected ? Colors.blue : Colors.grey.shade400,
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              template.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              template.description,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? Colors.blue : Colors.white,
                  foregroundColor: isSelected ? Colors.white : Colors.blue,
                  elevation: 0,
                  side: BorderSide(
                    color: isSelected ? Colors.blue : Colors.blue.shade100,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(isSelected ? "Selected" : "Use This Template"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
