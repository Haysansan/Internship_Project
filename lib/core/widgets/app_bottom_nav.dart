import 'package:apploan/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNav extends StatelessWidget {
  final List<Widget> items;

  const AppBottomNav({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      surfaceTintColor: AppColor.red,
      height: 70,
      color: AppColor.white,
      padding: 4.padHorizontal,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      ),
    );
  }
}
