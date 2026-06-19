import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class ExchangeRateWidget extends StatelessWidget {
  const ExchangeRateWidget({Key? key, required this.exchangeRate}) : super(key: key);

  final num exchangeRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIConstants.spacing.padAll,
      decoration: BoxDecoration(
        borderRadius: UIConstants.radius.radiusAll,
        color: AppColor.white,
        border: Border.all(width: 1, color: AppColor.lightGrey),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Image.asset(
                AssetPath.englishFlag.path,
                fit: BoxFit.cover,
                scale: 20,
              ),
              8.width,
              const Text(
                '1 USD',
                style: AppTextStyle.midPrimarySemiBold,
              ),
            ],
          ),
          const Spacer(),
          const Text(
            '=',
            style: AppTextStyle.midPrimarySemiBold,
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                '$exchangeRate Riel',
                style: AppTextStyle.midPrimarySemiBold,
              ),
              8.width,
              Image.asset(
                AssetPath.cambodiaFlag.path,
                fit: BoxFit.cover,
                scale: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
