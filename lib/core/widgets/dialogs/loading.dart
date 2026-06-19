import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: 32.padAll,
      elevation: 1,
      child: Container(
        padding: 16.padVertical,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: UIConstants.radius.radiusAll,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColor.primary),
            16.height,
            Text(
              'Loading ...',
              style: AppTextStyle.midPrimaryBold.copyWith(height: 0),
            ),
          ],
        ),
      ),
    );
  }
}
