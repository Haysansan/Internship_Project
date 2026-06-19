import 'package:apploan/core/configs/app_style.dart';
import 'package:apploan/core/extensions/int.dart';
import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  const LabeledField({
    super.key,
    required this.label,
    required this.child,
    this.required = false,
  });

  final String label;
  final Widget child;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: AppTextStyle.normalPrimaryRegular,
            children:
                required
                    ? const [
                      TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
                    ]
                    : [],
          ),
        ),
        4.height,
        child,
      ],
    );
  }
}
