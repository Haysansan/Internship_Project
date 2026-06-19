import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class StaffWidget extends StatelessWidget {
  StaffWidget({Key? key}) : super(key: key);

  final FinishDeliveryController controller = Get.find<FinishDeliveryController>();
  final DashboardController dashboardCtl = DashboardController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.lightGrey, width: 1),
          ),
          child: Column(
            children: [
              CustomRadioWidget(
                isNoBorder: true,
                title: 'បុគ្គលិក',
                groupValue: 'staff',
              ),
              Obx(() {
                if (controller.groupValue.value == 'staff') {
                  return Padding(
                    padding: controller.groupValue.value != 'staff'
                        ? EdgeInsets.zero
                        : EdgeInsets.only(
                            bottom: UIConstants.spacing.toDouble(),
                            left: UIConstants.spacing.toDouble(),
                            right: UIConstants.spacing.toDouble(),
                          ),
                    child: Column(
                      children: [
                        _customTextField(
                          controller: controller.deliveryUsdCtl..text = controller.totalAmount.toString(),
                          hint: 'បញ្ចូលលុយដុល្លារ',
                          isUsd: true,
                          enable: false,
                          onChanged: (value) {
                            if (controller.groupValue.value != 'other') {
                              controller.deliveryRielCtl.text = calculatePricingToKhmerCurreny(
                                enterAmount: value,
                                paidAmount: controller.totalAmount.toDouble(),
                                rating: dashboardCtl.dashboardModel.value?.rating,
                              );
                            }
                          },
                        ),
                        12.height,
                        _customTextField(
                          controller: controller.deliveryRielCtl..text = '0',
                          hint: 'បញ្ចូលលុយខ្មែរ',
                          enable: false,
                          onChanged: (value) {
                            if (controller.groupValue.value != 'other' && controller.deliveryUsdCtl.text.isEmpty) {
                              controller.deliveryUsdCtl.text = calculatePricingToDollarCurrency(
                                enterAmount: value,
                                paidAmount: controller.totalAmount.toDouble(),
                                rating: dashboardCtl.dashboardModel.value?.rating,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              })
            ],
          ),
        ),
        Obx(() {
          if (controller.isStaffError.value) {
            return Padding(
              padding: 4.padTop,
              child: const Text(
                'ការបញ្ចូលទឹកប្រាក់មិនទាន់គ្រប់',
                style: AppTextStyle.normalRedRegular,
              ),
            );
          }
          return SizedBox.fromSize();
        })
      ],
    );
  }

  Widget _customTextField({
    required TextEditingController controller,
    required dynamic Function(String)? onChanged,
    required String hint,
    bool isUsd = false,
    bool enable = true,
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hint,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      validator: (text) => FormValidator.empty(text),
      filled: true,
      hintStyle: AppTextStyle.normalGreyRegular,
      enable: enable,
      suffixIcon: InkWell(
        onTap: () {},
        child: Image.asset(
          isUsd ? AssetPath.usd.path : AssetPath.riel.path,
          scale: 19,
          color: AppColor.red,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
