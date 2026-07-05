

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const DrawerWidget(),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/dashboardbackground.png',
                fit: BoxFit.cover,
              ),
            ),
            // This is with scroll view
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Obx(
                      () => DashboardSummaryCard2(
                        summary: controller.summaryCardData,
                        userName: controller.displayUserName.value,
                        entityLabel: 'Clients',
                      ),
                    ),

                    20.height,

                    DashboardWidget(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
