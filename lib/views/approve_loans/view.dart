import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';
import 'widgets/widgets.dart';

class ApproveLoansView extends GetView<ApproveLoansController> {
  const ApproveLoansView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final title =
          controller.isCEO
              ? (controller.selectedTab.value == 1
                  ? LocaleKeys.approveLoan.tr
                  : LocaleKeys.viewAllLoans.tr)
              : switch (controller.selectedTab.value) {
                1 => LocaleKeys.verifyLoan.tr,
                2 => LocaleKeys.disburseLoan.tr,
                _ => LocaleKeys.viewAllLoans.tr,
              };
      return Scaffold(
        // ← no Obx here
        appBar: CustomAppBar(
          title: title,
          onBack: () => Navigator.pop(context, false),
        ),
        body: Column(
          children: [
            // Tab buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Obx(
                () => // ← Obx only around tabs
                    controller.isCEO ? _buildCEOTabs() : _buildBMTabs(),
              ),
            ),

            // Filter by CO (replaces free-text search)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (controller.selectedOfficer.value == null) {
                      return const SizedBox();
                    }
                    return Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => controller.filterByOfficer(null),
                        child: Text(
                          'Clear',
                          style: AppTextStyle.normalRedBold,
                        ),
                      ),
                    );
                  }),
                  Obx(
                    () => SearchDropDown<String>(
                      items: controller.coNames,
                      itemAsString: (item) => item,
                      onChanged: controller.filterByOfficer,
                      selectedItem: controller.selectedOfficer.value,
                      label: 'Filter by CO',
                    ),
                  ),
                ],
              ),
            ),

            // Loan list
            Expanded(
              child: Obx(() {
                // ← Obx only around the list
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  );
                }
                final loans = controller.currentList;
                if (loans.isEmpty) {
                  return NoDataWidget(text: LocaleKeys.searchNotFound.tr);
                }
                return RefreshIndicator(
                  color: AppColor.primary,
                  onRefresh: controller.fetchLoans,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: loans.length,
                    itemBuilder: (context, index) {
                      if (controller.selectedTab.value == 0) {
                        return LoanSummaryCard(loan: loans[index]);
                      }
                      return LoanApprovalCard(
                        loan: loans[index],
                        controller: controller,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  // ── BM: 3 tabs ───
  Widget _buildBMTabs() {
    return Row(
      children: [
        ApproveTabButton(
          count: controller.allCount,
          label: LocaleKeys.viewAllLoans.tr,
          isSelected: controller.selectedTab.value == 0,
          onTap: () => controller.selectedTab.value = 0,
        ),
        const SizedBox(width: 8),
        ApproveTabButton(
          count: controller.verifyCount,
          label: LocaleKeys.verifyLoan.tr,
          isSelected: controller.selectedTab.value == 1,
          isAlert:
              controller.verifyCount > 0 && controller.selectedTab.value != 1,
          onTap: () => controller.selectedTab.value = 1,
        ),
        const SizedBox(width: 8),
        ApproveTabButton(
          count: controller.disbursementCount,
          label: LocaleKeys.disburseLoan.tr,
          isSelected: controller.selectedTab.value == 2,
          isAlert:
              controller.disbursementCount > 0 &&
              controller.selectedTab.value != 2,
          onTap: () => controller.selectedTab.value = 2,
        ),
      ],
    );
  }

  // ── CEO: 2 tabs ───
  Widget _buildCEOTabs() {
    return Row(
      children: [
        ApproveTabButton(
          count: controller.allCount,
          label: LocaleKeys.viewAllLoans.tr,
          isSelected: controller.selectedTab.value == 0,
          onTap: () => controller.selectedTab.value = 0,
        ),
        const SizedBox(width: 8),
        ApproveTabButton(
          count: controller.acceptCount,
          label: LocaleKeys.approveLoan.tr,
          isSelected: controller.selectedTab.value == 1,
          isAlert:
              controller.acceptCount > 0 && controller.selectedTab.value != 1,
          onTap: () => controller.selectedTab.value = 1,
        ),
      ],
    );
  }
}
