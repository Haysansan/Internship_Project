class TrackingModel {
  final String invoice;
  final String title;
  final String dateTime;
  final String description;
  final String name;
  final String phone;

  TrackingModel({
    required this.invoice,
    required this.title,
    required this.dateTime,
    required this.description,
    required this.name,
    required this.phone,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      invoice: json['invoice'] ?? 'N/A',
      title: json['title'] ?? 'N/A',
      dateTime: json['date_time'] ?? 'N/A',
      description: json['description'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      phone: json['phone'] ?? 'N/A',
    );
  }
}
