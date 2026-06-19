import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class CustomerRejecteWidget extends StatelessWidget {
  CustomerRejecteWidget({Key? key}) : super(key: key);

  final FinishDeliveryController controller = Get.find<FinishDeliveryController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIConstants.spacing.padHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
            child: Row(children: [
              const Text(
                'ដឹកដល់ទីតាំងតែអត់យក',
                style: AppTextStyle.midPrimarySemiBold,
              ),
              UIConstants.spacing.width,
              Obx(
                () => Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    value: controller.successDeliveryFee.value,
                    activeColor: AppColor.red,
                    onChanged: (value) {
                      controller.clearMoney();
                      controller.successDeliveryFee.value = !controller.successDeliveryFee.value;
                      if (controller.successDeliveryFee.value) {
                        controller.cancelState.value = false;
                      }
                    },
                  ),
                ),
              ),
            ]),
          ),
          Obx(
            () => Visibility(
              visible: controller.successDeliveryFee.value,
              child: Container(
                margin: UIConstants.spacing.padTop,
                padding: 8.padHorizontal,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.lightGrey, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRadio(
                      title: 'គិតពីហាង',
                      groupValue: controller.payType.value,
                      value: 'shop',
                      onChanged: (value) {
                        controller.payType.value = 'shop';
                      },
                    ),
                    const Spacer(),
                    CustomRadio(
                      title: 'គិតពីអតិថិជន',
                      groupValue: controller.payType.value,
                      value: 'customer',
                      onChanged: (value) {
                        controller.payType.value = 'customer';
                      },
                    ),
                    8.width,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
