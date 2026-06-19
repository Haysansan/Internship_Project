class BookingDetailsModel {
  final num id;
  final String zone;
  final num? zoneId;
  final String destinationPhone;
  final String destinationDesc;
  final num totalAmount;
  final String date;
  final String typeOfService;
  final num? booking;
  final String typeOfCod;
  final String anyExtra;
  final num extraAmount;
  final String anyExtraType;
  final num serviceFee;
  final String image;

  BookingDetailsModel({
    required this.id,
    required this.zone,
    this.zoneId,
    required this.destinationPhone,
    required this.destinationDesc,
    required this.totalAmount,
    required this.date,
    required this.typeOfService,
    this.booking,
    required this.typeOfCod,
    required this.anyExtra,
    required this.extraAmount,
    required this.anyExtraType,
    required this.serviceFee,
    required this.image,
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookingDetailsModel(
      id: json['id'],
      zone: json['zone'] ?? 'N/A',
      zoneId: json['zoneId'],
      destinationPhone: json['destination_phone'] ?? 'N/A',
      destinationDesc: json['destination_desc'] ?? 'N/A',
      totalAmount: json['total_amount'] ?? 0.0,
      date: json['date'] ?? 'N/A',
      typeOfService: json['type_of_service'] ?? 'N/A',
      booking: json['booking'],
      typeOfCod: json['type_of_cod'] ?? 'N/A',
      anyExtra: json['any_extra'] ?? 'N/A',
      extraAmount: json['extra_amount'] ?? 0.0,
      anyExtraType: json['any_extra_type'] ?? 'N/A',
      serviceFee: json['service_fee'] ?? 0.0,
      image: json['image'] ?? '',
    );
  }
}
