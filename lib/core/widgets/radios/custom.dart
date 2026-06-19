import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class CustomRadio<T> extends StatelessWidget {
  const CustomRadio({
    Key? key,
    required this.title,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final dynamic groupValue;
  final T value;
  final Function(T value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UserRepository.shared.isTablet ? 32.padLeft : 16.padLeft,
      child: InkWell(
        onTap: () => onChanged(value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: AppColor.green,
              width: 0,
              child: Radio<T>(
                value: value,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value as T),
                activeColor: AppColor.red,
              ),
            ),
            20.width,
            Text(title, style: AppTextStyle.normalPrimaryRegular.copyWith(height: 0)),
          ],
        ),
      ),
    );
  }
}
