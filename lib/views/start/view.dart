// import 'package:apploan/core/core.dart';
// import 'package:apploan/views/views.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class StartView extends GetView<StartController> {
//   const StartView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: controller.selectedIndex.value == 0 ? true : false,
//       onPopInvoked: (didPop) {
//         controller.handleClickBack();
//       },
//       child: Scaffold(
//         appBar: appBarWidget(),
//         drawer: const DrawerWidget(),
//         body: Center(child: Obx(() => controller.selectedScreen.value)),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           elevation: 0,
//           surfaceTintColor: AppColor.red,
//           height: 70,
//           color: AppColor.white,
//           padding: 4.padHorizontal,
//           shape: const CircularNotchedRectangle(),
//           child: Obx(
//             () => Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [...controller.getItems().map((e) => e)],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartView extends GetView<StartController> {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final int selectedIndex = controller.selectedIndex.value;

      return PopScope(
        canPop: selectedIndex == 0,
        onPopInvoked: (didPop) {
          controller.handleClickBack();
        },
        child: Scaffold(
          extendBodyBehindAppBar: true, // background layer
          backgroundColor: Colors.transparent,
          appBar: selectedIndex == 0 ? appBarWidget() : null,
          drawer: const DrawerWidget(),
          body: Center(child: Obx(() => controller.selectedScreen.value)),
          bottomNavigationBar: Obx(
            () => AppBottomNav(items: controller.getItems()),
          ),
        ),
      );
    });
  }
}
