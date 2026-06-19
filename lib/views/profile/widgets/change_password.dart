import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/routes.dart';

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void changePasswordHandleTap() => Get.toNamed(Routes.changePassword);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColor.grey.withOpacity(0.5),
          child: const Icon(Icons.lock, color: AppColor.black),
        ),
        16.width,
        const Text(
          '..........',
          style: AppTextStyle.midPrimaryBold,
        ),
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: changePasswordHandleTap,
          child: Text(
            LocaleKeys.changePassword.tr,
            style: AppTextStyle.normalRedRegular,
          ),
        ),
      ],
    );
  }
}
