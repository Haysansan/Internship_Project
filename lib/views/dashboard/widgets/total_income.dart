import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class TotalIncomeWidget extends StatelessWidget {
  const TotalIncomeWidget({
    Key? key,
    required this.codKhr,
    required this.codUsd,
  }) : super(key: key);

  final String codKhr;
  final String codUsd;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      margin: UIConstants.spacing.padTop,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.blue,
        image: DecorationImage(
          image: AssetImage(AssetPath.dashboard.path),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
        border: Border.all(width: 1, color: AppColor.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.totalIncome.tr,
            style: AppTextStyle.midWhiteRegular,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                codKhr,
                style: AppTextStyle.midWhiteSemiBold,
              ),
              Text(
                codUsd,
                style: AppTextStyle.midWhiteSemiBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
