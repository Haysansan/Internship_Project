class CustomerPaymentModel {
  final String paymentMethods;
  final String phone;
  final String name;
  final String date;
  final String tranId;
  final String shopPaid;
  final num total;
  final String status;

  CustomerPaymentModel({
    required this.paymentMethods,
    required this.phone,
    required this.name,
    required this.date,
    required this.tranId,
    required this.shopPaid,
    required this.total,
    required this.status,
  });

  factory CustomerPaymentModel.fromJson(Map<String, dynamic> json) {
    return CustomerPaymentModel(
      paymentMethods: json['payment_methods'] ?? 'N/A',
      phone: json['phone'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      date: json['date'] ?? 'N/A',
      tranId: json['tran_id'] ?? 'N/A',
      shopPaid: json['shop_paid'] ?? 'N/A',
      total: json['total'] ?? 'N/A',
      status: json['status'] ?? 'N/A',
    );
  }
}

class DetailsModel {
  final String invoice;
  final String zone;
  final String destinationDesc;
  final String entryDate;
  final String completeDate;
  final String customerName;
  final num serviceFee;
  final num extraAmount;
  final num totalAmount;
  final num sellerAmount;
  final num staffAmount;
  final num companyAmount;
  final num amountPaid;
  final String profilePath;
  final String destinationPhone;

  DetailsModel({
    required this.invoice,
    required this.zone,
    required this.destinationDesc,
    required this.entryDate,
    required this.completeDate,
    required this.customerName,
    required this.serviceFee,
    required this.extraAmount,
    required this.totalAmount,
    required this.sellerAmount,
    required this.staffAmount,
    required this.companyAmount,
    required this.amountPaid,
    required this.profilePath,
    required this.destinationPhone,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      invoice: json['invoice'] ?? 'N/A',
      zone: json['zone'] ?? 'N/A',
      destinationDesc: json['destination_desc'] ?? 'N/A',
      entryDate: json['entry_date'] ?? 'N/A',
      completeDate: json['complete_date'] ?? 'N/A',
      customerName: json['customer_name'] ?? 'N/A',
      serviceFee: json['service_fee'] ?? 0.0,
      extraAmount: json['extra_amount'] ?? 0.0,
      totalAmount: json['total_amount'] ?? 0.0,
      sellerAmount: json['seller_amount'] ?? 0.0,
      staffAmount: json['staff_amount'] ?? 0.0,
      companyAmount: json['company_amount'] ?? 0.0,
      amountPaid: json['amount_paid'] ?? 0.0,
      profilePath: json['profilePath'] ?? 'N/A',
      destinationPhone: json['destination_phone'] ?? 'N/A',
    );
  }

  String get paymentType {
    if (staffAmount > 0) {
      return 'ABA អ្នកដឹក';
    }
    if (sellerAmount > 0) {
      return 'ABA អ្នកលក់';
    }
    return 'ABA ក្រុមហ៊ុន';
  }
}
