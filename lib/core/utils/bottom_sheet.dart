import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class BottomSheetManager {
  static Future custom({required Widget content}) {
    final BuildContext context = UserRepository.shared.context!;
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      backgroundColor: AppColor.white,
      isDismissible: true,
      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return Padding(
          //padding: 18.padAll,
          padding: EdgeInsets.only(
            top: 18.padAll.top,
            left: 18.padAll.left,
            right: 18.padAll.right,
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
          ),
          child: Stack(
            children: [
              content,
              const Positioned(
                right: 0,
                top: 0,
                child: CloseIcon(),
              ),
            ],
          ),
        );
      },
    );
  }
}
