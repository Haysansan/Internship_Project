import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';

class LoanDetailSheet extends StatelessWidget {
  const LoanDetailSheet({Key? key, required this.loan}) : super(key: key);

  final LoanApprovalModel loan;

  static void show(BuildContext context, LoanApprovalModel loan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true, // background tap closes
      backgroundColor: Colors.transparent,
      builder: (_) => LoanDetailSheet(loan: loan),
    );
  }

  String _formatAmount(String raw) {
    final num? value = num.tryParse(raw);
    if (value == null) return raw;
    return '${NumberFormat('#,###').format(value)} ៛';
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return AppColor.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // keeps the sheet above the keyboard if ever needed
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // hug content — no blank space
          children: [
            //  Header
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColor.lightGrey,
                    child: ClipOval(
                      child: CustomNetworkImage(
                        imageUrl: loan.photo,
                        width: 56,
                        height: 56,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loan.client,
                          style: AppTextStyle.normalPrimarySemiBold,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Branch: ${loan.branch}',
                          style: AppTextStyle.smallGreyRegular,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          loan.createAt,
                          style: AppTextStyle.smallGreyRegular,
                        ),
                      ],
                    ),
                  ),
                  // Status badge + X button stacked vertically
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.cancel,
                          color: AppColor.grey,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: _statusColor(loan.status)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          loan.status,
                          style: TextStyle(
                            color: _statusColor(loan.status),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const DarkGreyDivider(),

            //  Credit Officer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: AppTextStyle.normalPrimaryRegular,
                    children: [
                      const TextSpan(text: 'Credit Officer: '),
                      TextSpan(
                        text: loan.creditOfficer,
                        style: AppTextStyle.normalPrimarySemiBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const DarkGreyDivider(),

            //  Loan details grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      _detailCell(
                        label: 'Loan amount',
                        value: _formatAmount(loan.loanAmount),
                        valueColor: AppColor.red,
                        valueBold: true,
                      ),
                      _detailCell(
                        label: 'Interest rate',
                        value: loan.interestRate,
                        valueBold: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _detailCell(
                        label: 'Created on',
                        value: loan.createAt,
                        valueBold: true,
                      ),
                      _detailCell(
                        label: 'Cycle / Frequency',
                        value: '${loan.cycle} / (${loan.frequency})',
                        valueBold: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const DarkGreyDivider(),

            //  Product name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  loan.loanTerm,
                  style: AppTextStyle.smallGreyRegular,
                ),
              ),
            ),
            const DarkGreyDivider(),

            //  Close button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: UIConstants.radius.radiusAll,
                    ),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailCell({
    required String label,
    required String value,
    Color? valueColor,
    bool valueBold = false,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.smallGreyRegular),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: valueBold ? FontWeight.bold : FontWeight.normal,
              color: valueColor ?? AppColor.primaryText,
            ),
          ),
        ],
      ),
    );
  }
}
