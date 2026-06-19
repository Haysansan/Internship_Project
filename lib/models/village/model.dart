class VillageModel {
  final String name_en;
  final String name_kh;
  final int id;
  final int synced;

  VillageModel({
    required this.name_en,
    required this.name_kh,
    required this.id,
    required this.synced,
  });

  String get name => name_kh;

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      name_en: json["name_en"] ?? 'N/A',
      name_kh: json["name_kh"] ?? 'N/A',
      id: json["id"] ?? 0,
      synced: json["synced"] ?? 0,
    );
  }
}
