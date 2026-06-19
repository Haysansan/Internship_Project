import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void onInit() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.repeat();
    fetchInit();
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  // show branch_id for login
  Future<int?> getbranchId() async {
    int? branchId = await SharedPreferencesManager.getIntValue('branch_id');
    return branchId;
  }

  // show user_id from login
  Future<int?> getUserId() async {
    int? user_id = await SharedPreferencesManager.getIntValue('user_id');
    return user_id;
  }

  // Future<void> fetchInit() async {
  //   // final String token = await SharedPreferencesManager.get(Credential.token.name) ?? '';
  //   int? branchID = await getbranchId();
  //   int? userID = await getUserId();
  //   if (branchID == null && userID == null) {
  //     Future.delayed(const Duration(seconds: 3)).then((value) {
  //       controller.stop();
  //       Get.offAllNamed(Routes.login);
  //     });
  //     return;
  //   } else {
  //     Future.delayed(const Duration(seconds: 3)).then((value) {
  //       controller.stop();
  //       Get.offAllNamed(Routes.start);
  //     });
  //   }
  //   //

  //   try {
  //     final res = await Get.find<ApiService>().get(
  //       '${EndPoints.profile}?user_id=$userID',
  //       isShowLoading: false,
  //     );
  //     final data = getPropertyFromJson(res.data, 'data');
  //     if (data != null) {
  //       final ProfileModel profile = ProfileModel.fromJson(data);
  //       UserRepository.shared.setProfile(profile);
  //       controller.stop();
  //       Get.offAllNamed(Routes.start);
  //       return;
  //     }
  //     controller.stop();
  //     Get.offAllNamed(Routes.login);
  //   } catch (e) {
  //     if (isClosed) {
  //       return;
  //     }
  //     // restore role from the permission saved at login time
  //     final savedPermission =
  //         await SharedPreferencesManager.get(Credential.permission.name) ?? '';
  //     UserRepository.shared.setUserTypeFromPermission(savedPermission);

  //     controller.stop();
  //     Get.offAllNamed(Routes.start);
  //   }
  // }
  Future<void> fetchInit() async {
    int? branchID = await getbranchId();
    int? userID = await getUserId();

    if (branchID == null && userID == null) {
      await Future.delayed(const Duration(seconds: 3));
      controller.stop();
      Get.offAllNamed(Routes.login);
      return;
    }

    // Only one navigation path — no delayed race
    await Future.delayed(const Duration(seconds: 3));
    controller.stop();

    try {
      final res = await Get.find<ApiService>().get(
        '${EndPoints.profile}?user_id=$userID',
        isShowLoading: false,
      );
      final data = getPropertyFromJson(res.data, 'data');
      if (data != null) {
        final ProfileModel profile = ProfileModel.fromJson(data);
        UserRepository.shared.setProfile(profile);
      }
    } catch (e) {
      if (isClosed) return;
      final savedPermission =
          await SharedPreferencesManager.get(Credential.permission.name) ?? '';
      UserRepository.shared.setUserTypeFromPermission(savedPermission);
    }

    Get.offAllNamed(Routes.start);
  }
}
