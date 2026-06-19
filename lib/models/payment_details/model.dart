import 'package:apploan/models/models.dart';

class PaymentDetailsModel {
  final SummaryModel? summary;
  final List<DetailsModel> details;
  final DeliveryStatusCountModel? delivery;

  PaymentDetailsModel({
    required this.details,
    this.summary,
    this.delivery,
  });

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    return PaymentDetailsModel(
      summary: json['summary'] != null ? SummaryModel.fromJson(json['summary']) : null,
      delivery: json['delivery'] != null ? DeliveryStatusCountModel.fromJson(json['delivery']) : null,
      details: json['detail'] != null
          ? (json['detail'] as List).map((e) => DetailsModel.fromJson(e)).toList()
          : <DetailsModel>[],
    );
  }
}

class DeliveryStatusCountModel {
  final num success;
  final num pending;
  final num returned;

  DeliveryStatusCountModel({
    required this.success,
    required this.pending,
    required this.returned,
  });

  factory DeliveryStatusCountModel.fromJson(Map<String, dynamic> json) {
    return DeliveryStatusCountModel(
      success: json['success'] ?? 0,
      pending: json['pendding'] ?? 0,
      returned: json['return'] ?? 0,
    );
  }
}

class SummaryModel {
  final num amountVerifyUs;
  final num amountVerifyKh;
  final String paymentMethod;
  final num numberOfDelivery;
  final num extraAmountaxi;
  final num totalAmount;
  final String paymentDate;
  final num? totalCod;

  SummaryModel({
    required this.amountVerifyUs,
    required this.amountVerifyKh,
    required this.paymentMethod,
    required this.numberOfDelivery,
    required this.extraAmountaxi,
    required this.totalAmount,
    required this.paymentDate,
    this.totalCod,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      amountVerifyUs: json['amount_verify_us'] ?? 0.0,
      amountVerifyKh: json['amount_verify_kh'] ?? 0.0,
      paymentMethod: json['payment_method'] ?? 'N/A',
      numberOfDelivery: json['number_of_delivery'] ?? 0,
      extraAmountaxi: json['extra_amount_taxi'] ?? 0.0,
      totalAmount: json['total_amount'] ?? 0.0,
      paymentDate: (json['payment_date'] ?? 'N/A').split(' ')[0],
      totalCod: json['total_cod'] ?? 0,
    );
  }
}
