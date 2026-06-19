import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: controller.animation,
              child: SizedBox(
                width: 125,
                height: 125,
                child: CircleAvatar(
                  backgroundColor: AppColor.white,
                  backgroundImage: AssetImage(
                    AssetPath.appIcon.path,
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
