import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class CustomRadioWidget extends StatelessWidget {
  CustomRadioWidget({
    Key? key,
    required this.title,
    required this.groupValue,
    this.isNoBorder = false,
  }) : super(key: key);

  final bool isNoBorder;
  final String title;
  final String groupValue;

  final FinishDeliveryController controller = Get.find<FinishDeliveryController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isNoBorder
          ? null
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.lightGrey, width: 1),
            ),
      child: InkWell(
        onTap: () {
          if (!controller.cancelState.value) {
            controller.groupValue.value = groupValue;
          }
        },
        child: Row(
          children: [
            Obx(
              () => Radio<String>(
                value: groupValue,
                groupValue: controller.groupValue.value,
                onChanged: (value) {
                  if (!controller.cancelState.value) {
                    controller.groupValue.value = groupValue;
                  }
                  controller.clearMoney();
                },
                activeColor:
                    controller.cancelState.value || controller.successDeliveryFee.value ? Colors.grey : AppColor.red,
              ),
            ),
            4.width,
            Text(
              title,
              style: AppTextStyle.normalPrimaryRegular,
            ),
            const Expanded(child: SizedBox()),
            Obx(() {
              if (controller.groupValue.value == groupValue) {
                return Text(
                  '\$${controller.totalAmount}',
                  style: AppTextStyle.normalPrimaryRegular,
                );
              }
              return const SizedBox.shrink();
            }),
            UIConstants.spacing.width,
          ],
        ),
      ),
    );
  }
}
