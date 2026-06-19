import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class ChangePasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController currentPassCtl = TextEditingController();
  final TextEditingController newPassCtl = TextEditingController();
  final TextEditingController confirmPassCtl = TextEditingController();

  final RxBool isCurrentVisible = true.obs;
  final RxBool isnewVisible = true.obs;
  final RxBool isconfirmVisible = true.obs;

  @override
  void onClose() {
    currentPassCtl.dispose();
    newPassCtl.dispose();
    confirmPassCtl.dispose();
    super.onClose();
  }

  Future<void> changePassword() async {
    try {
      final payload = {
        'old_password': currentPassCtl.text,
        'password': newPassCtl.text,
        'confirm_password': confirmPassCtl.text,
      };
      await Get.find<ApiService>().post(
        EndPoints.updateProfile,
        payload,
        isShowLoading: true,
      );
      clearTextField();

      await SharedPreferencesManager.setValue(Credential.password.name, newPassCtl.text);

      DialogManager.showDialog(
        title: LocaleKeys.congratulation.tr,
        subTitle: LocaleKeys.youHaveSuccessfullyChangedThePassword.tr,
      );
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    }
  }

  void clearTextField() {
    currentPassCtl.text = '';
    newPassCtl.text = '';
    confirmPassCtl.text = '';
  }
}
