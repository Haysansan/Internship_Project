import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: AppColor.red,
        child: Icon(
          icon,
          color: AppColor.white,
        ),
      ),
    );
  }
}
