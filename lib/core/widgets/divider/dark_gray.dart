import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class DarkGreyDivider extends StatelessWidget {
  const DarkGreyDivider({
    super.key,
    this.thickness,
    this.indent,
  });

  final double? thickness;
  final double? indent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: indent,
      height: 0,
      color: AppColor.divider,
      thickness: thickness ?? 1,
    );
  }
}
