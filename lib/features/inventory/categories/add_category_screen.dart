import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ezo/core/layout/pos_design_system.dart'; // Your design system
// import 'package:ezo/core/widgets/pos_text_input.dart'; // Ensure path is correct

class CategoryFormDialog extends StatefulWidget {
  /// If provided, we are in "Edit Mode". If null, "Create Mode".
  final dynamic category; 
  final Function(String name, String description) onSubmit;

  const CategoryFormDialog({
    super.key,
    this.category,
    required this.onSubmit,
  });

  @override
  State<CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize with existing data if editing, or empty if new
    _nameController = TextEditingController(text: widget.category?.name ?? '');
    _descController = TextEditingController(text: widget.category?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_nameController.text.isEmpty) {
      // Basic manual validation since we are using custom inputs
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category Name is required")),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Pass data back to parent
    widget.onSubmit(_nameController.text, _descController.text);

    if (mounted) {
      setState(() => _isLoading = false);
      context.pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      elevation: 5,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500), // Limit width on large screens
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Shrink to fit content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.category == null ? "Add Category" : "Edit Category",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PosColors.textMain),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: PosColors.textLight),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              
              const Divider(height: 32, color: PosColors.border),

              // 2. Form Fields
              PosTextInput(
                label: "Category Name",
                isRequired: true,
                controller: _nameController,
                placeholder: "e.g. Beverages",
              ),
              
              PosTextInput(
                label: "Description",
                isRequired: false,
                controller: _descController,
                placeholder: "Optional details...",
              ),

              const SizedBox(height: 24),

              // 3. Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Cancel Button
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
                  
                  // Submit Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9F43), // Matches your "Add" button color
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: _isLoading 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text(widget.category == null ? "Create Category" : "Save Changes"),
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