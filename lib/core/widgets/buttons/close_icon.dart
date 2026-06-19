import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.grey,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
