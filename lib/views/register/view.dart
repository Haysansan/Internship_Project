import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  void registerTab() {
    if (!controller.formKey.currentState!.validate()) {
      return;
    }
    controller.formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.register.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UIConstants.spacing.height,

                // logo
                const LogoWidget(),

                UIConstants.spacing.height,

                Padding(
                  padding: UIConstants.spacing.padHorizontal,
                  child: Column(
                    children: [
                      // Phone number
                      CustomTextField(
                        controller: controller.phoneNumberCon,
                        hintText: LocaleKeys.accountName.tr,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                      ),

                      UIConstants.spacing.height,

                      // Password
                      CustomTextField(
                        controller: controller.passCon,
                        hintText: LocaleKeys.password.tr,
                        validator: (text) => FormValidator.empty(text),
                        textInputAction: TextInputAction.next,
                      ),

                      UIConstants.spacing.height,

                      // Confirm password
                      CustomTextField(
                        controller: controller.confirmCon,
                        hintText: LocaleKeys.confirmPassword.tr,
                        validator:
                            (text) => FormValidator.equalValues(
                              original: controller.passCon.text,
                              confirm: text,
                            ),
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),

                30.height,

                Padding(
                  padding: UIConstants.spacing.padHorizontal,
                  child: PrimaryButton(
                    text: 'ចុះឈ្មោះ',
                    onPressed: registerTab,
                  ),
                ),

                30.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
