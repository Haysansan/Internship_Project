import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

Decoration customDecoration({Color color = AppColor.white}) {
  return BoxDecoration(
    borderRadius: UIConstants.radius.radiusAll,
    color: color,
    boxShadow: [
      BoxShadow(
        color: AppColor.grey.withOpacity(0.5),
        spreadRadius: 0,
        blurRadius: 1,
        offset: const Offset(0, 0),
      ),
    ],
  );
}
