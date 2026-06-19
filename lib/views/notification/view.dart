import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.notification.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const DarkGreyDivider(indent: 25);
        },
        padding: EdgeInsets.only(
          left: UIConstants.spacing.toDouble(),
          right: UIConstants.spacing.toDouble(),
          top: UIConstants.spacing.toDouble(),
          bottom: UIConstants.midSpacing.toDouble(),
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: UIConstants.midSpacing.padBottom,
            child: const NotificationItemWidget(),
          );
        },
      ),
    );
  }
}
