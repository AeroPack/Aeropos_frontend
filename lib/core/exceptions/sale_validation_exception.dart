class SaleValidationException implements Exception {
  final String message;
  final List<String> invalidProducts;

  SaleValidationException(this.message, {this.invalidProducts = const []});

  @override
  String toString() {
    if (invalidProducts.isEmpty) {
      return message;
    }
    return '$message\nInvalid products: ${invalidProducts.join(", ")}';
  }
}
