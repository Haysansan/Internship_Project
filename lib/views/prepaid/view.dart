import 'package:apploan/core/core.dart';
import 'package:apploan/models/clientPrePaid/model.dart';
import 'package:apploan/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrePaidView extends GetView<PrePaidController> {
  const PrePaidView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.prepaid.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.red),
          );
        }
        return Padding(
          padding: UIConstants.spacing.padHorizontal,
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  UIConstants.spacing.height,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          controller.onClientChanged(
                            value as ClientPrepaidModel?,
                          );
                        },
                        selectedItem: controller.clientSelected,
                      ),
                    ],
                  ),
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
                  // UIConstants.spacing.height,
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
                  Obx(() => PrimaryButton(
                    text: LocaleKeys.submit.tr,
                    onPressed: UserRepository.shared.eodEnabled.value
                        ? () async {
                            if (!controller.formKey.currentState!.validate()) return;
                            controller.formKey.currentState!.save();
                            await controller.submitBooking();
                          }
                        : null,
                  )),

                  30.height,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
