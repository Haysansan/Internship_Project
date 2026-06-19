import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius.radiusAll),
      disabledColor: Colors.blue[200],
      onPressed: onPressed,
      elevation: elevation,
      child: Text(
        text,
        style: AppTextStyle.normalWhiteBold,
      ),
    );
  }
}
