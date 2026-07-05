import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/collected_vs_plan/model.dart';
import 'controller.dart';

class CollectedVsPlanView extends GetView<CollectedVsPlanController> {
  const CollectedVsPlanView({super.key});

  String _fmt(double amount) => NumberFormat('#,##0.##').format(amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Collected vs Plan',
        onBack: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          // Filter card
          Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date range row
                Row(
                  children: [
                    const Icon(Icons.date_range, size: 16, color: AppColor.primary),
                    const SizedBox(width: 6),
                    Text('Date Range', style: AppTextStyle.normalPrimaryBold),
                  ],
                ),
                // const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.getStartDatePicker().show(),
                        child: StackTextField(
                          controller: controller.startDateCtl,
                          hintText: 'Start Date',
                          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16, color: AppColor.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.getEndDatePicker().show(),
                        child: StackTextField(
                          controller: controller.endDateCtl,
                          hintText: 'End Date',
                          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16, color: AppColor.grey),
                        ),
                      ),
                    ),
                  ],
                ),

                // const SizedBox(height: 10),
                // const Divider(height: 1),
                // const SizedBox(height: 10),

                // CO filter row
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 16, color: AppColor.primary),
                    const SizedBox(width: 6),
                    Text('Filter by CO', style: AppTextStyle.normalPrimaryBold),
                  ],
                ),
                 const SizedBox(height: 8),
                Obx(
                  () => SearchDropDown<String>(
                    items: controller.coNames,
                    itemAsString: (item) => item,
                    onChanged: controller.filterByCo,
                    selectedItem: controller.selectedCo.value,
                    label: 'Select CO',
                    showClearButton: true,
                  ),
                ),

                const SizedBox(height: 10),

                // Search button + result count
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: controller.fetchData,
                          icon: const Icon(Icons.search, color: Colors.white, size: 18),
                          label: Text('Search', style: AppTextStyle.normalWhiteBold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(() {
                      final count = controller.displayedItems.length;
                      final isFiltered = controller.selectedCo.value != null;
                      if (!isFiltered) return const SizedBox.shrink();
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.primary.withOpacity(0.3)),
                        ),
                        child: Text(
                          '$count result${count != 1 ? 's' : ''}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColor.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoadingList.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.displayedItems.isEmpty) {
                return const Center(child: Text('No data'));
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColor.primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Collected', style: AppTextStyle.normalWhiteRegular),
                              const SizedBox(height: 4),
                              Text('៛${_fmt(controller.totalCollected)}', style: AppTextStyle.normalWhiteBold),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Total Plan', style: AppTextStyle.normalWhiteRegular),
                              const SizedBox(height: 4),
                              Text('៛${_fmt(controller.totalPlan)}', style: AppTextStyle.normalWhiteBold),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: controller.fetchData,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: controller.displayedItems.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, i) => _CollectedVsPlanCard(item: controller.displayedItems[i]),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _CollectedVsPlanCard extends StatelessWidget {
  final CollectedVsPlan item;
  const _CollectedVsPlanCard({required this.item});

  String _fmt(double v) => NumberFormat('#,##0.##').format(v);

  @override
  Widget build(BuildContext context) {
    final pct = item.percentage;
    final color = pct >= 100 ? Colors.green : (pct >= 70 ? Colors.orange : Colors.red);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 20, child: Icon(Icons.person, size: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.coName, style: AppTextStyle.normalPrimaryBold),
                    Text(item.branchName, style: AppTextStyle.smallGreyRegular),
                  ],
                ),
              ),
              Text(
                '${pct.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct / 100,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Collected: ៛${_fmt(item.collectedAmount)}', style: AppTextStyle.smallGreyRegular),
              Text('Plan: ៛${_fmt(item.planAmount)}', style: AppTextStyle.smallGreyRegular),
            ],
          ),
        ],
      ),
    );
  }
}
