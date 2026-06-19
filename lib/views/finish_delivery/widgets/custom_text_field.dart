import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class TextField extends StatelessWidget {
  const TextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final dynamic Function(String)? onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hint,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      validator: (text) => FormValidator.empty(text),
      filled: true,
      suffixIcon: InkWell(
        onTap: () {},
        child: Image.asset(
          AssetPath.usd.path,
          scale: 19,
          color: AppColor.red,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
