class CollectedVsPlan {
  final int coId;
  final String coName;
  final String branchName;
  final double collectedAmount;
  final double planAmount;

  CollectedVsPlan({
    required this.coId,
    required this.coName,
    required this.branchName,
    required this.collectedAmount,
    required this.planAmount,
  });

  double get percentage =>
      planAmount > 0 ? (collectedAmount / planAmount * 100).clamp(0, 100) : 0;

  factory CollectedVsPlan.fromJson(Map<String, dynamic> json) {
    return CollectedVsPlan(
      coId: int.tryParse(json['co_id']?.toString() ?? json['id']?.toString() ?? '') ?? 0,
      coName: json['co_name']?.toString() ?? json['officer_name']?.toString() ?? json['full_name']?.toString() ?? '',
      branchName: json['branch']?.toString() ?? json['branch_name']?.toString() ?? '',
      collectedAmount: double.tryParse(json['collected_amount']?.toString() ?? '') ?? 0.0,
      planAmount: double.tryParse(json['plan_amount']?.toString() ?? '') ?? 0.0,
    );
  }
}
