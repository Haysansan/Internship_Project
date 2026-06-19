class DeliveryStatusModel {
  final bool deliveryStatus;

  DeliveryStatusModel({required this.deliveryStatus});

  factory DeliveryStatusModel.fromJson(Map<String, dynamic> json) {
    return DeliveryStatusModel(deliveryStatus: json['delivery_status'] ?? false);
  }
}
