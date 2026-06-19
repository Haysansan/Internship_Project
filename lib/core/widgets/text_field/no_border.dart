import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class NoBorderTextField extends StatelessWidget {
  const NoBorderTextField({
    Key? key,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.hintText,
    this.controller,
  }) : super(key: key);

  final bool obscureText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        errorStyle: AppTextStyle.smallRedRegular,
        prefixIcon: prefixIcon,
        prefixIconColor: AppColor.primaryText,
        suffixIconColor: AppColor.primaryText,
        suffixIcon: suffixIcon,
        hintText: hintText,
        fillColor: AppColor.white,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.grey,
            width: 1,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.grey,
            width: 1,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.grey,
            width: 1,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.red),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
