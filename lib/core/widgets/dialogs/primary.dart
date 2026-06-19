import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class PrimaryDialog extends StatelessWidget {
  const PrimaryDialog({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onPressed,
    this.btnText = 'CLOSE',
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String btnText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: AppColor.white,
      insetPadding: UIConstants.spacing.padHorizontal,
      shape: RoundedRectangleBorder(borderRadius: UIConstants.radius.radiusAll),
      child: Padding(
        padding: 20.padAll,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _closeIconWidget(),
            Text(
              title,
              style: AppTextStyle.mediumPrimarySemiBold,
            ),
            15.height,
            Text(
              subTitle,
              style: AppTextStyle.normalSecondaryRegular,
            ),
            30.height,
            PrimaryButton(
              text: btnText,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _closeIconWidget() {
    return const Row(
      children: [
        Spacer(),
        CloseIcon(),
      ],
    );
  }
}
