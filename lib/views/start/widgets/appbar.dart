// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:apploan/core/core.dart';
// import 'package:apploan/views/views.dart';

// dynamic _tapFunction({required index}) {
//   switch (index) {
//     case 0:
//       return DialogManager.showCustom(DashboardFilterDialog());
//     case 1:
//       return DialogManager.showCustom(DateFilterDialog());
//     case 3:
//       return DialogManager.showCustom(DeliveryFilterDialog());
//   }
// }

// PreferredSizeWidget appBarWidget() {
//   final StartController startCtl = Get.find<StartController>();

//   return AppBar(
//     title: Obx(() => Text(startCtl.getTitle())),
//     elevation: 0,
//     actions: [
//       Obx(() {
//         if (startCtl.selectedIndex.value != 2 && startCtl.selectedIndex.value != 4) {
//           return Padding(
//             padding: 15.padRight,
//             child: InkWell(
//               child: const Icon(Icons.notifications),
//               onTap: () => _tapFunction(index: startCtl.selectedIndex.value),
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       }),
//     ],
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

dynamic _tapFunction({required index}) {
  switch (index) {
    case 0:
      return DialogManager.showCustom(DashboardFilterDialog());
    case 1:
      return DialogManager.showCustom(DateFilterDialog());
    case 3:
      return DialogManager.showCustom(DeliveryFilterDialog());
  }
}

PreferredSizeWidget appBarWidget() {
  final StartController startCtl = Get.find<StartController>();

  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Obx(() {
      final bool isDashboard = startCtl.selectedIndex.value == 0;

      return AppBar(
        title: Text(
          startCtl.getTitle(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: isDashboard ? Colors.transparent : AppColor.primary,
            image:
                isDashboard
                    ? null
                    : DecorationImage(
                      image: AssetImage('assets/images/appbarbackground.png'),
                      fit: BoxFit.cover,
                    ),
          ),
        ),
        actions: [
          if (startCtl.selectedIndex.value != 2 &&
              startCtl.selectedIndex.value != 4)
            Padding(
              padding: 15.padRight,
              child: InkWell(
                child: const Icon(Icons.notifications, color: Colors.white),
                onTap: () => _tapFunction(index: startCtl.selectedIndex.value),
              ),
            ),
        ],
      );
    }),
  );
}
