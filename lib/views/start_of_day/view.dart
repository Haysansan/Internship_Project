import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'controller.dart';

class StartOfDayView extends GetView<StartOfDayController> {
  const StartOfDayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Start Of Day'),
      body: Obx(() {
        if (controller.isChecking.value) {
          return const Center(child: CircularProgressIndicator(color: AppColor.red));
        }

        return RefreshIndicator(
          onRefresh: controller.checkEodStatus,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
              child: Padding(
                padding: UIConstants.spacing.padHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wb_sunny_outlined, size: 72, color: AppColor.hardOrange),
                    24.height,
                    Text(
                      'Start Of Day',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.extraHugeBlackSemiBold,
                    ),
                    16.height,
                    Text(
                      'Tap the button below to start the day.',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.normalGreyRegular,
                    ),
                    40.height,
                    Obx(() {
                      final canStart = !UserRepository.shared.eodEnabled.value;
                      return Column(
                        children: [
                          if (!canStart)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.lock_outline, size: 14, color: Colors.orange),
                                  SizedBox(width: 6),
                                  Text(
                                    'Day already started',
                                    style: TextStyle(color: Colors.orange, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          PrimaryButton(
                            text: 'Confirm',
                            onPressed: (canStart && !controller.isLoading.value)
                                ? controller.submit
                                : null,
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
