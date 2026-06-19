import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class TotalIncomeWidget extends StatelessWidget {
  const TotalIncomeWidget({Key? key, required this.codKhr}) : super(key: key);

  final String codKhr;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,

      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFE002A),
        borderRadius: UIConstants.radius.radiusAll,
        image: DecorationImage(
          image: AssetImage(AssetPath.dashboard.path),
          fit: BoxFit.cover,
          opacity: 0.35,
        ),
        border: Border.all(width: 1, color: AppColor.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.totalRepayment.tr,
            style: AppTextStyle.midWhiteRegular,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(codKhr, style: AppTextStyle.midWhiteSemiBold)],
          ),
        ],
      ),
    );
  }
}
