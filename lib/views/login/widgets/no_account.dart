import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/routes.dart';

class NoAccountWidget extends StatelessWidget {
  const NoAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Row(
        //   children: [
        //     InkWell(
        //       child: Container(
        //         height: 24,
        //         alignment: Alignment.centerLeft,
        //         child: Text.rich(
        //           TextSpan(
        //             children: [
        //               TextSpan(
        //                 text: LocaleKeys.forgotPassword.tr,
        //                 style: AppTextStyle.normalPrimaryRegular,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       onTap: () => Get.toNamed(Routes.register),
        //     ),
        //     40.width,
        //     InkWell(
        //       child: Container(
        //         height: 24,
        //         alignment: Alignment.centerRight,
        //         child: Text.rich(
        //           TextSpan(
        //             children: [
        //               TextSpan(
        //                 text: LocaleKeys.doNotHaveAnAccount.tr,
        //                 style: AppTextStyle.normalPrimaryRegular,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       onTap: () => Get.toNamed(Routes.register),
        //     ),
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.toNamed(Routes.register),
              child: Text.rich(
                TextSpan(
                  text: LocaleKeys.forgotPassword.tr,
                  style: AppTextStyle.normalPrimaryRegular,
                ),
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed(Routes.register),
              child: Text.rich(
                TextSpan(
                  text: LocaleKeys.doNotHaveAnAccount.tr,
                  style: AppTextStyle.normalPrimaryRegular,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
