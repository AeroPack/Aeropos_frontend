# Low-Level Design Architecture: Offline-First POS Application

## 1. System Overview

### 1.1 Architecture Pattern
**Clean Architecture with Offline-First Design**

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Screens    │  │   Widgets    │  │  State Mgmt  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↓↑
┌─────────────────────────────────────────────────────────────┐
│                   Business Logic Layer                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  Use Cases   │  │  Validators  │  │   Services   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            ↓↑
┌─────────────────────────────────────────────────────────────┐
│                      Data Layer                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Repositories │  │ Local DB     │  │  API Client  │      │
│  │              │  │ (Drift/Isar) │  │  (Optional)  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### 1.2 Core Principles
1. **Offline-First**: All operations work without internet
2. **Local Data Authority**: Local database is the source of truth
3. **Background Sync**: Sync happens transparently in background
4. **Conflict Resolution**: Automated conflict handling with manual override
5. **Data Integrity**: ACID transactions for critical operations

---

## 2. Data Layer Architecture

### 2.1 Local Database Design

**Technology Choice: Drift (formerly Moor)**
- Type-safe SQL queries
- Reactive streams for real-time updates
- Migration support
- Cross-platform (mobile, desktop, web)

**Alternative: Isar**
- NoSQL document database
- Faster for complex queries
- Better for large datasets
- Native Dart implementation

#### 2.1.1 Database Schema

```dart
// Core Tables Structure

@DataClassName('Product')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()(); // For sync
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get sku => text().unique()();
  TextColumn get category => text().nullable()();
  RealColumn get price => real()();
  RealColumn get cost => real().nullable()();
  IntColumn get stockQuantity => integer().withDefault(const Constant(0))();
  TextColumn get unit => text().withDefault(const Constant('pcs'))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  // Sync metadata
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))(); // 0: synced, 1: pending, 2: conflict
  TextColumn get deviceId => text()(); // Which device created/modified
}

@DataClassName('Customer')
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  RealColumn get creditLimit => real().withDefault(const Constant(0))();
  RealColumn get currentBalance => real().withDefault(const Constant(0))();
  
  // Sync metadata
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  TextColumn get deviceId => text()();
}

@DataClassName('Sale')
class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get invoiceNumber => text().unique()();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  RealColumn get subtotal => real()();
  RealColumn get tax => real().withDefault(const Constant(0))();
  RealColumn get discount => real().withDefault(const Constant(0))();
  RealColumn get total => real()();
  TextColumn get paymentMethod => text()(); // cash, card, upi, credit
  TextColumn get status => text()(); // pending, completed, cancelled, refunded
  TextColumn get notes => text().nullable()();
  
  // Sync metadata
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  TextColumn get deviceId => text()();
}

@DataClassName('SaleItem')
class SaleItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  IntColumn get saleId => integer().references(Sales, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real()();
  RealColumn get discount => real().withDefault(const Constant(0))();
  RealColumn get total => real()();
  
  // Sync metadata
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  TextColumn get deviceId => text()();
}

@DataClassName('SyncLog')
class SyncLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()(); // product, customer, sale, etc.
  TextColumn get entityUuid => text()();
  TextColumn get operation => text()(); // create, update, delete
  TextColumn get status => text()(); // pending, success, failed, conflict
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get attemptedAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
}

@DataClassName('ConflictResolution')
class ConflictResolutions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()();
  TextColumn get entityUuid => text()();
  TextColumn get localData => text()(); // JSON
  TextColumn get remoteData => text()(); // JSON
  TextColumn get resolution => text().nullable()(); // auto, manual, local_wins, remote_wins
  BoolColumn get isResolved => boolean().withDefault(const Constant(false))();
  DateTimeColumn get detectedAt => dateTime()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
}
```

### 2.2 Repository Pattern

```dart
// Abstract repository interface
abstract class Repository<T> {
  // CRUD operations
  Future<T> create(T entity);
  Future<T?> getById(int id);
  Future<T?> getByUuid(String uuid);
  Future<List<T>> getAll();
  Future<T> update(T entity);
  Future<void> delete(int id);
  
  // Sync operations
  Future<List<T>> getPendingSync();
  Future<void> markSynced(String uuid);
  Future<void> markConflict(String uuid);
  
  // Reactive streams
  Stream<List<T>> watchAll();
  Stream<T?> watchById(int id);
}

// Example implementation
class ProductRepository implements Repository<Product> {
  final AppDatabase _db;
  
  ProductRepository(this._db);
  
  @override
  Future<Product> create(Product product) async {
    // Generate UUID for sync
    final uuid = Uuid().v4();
    final deviceId = await DeviceInfo.getDeviceId();
    
    final entry = ProductsCompanion(
      uuid: Value(uuid),
      name: Value(product.name),
      sku: Value(product.sku),
      price: Value(product.price),
      // ... other fields
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      syncStatus: Value(SyncStatus.pending.index),
      deviceId: Value(deviceId),
    );
    
    final id = await _db.into(_db.products).insert(entry);
    
    // Trigger background sync
    SyncService.instance.scheduleSyncIfNeeded();
    
    return (await getById(id))!;
  }
  
  @override
  Stream<List<Product>> watchAll() {
    return _db.select(_db.products).watch();
  }
  
  // Batch operations for sync
  Future<void> batchUpsert(List<Product> products) async {
    await _db.batch((batch) {
      for (final product in products) {
        batch.insert(
          _db.products,
          product,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }
}
```

### 2.3 Data Models

```dart
// Domain models (business logic layer)
class Product {
  final int? id;
  final String uuid;
  final String name;
  final String sku;
  final String? category;
  final double price;
  final double? cost;
  final int stockQuantity;
  final String unit;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SyncMetadata syncMetadata;
  
  // Business methods
  double get profitMargin => cost != null ? ((price - cost!) / price) * 100 : 0;
  bool get isLowStock => stockQuantity < 10;
  bool get needsSync => syncMetadata.status == SyncStatus.pending;
}

class SyncMetadata {
  final DateTime? lastSyncedAt;
  final SyncStatus status;
  final String deviceId;
  final int version; // For optimistic locking
}

enum SyncStatus {
  synced,
  pending,
  conflict,
  error
}
```

---

## 3. Synchronization Architecture

### 3.1 Sync Strategy

**Hybrid Approach: Event-Driven + Periodic Sync**

```dart
class SyncService {
  static final instance = SyncService._();
  SyncService._();
  
  // Configuration
  static const Duration periodicSyncInterval = Duration(minutes: 15);
  static const Duration conflictRetryDelay = Duration(hours: 1);
  static const int maxRetryAttempts = 3;
  
  // Sync triggers
  void initialize() {
    // 1. Periodic sync
    Timer.periodic(periodicSyncInterval, (_) => syncAll());
    
    // 2. Network connectivity change
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        syncAll();
      }
    });
    
    // 3. App lifecycle (foreground/background)
    WidgetsBinding.instance.addObserver(_AppLifecycleObserver(
      onResumed: () => syncAll(),
    ));
    
    // 4. Manual trigger
    // Called after local data changes
  }
  
  Future<SyncResult> syncAll() async {
    if (!await _hasNetworkConnection()) {
      return SyncResult.noNetwork();
    }
    
    try {
      // 1. Pull remote changes first
      await _pullRemoteChanges();
      
      // 2. Resolve conflicts
      await _resolveConflicts();
      
      // 3. Push local changes
      await _pushLocalChanges();
      
      return SyncResult.success();
    } catch (e) {
      return SyncResult.error(e.toString());
    }
  }
  
  Future<void> _pullRemoteChanges() async {
    final lastSyncTime = await _getLastSyncTime();
    
    // Fetch changes from server since last sync
    final changes = await _apiClient.getChangesSince(lastSyncTime);
    
    for (final change in changes) {
      await _applyRemoteChange(change);
    }
  }
  
  Future<void> _applyRemoteChange(RemoteChange change) async {
    final localEntity = await _getLocalEntity(change.entityType, change.uuid);
    
    if (localEntity == null) {
      // New entity from server
      await _insertFromRemote(change);
    } else {
      // Check for conflicts
      if (localEntity.syncStatus == SyncStatus.pending) {
        // Conflict detected
        await _handleConflict(localEntity, change);
      } else {
        // Update local with remote
        await _updateFromRemote(change);
      }
    }
  }
  
  Future<void> _pushLocalChanges() async {
    final pendingChanges = await _db.getPendingChanges();
    
    for (final change in pendingChanges) {
      try {
        await _pushChange(change);
        await _db.markSynced(change.uuid);
      } catch (e) {
        await _db.incrementRetryCount(change.uuid);
        if (change.retryCount >= maxRetryAttempts) {
          await _db.markSyncError(change.uuid, e.toString());
        }
      }
    }
  }
}
```

### 3.2 Conflict Resolution

```dart
enum ConflictResolutionStrategy {
  lastWriteWins,      // Based on timestamp
  serverWins,         // Server data takes precedence
  clientWins,         // Local data takes precedence
  manual,             // User decides
  merge,              // Intelligent merge (field-level)
}

class ConflictResolver {
  Future<void> resolveConflict(
    Conflict conflict,
    ConflictResolutionStrategy strategy,
  ) async {
    switch (strategy) {
      case ConflictResolutionStrategy.lastWriteWins:
        final winner = conflict.localData.updatedAt.isAfter(conflict.remoteData.updatedAt)
            ? conflict.localData
            : conflict.remoteData;
        await _applyResolution(conflict, winner);
        break;
        
      case ConflictResolutionStrategy.serverWins:
        await _applyResolution(conflict, conflict.remoteData);
        break;
        
      case ConflictResolutionStrategy.clientWins:
        await _applyResolution(conflict, conflict.localData);
        await _pushToServer(conflict.localData);
        break;
        
      case ConflictResolutionStrategy.manual:
        await _showConflictDialog(conflict);
        break;
        
      case ConflictResolutionStrategy.merge:
        final merged = await _mergeData(conflict.localData, conflict.remoteData);
        await _applyResolution(conflict, merged);
        break;
    }
  }
  
  // Field-level merge for intelligent conflict resolution
  Future<dynamic> _mergeData(dynamic local, dynamic remote) async {
    // Compare field by field
    // Keep non-conflicting changes from both
    // For conflicting fields, use last-write-wins or prompt user
  }
}
```

### 3.3 Offline Queue Management

```dart
class OfflineQueue {
  final _queue = <QueuedOperation>[];
  
  void enqueue(Operation operation) {
    _queue.add(QueuedOperation(
      operation: operation,
      timestamp: DateTime.now(),
      retryCount: 0,
    ));
    
    _persistQueue();
    _processQueue();
  }
  
  Future<void> _processQueue() async {
    if (!await _hasNetwork()) return;
    
    final pending = _queue.where((op) => !op.isProcessed).toList();
    
    for (final op in pending) {
      try {
        await _executeOperation(op.operation);
        op.markProcessed();
      } catch (e) {
        op.incrementRetry();
        if (op.retryCount >= 3) {
          op.markFailed(e.toString());
        }
      }
    }
    
    _persistQueue();
  }
}
```

---

## 4. Business Logic Layer

### 4.1 Use Cases

```dart
// Example: Create Sale Use Case
class CreateSaleUseCase {
  final SaleRepository _saleRepo;
  final ProductRepository _productRepo;
  final InventoryService _inventoryService;
  
  Future<Result<Sale>> execute(CreateSaleRequest request) async {
    // 1. Validate request
    final validation = _validateRequest(request);
    if (!validation.isValid) {
      return Result.error(validation.errors);
    }
    
    // 2. Check inventory availability
    for (final item in request.items) {
      final product = await _productRepo.getById(item.productId);
      if (product == null) {
        return Result.error('Product not found: ${item.productId}');
      }
      if (product.stockQuantity < item.quantity) {
        return Result.error('Insufficient stock for ${product.name}');
      }
    }
    
    // 3. Create sale in transaction
    return await _db.transaction(() async {
      // Create sale
      final sale = await _saleRepo.create(request.toSale());
      
      // Create sale items
      for (final item in request.items) {
        await _saleItemRepo.create(item.toSaleItem(sale.id!));
      }
      
      // Update inventory
      await _inventoryService.deductStock(request.items);
      
      // Generate invoice
      await _invoiceService.generate(sale);
      
      return Result.success(sale);
    });
  }
}
```

### 4.2 Services

```dart
// Inventory Management Service
class InventoryService {
  final ProductRepository _productRepo;
  
  Future<void> deductStock(List<SaleItem> items) async {
    for (final item in items) {
      final product = await _productRepo.getById(item.productId);
      if (product != null) {
        await _productRepo.update(
          product.copyWith(
            stockQuantity: product.stockQuantity - item.quantity,
            updatedAt: DateTime.now(),
          ),
        );
      }
    }
  }
  
  Future<void> addStock(int productId, int quantity) async {
    final product = await _productRepo.getById(productId);
    if (product != null) {
      await _productRepo.update(
        product.copyWith(
          stockQuantity: product.stockQuantity + quantity,
          updatedAt: DateTime.now(),
        ),
      );
    }
  }
  
  Stream<List<Product>> watchLowStockProducts() {
    return _productRepo.watchAll().map(
      (products) => products.where((p) => p.isLowStock).toList(),
    );
  }
}

// Report Generation Service
class ReportService {
  Future<SalesReport> generateSalesReport(DateRange range) async {
    final sales = await _saleRepo.getSalesByDateRange(range);
    
    return SalesReport(
      totalSales: sales.fold(0.0, (sum, sale) => sum + sale.total),
      totalTransactions: sales.length,
      averageTransaction: sales.isEmpty ? 0 : sales.fold(0.0, (sum, sale) => sum + sale.total) / sales.length,
      topProducts: await _getTopProducts(sales),
      salesByPaymentMethod: _groupByPaymentMethod(sales),
      salesByHour: _groupByHour(sales),
    );
  }
}
```

---

## 5. Presentation Layer

### 5.1 State Management

**Recommended: Riverpod or Bloc**

```dart
// Using Riverpod example

// Providers
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.read(databaseProvider));
});

final productsProvider = StreamProvider<List<Product>>((ref) {
  return ref.read(productRepositoryProvider).watchAll();
});

final lowStockProductsProvider = StreamProvider<List<Product>>((ref) {
  return ref.read(inventoryServiceProvider).watchLowStockProducts();
});

// State notifier for complex state
class SaleStateNotifier extends StateNotifier<SaleState> {
  final SaleRepository _saleRepo;
  final CreateSaleUseCase _createSaleUseCase;
  
  SaleStateNotifier(this._saleRepo, this._createSaleUseCase) 
      : super(SaleState.initial());
  
  Future<void> createSale(CreateSaleRequest request) async {
    state = state.copyWith(isLoading: true);
    
    final result = await _createSaleUseCase.execute(request);
    
    result.when(
      success: (sale) {
        state = state.copyWith(
          isLoading: false,
          currentSale: sale,
          error: null,
        );
      },
      error: (error) {
        state = state.copyWith(
          isLoading: false,
          error: error,
        );
      },
    );
  }
}
```

### 5.2 Offline Indicator

```dart
class OfflineIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final isOffline = snapshot.data == ConnectivityResult.none;
        
        if (!isOffline) return SizedBox.shrink();
        
        return Container(
          color: Colors.orange,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(Icons.cloud_off, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Working Offline - Changes will sync when online',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

---

## 6. Data Security & Privacy

### 6.1 Local Data Encryption

```dart
// Encrypt sensitive data at rest
class EncryptionService {
  static const _key = 'your-                                                -key'; // Store securely
  
  String encrypt(String plainText) {
    // Use flutter_secure_storage for key management
    // Use encrypt package for AES encryption
  }
  
  String decrypt(String cipherText) {
    // Decrypt using stored key
  }
}

// Encrypt sensitive fields
class SecureCustomer extends Customer {
  @override
  String get phone => EncryptionService.decrypt(_encryptedPhone);
  
  @override
  String get email => EncryptionService.decrypt(_encryptedEmail);
}
```

### 6.2 Data Backup & Recovery

```dart
class BackupService {
  Future<void> createBackup() async {
    final dbPath = await _db.getDatabasePath();
    final backupPath = await _getBackupPath();
    
    // Copy database file
    await File(dbPath).copy(backupPath);
    
    // Optionally compress and encrypt
    await _compressAndEncrypt(backupPath);
  }
  
  Future<void> restoreBackup(String backupPath) async {
    // Decrypt and decompress
    final decrypted = await _decryptAndDecompress(backupPath);
    
    // Close current database
    await _db.close();
    
    // Replace with backup
    final dbPath = await _db.getDatabasePath();
    await File(decrypted).copy(dbPath);
    
    // Reopen database
    await _db.open();
  }
}
```

---

## 7. Performance Optimization

### 7.1 Database Indexing

```dart
@DataClassName('Product')
class Products extends Table {
  // ... columns ...
  
  @override
  Set<Index> get indexes => {
    Index('idx_product_sku', [sku]),
    Index('idx_product_category', [category]),
    Index('idx_product_sync_status', [syncStatus]),
    Index('idx_product_uuid', [uuid]),
  };
}
```

### 7.2 Pagination & Lazy Loading

```dart
class PaginatedProductRepository {
  static const pageSize = 50;
  
  Future<Page<Product>> getPage(int pageNumber) async {
    final offset = pageNumber * pageSize;
    
    final products = await (_db.select(_db.products)
      ..limit(pageSize, offset: offset))
      .get();
    
    final total = await _db.products.count().getSingle();
    
    return Page(
      items: products,
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalItems: total,
      hasMore: (offset + pageSize) < total,
    );
  }
}
```

### 7.3 Caching Strategy

```dart
class CacheManager {
  final _cache = <String, CachedData>{};
  static const cacheDuration = Duration(minutes: 5);
  
  T? get<T>(String key) {
    final cached = _cache[key];
    if (cached == null) return null;
    
    if (DateTime.now().difference(cached.timestamp) > cacheDuration) {
      _cache.remove(key);
      return null;
    }
    
    return cached.data as T;
  }
  
  void set<T>(String key, T data) {
    _cache[key] = CachedData(
      data: data,
      timestamp: DateTime.now(),
    );
  }
}
```

---

## 8. Testing Strategy

### 8.1 Unit Tests

```dart
// Test repository
void main() {
  late AppDatabase db;
  late ProductRepository repo;
  
  setUp(() async {
    db = AppDatabase.inMemory();
    repo = ProductRepository(db);
  });
  
  tearDown(() async {
    await db.close();
  });
  
  test('create product should generate UUID', () async {
    final product = Product(name: 'Test', sku: 'TEST-001', price: 100);
    final created = await repo.create(product);
    
    expect(created.uuid, isNotEmpty);
    expect(created.syncStatus, SyncStatus.pending);
  });
}
```

### 8.2 Integration Tests

```dart
// Test sync flow
void main() {
  testWidgets('sync should resolve conflicts', (tester) async {
    // Setup local and remote data with conflicts
    // Trigger sync
    // Verify conflict resolution
  });
}
```

---

## 9. Implementation Roadmap

### Phase 1: Foundation (Weeks 1-2)
- [ ] Setup Drift database
- [ ] Implement core repositories
- [ ] Create data models
- [ ] Setup dependency injection

### Phase 2: Core Features (Weeks 3-4)
- [ ] Product management (CRUD)
- [ ] Customer management
- [ ] Sales transactions
- [ ] Inventory tracking

### Phase 3: Offline Sync (Weeks 5-6)
- [ ] Implement sync service
- [ ] Conflict detection
- [ ] Conflict resolution UI
- [ ] Offline queue management

### Phase 4: Advanced Features (Weeks 7-8)
- [ ] Reports and analytics
- [ ] Data export/import
- [ ] Backup and restore
- [ ] Multi-device support

### Phase 5: Polish & Testing (Weeks 9-10)
- [ ] Performance optimization
- [ ] Security hardening
- [ ] Comprehensive testing
- [ ] Documentation

---

## 10. Recommended Packages

```yaml
dependencies:
  # Database
  drift: ^2.14.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.1.0
  path: ^1.8.3
  
  # Sync & Network
  connectivity_plus: ^5.0.0
  http: ^1.1.0
  dio: ^5.4.0  # For advanced HTTP features
  
  # State Management
  riverpod: ^2.4.0
  flutter_riverpod: ^2.4.0
  
  # Utilities
  uuid: ^4.2.0
  intl: ^0.19.0
  equatable: ^2.0.5
  
  # Security
  flutter_secure_storage: ^9.0.0
  encrypt: ^5.0.3
  
  # Background Processing
  workmanager: ^0.5.1
  
dev_dependencies:
  drift_dev: ^2.14.0
  build_runner: ^2.4.0
  mockito: ^5.4.0
```

---

## 11. Key Considerations

### 11.1 Data Consistency
- Use transactions for multi-table operations
- Implement optimistic locking (version numbers)
- Validate data integrity before sync

### 11.2 Scalability
- Design for 10,000+ products
- Handle 1,000+ daily transactions
- Support multiple concurrent users (multi-device)

### 11.3 Error Handling
- Graceful degradation when offline
- Retry mechanisms for failed syncs
- User-friendly error messages

### 11.4 Monitoring
- Track sync success/failure rates
- Monitor database size
- Log conflict occurrences
- Performance metrics (query times)

---

## 12. Future Enhancements

1. **Real-time Collaboration**: WebSocket-based live updates
2. **Advanced Analytics**: ML-based sales predictions
3. **Multi-currency Support**: Exchange rate handling
4. **Barcode Scanning**: Hardware integration
5. **Receipt Printing**: Thermal printer support
6. **Cloud Backup**: Automatic encrypted backups
7. **Multi-store Management**: Centralized data with store-level isolation








Summary
The architecture document covers:

1. System Architecture
Clean Architecture with 3 layers (Presentation, Business Logic, Data)
Offline-first design principles
Local database as source of truth
2. Data Layer
Database: Drift (type-safe SQL) or Isar (NoSQL) recommendations
Schema: Products, Customers, Sales, SaleItems, SyncLogs, ConflictResolutions
Repository Pattern: Abstract interfaces with concrete implementations
Sync Metadata: UUID, timestamps, sync status, device ID for each entity
3. Synchronization Strategy
Hybrid Approach: Event-driven + periodic sync (every 15 minutes)
Conflict Resolution: 5 strategies (last-write-wins, server-wins, client-wins, manual, merge)
Offline Queue: Persistent queue with retry mechanism
Pull-Push Model: Pull remote changes first, then push local changes
4. Business Logic
Use Cases: Transaction-based operations (e.g., CreateSale)
Services: Inventory management, report generation
Validation: Input validation before database operations
5. Presentation Layer
State Management: Riverpod or Bloc recommended
Reactive UI: Stream-based updates from database
Offline Indicator: Visual feedback for network status
6. Security
Local data encryption for sensitive fields
Backup and restore functionality
Secure key storage
7. Performance
Database indexing on frequently queried fields
Pagination for large datasets
In-memory caching with TTL
8. Implementation Roadmap
10-week plan broken into 5 phases
Foundation → Core Features → Offline Sync → Advanced Features → Polish
9. Recommended Packages
Complete list of Flutter packages for database, sync, state management, security, and utilities

The document provides code examples, diagrams, and best practices for building a production-ready offline-first POS system!