import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text ?? 'No Data',
        style: AppTextStyle.mediumPrimaryBold,
      ),
    );
  }
}
