class BookingModel {
  final num id;
  final String zone;
  final String destinationPhone;
  final String totalAmount;
  final String bookingDate;
  final String typeOfService;
  final String typeOfCod;
  final String booking;
  final String anyExtra;
  final String serviceFee;
  final String? image;

  BookingModel({
    required this.id,
    required this.zone,
    required this.destinationPhone,
    required this.totalAmount,
    required this.bookingDate,
    required this.typeOfService,
    required this.typeOfCod,
    required this.booking,
    required this.anyExtra,
    required this.serviceFee,
    this.image,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      zone: json['zone'] ?? 'N/A',
      destinationPhone: json['destination_phone'] ?? 'N/A',
      totalAmount: json['total_amount'] ?? 'N/A',
      bookingDate: json['booking_date'] ?? 'N/A',
      typeOfService: json['type_of_service'] ?? 'N/A',
      typeOfCod: json['type_of_cod'] ?? 'N/A',
      booking: json['booking'] ?? 'N/A',
      anyExtra: json['any_extra'] ?? 'N/A',
      serviceFee: json['service_fee'] ?? 'N/A',
      image: json['image'] ?? '',
    );
  }
}
