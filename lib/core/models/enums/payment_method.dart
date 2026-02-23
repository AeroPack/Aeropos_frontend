enum PaymentMethod {
  cash('cash'),
  card('card'),
  upi('upi'),
  credit('credit');

  final String value;
  const PaymentMethod(this.value);

  static PaymentMethod fromValue(String value) {
    return PaymentMethod.values.firstWhere((e) => e.value == value);
  }
}
