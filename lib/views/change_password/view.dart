import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.changePassword.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: SafeArea(
        bottom: true,
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: UIConstants.spacing.padHorizontal,
            child: Column(
              children: [
                20.height,

                // Current password
                Obx(
                  () => NoBorderTextField(
                    prefixIcon: const Icon(Icons.lock),
                    controller: controller.currentPassCtl,
                    obscureText: controller.isCurrentVisible.value,
                    textInputAction: TextInputAction.next,
                    suffixIcon: InkWell(
                      onTap:
                          () =>
                              controller.isCurrentVisible.value =
                                  !controller.isCurrentVisible.value,
                      child: Icon(
                        controller.isCurrentVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    hintText: LocaleKeys.currentPassword.tr,
                    validator: (text) => FormValidator.empty(text),
                  ),
                ),
                25.height,

                // New password
                Obx(
                  () => NoBorderTextField(
                    prefixIcon: const Icon(Icons.lock),
                    obscureText: controller.isnewVisible.value,
                    controller: controller.newPassCtl,
                    textInputAction: TextInputAction.next,
                    suffixIcon: InkWell(
                      onTap:
                          () =>
                              controller.isnewVisible.value =
                                  !controller.isnewVisible.value,
                      child: Icon(
                        controller.isnewVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    hintText: LocaleKeys.newPassword.tr,
                    validator: (text) => FormValidator.empty(text),
                  ),
                ),
                25.height,

                // Confirm password
                Obx(
                  () => NoBorderTextField(
                    prefixIcon: const Icon(Icons.lock),
                    controller: controller.confirmPassCtl,
                    obscureText: controller.isconfirmVisible.value,
                    textInputAction: TextInputAction.done,
                    suffixIcon: InkWell(
                      onTap:
                          () =>
                              controller.isconfirmVisible.value =
                                  !controller.isconfirmVisible.value,
                      child: Icon(
                        controller.isconfirmVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    hintText: LocaleKeys.confirmPassword.tr,
                    validator:
                        (text) => FormValidator.equalValues(
                          original: controller.newPassCtl.text,
                          confirm: text,
                        ),
                  ),
                ),
                50.height,

                // Change
                PrimaryButton(
                  text: LocaleKeys.change.tr,
                  onPressed: () async {
                    if (!controller.formKey.currentState!.validate()) {
                      return;
                    }
                    controller.formKey.currentState!.save();
                    await controller.changePassword();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
