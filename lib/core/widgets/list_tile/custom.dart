import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.text,
    this.leadingIconData,
    this.trillingIconData,
    this.onTap,
  }) : super(key: key);

  final String text;
  final IconData? leadingIconData;
  final IconData? trillingIconData;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: AppTextStyle.midWhiteRegular,
      ),
      leading: Icon(leadingIconData, color: AppColor.white),
      trailing: Icon(trillingIconData, size: 17, color: AppColor.white),
      minLeadingWidth: 10,
      visualDensity: const VisualDensity(vertical: -2),
      onTap: onTap,
    );
  }
}
