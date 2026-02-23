import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/database/app_database.dart'; // For UserEntity

class CustomerFormDialog extends StatefulWidget {
  final CustomerEntity? customer;
  final Future<void> Function({
    required String name,
    String? phone,
    String? email,
    String? address,
    required double creditLimit,
  })
  onSubmit;

  const CustomerFormDialog({super.key, this.customer, required this.onSubmit});

  @override
  State<CustomerFormDialog> createState() => _CustomerFormDialogState();
}

class _CustomerFormDialogState extends State<CustomerFormDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _creditLimitController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer?.name ?? "");
    _phoneController = TextEditingController(
      text: widget.customer?.phone ?? "",
    );
    _emailController = TextEditingController(
      text: widget.customer?.email ?? "",
    );
    _addressController = TextEditingController(
      text: widget.customer?.address ?? "",
    );
    _creditLimitController = TextEditingController(
      text: widget.customer?.creditLimit.toString() ?? "0.0",
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _creditLimitController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Name is required")));
      return;
    }
    setState(() => _isLoading = true);
    try {
      await widget.onSubmit(
        name: _nameController.text,
        phone: _phoneController.text.isEmpty ? null : _phoneController.text,
        email: _emailController.text.isEmpty ? null : _emailController.text,
        address: _addressController.text.isEmpty
            ? null
            : _addressController.text,
        creditLimit: double.tryParse(_creditLimitController.text) ?? 0.0,
      );
      if (mounted) {
        context.pop(); // Close dialog on success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
    final title = widget.customer == null
        ? "Add New Customer"
        : "Edit Customer";
    final btnLabel = widget.customer == null
        ? "Create Customer"
        : "Save Changes";

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name Field
              PosTextInput(
                label: "Name",
                placeholder: "e.g. John Doe",
                controller: _nameController,
                isRequired: true,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: PosTextInput(
                      label: "Phone",
                      placeholder: "e.g. +123456789",
                      controller: _phoneController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PosTextInput(
                      label: "Email",
                      placeholder: "john@example.com",
                      controller: _emailController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              PosTextInput(
                label: "Address",
                placeholder: "123 Main St",
                controller: _addressController,
                maxLines: 2,
              ),
              const SizedBox(height: 16),

              PosTextInput(
                label: "Credit Limit",
                placeholder: "0.0",
                controller: _creditLimitController,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(btnLabel),
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
