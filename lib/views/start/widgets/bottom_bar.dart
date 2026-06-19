import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: UserRepository.shared.isCO ? 85 : 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColor.primary : AppColor.black,
              size: 20,
            ),
            4.height,
            Text(
              label,
              style:
                  isSelected
                      ? AppTextStyle.smallRedRegular
                      : AppTextStyle.smallPrimaryRegular,
            ),
          ],
        ),
      ),
    );
  }
}
