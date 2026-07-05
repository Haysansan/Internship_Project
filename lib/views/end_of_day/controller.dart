import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/end_of_day/model.dart';

class EndOfDayController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  RxBool get eodEnabled => UserRepository.shared.eodEnabled;
  final TextEditingController dateCtl = TextEditingController();

  final RxList<BmCashItem> cashByBm = <BmCashItem>[].obs;
  final RxDouble totalCashCollect = 0.0.obs;
  final RxList<ExpenseItem> expenses = <ExpenseItem>[].obs;
  final RxDouble totalExpensesAmount = 0.0.obs;

  // disbursement
  final RxInt totalClientDisbursed = 0.obs;
  final RxDouble totalAmountDisbursed = 0.0.obs;

  // collection
  final RxInt totalClientCollected = 0.obs;
  final RxDouble totalAmountCollected = 0.0.obs;

  // plan_vs_collected
  final RxInt planClientCount = 0.obs;
  final RxDouble totalPlanCollect = 0.0.obs;
  final RxDouble collectedPlanAmount = 0.0.obs;
  final RxDouble uncollectedAmount = 0.0.obs;
  final RxDouble collectionRate = 0.0.obs;

  final RxDouble cashCeo = 0.0.obs;

  double get totalCashByBm => cashByBm.fold(0.0, (s, e) => s + e.amount);
  double get totalExpense => expenses.isNotEmpty
      ? expenses.fold(0.0, (s, e) => s + e.amount)
      : totalExpensesAmount.value;

  @override
  void onInit() {
    super.onInit();
    dateCtl.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    fetchSummary();
  }

  @override
  void onClose() {
    dateCtl.dispose();
    super.onClose();
  }

  DatePicker getDatePicker() => DatePicker(
    controller: dateCtl,
    initialDate: dateCtl.text.isEmpty ? DateTime.now() : DateTime.parse(dateCtl.text),
    minDate: DateTime(DateTime.now().year - 10),
    maxDate: DateTime(DateTime.now().year + 1),
    minYear: DateTime.now().year - 10,
    maxYear: DateTime.now().year + 1,
  );

  Future<Map<String, dynamic>> _baseParams() async {
    final branchId = await SharedPreferencesManager.getIntValue('branch_id');
    final userId = await SharedPreferencesManager.getIntValue('user_id');
    final permission = await SharedPreferencesManager.get('permission');
    return {'branch_id': branchId, 'user_id': userId, 'permission': permission, 'date': dateCtl.text};
  }

  Future<void> fetchSummary() async {
    isLoading.value = true;
    try {
      final params = await _baseParams();
      final api = Get.find<ApiService>();

      final results = await Future.wait([
        api.get(EndPoints.endOfDaySummary, queryParameters: params, isShowLoading: false),
        api.get(EndPoints.endOfDayExpenses, queryParameters: params, isShowLoading: false),
      ]);

      // Summary — no 'data' wrapper, fields are at root level
      final s = results[0].data as Map<String, dynamic>? ?? {};

      // cash_by_bm can be a List or { data: [...], total: N }
      final bmRaw = s['cash_by_bm'];
      final bmList = bmRaw is List
          ? bmRaw
          : (bmRaw is Map ? (bmRaw['data'] as List? ?? []) : []);
      cashByBm.value = bmList.map((e) => BmCashItem.fromJson(e as Map<String, dynamic>)).toList();

      totalCashCollect.value = _toDouble(s['total_cash_collect']);

      // disbursement → { client_count, total_amount }
      final disb = s['disbursement'] as Map<String, dynamic>? ?? {};
      totalClientDisbursed.value = _toInt(disb['client_count']);
      totalAmountDisbursed.value = _toDouble(disb['total_amount']);

      // collection → { client_count, total_collected }
      final col = s['collection'] as Map<String, dynamic>? ?? {};
      totalClientCollected.value = _toInt(col['client_count']);
      totalAmountCollected.value = _toDouble(col['total_collected']);

      // plan_vs_collected → { client_count, plan_amount, collected_amount, uncollected_amount, collection_rate }
      final pvc = s['plan_vs_collected'] as Map<String, dynamic>? ?? {};
      planClientCount.value = _toInt(pvc['client_count']);
      totalPlanCollect.value = _toDouble(pvc['plan_amount']);
      collectedPlanAmount.value = _toDouble(pvc['collected_amount']);
      uncollectedAmount.value = _toDouble(pvc['uncollected_amount']);
      collectionRate.value = _toDouble(pvc['collection_rate']);

      cashCeo.value = _toDouble(s['cash_ceo']);

      // expenses → { data: [...], total: 0 } — also in summary but keep separate call for detail
      final expList = getPropertyFromJson(results[1].data, 'data') as List? ?? [];
      expenses.value = expList.map((e) => ExpenseItem.fromJson(e)).toList();
      totalExpensesAmount.value = _toDouble((s['expenses'] as Map?)?['total']);
    } catch (e) {
      ExceptionHandler.handleException(e);
    } finally {
      isLoading.value = false;
    }
  }

  static double _toDouble(dynamic v) => double.tryParse(v?.toString() ?? '') ?? 0.0;
  static int _toInt(dynamic v) => int.tryParse(v?.toString() ?? '') ?? 0;

  Future<void> confirmEndOfDay() async {
    isSubmitting.value = true;
    try {
      final params = await _baseParams();
      await Get.find<ApiService>().post(
        EndPoints.storeEndOfDay,
        params,
        isShowLoading: true,
        retries: 0,
      );
      DialogManager.showDialog(
        title: LocaleKeys.successfully.tr,
        subTitle: 'End of day completed successfully.',
        onPressed: () => Get.back(),
      );
    } catch (e) {
      ExceptionHandler.handleException(e);
    } finally {
      isSubmitting.value = false;
    }
  }
}
