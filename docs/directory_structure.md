# Directory Structure for Offline-First POS Application

## Overview
This structure follows **Clean Architecture** principles without heavy state management libraries. For the cart functionality, we'll use Flutter's built-in `ChangeNotifier` or `ValueNotifier`.

---

## Complete Directory Structure

```
lib/
├── main.dart                          # App entry point
│
├── core/                              # Core functionality (shared across features)
│   ├── database/                      # Database layer
│   │   ├── app_database.dart         # Drift database definition
│   │   ├── app_database.g.dart       # Generated file
│   │   ├── tables/                   # Table definitions
│   │   │   ├── products_table.dart
│   │   │   ├── customers_table.dart
│   │   │   ├── sales_table.dart
│   │   │   ├── sale_items_table.dart
│   │   │   ├── categories_table.dart
│   │   │   ├── units_table.dart
│   │   │   ├── sync_logs_table.dart
│   │   │   └── conflict_resolutions_table.dart
│   │   └── daos/                     # Data Access Objects
│   │       ├── product_dao.dart
│   │       ├── customer_dao.dart
│   │       ├── sale_dao.dart
│   │       ├── category_dao.dart
│   │       └── unit_dao.dart
│   │
│   ├── models/                        # Domain models
│   │   ├── product.dart
│   │   ├── customer.dart
│   │   ├── sale.dart
│   │   ├── sale_item.dart
│   │   ├── category.dart
│   │   ├── unit.dart
│   │   ├── sync_metadata.dart
│   │   └── enums/
│   │       ├── sync_status.dart
│   │       ├── payment_method.dart
│   │       └── sale_status.dart
│   │
│   ├── repositories/                  # Repository pattern
│   │   ├── base_repository.dart      # Abstract base
│   │   ├── product_repository.dart
│   │   ├── customer_repository.dart
│   │   ├── sale_repository.dart
│   │   ├── category_repository.dart
│   │   └── unit_repository.dart
│   │
│   ├── services/                      # Business logic services
│   │   ├── sync_service.dart         # Handles data synchronization
│   │   ├── inventory_service.dart    # Stock management
│   │   ├── invoice_service.dart      # Invoice generation
│   │   ├── report_service.dart       # Report generation
│   │   ├── backup_service.dart       # Backup/restore
│   │   └── encryption_service.dart   # Data encryption
│   │
│   ├── network/                       # API & Network
│   │   ├── api_client.dart           # HTTP client wrapper
│   │   ├── api_endpoints.dart        # API endpoint constants
│   │   ├── network_info.dart         # Connectivity checker
│   │   └── interceptors/
│   │       └── auth_interceptor.dart
│   │
│   ├── utils/                         # Utility functions
│   │   ├── date_utils.dart
│   │   ├── currency_utils.dart
│   │   ├── validation_utils.dart
│   │   ├── device_info.dart
│   │   └── uuid_generator.dart
│   │
│   ├── constants/                     # App constants
│   │   ├── app_constants.dart
│   │   ├── database_constants.dart
│   │   └── sync_constants.dart
│   │
│   ├── router/                        # Navigation
│   │   └── app_router.dart           # GoRouter configuration
│   │
│   ├── layout/                        # Layout components
│   │   ├── app_shell.dart            # Main app scaffold
│   │   ├── pos_design_system.dart    # Design system
│   │   └── unified_scroll_behavior.dart
│   │
│   └── widgets/                       # Reusable widgets
│       ├── offline_indicator.dart
│       ├── sync_status_badge.dart
│       ├── loading_overlay.dart
│       ├── error_dialog.dart
│       └── confirmation_dialog.dart
│
├── features/                          # Feature modules
│   │
│   ├── dashboard/                     # Dashboard feature
│   │   ├── dashboard_screen.dart
│   │   └── widgets/
│   │       ├── stat_card.dart
│   │       ├── recent_sales_list.dart
│   │       └── low_stock_alert.dart
│   │
│   ├── products/                      # Product management
│   │   ├── screens/
│   │   │   ├── product_list_screen.dart
│   │   │   ├── product_form_screen.dart
│   │   │   └── product_detail_screen.dart
│   │   ├── widgets/
│   │   │   ├── product_card.dart
│   │   │   ├── product_search_bar.dart
│   │   │   └── product_filter_chip.dart
│   │   └── use_cases/
│   │       ├── create_product_use_case.dart
│   │       ├── update_product_use_case.dart
│   │       └── delete_product_use_case.dart
│   │
│   ├── categories/                    # Category master
│   │   ├── screens/
│   │   │   ├── category_list_screen.dart
│   │   │   └── category_form_screen.dart
│   │   └── widgets/
│   │       └── category_dropdown.dart
│   │
│   ├── units/                         # Unit master
│   │   ├── screens/
│   │   │   ├── unit_list_screen.dart
│   │   │   └── unit_form_screen.dart
│   │   └── widgets/
│   │       └── unit_dropdown.dart
│   │
│   ├── customers/                     # Customer management
│   │   ├── screens/
│   │   │   ├── customer_list_screen.dart
│   │   │   ├── customer_form_screen.dart
│   │   │   └── customer_detail_screen.dart
│   │   └── widgets/
│   │       ├── customer_card.dart
│   │       └── customer_search.dart
│   │
│   ├── sales/                         # Sales/POS feature
│   │   ├── screens/
│   │   │   ├── pos_screen.dart       # Main POS interface
│   │   │   ├── sale_list_screen.dart
│   │   │   └── sale_detail_screen.dart
│   │   ├── widgets/
│   │   │   ├── product_selector.dart
│   │   │   ├── cart_widget.dart
│   │   │   ├── cart_item_tile.dart
│   │   │   ├── payment_dialog.dart
│   │   │   └── invoice_preview.dart
│   │   ├── state/                    # State management (only for cart)
│   │   │   └── cart_notifier.dart    # ChangeNotifier for cart
│   │   └── use_cases/
│   │       ├── create_sale_use_case.dart
│   │       ├── calculate_totals_use_case.dart
│   │       └── generate_invoice_use_case.dart
│   │
│   ├── reports/                       # Reports & Analytics
│   │   ├── screens/
│   │   │   ├── reports_screen.dart
│   │   │   ├── sales_report_screen.dart
│   │   │   ├── inventory_report_screen.dart
│   │   │   └── customer_report_screen.dart
│   │   └── widgets/
│   │       ├── report_card.dart
│   │       ├── date_range_picker.dart
│   │       └── chart_widget.dart
│   │
│   ├── settings/                      # Settings
│   │   ├── screens/
│   │   │   ├── settings_screen.dart
│   │   │   ├── sync_settings_screen.dart
│   │   │   └── backup_screen.dart
│   │   └── widgets/
│   │       ├── setting_tile.dart
│   │       └── sync_status_card.dart
│   │
│   └── sync/                          # Sync management
│       ├── screens/
│       │   ├── sync_status_screen.dart
│       │   └── conflict_resolution_screen.dart
│       └── widgets/
│           ├── sync_log_tile.dart
│           └── conflict_card.dart
│
└── config/                            # Configuration
    ├── app_config.dart               # App configuration
    └── environment.dart              # Environment variables

```

---

## Key Files Explanation

### 1. **main.dart**
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  final database = AppDatabase();
  
  // Initialize services
  final syncService = SyncService(database);
  
  runApp(EzoPosApp(
    database: database,
    syncService: syncService,
  ));
  
  // Desktop window setup
  doWhenWindowReady(() {
    appWindow.minSize = const Size(800, 600);
    appWindow.size = const Size(1280, 720);
    appWindow.show();
  });
}
```

### 2. **Cart State Management (Minimal)**
```dart
// lib/features/sales/state/cart_notifier.dart

class CartNotifier extends ChangeNotifier {
  final List<CartItem> _items = [];
  
  List<CartItem> get items => List.unmodifiable(_items);
  
  double get subtotal => _items.fold(0, (sum, item) => sum + item.total);
  double get tax => subtotal * 0.18; // 18% tax
  double get total => subtotal + tax;
  
  void addItem(Product product, int quantity) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + quantity,
      );
    } else {
      _items.add(CartItem(
        product: product,
        quantity: quantity,
        unitPrice: product.price,
      ));
    }
    
    notifyListeners();
  }
  
  void removeItem(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }
  
  void updateQuantity(int productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        removeItem(productId);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
        notifyListeners();
      }
    }
  }
  
  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// Usage in POS screen
class PosScreen extends StatefulWidget {
  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  late final CartNotifier _cartNotifier;
  
  @override
  void initState() {
    super.initState();
    _cartNotifier = CartNotifier();
  }
  
  @override
  void dispose() {
    _cartNotifier.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Product selector
          Expanded(
            flex: 2,
            child: ProductSelector(
              onProductSelected: (product, quantity) {
                _cartNotifier.addItem(product, quantity);
              },
            ),
          ),
          
          // Cart
          Expanded(
            child: ListenableBuilder(
              listenable: _cartNotifier,
              builder: (context, _) {
                return CartWidget(
                  cart: _cartNotifier,
                  onCheckout: _handleCheckout,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3. **Repository Pattern (No State Management)**
```dart
// lib/core/repositories/product_repository.dart

class ProductRepository {
  final AppDatabase _db;
  
  ProductRepository(this._db);
  
  // Direct database operations - no state management needed
  Future<List<Product>> getAllProducts() async {
    return await _db.productDao.getAllProducts();
  }
  
  Future<Product> createProduct(Product product) async {
    return await _db.productDao.insertProduct(product);
  }
  
  Future<void> updateProduct(Product product) async {
    await _db.productDao.updateProduct(product);
  }
  
  Future<void> deleteProduct(int id) async {
    await _db.productDao.deleteProduct(id);
  }
  
  // For reactive UI, use Stream
  Stream<List<Product>> watchAllProducts() {
    return _db.productDao.watchAllProducts();
  }
}
```

### 4. **Screen Pattern (Direct Repository Usage)**
```dart
// lib/features/products/screens/product_list_screen.dart

class ProductListScreen extends StatelessWidget {
  final ProductRepository repository;
  
  const ProductListScreen({required this.repository});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: StreamBuilder<List<Product>>(
        stream: repository.watchAllProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          
          final products = snapshot.data!;
          
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateProduct(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### 5. **Dependency Injection (Simple)**
```dart
// lib/core/di/service_locator.dart

class ServiceLocator {
  static final instance = ServiceLocator._();
  ServiceLocator._();
  
  late final AppDatabase database;
  late final ProductRepository productRepository;
  late final CustomerRepository customerRepository;
  late final SaleRepository saleRepository;
  late final CategoryRepository categoryRepository;
  late final UnitRepository unitRepository;
  late final SyncService syncService;
  
  Future<void> initialize() async {
    database = AppDatabase();
    
    productRepository = ProductRepository(database);
    customerRepository = CustomerRepository(database);
    saleRepository = SaleRepository(database);
    categoryRepository = CategoryRepository(database);
    unitRepository = UnitRepository(database);
    
    syncService = SyncService(database);
    await syncService.initialize();
  }
}

// Usage in main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.instance.initialize();
  runApp(EzoPosApp());
}

// Usage in screens
class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = ServiceLocator.instance.productRepository;
    // Use repository...
  }
}
```

---

## Folder Organization Principles

### 1. **Core Layer** (Shared Infrastructure)
- Database, models, repositories, services
- No UI code
- Reusable across all features

### 2. **Features Layer** (Business Features)
- Each feature is self-contained
- Has its own screens, widgets, use cases
- Only sales feature has state management (cart)

### 3. **Minimal State Management**
- Use `StreamBuilder` for reactive UI from database
- Use `ChangeNotifier` only for cart in POS screen
- Use `FutureBuilder` for one-time data fetches
- Pass data via constructors and callbacks

---

## File Naming Conventions

```
Screens:       product_list_screen.dart
Widgets:       product_card.dart
Repositories:  product_repository.dart
Services:      sync_service.dart
Models:        product.dart
Use Cases:     create_product_use_case.dart
DAOs:          product_dao.dart
Tables:        products_table.dart
```

---

## Example Feature Structure

```
features/products/
├── screens/                    # UI screens
│   ├── product_list_screen.dart
│   ├── product_form_screen.dart
│   └── product_detail_screen.dart
├── widgets/                    # Feature-specific widgets
│   ├── product_card.dart
│   └── product_search_bar.dart
└── use_cases/                  # Business logic
    ├── create_product_use_case.dart
    └── update_product_use_case.dart
```

---

## Benefits of This Structure

1. **No Heavy State Management**: Only cart uses `ChangeNotifier`
2. **Clean Separation**: Core vs Features
3. **Scalable**: Easy to add new features
4. **Testable**: Each layer can be tested independently
5. **Offline-First Ready**: Database layer is separate
6. **Simple Navigation**: GoRouter handles all routing
7. **Minimal Dependencies**: Only essential packages

---

## When to Use State Management

**Use ChangeNotifier/ValueNotifier for:**
- ✅ Cart in POS screen (items change frequently)
- ✅ Form validation state (if complex)
- ✅ Multi-step wizards

**Don't Use State Management for:**
- ❌ Product list (use StreamBuilder with repository)
- ❌ Category master (direct repository calls)
- ❌ Unit master (direct repository calls)
- ❌ Customer list (use StreamBuilder)
- ❌ Reports (use FutureBuilder)

---

This structure keeps your app simple, maintainable, and focused on offline-first functionality without the overhead of complex state management libraries!
