import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class DashboardFilterDialog extends StatelessWidget {
  DashboardFilterDialog({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: AppColor.white,
      insetPadding: UIConstants.spacing.padHorizontal,
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
                LocaleKeys.filterDate.tr,
                style: AppTextStyle.mediumPrimaryBold,
              ),
              10.height,

              // Date
              InkWell(
                onTap: () {
                  controller.getDatePicker().show();
                },
                child: StackTextField(
                  controller: controller.dateCtl,
                  hintText: LocaleKeys.date.tr,
                  validator: (text) => FormValidator.empty(text),
                ),
              ),
              30.height,

              PrimaryButton(
                text: 'APPLY',
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
