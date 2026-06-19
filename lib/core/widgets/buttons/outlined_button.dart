import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppColor.primaryBtn,
    this.borderRadius = UIConstants.radius,
    this.elevation = 0,
    this.width = double.infinity,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final int borderRadius;
  final double elevation;
  final Color bgColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      height: UIConstants.btnHeight,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius.radiusAll,
        side: const BorderSide(
          color: AppColor.red,
          width: .5,
        ),
      ),
      disabledColor: Colors.blue[200],
      onPressed: onPressed,
      elevation: elevation,
      child: Text(
        text,
        style: AppTextStyle.normalPrimaryBold,
      ),
    );
  }
}
