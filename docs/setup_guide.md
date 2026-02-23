# Project Setup Guide

## Directory Structure Created

All required directories and files have been created for your offline-first POS application.

## Next Steps

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Generate Drift Database Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate:
- `lib/core/database/app_database.g.dart`
- All DAO `.g.dart` files

### 3. Initialize Service Locator in main.dart

Update your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/layout/unified_scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize service locator
  await ServiceLocator.instance.initialize();
  
  runApp(const EzoPosApp());

  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = const Size(800, 600);
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "AeroPOS";
    appWindow.show();
  });
}

class EzoPosApp extends StatelessWidget {
  const EzoPosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Ezo POS',
      scrollBehavior: UnifiedScrollBehavior(),
      theme: ThemeData(
        fontFamily: 'AppFont',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
```

### 4. Update Router Configuration

Add routes for new screens in `lib/core/router/app_router.dart`:

```dart
import 'package:go_router/go_router.dart';
import '../../features/products/screens/product_list_screen.dart';
import '../../features/categories/screens/category_list_screen.dart';
import '../../features/units/screens/unit_list_screen.dart';
import '../../features/sales/screens/pos_screen.dart';
// ... other imports

final appRouter = GoRouter(
  routes: [
    // Add your routes here
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductListScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoryListScreen(),
    ),
    GoRoute(
      path: '/units',
      builder: (context, state) => const UnitListScreen(),
    ),
    GoRoute(
      path: '/pos',
      builder: (context, state) => const PosScreen(),
    ),
    // ... more routes
  ],
);
```

## Project Structure Overview

```
lib/
├── core/
│   ├── database/          # Drift database, tables, DAOs
│   ├── models/            # Domain models and enums
│   ├── repositories/      # Data access layer
│   ├── services/          # Business logic services
│   ├── di/                # Dependency injection
│   ├── constants/         # App constants
│   ├── widgets/           # Reusable widgets
│   └── ...
│
└── features/
    ├── products/          # Product management
    ├── categories/        # Category master
    ├── units/             # Unit master
    ├── customers/         # Customer management
    ├── sales/             # POS & sales (with cart state)
    ├── reports/           # Reports & analytics
    └── ...
```

## Key Files Created

### Database Layer
- ✅ `app_database.dart` - Main database class
- ✅ All table definitions (products, customers, sales, etc.)
- ✅ All DAOs (ProductDao, CustomerDao, etc.)

### Repositories
- ✅ ProductRepository
- ✅ CustomerRepository
- ✅ SaleRepository
- ✅ CategoryRepository
- ✅ UnitRepository

### Services
- ✅ InventoryService
- ✅ SyncService (placeholder)

### State Management
- ✅ CartNotifier (ChangeNotifier for cart only)

### Feature Screens
- ✅ ProductListScreen
- ✅ CategoryListScreen
- ✅ UnitListScreen
- ✅ PosScreen (with cart)

### Configuration
- ✅ ServiceLocator (DI)
- ✅ AppConstants
- ✅ AppConfig

## Development Workflow

1. **Run code generation** after any database changes:
   ```bash
   flutter pub run build_runner watch
   ```

2. **Access repositories** via ServiceLocator:
   ```dart
   final repo = ServiceLocator.instance.productRepository;
   ```

3. **Use StreamBuilder** for reactive UI:
   ```dart
   StreamBuilder<List<Product>>(
     stream: repository.watchAllProducts(),
     builder: (context, snapshot) { ... }
   )
   ```

4. **Cart state** (only in POS screen):
   ```dart
   final cartNotifier = CartNotifier();
   ListenableBuilder(
     listenable: cartNotifier,
     builder: (context, _) { ... }
   )
   ```

## No State Management Libraries Needed!

- ✅ Use `StreamBuilder` for database-driven UI
- ✅ Use `FutureBuilder` for one-time data fetches
- ✅ Use `ChangeNotifier` only for cart
- ✅ Pass data via constructors and callbacks

## Ready to Build!

Your project structure is now complete. Start implementing features by:
1. Creating form screens for CRUD operations
2. Implementing sync service logic
3. Adding business logic use cases
4. Building out the UI components

Happy coding! 🚀
