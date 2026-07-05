class ContactUsModel {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String website;
  final String telegram;
  final String facebook;

  ContactUsModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.website,
    required this.telegram,
    required this.facebook,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      website: json['website'] ?? '',
      telegram: json['telgram'] ?? '', // API typo: missing 'e'
      facebook: json['facebook'] ?? '',
    );
  }
}
