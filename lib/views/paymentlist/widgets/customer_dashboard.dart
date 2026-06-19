import 'package:apploan/views/dashboard/widgets/exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class CustomerDashboardView extends StatelessWidget {
  CustomerDashboardView({super.key, required this.dashboard});

  final DashboardModel dashboard;
  final DashboardController dashboardCtl = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: UIConstants.spacing.padHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TotalPackageWidget(packages: '${dashboard.totalPackage} ${LocaleKeys.packages.tr}'),
              TotalPackageWidget(
                title: LocaleKeys.numberOfDelivery.tr,
                icon: Icons.delivery_dining,
                packages: '${dashboard.totalPackage}',
              ),
            ],
          ),
        ),

        UIConstants.spacing.height,

        // Exchange rate
        Padding(
          padding: UIConstants.spacing.padHorizontal,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.exchangeRateToday.tr,
                style: AppTextStyle.midPrimarySemiBold,
              ),
              UIConstants.spacing.height,
              ExchangeRateWidget(exchangeRate: dashboard.rating),
            ],
          ),
        ),
        UIConstants.spacing.height,
      ],
    );
  }
}
