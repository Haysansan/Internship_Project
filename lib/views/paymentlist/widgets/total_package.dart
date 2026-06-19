import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class TotalPackageWidget extends StatelessWidget {
  const TotalPackageWidget({
    Key? key,
    required this.packages,
    this.title,
    this.icon,
  }) : super(key: key);

  final String packages;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? LocaleKeys.clients.tr,
                style: AppTextStyle.normalWhiteRegular,
              ),
              Text(packages, style: AppTextStyle.midWhiteSemiBold),
            ],
          ),
          Icon(icon ?? Icons.assignment_sharp, size: 50, color: Colors.white),
        ],
      ),
    );
  }
}
