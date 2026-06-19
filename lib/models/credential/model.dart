class CredentialModel {
  final String token;
  final String name;
  final String permission;

  CredentialModel({
    required this.token,
    required this.name,
    required this.permission,
  });

  factory CredentialModel.fromJson(Map<String, dynamic> json) {
    return CredentialModel(
      token: json['token'],
      name: json['name'] ?? 'N/A',
      permission: json['permission'] ?? 'N/A',
    );
  }
}
