# Flutter Integration Guide - Quick Start

## API Summary

**Base URL:** `http://localhost:5002`  
**Auth Header:** `x-auth-token: YOUR_JWT_TOKEN`

### Key Endpoints

| Endpoint | Method | Auth | Purpose |
|----------|--------|------|---------|
| `/auth/signup` | POST | No | Register new business owner |
| `/auth/login` | POST | No | Login and get JWT token |
| `/auth/me` | GET | Yes | Get current user info |
| `/customers` | GET/POST/PUT/DELETE | Yes | Manage customers |
| `/suppliers` | GET/POST/PUT/DELETE | Yes | Manage suppliers |
| `/employees` | GET/POST/PUT/DELETE | Yes | Manage employees |
| `/products` | GET/POST/PUT/DELETE | Yes | Manage products |
| `/categories` | GET/POST/PUT/DELETE | Yes | Manage categories |
| `/brands` | GET/POST/PUT/DELETE | Yes | Manage brands |
| `/units` | GET/POST/PUT/DELETE | Yes | Manage units |
| `/invoices` | GET/POST | Yes | Manage invoices |
| `/sync` | POST | Yes | Batch sync all data |

### Multi-Tenancy
- Each business owner (tenant) has isolated data
- All endpoints automatically filter by authenticated tenant
- No cross-tenant access possible

---

## Prompt for Flutter Team

Use this prompt with your AI assistant to update the Flutter app:

```
I need to update my Flutter app to work with a new multi-tenant backend API. Here are the changes:

BACKEND CHANGES:
1. The "users" table is now "tenants" (business owners who log in)
2. New tables: customers, suppliers, employees (separate from tenants)
3. All data is now isolated per tenant using tenantId
4. Authentication returns a JWT token that must be included in all requests

API ENDPOINTS:
- Base URL: http://localhost:5002
- Auth header: x-auth-token: JWT_TOKEN
- Signup: POST /auth/signup (body: {name, email, password, businessName})
- Login: POST /auth/login (body: {email, password})
- Get user: GET /auth/me

CRUD ENDPOINTS (all require auth):
- /customers - manage tenant's customers
- /suppliers - manage tenant's suppliers  
- /employees - manage tenant's employees
- /products, /categories, /brands, /units - manage catalog
- /invoices - manage invoices
- /sync - batch sync (POST with {lastSyncTime})

REQUIRED CHANGES:
1. Update authentication to use /auth/signup and /auth/login
2. Store JWT token and include in x-auth-token header for all requests
3. Update local database schema to match new backend:
   - Rename users table to tenants
   - Add customers, suppliers, employees tables
   - Add tenantId to all business data tables
4. Update API service to use new endpoints
5. Update sync logic to use /sync endpoint
6. Handle walk-in customers (customerId can be null in invoices)

ENTITY STRUCTURES:
Tenant: {id, uuid, name, email, businessName, businessAddress, taxId}
Customer: {id, uuid, name, email, phone, address, creditLimit, currentBalance, tenantId}
Supplier: {id, uuid, name, email, phone, address, tenantId}
Employee: {id, uuid, name, email, phone, address, position, salary, tenantId}
Product: {id, uuid, name, sku, price, stockQuantity, categoryId, brandId, unitId, tenantId}
Invoice: {id, uuid, invoiceNumber, customerId, date, subtotal, tax, discount, total, tenantId, items: [...]}

Please update:
1. Local database schema (SQLite/Drift)
2. API service layer
3. Authentication flow
4. Sync service
5. All models to match new structure
```

---

## Quick Migration Checklist

### 1. Update Dependencies
```yaml
# pubspec.yaml
dependencies:
  http: ^1.1.0
  flutter_secure_storage: ^9.0.0
  drift: ^2.14.0
  # ... other dependencies
```

### 2. Update Local Database Schema

```dart
// database.dart
@DriftDatabase(tables: [
  Tenants,      // Renamed from Users
  Customers,    // New
  Suppliers,    // New
  Employees,    // New
  Products,     // Add tenantId column
  Categories,   // Add tenantId column
  Brands,       // Add tenantId column
  Units,        // Add tenantId column
  Invoices,     // Add tenantId column, change customerId reference
  InvoiceItems, // Add tenantId column
])
class AppDatabase extends _$AppDatabase {
  // Migration from version 1 to 2
  @override
  int get schemaVersion => 2;
  
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from == 1) {
        // Rename users to tenants
        await migrator.renameTable(users, 'tenants');
        
        // Create new tables
        await migrator.createTable(customers);
        await migrator.createTable(suppliers);
        await migrator.createTable(employees);
        
        // Add tenantId to existing tables
        await migrator.addColumn(products, products.tenantId);
        await migrator.addColumn(categories, categories.tenantId);
        // ... add to other tables
      }
    },
  );
}
```

### 3. Update API Service

```dart
class ApiService {
  static const baseUrl = 'http://localhost:5002';
  String? _token;

  // Set token after login/signup
  void setToken(String token) => _token = token;

  // Include token in headers
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_token != null) 'x-auth-token': _token!,
  };

  // Generic request methods
  Future<T> post<T>(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse<T>(response);
  }

  Future<T> get<T>(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
    );
    return _handleResponse<T>(response);
  }
}
```

### 4. Update Authentication

```dart
class AuthService {
  final ApiService _api;
  final FlutterSecureStorage _storage;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    String? businessName,
  }) async {
    final response = await _api.post('/auth/signup', {
      'name': name,
      'email': email,
      'password': password,
      if (businessName != null) 'businessName': businessName,
    });
    
    await _saveToken(response['token']);
  }

  Future<void> login(String email, String password) async {
    final response = await _api.post('/auth/login', {
      'email': email,
      'password': password,
    });
    
    await _saveToken(response['token']);
  }

  Future<void> _saveToken(String token) async {
    _api.setToken(token);
    await _storage.write(key: 'auth_token', value: token);
  }
}
```

### 5. Update Sync Service

```dart
class SyncService {
  final ApiService _api;
  final AppDatabase _db;

  Future<void> sync() async {
    final lastSync = await _db.getLastSyncTime();
    
    final response = await _api.post('/sync', {
      if (lastSync != null) 'lastSyncTime': lastSync.toIso8601String(),
    });

    // Update local database
    await _updateLocalData(response['updates']);
    
    // Save server time
    await _db.setLastSyncTime(
      DateTime.parse(response['serverTime']),
    );
  }

  Future<void> _updateLocalData(Map<String, dynamic> updates) async {
    await _db.transaction(() async {
      // Update products
      for (var item in updates['products']) {
        await _db.into(_db.products).insertOnConflictUpdate(
          Product.fromJson(item),
        );
      }
      
      // Update customers
      for (var item in updates['customers']) {
        await _db.into(_db.customers).insertOnConflictUpdate(
          Customer.fromJson(item),
        );
      }
      
      // ... update other entities
    });
  }
}
```

---

## Testing the Integration

### 1. Test Authentication
```dart
// Test signup
await authService.signup(
  name: 'Test User',
  email: 'test@example.com',
  password: 'password123',
  businessName: 'Test Business',
);

// Test login
await authService.login('test@example.com', 'password123');

// Verify token is stored
final token = await storage.read(key: 'auth_token');
print('Token: $token');
```

### 2. Test CRUD Operations
```dart
// Create customer
final customer = await customerService.create(
  name: 'John Doe',
  email: 'john@example.com',
  creditLimit: 5000,
);

// List customers
final customers = await customerService.getAll();
print('Customers: ${customers.length}');
```

### 3. Test Sync
```dart
// Initial sync
await syncService.sync();

// Verify data
final products = await db.select(db.products).get();
print('Synced ${products.length} products');
```

---

## Common Issues & Solutions

### Issue: 401 Unauthorized
**Solution:** Token not included or expired. Re-login and save new token.

### Issue: 404 Not Found
**Solution:** Trying to access another tenant's data. Verify tenantId filtering.

### Issue: Data not syncing
**Solution:** Check lastSyncTime format (ISO 8601). Ensure token is valid.

### Issue: Walk-in customer errors
**Solution:** Set customerId to null for walk-in customers in invoices.

---

## Next Steps

1. ✅ Update local database schema
2. ✅ Update API service with new endpoints
3. ✅ Update authentication flow
4. ✅ Update all models
5. ✅ Update sync service
6. ✅ Test thoroughly
7. ✅ Deploy to production

For detailed API reference, see [API_DOCUMENTATION.md](./API_DOCUMENTATION.md)
