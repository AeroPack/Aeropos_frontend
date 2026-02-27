import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ezo/l10n/app_localizations.dart';
import 'package:ezo/core/layout/pos_design_system.dart';
import 'package:ezo/core/widgets/role_guard.dart';
import 'package:ezo/core/constants/permissions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: PosColors.background,
      appBar: AppBar(
        // Localized AppBar title
        title: Text(l10n.settings),
        backgroundColor: Colors.white,
        foregroundColor: PosColors.textMain,
        elevation: 1,
      ),
      body: ListView(
        // RTL-safe padding
        padding: const EdgeInsetsDirectional.all(16),
        children: [
          _buildSettingsItem(
            context,
            title: l10n.invoiceSettings,
            subtitle: l10n.invoiceSettingsSubtitle,
            icon: Icons.receipt_long,
            onTap: () => context.go('/settings/invoice'),
          ),

          RoleGuard(
            permission: AppPermissions.manageEmployees,
            child: _buildSettingsItem(
              context,
              title: l10n.rolePermissions,
              subtitle: l10n.rolePermissionsSubtitle,
              icon: Icons.verified_user_outlined,
              onTap: () => context.go('/settings/roles'),
            ),
          ),

          // Add more settings here
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      // RTL-safe margin
      margin: const EdgeInsetsDirectional.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: PosColors.border),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsetsDirectional.all(8),
          decoration: BoxDecoration(
            color: PosColors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: PosColors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, color: PosColors.textLight),
        onTap: onTap,
      ),
    );
  }
}
