import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class FinishDeliveryView extends GetView<FinishDeliveryController> {
  const FinishDeliveryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(title: LocaleKeys.finishDelivery.tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment at
            Padding(
              padding: UIConstants.spacing.padHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIConstants.spacing.height,

                  SizedBox(
                    height: 24,
                    child: Text(
                      LocaleKeys.paymentAdd.tr,
                      style: AppTextStyle.midPrimarySemiBold,
                    ),
                  ),

                  UIConstants.spacing.height,

                  // Sell
                  CustomRadioWidget(title: 'ABA អ្នកលក់', groupValue: 'seller'),
                  UIConstants.spacing.height,

                  // Company
                  CustomRadioWidget(title: 'ABA ក្រុមហ៊ុន', groupValue: 'company'),
                  UIConstants.spacing.height,

                  // Staff
                  StaffWidget(),
                ],
              ),
            ),
            UIConstants.spacing.height,

            // Cancel
            CancelWidget(),
            UIConstants.spacing.height,

            // Customer reject
            // CustomerRejecteWidget(),
            // UIConstants.spacing.height,

            // Delivery fee
            // DeliveryFeeWidget(),

            30.height,

            // Submit
            Padding(
              padding: UIConstants.spacing.padHorizontal,
              child: PrimaryButton(
                text: 'SUBMIT',
                onPressed: () async => await controller.submit(),
              ),
            ),

            30.height,
          ],
        ),
      ),
    );
  }
}
