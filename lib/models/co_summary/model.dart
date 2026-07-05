class CoSummary {
  final int coId;
  final String coName;
  final String branchName;
  final double totalAmount;
  final int totalClients;

  CoSummary({
    required this.coId,
    required this.coName,
    required this.branchName,
    required this.totalAmount,
    this.totalClients = 0,
  });

  factory CoSummary.fromJson(Map<String, dynamic> json) {
    return CoSummary(
      coId: int.tryParse(
            json['co_id']?.toString() ??
            json['bm_id']?.toString() ??
            json['id']?.toString() ??
            '',
          ) ?? 0,
      coName:
          json['co']?.toString() ??
          json['officer_name']?.toString() ??
          json['bm_name']?.toString() ??
          json['bm']?.toString() ??
          json['full_name']?.toString() ??
          '',
      branchName:
          json['branch']?.toString() ?? json['branch_name']?.toString() ?? '',
      totalAmount:
          double.tryParse(json['total_os_principal']?.toString() ?? '') ?? 0.0,
      totalClients:
          int.tryParse(json['total_client']?.toString() ?? '') ?? 0,
    );
  }
}
