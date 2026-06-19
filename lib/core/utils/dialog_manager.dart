import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class DialogManager {
  DialogManager._();

  static Future<dynamic> showCustom(Widget content) {
    if (Get.isDialogOpen == true) Get.back();
    if (Get.isBottomSheetOpen == true) Get.back();
    return Get.dialog(
      content,
      transitionDuration: const Duration(milliseconds: 150),
    );
  }

  static Future<dynamic> showDialog({
    required String title,
    required String subTitle,
    Function()? onPressed,
    String? btnText,
  }) async {
    if (Get.isDialogOpen == true) Get.back();
    if (Get.isBottomSheetOpen == true) Get.back();
    return Get.dialog(
      PrimaryDialog(
        title: title,
        subTitle: subTitle,
        btnText: btnText ?? LocaleKeys.ok.tr,
        onPressed: () {
          Get.back();
          onPressed?.call();
        },
      ),
      transitionDuration: const Duration(milliseconds: 150),
    );
  }

  static Future<dynamic> showConnectionDialog() async {
    if (Get.isDialogOpen == true) Get.back();
    if (Get.isBottomSheetOpen == true) Get.back();
    return Get.dialog(
      barrierDismissible: false,
      PrimaryDialog(
        title: LocaleKeys.somethingWentWrong.tr,
        subTitle: LocaleKeys.unableToConnectToTheInternet.tr,
        btnText: LocaleKeys.ok.tr.toUpperCase(),
        onPressed: () => Get.back(),
      ),
      transitionDuration: const Duration(milliseconds: 150),
    );
  }

  static Future<dynamic> showLoadingDialog() {
    return Get.dialog(barrierDismissible: false, const LoadingDialog());
  }

  static void hideLoading() {
    if (Get.isDialogOpen == true) Get.back();
  }
}
