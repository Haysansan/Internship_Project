import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'loan_detail_sheet.dart';

class LoanSummaryCard extends StatelessWidget {
  const LoanSummaryCard({Key? key, required this.loan}) : super(key: key);

  final LoanApprovalModel loan;

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
    return GestureDetector(
      onTap: () => LoanDetailSheet.show(context, loan),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: UIConstants.radius.radiusAll,
          border: Border.all(color: AppColor.lightGrey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
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
                  Text(loan.client, style: AppTextStyle.normalPrimarySemiBold),
                  const SizedBox(height: 2),
                  Text(
                    _formatAmount(loan.loanAmount),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColor.red,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${loan.branch} - ${loan.createAt}',
                    style: AppTextStyle.smallGreyRegular,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
      ),
    );
  }
}
