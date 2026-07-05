class BmCashItem {
  final String bmName;
  final double amount;

  BmCashItem({required this.bmName, required this.amount});

  factory BmCashItem.fromJson(Map<String, dynamic> json) {
    return BmCashItem(
      bmName: json['bm_name']?.toString() ??
          json['bm']?.toString() ??
          json['full_name']?.toString() ??
          json['name']?.toString() ??
          json['officer_name']?.toString() ??
          '',
      amount: double.tryParse(
            json['cash_balance']?.toString() ??
            json['total_amount']?.toString() ??
            json['cash']?.toString() ??
            json['total_cash']?.toString() ??
            '',
          ) ?? 0.0,
    );
  }
}

class ExpenseItem {
  final String description;
  final double amount;
  final String date;

  ExpenseItem({required this.description, required this.amount, this.date = ''});

  factory ExpenseItem.fromJson(Map<String, dynamic> json) {
    return ExpenseItem(
      description: json['description']?.toString() ?? json['expense_type']?.toString() ?? '',
      amount: double.tryParse(json['amount']?.toString() ?? '') ?? 0.0,
      date: json['date']?.toString() ?? '',
    );
  }
}

class EndOfDaySummary {
  final List<BmCashItem> cashByBm;
  final double totalCashCollect;
  final List<ExpenseItem> expenses;
  final int totalClientDisbursed;
  final double totalAmountDisbursed;
  final int totalClientCollected;
  final double totalAmountCollected;
  final double totalPlanCollect;
  final double cashCeo;

  EndOfDaySummary({
    this.cashByBm = const [],
    this.totalCashCollect = 0,
    this.expenses = const [],
    this.totalClientDisbursed = 0,
    this.totalAmountDisbursed = 0,
    this.totalClientCollected = 0,
    this.totalAmountCollected = 0,
    this.totalPlanCollect = 0,
    this.cashCeo = 0,
  });

  double get totalExpense => expenses.fold(0.0, (s, e) => s + e.amount);
  double get totalCashByBm => cashByBm.fold(0.0, (s, e) => s + e.amount);
}
