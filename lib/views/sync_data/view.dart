import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class SyncDataView extends GetView<SyncDataController> {
  const SyncDataView({Key? key}) : super(key: key);

  void onSearch() async {
    controller.fetchSyncData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isLoading.value) {
          bool shouldClose = await showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text(
                    "Data transfer is in progress. Are you sure you want to exit?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("No"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Yes"),
                    ),
                  ],
                ),
          );
          return shouldClose;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.syncdata.tr,
          onBack: () => Navigator.pop(context, false),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              UIConstants.spacing.height,
              Padding(
                padding: UIConstants.spacing.padHorizontal,
                child: Form(
                  key: controller.formKey,
                  child: Text(
                    LocaleKeys.waitUntilSuccess.tr,
                    style: AppTextStyle.normalRedBold,
                  ),
                ),
              ),
              10.height,
              Obx(() {
                if (controller.isLoading.value || controller.isLoadings.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColor.red),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(
                        value: controller.progress.value,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${(controller.progress.value * 100).toStringAsFixed(0)}% Synced',
                      ),
                      if (controller.customerCount > 0)
                        Text(
                          'មានអតិថិជនមិនទាន់ធ្វើការ Transfer ។ សូមធ្វើការ Transfer Data ជាមុនសិន? ចំនួនអតិថិជនដែលមិនទាន់ធ្វើការ Transfer មាន ${controller.customerCount} នាក់។',
                        ),
                    ],
                  ),
                );
              }),
              Obx(() {
                if (controller.isLoadings.value ||
                    controller.customerCount > 0) {
                  return PrimaryButton(
                    text: LocaleKeys.syncdata.tr,
                    width: 100,
                    onPressed: null,
                  );
                } else {
                  return PrimaryButton(
                    text: LocaleKeys.syncdata.tr,
                    width: 100,
                    onPressed: controller.isLoading.value ? null : onSearch,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
