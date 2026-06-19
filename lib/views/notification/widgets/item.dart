import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: 6.padTop,
              child: const CircleAvatar(
                backgroundColor: AppColor.red,
                radius: 5,
              ),
            ),
            12.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.6,
                  child: const Text(
                    'Dina has booked your delivery. Please contact to his number',
                    textAlign: TextAlign.start,
                    style: AppTextStyle.normalPrimarySemiBold,
                  ),
                ),
                2.height,
                const Text(
                  'Jul 23 2024 at 09:31 AM',
                  style: AppTextStyle.smallGreyRegular,
                ),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 27,
              backgroundImage: AssetImage(AssetPath.placeholder.path),
            ),
          ],
        ),
      ),
    );
  }
}
