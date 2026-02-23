import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/viewModel/product_view_model.dart';
import 'package:ezo/core/repositories/category_repository.dart';
import 'package:ezo/core/repositories/unit_repository.dart';
import 'package:ezo/core/repositories/brand_repository.dart';
import 'package:ezo/core/services/sync_service.dart';

// Fakes
class FakeCategoryRepository implements CategoryRepository {
  @override
  noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class FakeUnitRepository implements UnitRepository {
  @override
  noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class FakeBrandRepository implements BrandRepository {
  @override
  noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class FakeSyncService implements SyncService {
  @override
  noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  late AppDatabase db;
  late ProductViewModel viewModel;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    viewModel = ProductViewModel(
      db,
      FakeCategoryRepository(),
      FakeUnitRepository(),
      FakeBrandRepository(),
      FakeSyncService(),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('should insert product successfully', () async {
    await viewModel.addProduct(
      name: 'Test Product',
      sku: 'TEST-SKU-001',
      price: 100.0,
      stockQuantity: 10,
      cost: 50.0,
    );

    final products = await db.getAllProducts();
    expect(products.length, 1);
    expect(products.first.name, 'Test Product');
    expect(products.first.sku, 'TEST-SKU-001');
    expect(products.first.cost, 50.0);
  });

  test('should fail on duplicate SKU', () async {
    await viewModel.addProduct(
      name: 'Test Product 1',
      sku: 'DUPLICATE',
      price: 100.0,
      stockQuantity: 10,
    );

    expect(
      () => viewModel.addProduct(
        name: 'Test Product 2',
        sku: 'DUPLICATE',
        price: 200.0,
        stockQuantity: 5,
      ),
      throwsA(isA<SqliteException>()),
    );
  });
}
