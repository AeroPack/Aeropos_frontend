enum SaleStatus {
  pending('pending'),
  completed('completed'),
  cancelled('cancelled'),
  refunded('refunded');

  final String value;
  const SaleStatus(this.value);

  static SaleStatus fromValue(String value) {
    return SaleStatus.values.firstWhere((e) => e.value == value);
  }
}
