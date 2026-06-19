enum PaymentStatus {
  successfully('Successful'),
  pending('Pending'),
  failed('Failed'),
  returned('Return'),
  ;

  final String key;
  const PaymentStatus(this.key);
}
