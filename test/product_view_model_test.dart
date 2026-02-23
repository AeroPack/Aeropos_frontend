import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/viewModel/product_view_model.dart';
import 'package:ezo/core/repositories/category_repository.dart';
import 'package:ezo/core/repositories/unit_repository.dart';
import 'package:ezo/core/repositories/brand_repository.dart';
import 'package:ezo/core/services/sync_service.dart';

class FakeSyncService implements SyncService {
  @override
  noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  late AppDatabase database;
  late ProductViewModel viewModel;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    viewModel = ProductViewModel(
      database,
      CategoryRepository(database),
      UnitRepository(database),
      BrandRepository(database),
      FakeSyncService(),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'ProductViewModel.deleteProduct removes product from database',
    () async {
      // 1. Add a product
      await viewModel.addProduct(
        name: 'Test Product',
        sku: 'TEST-001',
        price: 10.0,
        stockQuantity: 100.0,
      );

      var products = await database.getAllProducts();
      expect(products.length, 1);
      final id = products.first.id;

      // 2. Delete the product
      await viewModel.deleteProduct(id);

      // 3. Verify it's gone
      products = await database.getAllProducts();
      expect(products.length, 0);
    },
  );
}
