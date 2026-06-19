import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class DateFilterDialog extends StatelessWidget {
  DateFilterDialog({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PaymentListController paymentCtl = Get.find<PaymentListController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      elevation: 0,
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

              // Start date
              30.height,

              PrimaryButton(
                text: 'APPLY',
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  Get.back();
                  if (UserRepository.shared.isCO) {
                    return;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
