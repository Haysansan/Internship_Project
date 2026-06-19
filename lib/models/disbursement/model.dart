class DisbursementModel {
  String? client;
  String? loan_officer;
  String? branch;
  String? client_id;
  String? loan_id;
  String? client_code;
  String? account_number;
  String? cycle;
  String? loan_term;
  String? photo;
  String? principal;
  String? villages_name;

  DisbursementModel({
    this.client,
    this.loan_officer,
    this.branch,
    this.client_id,
    this.loan_id,
    this.client_code,
    this.account_number,
    this.cycle,
    this.loan_term,
    this.photo,
    this.principal,
    this.villages_name,
  });
  DisbursementModel.fromJson(Map<String, dynamic> json) {
    client = json["client"];
    loan_officer = json["loan_officer"];
    branch = json["branch"];
    client_id = json["client_id"];
    loan_id = json["loan_id"];
    client_code = json["client_code"];
    account_number = json["account_number"];
    cycle = json["cycle"];
    loan_term = json["loan_term"];
    photo = json["photo"];
    principal = json["principal"];
    villages_name = json["villages_name"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client'] = this.client;
    data['loan_officer'] = this.loan_officer;
    data['branch'] = this.branch;
    data['client_id'] = this.client_id;
    data['loan_id'] = this.loan_id;
    data['client_code'] = this.client_code;

    data["account_number"] = this.account_number;
    data['cycle'] = this.cycle;
    data['loan_term'] = this.loan_term;
    data['photo'] = this.photo;
    data['principal'] = this.principal;
    data['villages_name'] = this.villages_name;
    return data;
  }
}

class DisbursementListModel {
  final String client;
  final String loan_officer;
  final String branch;
  final String client_id;
  final String loan_id;
  final String client_code;
  final String account_number;
  final String cycle;
  final String loan_term;
  final String photo;
  final String principal;
  final String villages_name;
  final String loan_status;
  final String interestRate;

  DisbursementListModel({
    required this.client,
    required this.loan_officer,
    required this.branch,
    required this.client_id,
    required this.loan_id,
    required this.client_code,
    required this.account_number,
    required this.cycle,
    required this.loan_term,
    required this.photo,
    required this.principal,
    required this.villages_name,
    required this.loan_status,
    required this.interestRate,
  });
  factory DisbursementListModel.fromJson(Map<String, dynamic> json) {
    return DisbursementListModel(
      client: json["client"] ?? 'N/A',
      loan_officer: json["loan_officer"] ?? 'N/A',
      branch: json["branch"] ?? 'N/A',
      client_id: json["client_id"] ?? 'N/A',
      loan_id: json["loan_id"] ?? 'N/A',
      client_code: json["client_code"] ?? 'N/A',
      account_number: json["account_number"] ?? 'N/A',
      cycle: json["cycle"] ?? 'N/A',
      loan_term: json["loan_term"] ?? 'N/A',
      photo: json["photo"] ?? 'N/A',
      principal: json["principal"] ?? 'N/A',
      villages_name: json["villages_name"] ?? 'N/A',
      loan_status: json["loan_status"] ?? 'N/A',
      interestRate: json["interest_rate"] ?? 'N/A',
    );
  }
}

class AppliedAmountModel {
  final int id;
  final String amountLoans;

  AppliedAmountModel({required this.id, required this.amountLoans});

  factory AppliedAmountModel.fromJson(Map<String, dynamic> json) =>
      AppliedAmountModel(id: json['id'], amountLoans: json['amount_loans']);

  String get name => amountLoans.toString();

  @override
  String toString() => name;
}

class LoanPurposeModel {
  final int id;
  final String name;
  LoanPurposeModel({required this.id, required this.name});
  factory LoanPurposeModel.fromJson(Map<String, dynamic> json) =>
      LoanPurposeModel(id: json['id'], name: json['name']);
}

class FrequencyTypeModel {
  final String id;
  final String name;
  FrequencyTypeModel({required this.id, required this.name});
  factory FrequencyTypeModel.fromJson(Map<String, dynamic> json) =>
      FrequencyTypeModel(id: json['id'], name: json['name']);
}

class DailyIncomeModel {
  final int id;
  final String name;
  DailyIncomeModel({required this.id, required this.name});

  factory DailyIncomeModel.fromJson(Map<String, dynamic> json) =>
      DailyIncomeModel(id: json['id'], name: json['name']);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class FeeModel {
  final int id;
  final String name;

  FeeModel({required this.id, required this.name});

  factory FeeModel.fromJson(Map<String, dynamic> json) =>
      FeeModel(id: json['id'], name: json['name']);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
