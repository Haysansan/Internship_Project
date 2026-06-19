class ProvinceModel {
  final String name_en;
  final String name;
  final int id;
  final int synced;

  ProvinceModel({
    required this.name_en,
    required this.name,
    required this.id,
    required this.synced,
  });
  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      name_en: json["name_en"] ?? 'N/A',
      name: json["name_kh"] ?? 'N/A',
      id: json["id"] ?? 0,
      synced: json["synced"] ?? 0,
    );
  }
}
