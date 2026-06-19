import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:apploan/core/core.dart';

class PrimarySwitch extends StatelessWidget {
  const PrimarySwitch({
    Key? key,
    required this.onToggle,
    required this.value,
    this.width = 70,
  }) : super(key: key);

  final void Function(bool) onToggle;
  final double width;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: width,
      height: 40.0,
      valueFontSize: 15.0,
      toggleSize: 25.0,
      value: value,
      borderRadius: 30.0,
      padding: 8.0,
      activeColor: AppColor.red,
      onToggle: onToggle,
    );
  }
}
