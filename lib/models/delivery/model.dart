class DeliveryModel {
  final num id;
  final String invoiceId;
  final String shop;
  final String zone;
  final String destinationPhone;
  final num totalAmount;
  final String date;
  final String completeDate;
  final String deliveryName;
  final String typeOfService;
  final String deliveryStatus;
  final bool toggleStatus;
  final String status;
  final String reason;
  final int? paymentAtId;
  final String paymentAt;
  final num isProblem;
  final String image;

  DeliveryModel({
    required this.invoiceId,
    required this.id,
    required this.shop,
    required this.zone,
    required this.destinationPhone,
    required this.totalAmount,
    required this.date,
    required this.completeDate,
    required this.deliveryName,
    required this.typeOfService,
    required this.deliveryStatus,
    required this.toggleStatus,
    required this.status,
    required this.reason,
    this.paymentAtId,
    required this.paymentAt,
    required this.isProblem,
    required this.image,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      invoiceId: json['invoice'] ?? 'N/A',
      id: json['id'],
      shop: json['shop'] ?? 'N/A',
      zone: json['zone'] ?? 'N/A',
      destinationPhone: json['destination_phone'] ?? 'N/A',
      totalAmount: json['total_amount'] ?? 0.0,
      date: json['date'] ?? 'N/A',
      completeDate: json['complete_date'] ?? 'N/A',
      deliveryName: json['delivery_name'] ?? 'N/A',
      typeOfService: json['type_of_service'] ?? 'N/A',
      deliveryStatus: json['delivery_status'] ?? 'N/A',
      toggleStatus: json['toggle_status'] ?? false,
      status: json['status'] ?? 'N/A',
      reason: json['reason'] ?? 'N/A',
      paymentAtId: json['payment_at_id'],
      paymentAt: json['payment_at'] ?? 'N/A',
      isProblem: json['is_problem'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  bool get isIssus {
    return isProblem == 1;
  }
}
