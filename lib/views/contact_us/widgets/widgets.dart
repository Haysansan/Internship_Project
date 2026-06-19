import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class ContactItemWidget extends StatelessWidget {
  const ContactItemWidget({
    Key? key,
    required this.icons,
    required this.label,
  }) : super(key: key);

  final IconData icons;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icons,
          color: AppColor.red,
          size: 30,
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Text(
            label,
            style: AppTextStyle.normalPrimaryRegular,
          ),
        )
      ],
    );
  }
}
