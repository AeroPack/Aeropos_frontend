import 'package:flutter/material.dart';
import 'package:ezo/core/di/service_locator.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/constants/permissions.dart';

class RoleSettingsScreen extends StatefulWidget {
  const RoleSettingsScreen({super.key});

  @override
  State<RoleSettingsScreen> createState() => _RoleSettingsScreenState();
}

class _RoleSettingsScreenState extends State<RoleSettingsScreen> {
  final _dio = ServiceLocator.instance.dio;

  List<String> _roles = [];
  String? _selectedRole;
  List<String> _currentPermissions = [];
  bool _isLoadingRoles = false;
  bool _isLoadingPermissions = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    setState(() => _isLoadingRoles = true);
    try {
      final response = await _dio.get('/api/roles');
      if (response.statusCode == 200) {
        final List<String> roles = List<String>.from(response.data);
        setState(() {
          _roles = roles;
          if (_roles.isNotEmpty && _selectedRole == null) {
            _selectedRole = _roles.first;
            _fetchPermissions(_selectedRole!);
          }
        });
      }
    } catch (e) {
      _showError("Failed to fetch roles: $e");
    } finally {
      setState(() => _isLoadingRoles = false);
    }
  }

  Future<void> _fetchPermissions(String role) async {
    setState(() => _isLoadingPermissions = true);
    try {
      final response = await _dio.get('/api/roles/$role/permissions');
      if (response.statusCode == 200) {
        setState(() {
          _currentPermissions = List<String>.from(response.data);
        });
      }
    } catch (e) {
      _showError("Failed to fetch permissions: $e");
    } finally {
      setState(() => _isLoadingPermissions = false);
    }
  }

  Future<void> _savePermissions() async {
    if (_selectedRole == null) return;

    setState(() => _isSaving = true);
    try {
      await _dio.post(
        '/api/roles/$_selectedRole/permissions',
        data: {'permissions': _currentPermissions},
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permissions saved successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      _showError("Failed to save permissions: $e");
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _togglePermission(String key, bool value) {
    setState(() {
      if (value) {
        _currentPermissions.add(key);
      } else {
        _currentPermissions.remove(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PosColors.background,
      appBar: AppBar(
        title: const Text("Role Settings"),
        backgroundColor: Colors.white,
        foregroundColor: PosColors.textMain,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: _isSaving ? null : _savePermissions,
              icon: _isSaving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save, size: 18),
              label: const Text("Save Changes"),
              style: ElevatedButton.styleFrom(
                backgroundColor: PosColors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          if (isMobile) {
            return Column(
              children: [
                // Mobile: Horizontal Role Selector
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: PosColors.border)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _roles.map((role) {
                        final isSelected = role == _selectedRole;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              role[0].toUpperCase() + role.substring(1),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : PosColors.textMain,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: PosColors.blue,
                            backgroundColor: Colors.white,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => _selectedRole = role);
                                _fetchPermissions(role);
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                if (_isLoadingRoles)
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),

                // Expanded Permissions List
                Expanded(child: _buildPermissionsList()),
              ],
            );
          } else {
            // Desktop/Tablet: Sidebar Layout
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Sidebar: Roles
                Container(
                  width: 250,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(right: BorderSide(color: PosColors.border)),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Roles",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: PosColors.textMain,
                          ),
                        ),
                      ),
                      if (_isLoadingRoles)
                        const Center(child: CircularProgressIndicator())
                      else
                        Expanded(
                          child: ListView.separated(
                            itemCount: _roles.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              color: PosColors.border,
                            ),
                            itemBuilder: (context, index) {
                              final role = _roles[index];
                              final isSelected = role == _selectedRole;
                              return ListTile(
                                title: Text(
                                  role[0].toUpperCase() + role.substring(1),
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? PosColors.blue
                                        : PosColors.textMain,
                                  ),
                                ),
                                tileColor: isSelected
                                    ? Colors.blue.withValues(alpha: 0.05)
                                    : null,
                                selected: isSelected,
                                onTap: () {
                                  setState(() => _selectedRole = role);
                                  _fetchPermissions(role);
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),

                // Main Area: Permissions
                Expanded(child: _buildPermissionsList()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildPermissionsList() {
    return _isLoadingPermissions
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(24),
            children: [
              if (_selectedRole != null) ...[
                Text(
                  "Permissions for ${_selectedRole![0].toUpperCase()}${_selectedRole!.substring(1)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: PosColors.textMain,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Toggle the features this role can access.",
                  style: TextStyle(color: PosColors.textLight),
                ),
                const SizedBox(height: 24),
                ...AppPermissions.labels.entries.map((entry) {
                  final key = entry.key;
                  final label = entry.value;
                  final hasAccess = _currentPermissions.contains(key);

                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: hasAccess
                            ? PosColors.blue.withValues(alpha: 0.3)
                            : PosColors.border,
                      ),
                    ),
                    child: SwitchListTile(
                      title: Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      value: hasAccess,
                      activeTrackColor: PosColors.blue,
                      onChanged: (val) => _togglePermission(key, val),
                    ),
                  );
                }),
              ] else
                const Center(
                  child: Text("Select a role to configure permissions"),
                ),
            ],
          );
  }
}
