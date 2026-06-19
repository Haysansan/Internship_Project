class ContactUsModel {
  final String englishName;
  final String khmerName;
  final String email;
  final String phone;
  final String address;

  ContactUsModel({
    required this.englishName,
    required this.khmerName,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      englishName: json['name_en'] ?? 'N/A',
      khmerName: json['name_kh'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      phone: json['phone'] ?? 'N/A',
      address: json['address'] ?? 'N/A',
    );
  }
}
