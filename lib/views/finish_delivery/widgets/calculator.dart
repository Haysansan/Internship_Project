String calculatePricingToDollarCurrency({required String enterAmount, required double paidAmount, required rating}) {
  if (enterAmount.isEmpty) {
    return paidAmount.toString();
  }
  final khmerAsDouble = double.parse(enterAmount);
  final dollar = khmerAsDouble / rating;
  final amount = paidAmount - dollar;
  if (amount < 0) {
    return 0.0.toString();
  }
  return amount.toStringAsFixed(2);
}

String calculatePricingToKhmerCurreny({required String enterAmount, required double paidAmount, required rating}) {
  if (enterAmount.isEmpty) {
    final khmer = paidAmount * rating;
    return khmer.toString();
  }
  final dollarAsDouble = double.parse(enterAmount);
  paidAmount -= dollarAsDouble;
  if (paidAmount < 0) {
    return 0.0.toString();
  }
  final khmer = paidAmount * rating;
  return khmer.toStringAsFixed(2);
}
