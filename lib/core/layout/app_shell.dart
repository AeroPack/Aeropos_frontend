import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_controller.dart';
import '../di/service_locator.dart';
import '../constants/permissions.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Data Models
// ─────────────────────────────────────────────────────────────────────────────

class SidebarItem {
  final String label;
  final IconData icon;
  final int branchIndex;
  final String? requiredPermission;

  const SidebarItem({
    required this.label,
    required this.icon,
    required this.branchIndex,
    this.requiredPermission,
  });
}

class SidebarGroup {
  final String label;
  final IconData icon;

  /// If null, this group is a collapsible header.
  /// If set, tapping navigates directly (standalone item).
  final int? branchIndex;

  /// If set, tapping pushes this route instead of goBranch.
  final String? routePush;

  final List<SidebarItem> children;

  const SidebarGroup({
    required this.label,
    required this.icon,
    this.branchIndex,
    this.routePush,
    this.children = const [],
  });

  bool get isStandalone => children.isEmpty;
}

// ─────────────────────────────────────────────────────────────────────────────
// AppShell
// ─────────────────────────────────────────────────────────────────────────────

class AppShell extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  bool _isRailExtended = true;

  // All groups start collapsed; click to expand
  final Set<String> _expandedGroups = {};

  static const List<SidebarGroup> _sidebarGroups = [
    // ── Standalone ──────────────────────────────────────────────────────────
    SidebarGroup(
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      branchIndex: 0,
    ),

    // ── Item Master ─────────────────────────────────────────────────────────
    SidebarGroup(
      label: 'Item Master',
      icon: Icons.inventory_2_outlined,
      children: [
        SidebarItem(
          label: 'Product List',
          icon: Icons.list_alt_outlined,
          branchIndex: 1,
          requiredPermission: AppPermissions.manageProducts,
        ),
        SidebarItem(
          label: 'Category List',
          icon: Icons.category_outlined,
          branchIndex: 3,
        ),
        SidebarItem(label: 'Unit List', icon: Icons.straighten, branchIndex: 4),
        SidebarItem(
          label: 'Brand List',
          icon: Icons.branding_watermark_outlined,
          branchIndex: 5,
        ),
      ],
    ),

    // ── People ───────────────────────────────────────────────────────────────
    SidebarGroup(
      label: 'People',
      icon: Icons.groups_outlined,
      children: [
        SidebarItem(
          label: 'Customers',
          icon: Icons.person_outline,
          branchIndex: 7,
        ),
        SidebarItem(
          label: 'Suppliers',
          icon: Icons.local_shipping_outlined,
          branchIndex: 8,
        ),
        SidebarItem(
          label: 'Employees',
          icon: Icons.badge_outlined,
          branchIndex: 16,
          requiredPermission: AppPermissions.manageEmployees,
        ),
      ],
    ),

    // ── Sales ────────────────────────────────────────────────────────────────
    SidebarGroup(
      label: 'Sales',
      icon: Icons.receipt_long_outlined,
      children: [
        SidebarItem(
          label: 'New Invoice',
          icon: Icons.add_chart_outlined,
          branchIndex: 13,
        ),
        SidebarItem(
          label: 'Sales History',
          icon: Icons.history_edu_outlined,
          branchIndex: 9,
        ),
        SidebarItem(
          label: 'Transactions',
          icon: Icons.swap_horiz_outlined,
          branchIndex: 6,
          requiredPermission: AppPermissions.viewTransactions,
        ),
        SidebarItem(
          label: 'Reports',
          icon: Icons.bar_chart,
          branchIndex: 10,
          requiredPermission: AppPermissions.viewReports,
        ),
        SidebarItem(
          label: 'Invoice Template',
          icon: Icons.description_outlined,
          branchIndex: 12,
        ),
      ],
    ),

    // ── POS Billing ──────────────────────────────────────────────────────────
    SidebarGroup(
      label: 'POS Billing',
      icon: Icons.monitor_outlined,
      routePush: '/pos',
    ),

    // ── Settings ─────────────────────────────────────────────────────────────
    SidebarGroup(
      label: 'Settings',
      icon: Icons.settings_outlined,
      branchIndex: 11,
    ),
  ];

  void _onBranchSelected(int branchIndex) {
    widget.navigationShell.goBranch(
      branchIndex,
      initialLocation: branchIndex == widget.navigationShell.currentIndex,
    );
  }

  void _onGroupTap(SidebarGroup group) {
    if (group.routePush != null) {
      context.push(group.routePush!);
      return;
    }
    if (group.isStandalone && group.branchIndex != null) {
      _onBranchSelected(group.branchIndex!);
      return;
    }
    // Toggle expand/collapse
    setState(() {
      if (_expandedGroups.contains(group.label)) {
        _expandedGroups.remove(group.label);
      } else {
        _expandedGroups.add(group.label);
      }
    });
  }

  Future<void> _handleLogout(BuildContext context) async {
    final syncService = ServiceLocator.instance.syncService;
    final pendingDetails = await syncService.getPendingChangesDetails();

    if (pendingDetails.hasPending) {
      if (!context.mounted) return;
      await _showSyncDialog(context, syncService, pendingDetails);
    } else {
      await ref.read(authControllerProvider.notifier).logout();
    }
  }

  Future<void> _showSyncDialog(
    BuildContext context,
    dynamic syncService,
    dynamic pendingDetails,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return _SyncProgressDialog(
          syncService: syncService,
          pendingDetails: pendingDetails,
          onSyncComplete: () async {
            Navigator.of(dialogContext).pop();
            await ref.read(authControllerProvider.notifier).logout();
          },
          onForceLogout: () async {
            Navigator.of(dialogContext).pop();
            await ref.read(authControllerProvider.notifier).logout();
          },
        );
      },
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  bool _isItemVisible(SidebarItem item, dynamic user) {
    if (item.requiredPermission == null) return true;
    return user?.hasPermission(item.requiredPermission!) ?? false;
  }

  bool _isGroupVisible(SidebarGroup group, dynamic user) {
    if (group.label == 'POS Billing') {
      return user?.hasPermission(AppPermissions.accessPos) ?? false;
    }
    if (group.label == 'Settings') {
      return user?.hasPermission(AppPermissions.manageSettings) ?? true;
    }
    if (group.isStandalone) return true;
    // Group visible if at least one child is visible
    return group.children.any((item) => _isItemVisible(item, user));
  }

  bool _isItemActive(SidebarItem item) =>
      item.branchIndex == widget.navigationShell.currentIndex;

  bool _isGroupActive(SidebarGroup group) {
    if (group.isStandalone) {
      return group.branchIndex == widget.navigationShell.currentIndex;
    }
    return group.children.any(_isItemActive);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    final width = MediaQuery.of(context).size.width;
    final isLargeDesktop = width > 1200;
    final isMediumDesktop = width > 1000;
    final isSmallDesktop = width > 900;
    final isTablet = width > 600;
    final isDesktop = isSmallDesktop;

    final visibleGroups = _sidebarGroups
        .where((g) => _isGroupVisible(g, user))
        .toList();

    // ── AppBar ────────────────────────────────────────────────────────────────
    final appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      shape: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      leadingWidth: isDesktop ? (isLargeDesktop ? 250 : 200) : null,
      leading: isDesktop
          ? Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.storefront,
                    color: Color(0xFF0F172A),
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Aero",
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "POS",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 191, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : null,

      title: Row(
        children: [
          if (isDesktop) ...[
            IconButton(
              onPressed: () =>
                  setState(() => _isRailExtended = !_isRailExtended),
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.compare_arrows,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Container(
              height: 40,
              constraints: BoxConstraints(
                maxWidth: isLargeDesktop ? 400 : (isMediumDesktop ? 300 : 250),
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                  suffixIcon: isTablet
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          child: Container(
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "⌘ K",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),

      actions: [
        if (isSmallDesktop) ...[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Image.network(
                  'https://flagcdn.com/w20/pk.png',
                  width: 20,
                  errorBuilder: (c, o, s) => const Icon(Icons.flag, size: 16),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Freshmart",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],

        if (isMediumDesktop) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              icon: const Icon(Icons.add_circle_outline, size: 18),
              label: const Text("Add New"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: () => context.push('/pos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              icon: const Icon(Icons.monitor, size: 18),
              label: const Text("POS"),
            ),
          ),
        ],

        if (isTablet)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.fullscreen, color: Colors.grey),
          ),

        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.email_outlined, color: Colors.grey),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  "1",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.grey),
        ),

        if (isTablet)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined, color: Colors.grey),
          ),

        Padding(
          padding: const EdgeInsets.only(right: 16, left: 8),
          child: PopupMenuButton<String>(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            icon: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: const NetworkImage(
                'https://i.pravatar.cc/150?img=11',
              ),
            ),
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  _onBranchSelected(14);
                  break;
                case 'company':
                  _onBranchSelected(15);
                  break;
                case 'settings':
                  _onBranchSelected(11);
                  break;
                case 'logout':
                  _handleLogout(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: ListTile(
                  leading: Icon(Icons.person_outline, size: 20),
                  title: Text('User Profile', style: TextStyle(fontSize: 14)),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const PopupMenuItem<String>(
                value: 'company',
                child: ListTile(
                  leading: Icon(Icons.business_outlined, size: 20),
                  title: Text(
                    'Company Profile',
                    style: TextStyle(fontSize: 14),
                  ),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const PopupMenuItem<String>(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings_outlined, size: 20),
                  title: Text('Settings', style: TextStyle(fontSize: 14)),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout, size: 20, color: Colors.red),
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // ── Desktop layout ─────────────────────────────────────────────────────────
    if (isDesktop) {
      // Always extended (full-width labels always visible)
      final sidebarWidth = 240.0;

      return Scaffold(
        appBar: appBar,
        body: Row(
          children: [
            // ── Sidebar ──────────────────────────────────────────────────────
            Container(
              width: sidebarWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(right: BorderSide(color: Colors.grey.shade200)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  for (final group in visibleGroups)
                    _buildSidebarGroup(group, user, true),
                ],
              ),
            ),
            const VerticalDivider(width: 1, thickness: 1, color: Colors.grey),
            Expanded(
              child: Container(
                color: const Color(0xFFF5F7FA),
                child: widget.navigationShell,
              ),
            ),
          ],
        ),
      );
    }

    // ── Mobile/Tablet layout ───────────────────────────────────────────────────
    // Bottom bar: Dashboard, Sales History, Settings (+ POS if permitted)
    final bottomItems = <_BottomItem>[
      _BottomItem(
        label: 'Dashboard',
        icon: Icons.dashboard_outlined,
        branchIndex: 0,
      ),
      _BottomItem(
        label: 'History',
        icon: Icons.history_edu_outlined,
        branchIndex: 9,
      ),
      _BottomItem(
        label: 'Settings',
        icon: Icons.settings_outlined,
        branchIndex: 11,
      ),
      if (user?.hasPermission(AppPermissions.accessPos) ?? false)
        _BottomItem(
          label: 'POS',
          icon: Icons.monitor_outlined,
          branchIndex: -1,
          routePush: '/pos',
        ),
    ];

    int bottomBarIndex = bottomItems.indexWhere(
      (item) => item.branchIndex == widget.navigationShell.currentIndex,
    );
    if (bottomBarIndex == -1) bottomBarIndex = 0;

    return Scaffold(
      appBar: appBar,
      drawer: _buildMobileDrawer(visibleGroups, user),
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: bottomBarIndex,
        onDestinationSelected: (i) {
          final item = bottomItems[i];
          if (item.routePush != null) {
            context.push(item.routePush!);
          } else {
            _onBranchSelected(item.branchIndex);
          }
        },
        destinations: bottomItems
            .map(
              (item) => NavigationDestination(
                icon: Icon(item.icon),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }

  // ── Desktop sidebar group builder ──────────────────────────────────────────

  Widget _buildSidebarGroup(SidebarGroup group, dynamic user, bool extended) {
    final isActive = _isGroupActive(group);
    final isExpanded = _expandedGroups.contains(group.label);
    final visibleChildren = group.children
        .where((item) => _isItemVisible(item, user))
        .toList();

    // ── Standalone item (no children) ─────────────────────────────────────────
    if (group.isStandalone) {
      return _SidebarTile(
        icon: group.icon,
        label: group.label,
        isSelected: isActive,
        extended: extended,
        onTap: () => _onGroupTap(group),
      );
    }

    // ── Group header + children (with AnimatedSize for smooth open/close) ─────
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Group header
        _SidebarTile(
          icon: group.icon,
          label: group.label,
          isSelected: isActive,
          extended: extended,
          trailing: extended
              ? AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    Icons.expand_more,
                    size: 18,
                    color: isActive ? Colors.blue : Colors.grey.shade500,
                  ),
                )
              : null,
          onTap: () {
            if (!extended) {
              if (visibleChildren.isNotEmpty) {
                _onBranchSelected(visibleChildren.first.branchIndex);
              }
            } else {
              _onGroupTap(group);
            }
          },
        ),

        // Children — wrapped in ClipRect + AnimatedSize for smooth animation
        ClipRect(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: extended && isExpanded
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: visibleChildren
                        .map(
                          (item) => _SidebarChildTile(
                            icon: item.icon,
                            label: item.label,
                            isSelected: _isItemActive(item),
                            onTap: () => _onBranchSelected(item.branchIndex),
                          ),
                        )
                        .toList(),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  // ── Mobile drawer ──────────────────────────────────────────────────────────

  Widget _buildMobileDrawer(List<SidebarGroup> groups, dynamic user) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0F172A)),
            child: Center(
              child: Text(
                "AeroPOS",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (final group in groups)
                  if (group.isStandalone)
                    ListTile(
                      leading: Icon(group.icon),
                      title: Text(group.label),
                      selected: _isGroupActive(group),
                      selectedColor: Colors.blue,
                      onTap: () {
                        Navigator.of(context).pop();
                        _onGroupTap(group);
                      },
                    )
                  else
                    ExpansionTile(
                      leading: Icon(
                        group.icon,
                        color: _isGroupActive(group) ? Colors.blue : null,
                      ),
                      title: Text(
                        group.label,
                        style: TextStyle(
                          color: _isGroupActive(group) ? Colors.blue : null,
                          fontWeight: _isGroupActive(group)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      initiallyExpanded: _isGroupActive(group),
                      children: group.children
                          .where((item) => _isItemVisible(item, user))
                          .map(
                            (item) => ListTile(
                              contentPadding: const EdgeInsets.only(
                                left: 56,
                                right: 16,
                              ),
                              leading: Icon(item.icon, size: 20),
                              title: Text(
                                item.label,
                                style: const TextStyle(fontSize: 14),
                              ),
                              selected: _isItemActive(item),
                              selectedColor: Colors.blue,
                              onTap: () {
                                Navigator.of(context).pop();
                                _onBranchSelected(item.branchIndex);
                              },
                            ),
                          )
                          .toList(),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sidebar Tile Widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SidebarTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool extended;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.extended,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.blue : Colors.grey.shade700;
    final bg = isSelected
        ? Colors.blue.withValues(alpha: 0.1)
        : Colors.transparent;

    if (!extended) {
      return Tooltip(
        message: label,
        preferBelow: false,
        child: Material(
          color: bg,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 48,
              child: Center(child: Icon(icon, color: color, size: 22)),
            ),
          ),
        ),
      );
    }

    return Material(
      color: bg,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarChildTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarChildTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? Colors.blue.withValues(alpha: 0.08)
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(
            left: 44,
            right: 16,
            top: 10,
            bottom: 10,
          ),
          decoration: isSelected
              ? const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.blue, width: 3),
                  ),
                )
              : null,
          child: Row(
            children: [
              Icon(
                icon,
                size: 17,
                color: isSelected ? Colors.blue : Colors.grey.shade500,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected ? Colors.blue : Colors.grey.shade700,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
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
// Bottom bar helper
// ─────────────────────────────────────────────────────────────────────────────

class _BottomItem {
  final String label;
  final IconData icon;
  final int branchIndex;
  final String? routePush;

  const _BottomItem({
    required this.label,
    required this.icon,
    required this.branchIndex,
    this.routePush,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Sync Progress Dialog (unchanged)
// ─────────────────────────────────────────────────────────────────────────────

class _SyncProgressDialog extends StatefulWidget {
  final dynamic syncService;
  final dynamic pendingDetails;
  final VoidCallback onSyncComplete;
  final VoidCallback onForceLogout;

  const _SyncProgressDialog({
    required this.syncService,
    required this.pendingDetails,
    required this.onSyncComplete,
    required this.onForceLogout,
  });

  @override
  State<_SyncProgressDialog> createState() => _SyncProgressDialogState();
}

class _SyncProgressDialogState extends State<_SyncProgressDialog> {
  bool _isSyncing = true;
  bool _hasError = false;
  String _errorMessage = '';
  dynamic _syncResult;
  bool _showForceLogoutWarning = false;

  @override
  void initState() {
    super.initState();
    _performSync();
  }

  Future<void> _performSync() async {
    setState(() {
      _isSyncing = true;
      _hasError = false;
      _errorMessage = '';
      _syncResult = null;
      _showForceLogoutWarning = false;
    });

    try {
      final result = await widget.syncService.push();
      _syncResult = result;

      if (mounted) {
        if (result.success) {
          widget.onSyncComplete();
        } else {
          setState(() {
            _isSyncing = false;
            _hasError = true;
            _errorMessage = _buildErrorMessage(result);
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSyncing = false;
          _hasError = true;
          _errorMessage = 'Failed to sync. Please check your connection.';
        });
      }
    }
  }

  String _buildErrorMessage(dynamic result) {
    final failedItems = <String>[];
    result.failedCounts.forEach((key, count) {
      if (count > 0) failedItems.add('$count $key');
    });
    return 'Failed to sync: ${failedItems.join(', ')}';
  }

  String _buildPendingMessage() {
    final pending = widget.pendingDetails;
    final items = <String>[];
    if (pending.categories > 0) items.add('${pending.categories} categories');
    if (pending.units > 0) items.add('${pending.units} units');
    if (pending.brands > 0) items.add('${pending.brands} brands');
    if (pending.products > 0) items.add('${pending.products} products');
    if (pending.customers > 0) items.add('${pending.customers} customers');
    if (pending.suppliers > 0) items.add('${pending.suppliers} suppliers');
    if (pending.employees > 0) items.add('${pending.employees} employees');
    if (pending.invoices > 0) items.add('${pending.invoices} invoices');
    return items.join(', ');
  }

  void _handleForceLogout() {
    if (_showForceLogoutWarning) {
      widget.onForceLogout();
    } else {
      setState(() => _showForceLogoutWarning = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _showForceLogoutWarning
            ? '⚠️ Warning: Data Loss'
            : (_hasError ? 'Sync Failed' : 'Syncing Changes'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isSyncing) ...[
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Syncing ${_buildPendingMessage()}...'),
            const SizedBox(height: 8),
            const Text(
              'Please wait while we sync your changes to the server.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ] else if (_showForceLogoutWarning) ...[
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'You have unsaved changes that failed to sync. If you force logout now, these changes will be permanently lost.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            if (_syncResult != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Failed Items:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _buildErrorMessage(_syncResult),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ] else if (_hasError) ...[
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(_errorMessage, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            if (_syncResult != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_syncResult.totalSynced > 0) ...[
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Synced: ${_syncResult.totalSynced} items',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (_syncResult.totalFailed > 0) ...[
                      Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Failed: ${_syncResult.totalFailed} items',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
      actions: [
        if (_hasError && !_showForceLogoutWarning) ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(onPressed: _performSync, child: const Text('Retry')),
          TextButton(
            onPressed: _handleForceLogout,
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Force Logout'),
          ),
        ] else if (_showForceLogoutWarning) ...[
          TextButton(
            onPressed: () => setState(() => _showForceLogoutWarning = false),
            child: const Text('Go Back'),
          ),
          ElevatedButton(
            onPressed: _handleForceLogout,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Confirm Force Logout'),
          ),
        ],
      ],
    );
  }
}
