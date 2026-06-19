class ProductDetailModel {
  final int id;
  final String name;
  final String interest_rate;
  final String principal;
  final int loan_term;
  final String fee;
  ProductDetailModel({
    required this.id,
    required this.name,
    required this.interest_rate,
    required this.principal,
    required this.loan_term,
    required this.fee,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'N/A',
      interest_rate: json['interest_rate'] ?? '0',
      principal: json['principal'] ?? '0',
      loan_term: json['loan_term'] ?? 0,
      fee: json['fee'] ?? "0",
    );
  }
}
