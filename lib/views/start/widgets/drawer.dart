import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/flavor/app_config.dart';
import 'package:apploan/routes.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  void languageHandleTap() {
    Get.back();
    Get.toNamed(Routes.language);
  }

  void termConditionHandleTap() {
    Get.back();
    Get.toNamed(Routes.termCondition);
  }

  void contactUsHandleTap() {
    Get.back();
    Get.toNamed(Routes.contactUs);
  }

  void logOutHandleTap() {
    Get.back();
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

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.deleteAccount.tr),
          content: Text(LocaleKeys.confirm1.tr),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
              },
              child: Text(LocaleKeys.cancel.tr),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop(); // close dialog first
                _showFinalConfirmation(context);
              },
              child: Text(LocaleKeys.delete.tr),
            ),
          ],
        );
      },
    );
  }

  void _showFinalConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.confirmation.tr),
          content: Text(LocaleKeys.confirm2.tr),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocaleKeys.no.tr),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                Navigator.of(context).pop(); // close dialog
                //  _deleteAccount(context);

                logOutHandleTap();
              },
              child: Text(LocaleKeys.yes.tr),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: AppColor.primary,
      shape: const RoundedRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColor.hardOrange,
          image: DecorationImage(
            image: AssetImage('assets/images/drawerbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  // Header
                  DrawerHeader(
                    padding: 12.padRight,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Image.asset(
                      AssetPath.appLogo.path,
                      fit: BoxFit.contain,
                    ),
                  ),
                  16.height,

                  // Language
                  CustomListTile(
                    text: LocaleKeys.language.tr,
                    leadingIconData: Icons.language,
                    trillingIconData: Icons.arrow_forward_ios_rounded,
                    onTap: languageHandleTap,
                  ),
                  16.height,

                  // Term and condition
                  // CustomListTile(
                  //   text: LocaleKeys.termAndCondition.tr,
                  //   leadingIconData: Icons.book_rounded,
                  //   trillingIconData: Icons.arrow_forward_ios_rounded,
                  //   onTap: termConditionHandleTap,
                  // ),
                  // 16.height,
                  // Log out
                  CustomListTile(
                    leadingIconData: Icons.delete,
                    text: LocaleKeys.deleteAccount.tr,
                    trillingIconData: Icons.arrow_forward_ios_rounded,
                    onTap: () => _showDeleteDialog(context),
                  ),
                  16.height,

                  // Contact us
                  CustomListTile(
                    leadingIconData: Icons.contact_support,
                    text: LocaleKeys.contactUs.tr,
                    trillingIconData: Icons.arrow_forward_ios_rounded,
                    onTap: contactUsHandleTap,
                  ),
                  16.height,

                  // Log out
                  CustomListTile(
                    leadingIconData: Icons.logout,
                    text: LocaleKeys.logout.tr,
                    trillingIconData: Icons.arrow_forward_ios_rounded,
                    onTap: logOutHandleTap,
                  ),
                ],
              ),
            ),
            SafeArea(top: false, child: versionWidget()),
            8.height,
          ],
        ),
      ),
    );
  }

  Widget versionWidget() {
    return Padding(
      padding: 16.padLeft,
      child: Text(
        '${LocaleKeys.version.tr} ${AppConfig.shared.version}',
        style: AppTextStyle.normalWhiteRegular,
      ),
    );
  }
}
