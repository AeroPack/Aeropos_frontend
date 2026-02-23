import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/widgets/pos_toast.dart'; 

class BrandFormDialog extends StatefulWidget {
  final dynamic brand; 
  final Future<void> Function(String name, String description) onSubmit;

  const BrandFormDialog({
    super.key,
    this.brand,
    required this.onSubmit,
  });

  @override
  State<BrandFormDialog> createState() => _BrandFormDialogState();
}

class _BrandFormDialogState extends State<BrandFormDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.brand?.name ?? '');
    _descController = TextEditingController(text: widget.brand?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_nameController.text.isEmpty) {
      PosToast.showError(context, "Brand Name is required");
      return;
    }

    setState(() => _isLoading = true);

    try {
      await widget.onSubmit(_nameController.text, _descController.text);

      if (mounted) {
        setState(() => _isLoading = false);
        context.pop(); 
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        PosToast.showError(context, "Error saving brand: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      elevation: 5,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.brand == null ? "Add Brand" : "Edit Brand",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PosColors.textMain),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: PosColors.textLight),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              
              const Divider(height: 32, color: PosColors.border),

              PosTextInput(
                label: "Brand Name",
                isRequired: true,
                controller: _nameController,
                placeholder: "e.g. Nike",
              ),
              
              PosTextInput(
                label: "Description",
                isRequired: false,
                controller: _descController,
                placeholder: "Optional details...",
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      side: const BorderSide(color: PosColors.border),
                      foregroundColor: PosColors.textMain,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Cancel"),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9F43), 
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: _isLoading 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text(widget.brand == null ? "Create Brand" : "Save Changes"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
