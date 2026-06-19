import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class StackTextField extends StatelessWidget {
  const StackTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.validator,
    this.suffixIcon,
    this.hintStyle = const TextStyle(color: AppColor.grey),
    this.maxLine = 2,
    this.errorText,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextStyle hintStyle;
  final int maxLine;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextField(
          controller: controller,
          hintText: hintText,
          validator: validator,
          suffixIcon: suffixIcon,
          maxLine: maxLine,
          errorText: errorText,
          readOnly: true,
        ),
        Positioned(
          child: Container(
            height: 48,
            width: double.infinity,
            color: AppColor.transparent,
          ),
        ),
      ],
    );
  }
}
