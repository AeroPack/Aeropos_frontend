import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// Rich text section editor using Flutter Quill
class RichTextSectionEditor extends StatefulWidget {
  final String? initialDelta;
  final Function(String delta) onChanged;

  const RichTextSectionEditor({
    super.key,
    this.initialDelta,
    required this.onChanged,
  });

  @override
  State<RichTextSectionEditor> createState() => _RichTextSectionEditorState();
}

class _RichTextSectionEditorState extends State<RichTextSectionEditor> {
  late QuillController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    if (widget.initialDelta != null && widget.initialDelta!.isNotEmpty) {
      try {
        final doc = Document.fromJson(jsonDecode(widget.initialDelta!));
        _controller = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        _controller = QuillController.basic();
      }
    } else {
      _controller = QuillController.basic();
    }

    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final delta = jsonEncode(_controller.document.toDelta().toJson());
    widget.onChanged(delta);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Toolbar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: QuillSimpleToolbar(
              controller: _controller,
              config: QuillSimpleToolbarConfig(
                showAlignmentButtons: true,
                showBoldButton: true,
                showItalicButton: true,
                showUnderLineButton: true,
                showStrikeThrough: true,
                showListBullets: true,
                showListNumbers: true,
                showFontSize: true,
                showFontFamily: true,
                showCodeBlock: true,
                showQuote: true,
                showIndent: true,
                showLink: true,
                showSearchButton: false,
                showColorButton: true,
                showBackgroundColorButton: true,
                showClearFormat: true,
              ),
            ),
          ),
          // Editor
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            child: QuillEditor.basic(
              controller: _controller,
              focusNode: _focusNode,
              config: const QuillEditorConfig(
                padding: EdgeInsets.zero,
                placeholder: 'Enter your text here...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
