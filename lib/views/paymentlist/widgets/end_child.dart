import 'package:apploan/views/paymentlist/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:intl/intl.dart';

class EndChildsWidget extends StatelessWidget {
  const EndChildsWidget({
    super.key,
    required this.tracking,
    required this.controller,
  });

  final PaymentModel tracking;
  final PaymentListController controller;

  static const _pendingStatuses = ['មិនទាន់ផ្ទេរ', 'មិនទាន់អនុម័ត'];

  bool get _isPending => _pendingStatuses.contains(tracking.status_pay);

  String formatCurrency(String amount) {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
    ).format(double.parse(amount)).replaceAll('.00', '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: 12.padAll,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Client code + date (left) and status (right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tracking.client_code,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.normalPrimaryBold.copyWith(
                        color: AppColor.primary,
                      ),
                    ),
                    2.height,
                    Text(
                      '${LocaleKeys.date.tr}: ${tracking.submitted_on}',
                      style: AppTextStyle.smallGreyRegular,
                    ),
                  ],
                ),
              ),
              8.width,
              _StatusBadge(label: tracking.status_pay, isPending: _isPending),
            ],
          ),
          10.height,

          // Avatar + client name + amounts
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColor.white,
                child: ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: tracking.photo,
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tracking.client,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.normalPrimarySemiBold,
                    ),
                    4.height,
                    Text(
                      'ទឹកទទួលបាន: ${formatCurrency(tracking.total_repayment)}',
                      style: AppTextStyle.smallRedSemibold,
                    ),
                    4.height,
                    Text(
                      'ទឹកប្រាក់ពិន័យ: ${tracking.amount_penalty.isNotEmpty ? formatCurrency(tracking.amount_penalty.replaceAll(',', '')) : 'គ្មាន'}',
                      style: AppTextStyle.smallGreyRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.isPending});

  final String label;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    final color = isPending ? const Color(0xFFE08A00) : AppColor.green;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.smallGreyRegular.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
