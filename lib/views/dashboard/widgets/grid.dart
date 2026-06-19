import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class GridItemWidget extends StatelessWidget {
  const GridItemWidget({
    Key? key,
    required this.title,
    required this.amount,
    this.icon = Icons.attach_money,
  }) : super(key: key);

  final String title;
  final String amount;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          (Get.width * 0.5) -
          UIConstants.spacing -
          (UIConstants.midSpacing / 2),
      decoration: BoxDecoration(
        borderRadius: UIConstants.radius.radiusAll,
        color: AppColor.white,
        border: Border.all(width: 1, color: AppColor.lightGrey),
      ),
      child: Padding(
        padding: UIConstants.spacing.padAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    amount,
                    maxLines: 2,
                    style: AppTextStyle.midPrimarySemiBold,
                  ),
                ),
                UnconstrainedBox(
                  alignment: Alignment.centerRight,
                  child: Icon(icon, color: AppColor.primary, size: 45),
                ),
              ],
            ),
            10.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: AppColor.primary, thickness: 3),
                Text(title, style: AppTextStyle.normalSecondaryRegular),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
