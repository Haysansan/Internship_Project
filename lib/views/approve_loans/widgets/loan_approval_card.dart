import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class LoanApprovalCard extends StatefulWidget {
  const LoanApprovalCard({
    Key? key,
    required this.loan,
    required this.controller,
  }) : super(key: key);

  final LoanApprovalModel loan;
  final ApproveLoansController controller;

  @override
  State<LoanApprovalCard> createState() => _LoanApprovalCardState();
}

class _LoanApprovalCardState extends State<LoanApprovalCard> {
  late final TextEditingController _commentCtl = TextEditingController();

  @override
  void dispose() {
    _commentCtl.dispose();
    super.dispose();
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

  void _onApprove() {
    final comment = _commentCtl.text.trim();
    if (widget.controller.isCEO) {
      widget.controller.approveLoan(widget.loan, comment);
    } else if (widget.controller.selectedTab.value == 1) {
      widget.controller.verifyLoan(widget.loan, comment);
    } else {
      widget.controller.disburseLoan(widget.loan, comment);
    }
  }

  void _onReject() {
    final comment = _commentCtl.text.trim();
    if (widget.controller.isCEO) {
      widget.controller.rejectLoan(widget.loan, comment);
    } else if (widget.controller.selectedTab.value == 1) {
      widget.controller.rejectVerifyLoan(widget.loan, comment);
    } else {
      widget.controller.rejectDisbursement(widget.loan, comment);
    }
  }

  bool get _showActions => widget.controller.selectedTab.value != 0;

  @override
  Widget build(BuildContext context) {
    final loan = widget.loan;
    final controller = widget.controller;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: UIConstants.radius.radiusAll,
        border: Border.all(color: AppColor.lightGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.normalPrimarySemiBold,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Branch: ${loan.branch}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.smallGreyRegular,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Village: ${loan.village}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.smallGreyRegular,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 110),
                  child: Container(
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _statusColor(loan.status),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const DarkGreyDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
          const DarkGreyDivider(),
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
                    const SizedBox(width: 12),
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
                    const SizedBox(width: 12),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(loan.loanTerm, style: AppTextStyle.smallGreyRegular),
          ),
          if (_showActions) ...[
            const DarkGreyDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              child: TextField(
                controller: _commentCtl,
                decoration: InputDecoration(
                  hintText: 'Add a comment',
                  hintStyle: AppTextStyle.normalLightGreyRegular,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: UIConstants.radius.radiusAll,
                    borderSide: const BorderSide(color: AppColor.lightGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: UIConstants.radius.radiusAll,
                    borderSide: const BorderSide(color: AppColor.lightGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: UIConstants.radius.radiusAll,
                    borderSide: const BorderSide(color: AppColor.lightGrey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 14),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _onApprove,
                      icon: const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 18,
                      ),
                      label: Text(
                        controller.isBM
                            ? controller.selectedTab.value == 2
                                ? LocaleKeys.disburseLoan.tr
                                : 'Verify'
                            : 'Approve',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Colors.green, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: UIConstants.radius.radiusAll,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _onReject,
                      icon: const Icon(
                        Icons.close,
                        color: AppColor.red,
                        size: 18,
                      ),
                      label: const Text(
                        'Reject',
                        style: TextStyle(
                          color: AppColor.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: AppColor.red, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: UIConstants.radius.radiusAll,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
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
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.smallGreyRegular,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
