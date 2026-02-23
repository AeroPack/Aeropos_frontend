import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_controller.dart';

class RoleGuard extends ConsumerWidget {
  final List<String> allowedRoles;
  final String? permission;
  final Widget child;
  final Widget fallback;

  const RoleGuard({
    super.key,
    this.allowedRoles = const [],
    this.permission,
    required this.child,
    this.fallback = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    if (user == null) {
      return fallback;
    }

    // Check permission if provided
    if (permission != null) {
      if (user.hasPermission(permission!)) {
        return child;
      }
    }

    // Check roles if provided and permission check didn't pass (or wasn't provided)
    // If permission was provided and failed, we still check roles (OR logic logic? or AND?)
    // Usually if permission is specified, we care about permission.
    // But for backward compatibility with existing code passing allowedRoles, we check it.
    if (allowedRoles.isNotEmpty && allowedRoles.contains(user.role)) {
      return child;
    }

    // If no permission specified and no roles specified, deny? Or allow?
    // Assuming secure by default, deny.
    // But if developer forgets to add constraints, it returns fallback. Correct.

    return fallback;
  }
}
