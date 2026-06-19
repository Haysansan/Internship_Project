class ProductModel {
  final int id;
  final String name;
  final String interest_rate;
  final String principal;
  final String loan_term;
  final String syncedate;
  final String synced;
  final String fee;
  final String frequency_type;

  ProductModel({
    required this.id,
    required this.name,
    required this.interest_rate,
    required this.principal,
    required this.loan_term,
    required this.syncedate,
    required this.synced,
    required this.fee,
    required this.frequency_type,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'N/A',
      interest_rate: json['interest_rate'] ?? 'N/A',
      principal: json['principal'] ?? 'N/A',
      loan_term: json['loan_term'] ?? 'N/A',
      syncedate: json['syncedate'] ?? 'N/A',
      synced: json['synced'] ?? 'N/A',
      fee: json['fee'] ?? 'N/A',
      frequency_type: json['frequency_type'] ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['interest_rate'] = this.interest_rate;
    data['principal'] = this.principal;
    data['loan_term'] = this.loan_term;
    data['syncedate'] = this.syncedate;
    data['synced'] = this.synced;
    data['fee'] = this.fee;
    data['frequency_type'] = this.frequency_type;
    return data;
  }
}

class ProductTypeModel {
  final String id;
  final String name;
  final String? nameKh;

  ProductTypeModel({required this.id, required this.name, this.nameKh});

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) =>
      ProductTypeModel(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        nameKh: json['name_kh']?.toString(),
      );
}
