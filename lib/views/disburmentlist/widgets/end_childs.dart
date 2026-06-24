import 'package:apploan/models/disbursement/disbursement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:intl/intl.dart';

class EndsChildWidget extends StatelessWidget {
  const EndsChildWidget({Key? key, required this.tracking}) : super(key: key);

  final DisbursementListModel tracking;

  String formatCurrency(String amount) {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
    ).format(double.tryParse(amount) ?? 0).replaceAll('.00', '');
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColor.green;
      case 'waiting verify':
        return const Color(0xFFE08A00);
      case 'rejected':
        return AppColor.red;
      default:
        return AppColor.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPending = tracking.loan_status.toLowerCase().contains('waiting');
    final statusColor = _statusColor(tracking.loan_status);

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
          // Client code + amount (left) and status (right)
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
                      'ទឹកប្រាក់កម្ចី: ${formatCurrency(tracking.principal)}',
                      style: AppTextStyle.smallGreyRegular,
                    ),
                  ],
                ),
              ),
              8.width,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tracking.loan_status,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.smallGreyRegular.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          10.height,

          // Avatar + client name + loan officer/zone
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
                      'មន្រ្ដីឈ្មោ៖: ${tracking.loan_officer}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.smallGreyRegular,
                    ),
                    4.height,
                    Text(
                      '${LocaleKeys.location.tr}: ${tracking.villages_name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.smallGreyRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (isPending) ...[
            8.height,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.hourglass_top_rounded,
                    size: 14,
                    color: statusColor,
                  ),
                  6.width,
                  Expanded(
                    child: Text(
                      'រង់ចាំការអនុម័តពី BM / CEO',
                      style: AppTextStyle.smallGreyRegular.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
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
}
