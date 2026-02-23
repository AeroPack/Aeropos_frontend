import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/database/app_database.dart';

class EmployeeFormDialog extends StatefulWidget {
  final EmployeeEntity? employee;
  final Future<void> Function({
    required String name,
    String? phone,
    String? email,
    String? address,
    String? role,
    String? password,
    String? authMethod,
  })
  onSubmit;

  const EmployeeFormDialog({super.key, this.employee, required this.onSubmit});

  @override
  State<EmployeeFormDialog> createState() => _EmployeeFormDialogState();
}

class _EmployeeFormDialogState extends State<EmployeeFormDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  String _selectedRole = 'employee';
  bool _isLoading = false;

  /// Toggle between 'manual' and 'google' auth methods (only for new employees)
  String _authMethod = 'manual';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee?.name ?? "");
    _phoneController = TextEditingController(
      text: widget.employee?.phone ?? "",
    );
    _emailController = TextEditingController(
      text: widget.employee?.email ?? "",
    );
    _addressController = TextEditingController(
      text: widget.employee?.address ?? "",
    );
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    try {
      if (widget.employee != null) {
        _selectedRole = (widget.employee as dynamic).role ?? 'employee';
      }
    } catch (_) {
      _selectedRole = 'employee';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_authMethod == 'google') {
      // Google Auth: only email is required
      if (_emailController.text.isEmpty ||
          !_emailController.text.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid Gmail address")),
        );
        return;
      }
    } else {
      // Manual: name and password required
      if (_nameController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Name is required")));
        return;
      }

      if (widget.employee == null) {
        if (_passwordController.text.length < 6) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password must be at least 6 characters"),
            ),
          );
          return;
        }
        if (_passwordController.text != _confirmPasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Passwords do not match")),
          );
          return;
        }
      }
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
        role: _selectedRole,
        password: (widget.employee == null && _authMethod == 'manual')
            ? _passwordController.text
            : null,
        authMethod: widget.employee == null ? _authMethod : null,
      );
      if (mounted) {
        context.pop();
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
    final isEditing = widget.employee != null;
    final title = isEditing ? "Edit Employee" : "Add New Employee";
    final btnLabel = isEditing ? "Save Changes" : "Create Employee";

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 520,
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
              const SizedBox(height: 16),

              // Auth Method Toggle (only for new employees)
              if (!isEditing) ...[
                _AuthMethodToggle(
                  selected: _authMethod,
                  onChanged: (method) {
                    setState(() {
                      _authMethod = method;
                      // Reset fields when switching
                      _nameController.clear();
                      _emailController.clear();
                      _phoneController.clear();
                      _addressController.clear();
                      _passwordController.clear();
                      _confirmPasswordController.clear();
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],

              if (_authMethod == 'google' && !isEditing) ...[
                // ── Google Auth Mode ─────────────────────────────────
                _GoogleAuthHint(),
                const SizedBox(height: 16),
                PosTextInput(
                  label: "Gmail Address",
                  placeholder: "employee@gmail.com",
                  controller: _emailController,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
              ] else ...[
                // ── Manual Mode ──────────────────────────────────────
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

                if (!isEditing) ...[
                  Row(
                    children: [
                      Expanded(
                        child: PosTextInput(
                          label: "Password",
                          placeholder: "******",
                          controller: _passwordController,
                          isRequired: true,
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PosTextInput(
                          label: "Confirm Password",
                          placeholder: "******",
                          controller: _confirmPasswordController,
                          isRequired: true,
                          isPassword: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ],

              // Role Dropdown (always visible)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Role",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: PosColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: PosColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedRole,
                        isExpanded: true,
                        items: ['admin', 'manager', 'employee', 'cashier'].map((
                          role,
                        ) {
                          return DropdownMenuItem(
                            value: role,
                            child: Text(
                              role[0].toUpperCase() + role.substring(1),
                              style: const TextStyle(
                                fontSize: 14,
                                color: PosColors.textMain,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedRole = val);
                        },
                      ),
                    ),
                  ),
                ],
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

// ─────────────────────────────────────────────────────────────────────────────
// Segmented toggle widget: Manual | Google Auth
// ─────────────────────────────────────────────────────────────────────────────

class _AuthMethodToggle extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _AuthMethodToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _ToggleTab(
            label: 'Manual',
            icon: Icons.person_outline,
            isSelected: selected == 'manual',
            onTap: () => onChanged('manual'),
          ),
          const SizedBox(width: 4),
          _ToggleTab(
            label: 'Google Auth',
            icon: Icons.g_mobiledata_rounded,
            isSelected: selected == 'google',
            onTap: () => onChanged('google'),
          ),
        ],
      ),
    );
  }
}

class _ToggleTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleTab({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? PosColors.blue : Colors.grey,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? PosColors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Info banner shown in Google Auth mode
// ─────────────────────────────────────────────────────────────────────────────

class _GoogleAuthHint extends StatelessWidget {
  const _GoogleAuthHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF3B82F6), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'The employee will log in using their Google account. '
              'No password is needed — just enter their Gmail address and assign a role.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue.shade800,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
