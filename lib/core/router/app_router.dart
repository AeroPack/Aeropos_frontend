import 'dart:async';
import 'package:ezo/features/auth/presentation/providers/auth_controller.dart';
import 'package:ezo/features/auth/presentation/screens/login_screen.dart';
import 'package:ezo/features/auth/presentation/screens/signup_screen.dart';
import 'package:ezo/features/auth/presentation/screens/email_verification_pending_screen.dart';
import 'package:ezo/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:ezo/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:ezo/features/inventory/products/item_list.dart';
import 'package:ezo/features/inventory/products/add_product_screen.dart';
import 'package:ezo/features/inventory/products/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ezo/core/database/app_database.dart';
import '../layout/app_shell.dart';
import '../../features/dashboard/dashboard_screen.dart';
import 'package:ezo/features/inventory/categories/category_list_screen.dart';
import 'package:ezo/features/inventory/units/unit_list_screen.dart';
import 'package:ezo/features/inventory/brands/brand_list_screen.dart';
import 'package:ezo/features/customers/customer_list_screen.dart';
import 'package:ezo/features/suppliers/supplier_list_screen.dart';
import 'package:ezo/features/employees/employee_list_screen.dart';
import 'package:ezo/features/pos/pos_screen.dart';
import 'package:ezo/features/inventory/reports/invoice_settings_screen.dart';
import 'package:ezo/features/invoice/screens/invoice_template_screen.dart';
import 'package:ezo/features/invoice/screens/invoice_form_screen.dart';
import 'package:ezo/features/invoice/screens/invoice_history_screen.dart';
import 'package:ezo/features/profile/presentation/screens/user_profile_screen.dart';
import 'package:ezo/features/profile/presentation/screens/company_profile_screen.dart';
import 'package:ezo/features/settings/screens/settings_screen.dart';
import 'package:ezo/features/settings/screens/role_settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    refreshListenable: GoRouterRefreshStream(authController.stream),
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final isLoggedIn = authState.status == AuthStatus.authenticated;
      final isPublicRoute =
          state.uri.path == '/login' ||
          state.uri.path == '/signup' ||
          state.uri.path == '/forgot-password' ||
          state.uri.path == '/reset-password';

      if (!isLoggedIn && !isPublicRoute) {
        return '/login';
      }

      if (isLoggedIn) {
        // Check if email is verified
        final user = authState.user;
        final isVerified = user?.isEmailVerified ?? false;
        final isPendingScreen = state.uri.path == '/verify-pending';

        if (!isVerified) {
          if (!isPendingScreen) return '/verify-pending';
          return null;
        }

        if (isPublicRoute || isPendingScreen) {
          return '/dashboard';
        }
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/verify-pending',
        builder: (context, state) => const EmailVerificationPendingScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];
          return ResetPasswordScreen(token: token);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          // Index 0: Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),

          // Index 1: Products
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/inventory',
                builder: (context, state) => const ProductListScreen(),
                routes: [
                  GoRoute(
                    path: 'view',
                    builder: (context, state) {
                      final product = state.extra as ProductEntity;
                      return ProductDetailScreen(product: product);
                    },
                  ),
                  GoRoute(
                    path: 'add',
                    builder: (context, state) {
                      final product = state.extra as ProductEntity?;
                      return AddItemScreen(product: product);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Index 2: Add Product
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/add-product',
                builder: (context, state) {
                  final product = state.extra as ProductEntity?;
                  return AddItemScreen(product: product);
                },
              ),
            ],
          ),
          // Index 3: Category List
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/category-list',
                builder: (context, state) => const CategoryListScreen(),
              ),
            ],
          ),
          // Index 4: Unit List
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/unit-list',
                builder: (context, state) => const UnitListScreen(),
              ),
            ],
          ),
          // Index 5: Brand List
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/brand-list',
                builder: (context, state) => const BrandListScreen(),
              ),
            ],
          ),
          // Index 3: Transactions
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/transactions',
                builder: (context, state) => const Scaffold(
                  body: Center(child: Text("Transactions")),
                ), // Inline placeholder
              ),
            ],
          ),

          // Index 3: Customers (Sidebar Only)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/customers',
                builder: (context, state) => const CustomerListScreen(),
              ),
            ],
          ),

          // Index 8: Suppliers (Sidebar Only) - Note: Index will need to match AppShell
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/suppliers',
                builder: (context, state) => const SupplierListScreen(),
              ),
            ],
          ),

          // Index 9: Sales History
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/sales-history',
                builder: (context, state) => const InvoiceHistoryScreen(),
              ),
            ],
          ),

          // Index 4: Reports (Sidebar Only)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reports',
                builder: (context, state) => const Scaffold(
                  body: Center(child: Text("Reports")),
                ), // Inline placeholder
              ),
            ],
          ),

          // Index 10: Settings (Both)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  GoRoute(
                    path: 'invoice',
                    builder: (context, state) => const InvoiceSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'roles',
                    builder: (context, state) => const RoleSettingsScreen(),
                  ),
                ],
              ),
            ],
          ),

          // Index 11: Invoice Templates
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/invoice-templates',
                builder: (context, state) => const InvoiceTemplateScreen(),
              ),
            ],
          ),
          // Index 12: New Invoice
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/new-invoice',
                builder: (context, state) => const InvoiceFormScreen(),
              ),
            ],
          ),
          // Index 14: User Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const UserProfileScreen(),
              ),
            ],
          ),
          // Index 15: Company Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/company-profile',
                builder: (context, state) => const CompanyProfileScreen(),
              ),
            ],
          ),
          // Index 16: Employees
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/employees',
                builder: (context, state) => const EmployeeListScreen(),
              ),
            ],
          ),
        ],
      ),

      // Full screen route for POS (outside AppShell)
      GoRoute(path: '/pos', builder: (context, state) => const PosScreen()),
    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
