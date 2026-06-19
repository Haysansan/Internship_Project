class LoanApprovalModel {
  final int id;
  final String client;
  final String branch;
  final String village;
  final String creditOfficer;
  final String loanAmount;
  final String interestRate;
  final String createAt;
  final String cycle;
  final String loanTerm;
  final String status;
  final String photo;
  final String loanId;
  final String clientCode;
  final String clientId;
  final String frequency;

  LoanApprovalModel({
    required this.id,
    required this.client,
    required this.branch,
    required this.village,
    required this.creditOfficer,
    required this.loanAmount,
    required this.interestRate,
    required this.createAt,
    required this.cycle,
    required this.loanTerm,
    required this.status,
    required this.photo,
    required this.loanId,
    required this.clientCode,
    required this.clientId,
    required this.frequency,
  });

  LoanApprovalModel copyWith({String? status}) {
    return LoanApprovalModel(
      id: id,
      client: client,
      branch: branch,
      village: village,
      creditOfficer: creditOfficer,
      loanAmount: loanAmount,
      interestRate: interestRate,
      createAt: createAt,
      cycle: cycle,
      loanTerm: loanTerm,
      status: status ?? this.status,
      photo: photo,
      loanId: loanId,
      clientCode: clientCode,
      clientId: clientId,
      frequency: frequency,
    );
  }

  factory LoanApprovalModel.fromJson(Map<String, dynamic> json) {
    return LoanApprovalModel(
      id: json['id'] ?? 0,
      client: json['client'] ?? json['client_name'] ?? 'N/A',
      branch: json['branch'] ?? 'N/A',
      creditOfficer: json['loan_officer'] ?? json['credit_officer'] ?? 'N/A',
      loanAmount:
          json['principal']?.toString() ??
          json['loan_amount']?.toString() ??
          '0',
      interestRate: json['interest_rate'] ?? 'N/A',
      createAt: json['disbursement_date']?.toString().split(' ')[0] ?? 'N/A',
      cycle: 'វដ្តទី ${json['cycle'] ?? 'N/A'}',
      loanTerm: json["loan_term"] ?? 'N/A',
      village: json['villages_name'] ?? json['village_name'] ?? 'N/A',
      status: json['status'] ?? 'pending',
      photo: json['photo'] ?? '',
      loanId: json['loan_id']?.toString() ?? '0',
      clientCode: json['client_code'] ?? 'N/A',
      clientId: json['client_id']?.toString() ?? '0',
      frequency: json['loan_frequency'] ?? 'N/A',
    );
  }
}
