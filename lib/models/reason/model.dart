class ReasonModel {
  final int? id;
  final String? name;

  ReasonModel({required this.id, required this.name});

  factory ReasonModel.fromJson(Map<String, dynamic> json) {
    return ReasonModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
