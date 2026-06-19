import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';
import 'package:apploan/routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;
import 'package:intl/intl.dart';

class WrittenoffView extends GetView<WrittenoffController> {
  const WrittenoffView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.writtenoff.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      bottomNavigationBar: AppBottomNav(items: controller.getItems()),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.red),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SummarySection(),
            Padding(
              padding: UIConstants.spacing.padHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIConstants.spacing.height,
                  SearchField(
                    controller: controller.searchCtl,
                    hintText: LocaleKeys.searchByCIDName.tr,
                    onClear: controller.clearSearch,
                    onSubmitted: controller.searchLocally,
                  ),
                ],
              ),
            ),
            if (controller.repaymentModel.isEmpty)
              const Expanded(child: NoDataWidget())
            else
              Expanded(
                child: RefreshIndicator(
                  backgroundColor: AppColor.white,
                  color: AppColor.primary,
                  onRefresh: controller.onRefresh,
                  child: pull.SmartRefresher(
                    header: pull.CustomHeader(
                      height: 0,
                      builder: (context, mode) => const SizedBox.shrink(),
                    ),
                    enablePullUp: !controller.pagination.isEndOfPage,
                    controller: controller.refreshCtl,
                    onLoading: controller.onLoading,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        left: UIConstants.spacing.toDouble(),
                        right: UIConstants.spacing.toDouble(),
                      ),
                      itemCount: controller.repaymentModel.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: UIConstants.spacing.padBottom,
                          child: WrittenoffWidget(
                            woLoan: controller.repaymentModel[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  String formatCurrency(String amount) {
    // ignore: unnecessary_null_comparison
    return amount != null
        ? 'រៀល ${NumberFormat.currency(locale: 'en_US', symbol: '').format(double.parse(amount))}'
            .replaceAll('.00', '')
        : 'N/A';
  }
}

// Summary card
class _SummarySection extends StatelessWidget {
  const _SummarySection();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<WrittenoffController>();
    return Obx(() {
      if (c.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final totalCount = c.totalclient.toInt();
      final totalAmount = c.total.toDouble();

      final config = _buildConfig(
        user: UserRepository.shared,
        totalCount: totalCount,
        totalAmount: totalAmount,
      );

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomSummaryCard(
          mode: SummaryCardMode.totalRepayment,
          config: config,
        ),
      );
    });
  }

  SummaryCardConfig _buildConfig({
    required UserRepository user,
    required int totalCount,
    required double totalAmount,
  }) {
    if (user.isCO) {
      return SummaryCardConfig.forCO(
        collectedClients: totalCount,
        totalClients: totalCount,
        totalRepaymentUsd: totalAmount,
        collectedUsd: totalAmount,
        onTap: () => Get.toNamed(Routes.customers),
      );
    }
    if (user.isBM) {
      return SummaryCardConfig.forBM(
        collectedCOs: totalCount,
        totalCOs: totalCount,
        totalRepaymentUsd: totalAmount,
        collectedUsd: totalAmount,
      );
    }
    // user.isEco
    return SummaryCardConfig.forCEO(
      collectedBMs: totalCount,
      totalBMs: totalCount,
      totalRepaymentUsd: totalAmount,
      collectedUsd: totalAmount,
    );
  }
}
