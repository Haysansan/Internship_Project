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

  void profileHandleTap() {
    Get.back();
    Get.toNamed(Routes.profile);
  }

  void cashSummaryByBMHandleTap() {
    Get.back();
    Get.toNamed(Routes.cashSummaryByBM);
  }

  void cashSummaryCoHandleTap() {
    Get.back();
    Get.toNamed(Routes.cashSummaryCo);
  }

  void collectedVsPlanHandleTap() {
    Get.back();
    Get.toNamed(Routes.collectedVsPlan);
  }

  void startOfDayHandleTap() {
    Get.back();
    Get.toNamed(Routes.startOfDay);
  }

  void endOfDayHandleTap() {
    Get.back();
    Get.toNamed(Routes.endOfDay);
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
    final user = UserRepository.shared.profile;
    final isCEOorBM = UserRepository.shared.isEco || UserRepository.shared.isBM;

    return Drawer(
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
          children: [
            // ── Header: logo + user info ──────────────────────────
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  Image.asset(AssetPath.appLogo.path, height: 56, fit: BoxFit.contain),
                  12.height,
                  const Divider(height: 1),
                  12.height,
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColor.hardOrange,
                        child: Text(
                          user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      12.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: AppTextStyle.normalPrimaryBold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            4.height,
                            Text(
                              user.type.isNotEmpty && user.type != 'N/A' ? user.type : user.email,
                              style: AppTextStyle.smallGreyRegular,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Menu items ────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _sectionLabel('General'),
                  CustomListTile(
                    text: LocaleKeys.profile.tr,
                    leadingIconData: Icons.person_outline,
                    trillingIconData: Icons.arrow_forward_ios_rounded,
                    onTap: profileHandleTap,
                  ),
                  CustomListTile(
                    text: LocaleKeys.language.tr,
                    leadingIconData: Icons.language,
                    trillingIconData: Icons.arrow_forward_ios_rounded,
                    onTap: languageHandleTap,
                  ),
                  CustomListTile(
                    leadingIconData: Icons.contact_support_outlined,
                    text: LocaleKeys.contactUs.tr,
                    trillingIconData: Icons.arrow_forward_ios_rounded,
                    onTap: contactUsHandleTap,
                  ),

                  if (UserRepository.shared.isEco) ...[
                    _divider(),
                    _sectionLabel('Day Operations'),
                    CustomListTile(
                      leadingIconData: Icons.wb_sunny_outlined,
                      text: 'Start Of Day',
                      trillingIconData: Icons.arrow_forward_ios_rounded,
                      onTap: startOfDayHandleTap,
                    ),
                    CustomListTile(
                      leadingIconData: Icons.nights_stay_outlined,
                      text: 'End Of Day',
                      trillingIconData: Icons.arrow_forward_ios_rounded,
                      onTap: endOfDayHandleTap,
                    ),
                  ],

                  if (isCEOorBM) ...[
                    _divider(),
                    _sectionLabel('Reports'),
                    CustomListTile(
                      leadingIconData: Icons.summarize_outlined,
                      text: UserRepository.shared.isEco ? 'CEO Taill' : 'BM Taill',
                      trillingIconData: Icons.arrow_forward_ios_rounded,
                      onTap: cashSummaryByBMHandleTap,
                    ),
                    CustomListTile(
                      leadingIconData: Icons.people_alt_outlined,
                      text: UserRepository.shared.isEco ? 'OS Summary by BM' : 'OS Summary by CO',
                      trillingIconData: Icons.arrow_forward_ios_rounded,
                      onTap: cashSummaryCoHandleTap,
                    ),
                    CustomListTile(
                      leadingIconData: Icons.bar_chart_rounded,
                      text: 'Collected vs Plan',
                      trillingIconData: Icons.arrow_forward_ios_rounded,
                      onTap: collectedVsPlanHandleTap,
                    ),
                  ],

                  _divider(),
                  // Logout
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.redAccent),
                      title: Text(LocaleKeys.logout.tr, style: AppTextStyle.midWhiteRegular),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 17, color: Colors.redAccent),
                      minLeadingWidth: 10,
                      visualDensity: const VisualDensity(vertical: -2),
                      onTap: logOutHandleTap,
                    ),
                  ),
                ],
              ),
            ),

            // ── Version ───────────────────────────────────────────
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: Text(
                  '${LocaleKeys.version.tr} ${AppConfig.shared.version}',
                  style: AppTextStyle.normalWhiteRegular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Divider(color: Colors.white.withOpacity(0.25), height: 1),
    );
  }
}
