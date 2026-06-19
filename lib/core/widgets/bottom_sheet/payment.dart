import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/routes.dart';

class PaymentSheet extends StatelessWidget {
  const PaymentSheet({Key? key, required this.payment}) : super(key: key);

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(AssetPath.placeholder.path),
              ),
              14.width,
              Text(
                payment.client,
                style: AppTextStyle.normalPrimarySemiBold,
              ),
            ],
          ),
          15.height,
          const DarkGreyDivider(),
          15.height,
          _item(
            title: '${LocaleKeys.amount.tr} (\$)',
            value: '\$${payment.total_repayment}',
          ),
          10.height,
          _item(
            title: '${LocaleKeys.amount.tr} (៛)',
            value: '${payment.total_repayment}',
          ),
          10.height,
          _item(
            title: LocaleKeys.checkedBy.tr,
            value: payment.total_repayment,
          ),
          10.height,
          _item(
            title: LocaleKeys.date.tr,
            value: payment.submitted_on,
          ),
          10.height,
          _item(
            title: LocaleKeys.totalAmount.tr,
            value: '\$${payment.total_repayment}',
            isTotal: true,
          ),
          18.height,
          PrimaryButton(
            text: LocaleKeys.viewDetails.tr,
            onPressed: () {
              Get.back();
              final Map<String, dynamic> arguments = {'paymentId': payment.id};
              Get.toNamed(Routes.paymentDetail, arguments: arguments);
            },
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String title,
    required String value,
    bool isTotal = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: isTotal ? AppTextStyle.normalPrimarySemiBold : AppTextStyle.normalPrimaryRegular,
        ),
        const Spacer(),
        Text(
          value,
          style: isTotal ? AppTextStyle.normalRedBold : AppTextStyle.normalPrimaryRegular,
        ),
      ],
    );
  }
}
