import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/routes.dart';
import 'package:apploan/views/views.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  void onLogout() {
    DialogManager.showCustom(
      PrimaryDialog(
        title: LocaleKeys.logout.tr,
        subTitle: LocaleKeys.areYouSureYourWantToLogout.tr,
        btnText: LocaleKeys.yes.tr.toUpperCase(),
        onPressed: () async {
          Get.back();
          await UserRepository.shared.logout();
        },
      ),
    );
  }

  void onDeleteAccount() {
    DialogManager.showCustom(
      PrimaryDialog(
        title: LocaleKeys.deleteAccount.tr,
        subTitle: LocaleKeys.deleteAccountMessage.tr,
        btnText: LocaleKeys.yes.tr.toUpperCase(),
        onPressed: () async {
          Get.back();
          await controller.deleteAccount();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile
              ProfileWidget(),
              20.height,

              // User information
              Padding(
                padding: UIConstants.spacing.padHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.profile.tr, style: AppTextStyle.normalPrimaryBold),
                    10.height,
                    ProfileItemWidget(icon: Icons.phone, text: UserRepository.shared.profile.phone),
                    20.height,
                    const ChangePasswordWidget(),
                    20.height,
                    const ProfileItemWidget(icon: Icons.location_on, text: 'Phnom Penh'),
                  ],
                ),
              ),
              40.height,

              // Settings
              Padding(
                padding: UIConstants.spacing.padHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.settings.tr,
                      style: AppTextStyle.normalPrimaryBold,
                    ),
                    10.height,

                    // Language
                    ProfileItemWidget(
                      icon: Icons.language,
                      text: LocaleKeys.language.tr,
                      onTap: () => Get.toNamed(Routes.language),
                    ),
                    20.height,

                    // Logout
                    ProfileItemWidget(
                      icon: Icons.logout,
                      text: LocaleKeys.logout.tr,
                      iconColor: AppColor.red,
                      style: AppTextStyle.normalRedRegular,
                      onTap: onLogout,
                    ),
                    20.height,

                    // Delete account
                    ProfileItemWidget(
                      icon: Icons.delete,
                      text: LocaleKeys.deleteAccount.tr,
                      iconColor: AppColor.red,
                      style: AppTextStyle.normalRedRegular,
                      onTap: onDeleteAccount,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
