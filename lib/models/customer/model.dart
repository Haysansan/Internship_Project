class ClientModel {
  final String branch;
  final String staff;
  final int id;
  final String client_code;
  final String loan_officer_id;
  final String first_name;
  final String last_name;
  final String gender;
  final String mobile;
  final String external_id;
  final String email;
  final String photo;
  final String address;
  final String name;

  ClientModel({
    required this.branch,
    required this.staff,
    required this.id,
    required this.client_code,
    required this.loan_officer_id,
    required this.first_name,
    required this.last_name,
    required this.gender,
    required this.mobile,
    required this.external_id,
    required this.email,
    required this.photo,
    required this.address,
    required this.name,
  });

  String get displayName {
    final hasFirstLast = first_name != 'N/A' || last_name != 'N/A';
    if (hasFirstLast) {
      return '${first_name} ${last_name}'.trim();
    }
    return name != 'N/A' ? name : 'N/A';
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      branch: json["branch"]?.toString() ?? 'N/A',
      staff: json["staff"]?.toString() ?? 'N/A',
      id: json["id"] ?? 0,
      client_code: json["client_code"]?.toString() ?? 'N/A',
      loan_officer_id: json["loan_officer_id"]?.toString() ?? 'N/A',
      first_name: json["first_name"]?.toString() ?? 'N/A',
      last_name: json["last_name"]?.toString() ?? 'N/A',
      gender: json["gender"]?.toString() ?? 'N/A',
      mobile: json["mobile"]?.toString() ?? 'N/A',
      external_id: json["external_id"]?.toString() ?? 'N/A',
      email: json["email"]?.toString() ?? 'N/A',
      photo: json["photo"]?.toString() ?? '',
      address:
          json["villages_name"]?.toString() ??
          json["address"]?.toString() ??
          'N/A',
      name: json["client"]?.toString() ?? json["name"]?.toString() ?? 'N/A',
    );
  }
}
