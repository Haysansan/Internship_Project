class ClientDisbModel {
  final int id;
  final String name;
  final String client_code;

  ClientDisbModel({
    required this.id,
    required this.name,
    required this.client_code,
  });
  factory ClientDisbModel.fromJson(Map<String, dynamic> json) {
    return ClientDisbModel(
        id: json["id"] ?? "0",
        name: json["name"] ?? 'N/A',
        client_code: json["client_code"] ?? 'N/A',
    );
  }
}
