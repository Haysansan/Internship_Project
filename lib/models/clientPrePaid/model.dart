class ClientPrepaidModel {
  final String name;
  final String id;
  final String client_code;
  ClientPrepaidModel({
    required this.name,
    required this.id,
    required this.client_code,
  });

  factory ClientPrepaidModel.fromJson(Map<String, dynamic> json) {
    return ClientPrepaidModel(
      id: json['id'].toString(),
      name: json["client"] ?? json["name"] ?? 'N/A',
      client_code: json["client_code"] ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
