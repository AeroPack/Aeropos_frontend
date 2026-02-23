import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/models/invoice_template.dart';
import '../widgets/rich_text_section_editor.dart';

/// Configuration model for custom template sections
class TemplateSection {
  final String id;
  final String type; // 'header', 'customer', 'items', 'footer'
  final String label;
  final bool visible;
  final bool useRichText; // Toggle between simple and rich text mode
  final String? richTextContent; // Flutter Quill delta JSON
  final Map<String, dynamic> properties;

  TemplateSection({
    required this.id,
    required this.type,
    required this.label,
    this.visible = true,
    this.useRichText = false,
    this.richTextContent,
    this.properties = const {},
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'label': label,
    'visible': visible,
    'useRichText': useRichText,
    'richTextContent': richTextContent,
    'properties': properties,
  };

  factory TemplateSection.fromJson(Map<String, dynamic> json) {
    return TemplateSection(
      id: json['id'] as String,
      type: json['type'] as String,
      label: json['label'] as String,
      visible: json['visible'] as bool? ?? true,
      useRichText: json['useRichText'] as bool? ?? false,
      richTextContent: json['richTextContent'] as String?,
      properties: json['properties'] as Map<String, dynamic>? ?? {},
    );
  }

  TemplateSection copyWith({
    String? id,
    String? type,
    String? label,
    bool? visible,
    bool? useRichText,
    String? richTextContent,
    Map<String, dynamic>? properties,
  }) {
    return TemplateSection(
      id: id ?? this.id,
      type: type ?? this.type,
      label: label ?? this.label,
      visible: visible ?? this.visible,
      useRichText: useRichText ?? this.useRichText,
      richTextContent: richTextContent ?? this.richTextContent,
      properties: properties ?? this.properties,
    );
  }
}

class CustomTemplateEditor extends ConsumerStatefulWidget {
  const CustomTemplateEditor({super.key});

  @override
  ConsumerState<CustomTemplateEditor> createState() =>
      _CustomTemplateEditorState();
}

class _CustomTemplateEditorState extends ConsumerState<CustomTemplateEditor> {
  List<TemplateSection> _sections = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadExistingConfig();
  }

  void _loadExistingConfig() {
    final currentTemplate = ref.read(invoiceTemplateProvider);
    if (currentTemplate.customConfig != null &&
        currentTemplate.customConfig!.isNotEmpty) {
      try {
        final config = jsonDecode(currentTemplate.customConfig!);
        final sections = (config['sections'] as List)
            .map((s) => TemplateSection.fromJson(s as Map<String, dynamic>))
            .toList();
        setState(() {
          _sections = sections;
        });
      } catch (e) {
        _initializeDefaultSections();
      }
    } else {
      _initializeDefaultSections();
    }
  }

  void _initializeDefaultSections() {
    setState(() {
      _sections = [
        TemplateSection(
          id: 'header',
          type: 'header',
          label: 'Header',
          properties: {'alignment': 'center', 'showLogo': true},
        ),
        TemplateSection(
          id: 'customer',
          type: 'customer',
          label: 'Customer Details',
          properties: {'alignment': 'left'},
        ),
        TemplateSection(
          id: 'items',
          type: 'items',
          label: 'Items Table',
          properties: {'showBorder': true},
        ),
        TemplateSection(
          id: 'footer',
          type: 'footer',
          label: 'Footer',
          properties: {'alignment': 'center'},
        ),
        TemplateSection(
          id: 'rich_text_1',
          type: 'rich_text',
          label: 'Custom Text (Rich) #1',
          properties: {'delta': ''},
        ),
      ];
    });
  }

  void _addRichTextSection() {
    setState(() {
      final richTextCount = _sections
          .where((s) => s.type == 'rich_text')
          .length;
      _sections.add(
        TemplateSection(
          id: 'rich_text_${richTextCount + 1}',
          type: 'rich_text',
          label: 'Custom Text (Rich) #${richTextCount + 1}',
          properties: {'delta': ''},
        ),
      );
    });
  }

  void _deleteSection(int index) {
    setState(() {
      _sections.removeAt(index);
    });
  }

  Future<void> _saveTemplate() async {
    final config = {
      'version': '1.0',
      'sections': _sections.map((s) => s.toJson()).toList(),
    };

    await ref
        .read(invoiceTemplateProvider.notifier)
        .updateTemplate(
          layout: InvoiceLayout.custom,
          customConfig: jsonEncode(config),
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Custom template saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickImage(int index) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500, // Limit size for storage
        maxHeight: 500,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        final base64Image = base64Encode(bytes);
        _updateSectionProperty(index, 'logoImage', base64Image);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _reorderSections(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _sections.removeAt(oldIndex);
      _sections.insert(newIndex, item);
    });
  }

  void _toggleSectionVisibility(int index) {
    setState(() {
      _sections[index] = _sections[index].copyWith(
        visible: !_sections[index].visible,
      );
    });
  }

  void _updateSectionProperty(int index, String key, dynamic value) {
    setState(() {
      if (key == 'useRichText') {
        _sections[index] = _sections[index].copyWith(
          useRichText: value as bool,
        );
      } else if (key == 'richTextContent') {
        _sections[index] = _sections[index].copyWith(
          richTextContent: value as String,
        );
      } else {
        final updatedProperties = Map<String, dynamic>.from(
          _sections[index].properties,
        );
        updatedProperties[key] = value;
        _sections[index] = _sections[index].copyWith(
          properties: updatedProperties,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Custom Template Builder',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: _saveTemplate,
              icon: const Icon(Icons.save),
              label: const Text('Save Template'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Left Panel - Section Builder
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Template Sections',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Drag to reorder sections',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ReorderableListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: _sections.length,
                      onReorder: _reorderSections,
                      itemBuilder: (context, index) {
                        final section = _sections[index];
                        return _SectionCard(
                          key: ValueKey(section.id),
                          section: section,
                          index: index,
                          onToggleVisibility: () =>
                              _toggleSectionVisibility(index),
                          onPropertyChanged: (key, value) =>
                              _updateSectionProperty(index, key, value),
                          onDelete: section.type == 'rich_text'
                              ? () => _deleteSection(index)
                              : null,
                          onPickImage: () => _pickImage(index),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ElevatedButton.icon(
                      onPressed: _addRichTextSection,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Rich Text Section'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        foregroundColor: Colors.blue.shade700,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.blue.shade200),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Panel - Live Preview
          Expanded(
            flex: 3,
            child: Container(
              color: const Color(0xFFF5F7FA),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Live Preview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(32),
                      child: SingleChildScrollView(child: _buildPreview()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _sections.where((s) => s.visible).map((section) {
        switch (section.type) {
          case 'header':
            return _buildHeaderPreview(section);
          case 'customer':
            return _buildCustomerPreview(section);
          case 'items':
            return _buildItemsPreview(section);
          case 'footer':
            return _buildFooterPreview(section);
          case 'rich_text':
            return _buildRichTextPreview(section);
          default:
            return const SizedBox.shrink();
        }
      }).toList(),
    );
  }

  Widget _buildHeaderPreview(TemplateSection section) {
    if (section.useRichText) {
      return _renderRichTextContent(section.richTextContent);
    }

    final alignment = section.properties['alignment'] as String? ?? 'center';
    final showLogo = section.properties['showLogo'] as bool? ?? true;
    final logoImage = section.properties['logoImage'] as String?;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: alignment == 'left'
            ? CrossAxisAlignment.start
            : alignment == 'right'
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.center,
        children: [
          if (showLogo)
            if (logoImage != null)
              Image.memory(
                base64Decode(logoImage),
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 32,
                    ),
                  );
                },
              )
            else
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.business, color: Colors.blue, size: 32),
              ),
          const SizedBox(height: 12),
          const Text(
            'Your Business Name',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Business Address, City, State',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerPreview(TemplateSection section) {
    if (section.useRichText) {
      return _renderRichTextContent(section.richTextContent);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bill To:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'Customer Name\nCustomer Address\nPhone: +1234567890',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsPreview(TemplateSection section) {
    if (section.useRichText) {
      return _renderRichTextContent(section.richTextContent);
    }

    final showBorder = section.properties['showBorder'] as bool? ?? true;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Table(
        border: showBorder
            ? TableBorder.all(color: Colors.grey.shade300)
            : null,
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Item',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Qty',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sample Product', style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('2', style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('\$100.00', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterPreview(TemplateSection section) {
    if (section.useRichText) {
      return _renderRichTextContent(section.richTextContent);
    }

    final alignment = section.properties['alignment'] as String? ?? 'center';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: alignment == 'left'
          ? Alignment.centerLeft
          : alignment == 'right'
          ? Alignment.centerRight
          : Alignment.center,
      child: const Text(
        'Thank you for your business!',
        style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _renderRichTextContent(String? delta) {
    if (delta == null || delta.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'No content yet. Enable rich text mode and start editing.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    try {
      final doc = Document.fromJson(jsonDecode(delta));
      final controller = QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: QuillEditor.basic(
          controller: controller,
          config: const QuillEditorConfig(padding: EdgeInsets.zero),
        ),
      );
    } catch (e) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Error displaying content',
          style: TextStyle(
            fontSize: 12,
            color: Colors.red.shade500,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
  }

  Widget _buildRichTextPreview(TemplateSection section) {
    final delta = section.properties['delta'] as String? ?? '';

    if (delta.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'No content yet. Click to edit.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    try {
      final doc = Document.fromJson(jsonDecode(delta));
      final controller = QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: QuillEditor.basic(
          controller: controller,
          config: const QuillEditorConfig(padding: EdgeInsets.zero),
        ),
      );
    } catch (e) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Error displaying content',
          style: TextStyle(
            fontSize: 12,
            color: Colors.red.shade500,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
  }
}

class _SectionCard extends StatelessWidget {
  final TemplateSection section;
  final int index;
  final VoidCallback onToggleVisibility;
  final Function(String key, dynamic value) onPropertyChanged;
  final VoidCallback? onDelete;
  final VoidCallback? onPickImage;

  const _SectionCard({
    super.key,
    required this.section,
    required this.index,
    required this.onToggleVisibility,
    required this.onPropertyChanged,
    this.onDelete,
    this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: section.visible ? Colors.white : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: section.visible ? Colors.blue.shade200 : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: ExpansionTile(
        leading: Icon(Icons.drag_indicator, color: Colors.grey.shade400),
        title: Text(
          section.label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: section.visible ? Colors.black87 : Colors.grey.shade500,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                section.visible ? Icons.visibility : Icons.visibility_off,
                color: section.visible ? Colors.blue : Colors.grey,
              ),
              onPressed: onToggleVisibility,
            ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDelete,
                tooltip: 'Delete section',
              ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSectionProperties(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionProperties() {
    switch (section.type) {
      case 'header':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Use Rich Text Editor'),
              subtitle: const Text('Enable advanced formatting'),
              value: section.useRichText,
              onChanged: (val) => onPropertyChanged('useRichText', val),
            ),
            if (section.useRichText)
              RichTextSectionEditor(
                initialDelta: section.richTextContent,
                onChanged: (delta) =>
                    onPropertyChanged('richTextContent', delta),
              )
            else ...[
              SwitchListTile(
                title: const Text('Show Logo'),
                value: section.properties['showLogo'] as bool? ?? true,
                onChanged: (val) => onPropertyChanged('showLogo', val),
              ),
              const SizedBox(height: 12),
              if (section.properties['showLogo'] == true) ...[
                const Text(
                  'Logo Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (section.properties['logoImage'] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.memory(
                          base64Decode(section.properties['logoImage']),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: onPickImage,
                          icon: const Icon(Icons.upload, size: 16),
                          label: Text(
                            section.properties['logoImage'] != null
                                ? 'Change Logo'
                                : 'Upload Logo',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade50,
                            foregroundColor: Colors.blue.shade700,
                            elevation: 0,
                          ),
                        ),
                        if (section.properties['logoImage'] != null)
                          TextButton.icon(
                            onPressed: () =>
                                onPropertyChanged('logoImage', null),
                            icon: const Icon(Icons.close, size: 16),
                            label: const Text('Remove Logo'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
              _buildAlignmentSelector(),
            ],
          ],
        );
      case 'customer':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Use Rich Text Editor'),
              subtitle: const Text('Enable advanced formatting'),
              value: section.useRichText,
              onChanged: (val) => onPropertyChanged('useRichText', val),
            ),
            if (section.useRichText)
              RichTextSectionEditor(
                initialDelta: section.richTextContent,
                onChanged: (delta) =>
                    onPropertyChanged('richTextContent', delta),
              )
            else
              _buildAlignmentSelector(),
          ],
        );
      case 'items':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Use Rich Text Editor'),
              subtitle: const Text('Customize table headers and notes'),
              value: section.useRichText,
              onChanged: (val) => onPropertyChanged('useRichText', val),
            ),
            if (section.useRichText)
              RichTextSectionEditor(
                initialDelta: section.richTextContent,
                onChanged: (delta) =>
                    onPropertyChanged('richTextContent', delta),
              )
            else
              SwitchListTile(
                title: const Text('Show Border'),
                value: section.properties['showBorder'] as bool? ?? true,
                onChanged: (val) => onPropertyChanged('showBorder', val),
              ),
          ],
        );
      case 'footer':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Use Rich Text Editor'),
              subtitle: const Text('Enable advanced formatting'),
              value: section.useRichText,
              onChanged: (val) => onPropertyChanged('useRichText', val),
            ),
            if (section.useRichText)
              RichTextSectionEditor(
                initialDelta: section.richTextContent,
                onChanged: (delta) =>
                    onPropertyChanged('richTextContent', delta),
              )
            else
              _buildAlignmentSelector(),
          ],
        );
      case 'rich_text':
        return RichTextSectionEditor(
          initialDelta: section.properties['delta'] as String?,
          onChanged: (delta) => onPropertyChanged('delta', delta),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAlignmentSelector() {
    final currentAlignment =
        section.properties['alignment'] as String? ?? 'center';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Text('Alignment: '),
          const SizedBox(width: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'left',
                label: Text('Left'),
                icon: Icon(Icons.align_horizontal_left),
              ),
              ButtonSegment(
                value: 'center',
                label: Text('Center'),
                icon: Icon(Icons.align_horizontal_center),
              ),
              ButtonSegment(
                value: 'right',
                label: Text('Right'),
                icon: Icon(Icons.align_horizontal_right),
              ),
            ],
            selected: {currentAlignment},
            onSelectionChanged: (Set<String> newSelection) {
              onPropertyChanged('alignment', newSelection.first);
            },
          ),
        ],
      ),
    );
  }
}
