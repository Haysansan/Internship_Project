import 'package:apploan/models/clientPrePaid/model.dart';
import 'package:apploan/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class PayfoeachotherView extends GetView<PayfoeachotherController> {
  const PayfoeachotherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.payforearchother.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: Padding(
        padding: UIConstants.spacing.padHorizontal,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                UIConstants.spacing.height,
                Obx(() {
                  if (controller.isLoadings.value) {
                    // Display loading indicator when data is being fetched
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.red),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.choosestaff.tr,
                        style: AppTextStyle.normalPrimaryRegular,
                      ),
                      SearchDropDown<StaffModel>(
                        items: controller.StaffList,
                        itemAsString:
                            (item) =>
                                item.name
                                    .toString(), // Convert StaffModel to String
                        onChanged: (value) async {
                          await controller.onStaffChanged(value);
                        },
                        selectedItem: controller.StaffSelected,
                      ),
                    ],
                  );
                }),
                Obx(() {
                  if (controller.isLoading.value) {
                    // Display loading indicator when data is being fetched
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.red),
                    );
                  }

                  // If not loading, show the dropdown
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIConstants.spacing.height,
                      Text(
                        LocaleKeys.chooseclients.tr,
                        style: AppTextStyle.normalPrimaryRegular,
                      ),
                      SearchDropDown<ClientPrepaidModel>(
                        items: controller.ClientList,
                        itemAsString:
                            (item) =>
                                '${item.client_code} - ${item.name}', // Convert StaffModel to String
                        onChanged: (value) {
                          controller.onClientChanged(value);
                        },
                        selectedItem: controller.clientSelected,
                      ),
                    ],
                  );
                }),
                UIConstants.spacing.height,
                // Total amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.totalRepayment.tr,
                      style: AppTextStyle.normalPrimaryRegular,
                    ),
                    2.height,
                    CustomTextField(
                      controller: controller.totalAmountCtl,
                      hintText: '\0.00',
                      textInputAction: TextInputAction.next,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (text) => FormValidator.empty(text),
                    ),
                  ],
                ),
                UIConstants.spacing.height,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.description.tr,
                      style: AppTextStyle.normalPrimaryRegular,
                    ),
                    2.height,
                    CustomTextField(
                      controller: controller.descriptionCtl,
                      hintText: LocaleKeys.description.tr,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
                UIConstants.spacing.height,
                // Submit
                PrimaryButton(
                  text: LocaleKeys.submit.tr,
                  onPressed: () async {
                    if (!controller.formKey.currentState!.validate()) {
                      return;
                    }
                    controller.formKey.currentState!.save();
                    await controller.submitBooking();
                  },
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
