import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:intl/intl.dart';

class DatePicker {
  final TextEditingController controller;
  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final int minYear;
  final int maxYear;

  DatePicker({
    required this.controller,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
    required this.minYear,
    required this.maxYear,
  });

  void show() {
    if (GetPlatform.isAndroid) {
      _androidPicker();
    } else {
      _iosPicker();
    }
  }

  // void _androidPicker() async {
  //   final result = await showDatePicker(
  //     context: UserRepository.shared.context!,
  //     initialDate: initialDate,
  //     firstDate: minDate,
  //     lastDate: maxDate,
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(primary: AppColor.secondary),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (result == null) {
  //     controller.text = DateFormat('yyyy-MM-dd').format(initialDate);
  //     return;
  //   }
  //   controller.text = result.toString().split(' ')[0];
  // }
  void _androidPicker() async {
    final result = await showDatePicker(
      context: UserRepository.shared.context!,
      initialDate: initialDate,
      firstDate: minDate,
      lastDate: maxDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColor.secondary),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling, // reset scaler
            ),
            child: child!,
          ),
        );
      },
    );

    if (result == null) {
      controller.text = DateFormat('yyyy-MM-dd').format(initialDate);
      return;
    }
    controller.text = result.toString().split(' ')[0];
  }

  // void _iosPicker() async {
  //   await showCupertinoModalPopup(
  //     context: UserRepository.shared.context!,
  //     builder: (context) {
  //       return CupertinoActionSheet(
  //         actions: [_cupertinoAction()],
  //         cancelButton: CupertinoActionSheetAction(
  //           child: Text(
  //             LocaleKeys.done.tr,
  //             style: AppTextStyle.mediumRedSemiBold,
  //           ),
  //           onPressed: () {
  //             if (controller.text.isEmpty) {
  //               controller.text = DateFormat('yyyy-MM-dd').format(initialDate);
  //             }
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
  void _iosPicker() async {
    await showCupertinoModalPopup(
      context: UserRepository.shared.context!,
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: CupertinoActionSheet(
            actions: [_cupertinoAction()],
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                LocaleKeys.done.tr,
                style: AppTextStyle.mediumRedSemiBold,
              ),
              onPressed: () {
                if (controller.text.isEmpty) {
                  controller.text = DateFormat(
                    'yyyy-MM-dd',
                  ).format(initialDate);
                }
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  Widget _cupertinoAction() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: CupertinoDatePicker(
        initialDateTime: initialDate,
        minimumDate: minDate,
        maximumDate: maxDate,
        minimumYear: minYear,
        maximumYear: maxYear,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged:
            (date) => controller.text = date.toString().split(' ')[0],
      ),
    );
  }
}
