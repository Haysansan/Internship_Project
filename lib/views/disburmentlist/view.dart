import 'package:apploan/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class DisburmentListView extends GetView<DisburmentListController> {
  const DisburmentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.loanDisbursmentsList.tr,
        onBack: () => Get.offAllNamed(Routes.start),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SummarySection(),
            UIConstants.spacing.height,
            const _SearchSection(),
            UIConstants.spacing.height,
            _DisbursementList(
              items: controller.disburment,
              isDone: controller.isDone,
            ),
          ],
        );
      }),
    );
  }
}

// Summary card
class _SummarySection extends StatelessWidget {
  const _SummarySection();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DisburmentListController>();
    return Obx(() {
      if (c.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final totalClients = int.tryParse(c.totalClient.text) ?? 0;
      final totalAmount =
          double.tryParse(c.totalAmount.text.replaceAll(',', '')) ?? 0;

      final config = _buildConfig(
        user: UserRepository.shared,
        totalCount: totalClients,
        totalDisbursementUsd: totalAmount,
      );

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomSummaryCard(
          mode: SummaryCardMode.totalDisbursement,
          config: config,
        ),
      );
    });
  }

  SummaryCardConfig _buildConfig({
    required UserRepository user,
    required int totalCount,
    required double totalDisbursementUsd,
  }) {
    if (user.isCO) {
      return SummaryCardConfig.forCO(
        collectedClients: 0,
        totalClients: totalCount,
        totalRepaymentUsd: totalDisbursementUsd,
        collectedUsd: 0,
        onTap: () => Get.toNamed(Routes.customers),
      );
    }
    if (user.isBM) {
      return SummaryCardConfig.forBM(
        collectedCOs: 0,
        totalCOs: totalCount,
        totalRepaymentUsd: totalDisbursementUsd,
        collectedUsd: 0,
      );
    }
    // user.isEco
    return SummaryCardConfig.forCEO(
      collectedBMs: 0,
      totalBMs: totalCount,
      totalRepaymentUsd: totalDisbursementUsd,
      collectedUsd: 0,
    );
  }
}

// Search
class _SearchSection extends StatelessWidget {
  const _SearchSection();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<DisburmentListController>();
    return Padding(
      padding: UIConstants.spacing.padHorizontal,
      child: SearchField(
        controller: c.searchCtl,
        hintText: LocaleKeys.searchByCIDName.tr,
        onClear: () {
          c.clearFilter();
          c.filterByName();
        },
        onSubmitted: (_) => c.filterByName(),
      ),
    );
  }
}

// Disbursement list
class _DisbursementList extends StatelessWidget {
  const _DisbursementList({required this.items, required this.isDone});

  final List<DisbursementListModel> items;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    if (isDone && items.isEmpty) {
      return NoDataWidget(text: LocaleKeys.searchNotFound.tr);
    }
    return Expanded(
      child: ListView.builder(
        padding: UIConstants.spacing.padHorizontal,
        itemCount: items.length,
        itemBuilder:
            (context, index) => EndsChildWidget(tracking: items[index]),
      ),
    );
  }
}
