import '../repositories/product_repository.dart';
import '../models/product.dart';

class InventoryService {
  final ProductRepository _productRepo;

  InventoryService(this._productRepo);

  Future<void> deductStock(int productId, int quantity) async {
    final product = await _productRepo.getProductById(productId);
    if (product != null) {
      final updatedProduct = product.copyWith(
        stockQuantity: product.stockQuantity - quantity,
        updatedAt: DateTime.now(),
      );
      await _productRepo.updateProduct(updatedProduct);
    }
  }

  Future<void> addStock(int productId, int quantity) async {
    final product = await _productRepo.getProductById(productId);
    if (product != null) {
      final updatedProduct = product.copyWith(
        stockQuantity: product.stockQuantity + quantity,
        updatedAt: DateTime.now(),
      );
      await _productRepo.updateProduct(updatedProduct);
    }
  }

  Stream<List<Product>> watchLowStockProducts({int threshold = 10}) {
    return _productRepo.watchAllProducts().map(
      (products) => products.where((p) => p.stockQuantity < threshold).toList(),
    );
  }
}
