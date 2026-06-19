class ScanCompleteModel {
  final int id;
  final int paymentAtId;
  final num? totalAmount;
  final String? paymentAt;
  final bool? deliveryStatus;
  final String? key;

  ScanCompleteModel({
    required this.id,
    required this.paymentAtId,
    this.totalAmount,
    this.paymentAt,
    this.deliveryStatus,
    this.key,
  });

  factory ScanCompleteModel.fromJson(Map<String, dynamic> json) {
    return ScanCompleteModel(
      id: json['id'],
      paymentAtId: json['payment_at_id'],
      totalAmount: json['total_amount'],
      paymentAt: json['payment_at'],
      deliveryStatus: json['delivery_status'],
      key: json['key'],
    );
  }
}
