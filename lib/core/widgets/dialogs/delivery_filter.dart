import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class DeliveryFilterDialog extends StatelessWidget {
  DeliveryFilterDialog({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RepaymentController deliveryCtl = Get.find<RepaymentController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      elevation: 0,
      insetPadding: UIConstants.spacing.padAll,
      shape: RoundedRectangleBorder(borderRadius: UIConstants.radius.radiusAll),
      child: Padding(
        padding: 20.padAll,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.filterDelivery.tr,
                style: AppTextStyle.mediumPrimaryBold,
              ),

              12.height,

              // Start bill create
              Text(LocaleKeys.startBillcreate.tr),
              InkWell(
                onTap: () {},
                child: StackTextField(
                  controller: deliveryCtl.startBillCreateDateCtl,
                  hintText: LocaleKeys.date.tr,
                ),
              ),
              12.height,

              // End bill create
              Text(LocaleKeys.endBillCreate.tr),
              InkWell(
                onTap: () {},
                child: StackTextField(
                  controller: deliveryCtl.endBillCreateDateCtl,
                  hintText: LocaleKeys.date.tr,
                ),
              ),
              12.height,

              // Start bill finish
              Text(LocaleKeys.endBillFinish.tr),
              InkWell(
                onTap: () {
                  deliveryCtl.startBillCreateDateCtl.clear();
                  deliveryCtl.endBillCreateDateCtl.clear();
                },
                child: StackTextField(hintText: LocaleKeys.startBillFinish.tr),
              ),
              12.height,

              // End bill finish
              Text(LocaleKeys.startBillFinish.tr),
              InkWell(
                onTap: () {
                  deliveryCtl.startBillCreateDateCtl.clear();
                  deliveryCtl.endBillCreateDateCtl.clear();
                },
                child: StackTextField(hintText: LocaleKeys.endBillFinish.tr),
              ),
              12.height,

              Row(
                children: [
                  Expanded(
                    child: OutlinedButtonWidget(
                      width: null,
                      text: 'RESET',
                      onPressed: () async {
                        Get.back();
                        deliveryCtl.clearFilter();
                        // deliveryCtl.fetchDelivery(isFilter: true, isRefresh: true);
                      },
                    ),
                  ),
                  8.width,
                  Expanded(
                    child: PrimaryButton(
                      width: null,
                      text: 'APPLY',
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        Get.back();
                        deliveryCtl.setFilterValue();
                        // deliveryCtl.fetchDelivery(isRefresh: true, isFilter: true);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
