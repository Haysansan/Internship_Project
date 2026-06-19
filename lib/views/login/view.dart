import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

// class LoginView extends GetView<LoginController> {
//   const LoginView({Key? key}) : super(key: key);

//   void loginTab() async {
//     if (!controller.formKey.currentState!.validate()) {
//       return;
//     }
//     controller.formKey.currentState!.save();
//     await controller.login();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/background.jpg"),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               child: Container(
//                 child: Form(
//                   key:
//                       controller
//                           .formKey, // Form key for validation and submission
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       UIConstants
//                           .spacing
//                           .height, // Vertical spacing defined in your UI constants
//                       // Logo Widget
//                       SizedBox(height: 40.0),
//                       const LogoWidget(),

//                       SizedBox(height: 10.0),
//                       //card form
//                       Container(
//                         margin: const EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(
//                                 0.5,
//                               ), // Shadow color
//                               spreadRadius: 2, // Spread radius
//                               blurRadius: 5, // Blur radius
//                               offset: Offset(
//                                 0,
//                                 3,
//                               ), // Offset in x and y directions
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: UIConstants.spacing.padHorizontal,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 10.0),
//                               // Phone number label in Khmer
//                               Text(
//                                 LocaleKeys.phoneNumber.tr,
//                                 style: TextStyle(fontSize: 14),
//                               ),

//                               SizedBox(height: 5.0), // Vertical spacing
//                               CustomTextField(
//                                 controller: controller.usernameCtl,
//                                 hintText: LocaleKeys.phoneNumber.tr,
//                                 validator: (text) {
//                                   return FormValidator.phoneNumber(text);
//                                 },
//                               ),

//                               UIConstants.spacing.height, // Vertical spacing
//                               // Password label in Khmer
//                               Text(
//                                 LocaleKeys.password.tr,
//                                 style: TextStyle(fontSize: 14),
//                               ),

//                               SizedBox(height: 5.0), // Vertical spacing
//                               // Password input field
//                               Obx(
//                                 () => CustomTextField(
//                                   controller: controller.passCtl,
//                                   hintText: LocaleKeys.password.tr,
//                                   suffixIcon: InkWell(
//                                     onTap:
//                                         () =>
//                                             controller.isPassVisible.value =
//                                                 !controller.isPassVisible.value,
//                                     child: Icon(
//                                       controller.isPassVisible.value
//                                           ? Icons.visibility
//                                           : Icons.visibility_off,
//                                     ),
//                                   ),
//                                   obscureText: controller.isPassVisible.value,
//                                   validator:
//                                       (text) => FormValidator.empty(
//                                         text,
//                                       ), // Validate non-empty password
//                                 ),
//                               ),

//                               UIConstants.spacing.height,
//                               Column(
//                                 children: [
//                                   // Login button
//                                   PrimaryButton(
//                                     text: LocaleKeys.login.tr,
//                                     onPressed: loginTab,
//                                   ),

//                                   SizedBox(height: 4.0), // Vertical spacing
//                                   // Register text widget
//                                   const NoAccountWidget(),
//                                 ],
//                               ),
//                               SizedBox(height: 5.0),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // Expands to fill remaining space
//                       SizedBox(height: 10.0),
//                       SocialLoginWidget(),
//                       const Spacer(),
//                       // SocialButtonsWidget(),
//                       // SizedBox(height: 10.0),
//                       // Bottom section with login button and register text
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  void loginTab() async {
    if (!controller.formKey.currentState!.validate()) {
      return;
    }
    controller.formKey.currentState!.save();
    await controller.login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UIConstants.spacing.height,
                      SizedBox(height: 40.0),
                      const LogoWidget(),
                      SizedBox(height: 10.0),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: UIConstants.spacing.padHorizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.0),
                              Text(
                                LocaleKeys.phoneNumber.tr,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5.0),
                              CustomTextField(
                                controller: controller.usernameCtl,
                                hintText: LocaleKeys.phoneNumber.tr,
                                validator: (text) {
                                  return FormValidator.phoneNumber(text);
                                },
                              ),
                              UIConstants.spacing.height,
                              Text(
                                LocaleKeys.password.tr,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5.0),
                              Obx(
                                () => CustomTextField(
                                  controller: controller.passCtl,
                                  hintText: LocaleKeys.password.tr,
                                  suffixIcon: InkWell(
                                    onTap:
                                        () =>
                                            controller.isPassVisible.value =
                                                !controller.isPassVisible.value,
                                    child: Icon(
                                      controller.isPassVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  obscureText: controller.isPassVisible.value,
                                  validator:
                                      (text) => FormValidator.empty(text),
                                ),
                              ),
                              UIConstants.spacing.height,
                              PrimaryButton(
                                text: LocaleKeys.login.tr,
                                onPressed: loginTab,
                              ),
                              SizedBox(height: 4.0),
                              const NoAccountWidget(),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      SocialLoginWidget(),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
