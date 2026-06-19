import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class CancelWidget extends StatelessWidget {
  CancelWidget({Key? key}) : super(key: key);

  final FinishDeliveryController finishDeliveryCtl = Get.find<FinishDeliveryController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIConstants.spacing.padHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'បោះបង់',
                    style: AppTextStyle.midPrimarySemiBold,
                    textAlign: TextAlign.center,
                  ),
                ),
                UIConstants.spacing.width,
                Obx(
                  () => Transform.scale(
                    scale: 1.1,
                    child: Checkbox(
                      activeColor: AppColor.red,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: finishDeliveryCtl.cancelState.value,
                      onChanged: (value) {
                        finishDeliveryCtl.cancelState.value = !finishDeliveryCtl.cancelState.value;
                        if (finishDeliveryCtl.cancelState.value) {
                          finishDeliveryCtl.successDeliveryFee.value = false;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          UIConstants.spacing.height,
          Obx(
            () => AbsorbPointer(
              absorbing: !finishDeliveryCtl.cancelState.value,
              child: CustomDropdown(
                hintText: '-- ជ្រើសរើស --',
                items: finishDeliveryCtl.reasons,
                onChanged: (value) {
                  finishDeliveryCtl.cancelCtl.text = value;
                  finishDeliveryCtl.reasonId = value;
                },
                color: finishDeliveryCtl.cancelState.value ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
