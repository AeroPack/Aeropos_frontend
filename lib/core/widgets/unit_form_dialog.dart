import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/widgets/pos_toast.dart';

class UnitFormDialog extends StatefulWidget {
  final UnitEntity? unit;
  final Future<void> Function(String name, String symbol) onSubmit;

  const UnitFormDialog({
    super.key,
    this.unit,
    required this.onSubmit,
  });

  @override
  State<UnitFormDialog> createState() => _UnitFormDialogState();
}

class _UnitFormDialogState extends State<UnitFormDialog> {
  late TextEditingController _nameController;
  late TextEditingController _symbolController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.unit?.name ?? "");
    _symbolController = TextEditingController(text: widget.unit?.symbol ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _symbolController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_nameController.text.isEmpty || _symbolController.text.isEmpty) {
      PosToast.showError(context, "Name and Symbol are required");
      return;
    }
    setState(() => _isLoading = true);
    try {
      await widget.onSubmit(_nameController.text, _symbolController.text);
      if (mounted) {
        context.pop(); // Close dialog on success
      }
    } catch (e) {
      if (mounted) {
        PosToast.showError(context, "Error: $e");
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine title
    final title = widget.unit == null ? "Add New Unit" : "Edit Unit";
    final btnLabel = widget.unit == null ? "Create Unit" : "Save Changes";

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                 IconButton(
                   icon: const Icon(Icons.close),
                   onPressed: () => context.pop(),
                 )
              ],
            ),
            const SizedBox(height: 24),
            
            // Name Field
            PosTextInput(
              label: "Unit Name",
              placeholder: "e.g. Kilogram",
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            
            // Symbol Field
            PosTextInput(
              label: "Unit Symbol",
              placeholder: "e.g. kg",
              controller: _symbolController,
            ),
            const SizedBox(height: 32),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PosColors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text(btnLabel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
