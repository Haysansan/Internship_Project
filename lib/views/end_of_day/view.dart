import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/end_of_day/model.dart';
import 'controller.dart';

class EndOfDayView extends GetView<EndOfDayController> {
  const EndOfDayView({Key? key}) : super(key: key);

  String _fmt(double v) => '៛${NumberFormat('#,##0').format(v)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'End Of Day'),
      body: Column(
        children: [
          // ── Red header with date filter ──────────────────────────
          Container(
            color: AppColor.primary,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SELECT DATE',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      const Icon(Icons.calendar_today_outlined, size: 16, color: AppColor.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.getDatePicker().show(),
                          behavior: HitTestBehavior.opaque,
                          child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: controller.dateCtl,
                            builder: (_, val, __) => Text(
                              val.text.isEmpty ? 'Select Date' : val.text,
                              style: TextStyle(
                                fontSize: 14,
                                color: val.text.isEmpty ? AppColor.grey : AppColor.primaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(width: 1, indent: 10, endIndent: 10),
                      IconButton(
                        onPressed: controller.fetchSummary,
                        icon: const Icon(Icons.search, color: AppColor.grey, size: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Body ─────────────────────────────────────────────────
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return RefreshIndicator(
                onRefresh: controller.fetchSummary,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                  children: [
                    _dateHeader(),
                    const SizedBox(height: 12),

                    // 1. Cash by BM
                    _SectionCard(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Cash by BM',
                      child: Obx(() {
                        if (controller.cashByBm.isEmpty) return _emptyRow();
                        return Column(
                          children: [
                            ...controller.cashByBm.map((bm) => _rowItem(bm.bmName, _fmt(bm.amount))),
                            const Divider(height: 16),
                            _rowItem('Total', _fmt(controller.totalCashByBm), bold: true),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 10),

                    // // 2. Total Cash Collect
                    // _SectionCard(
                    //   icon: Icons.payments_outlined,
                    //   title: 'Total Cash Collect',
                    //   child: Obx(() => _rowItem(
                    //     'Total Collected',
                    //     _fmt(controller.totalCashCollect.value),
                    //     bold: true,
                    //     valueColor: Colors.green.shade700,
                    //   )),
                    // ),
                    // const SizedBox(height: 10),

                    // 3. List Expense
                    _SectionCard(
                      icon: Icons.receipt_long_outlined,
                      title: 'List Expense',
                      child: Obx(() {
                        if (controller.expenses.isEmpty) return _emptyRow();
                        return Column(
                          children: [
                            ...controller.expenses.map((e) => _rowItem(e.description, _fmt(e.amount))),
                            const Divider(height: 16),
                            _rowItem('Total Expense', _fmt(controller.totalExpense), bold: true, valueColor: Colors.red.shade600),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 10),

                    // 4. Total Client Disbursement
                    _SectionCard(
                      icon: Icons.credit_card_outlined,
                      title: 'Total Client Disbursement',
                      child: Obx(() => Column(
                        children: [
                          _rowItem('Total Clients', '${controller.totalClientDisbursed.value}'),
                          _rowItem('Total Amount', _fmt(controller.totalAmountDisbursed.value), bold: true),
                        ],
                      )),
                    ),
                    const SizedBox(height: 10),

                    // 5. Total Client Collect
                    _SectionCard(
                      icon: Icons.people_alt_outlined,
                      title: 'Total Client Collect',
                      child: Obx(() => Column(
                        children: [
                          _rowItem('Total Clients', '${controller.totalClientCollected.value}'),
                          _rowItem('Total Amount', _fmt(controller.totalAmountCollected.value), bold: true),
                        ],
                      )),
                    ),
                    const SizedBox(height: 10),

                    // 6. Plan vs Collected
                    _SectionCard(
                      icon: Icons.bar_chart_rounded,
                      title: 'Plan vs Collected',
                      child: Obx(() {
                        final rate = controller.collectionRate.value.clamp(0.0, 100.0);
                        final color = rate >= 100 ? Colors.green : (rate >= 70 ? Colors.orange : Colors.red);
                        return Column(
                          children: [
                            _rowItem('Total Clients', '${controller.planClientCount.value}'),
                            _rowItem('Plan Amount', _fmt(controller.totalPlanCollect.value)),
                            _rowItem('Collected', _fmt(controller.collectedPlanAmount.value), valueColor: Colors.green.shade700),
                            _rowItem('Uncollected', _fmt(controller.uncollectedAmount.value), valueColor: Colors.red.shade600),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: rate / 100,
                                minHeight: 8,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(color),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${rate.toStringAsFixed(1)}%',
                                style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 10),

                    // 7. Cash CEO
                    _SectionCard(
                      icon: Icons.account_balance_outlined,
                      title: 'Cash CEO',
                      child: Obx(() => _rowItem(
                        'Cash on Hand',
                        _fmt(controller.cashCeo.value),
                        bold: true,
                        valueColor: AppColor.primary,
                      )),
                    ),
                    const SizedBox(height: 24),

                    // Confirm button
                    Obx(() {
                      final canSubmit = controller.eodEnabled.value && !controller.isSubmitting.value;
                      return Column(
                        children: [
                          if (!controller.eodEnabled.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.lock_outline, size: 14, color: Colors.orange),
                                  SizedBox(width: 6),
                                  Text(
                                    'End of day already closed',
                                    style: TextStyle(color: Colors.orange, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          PrimaryButton(
                            text: 'Confirm End Of Day',
                            onPressed: canSubmit ? controller.confirmEndOfDay : null,
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _dateHeader() {
    final now = DateTime.now();
    final date = DateFormat('EEEE, dd MMMM yyyy').format(now);
    return Row(
      children: [
        const Icon(Icons.nights_stay_outlined, size: 18, color: AppColor.hardOrange),
        const SizedBox(width: 8),
        Text(date, style: AppTextStyle.normalPrimaryBold),
      ],
    );
  }

  Widget _rowItem(String label, String value, {bool bold = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyle.normalGreyRegular),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ?? AppColor.primaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyRow() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Center(child: Text('No data', style: AppTextStyle.smallGreyRegular)),
  );
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _SectionCard({required this.icon, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: AppColor.primary),
              ),
              const SizedBox(width: 10),
              Text(title, style: AppTextStyle.normalPrimaryBold),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
