import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class DeliveryFeeWidget extends StatelessWidget {
  DeliveryFeeWidget({Key? key}) : super(key: key);

  final FinishDeliveryController controller = Get.find<FinishDeliveryController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIConstants.spacing.padHorizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.deliveryFee.tr,
            style: AppTextStyle.midPrimarySemiBold,
          ),
          15.height,
          Form(
            key: controller.deliveryFeeformKey,
            child: CustomTextField(
              controller: controller.deliveryFeeCtl,
              hintText: 'បញ្ចូលលុយដុល្លារ',
              hintStyle: AppTextStyle.normalGreyRegular,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              validator: (text) => FormValidator.empty(text),
              filled: true,
              suffixIcon: InkWell(
                child: Image.asset(
                  AssetPath.usd.path,
                  scale: 19,
                  color: AppColor.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
