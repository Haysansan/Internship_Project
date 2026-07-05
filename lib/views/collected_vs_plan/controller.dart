import 'package:apploan/core/core.dart';
import 'package:apploan/models/collected_vs_plan/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CollectedVsPlanController extends GetxController {
  final RxBool isLoadingList = false.obs;
  final RxList<CollectedVsPlan> items = <CollectedVsPlan>[].obs;
  final Rx<String?> selectedCo = Rx<String?>(null);

  final TextEditingController startDateCtl = TextEditingController();
  final TextEditingController endDateCtl = TextEditingController();

  List<String> get coNames =>
      items.map((e) => e.coName).toSet().toList()..sort();

  List<CollectedVsPlan> get displayedItems => selectedCo.value == null
      ? items
      : items.where((e) => e.coName == selectedCo.value).toList();

  void filterByCo(String? name) => selectedCo.value = name;

  double get totalCollected => displayedItems.fold(0.0, (sum, e) => sum + e.collectedAmount);
  double get totalPlan => displayedItems.fold(0.0, (sum, e) => sum + e.planAmount);
  double get overallPercentage =>
      totalPlan > 0 ? (totalCollected / totalPlan * 100).clamp(0, 100) : 0;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    startDateCtl.text = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1));
    endDateCtl.text = DateFormat('yyyy-MM-dd').format(now);
    fetchData();
  }

  @override
  void onClose() {
    startDateCtl.dispose();
    endDateCtl.dispose();
    super.onClose();
  }

  DatePicker getStartDatePicker() => DatePicker(
    controller: startDateCtl,
    initialDate: startDateCtl.text.isEmpty
        ? DateTime.now()
        : DateTime.parse(startDateCtl.text),
    minDate: DateTime(DateTime.now().year - 10),
    maxDate: DateTime(DateTime.now().year + 1),
    minYear: DateTime.now().year - 10,
    maxYear: DateTime.now().year + 1,
  );

  DatePicker getEndDatePicker() => DatePicker(
    controller: endDateCtl,
    initialDate: endDateCtl.text.isEmpty
        ? DateTime.now()
        : DateTime.parse(endDateCtl.text),
    minDate: DateTime(DateTime.now().year - 10),
    maxDate: DateTime(DateTime.now().year + 1),
    minYear: DateTime.now().year - 10,
    maxYear: DateTime.now().year + 1,
  );

  Future<void> fetchData() async {
    isLoadingList.value = true;
    try {
      final branchId = await SharedPreferencesManager.getIntValue('branch_id');
      final userId = await SharedPreferencesManager.getIntValue('user_id');
      final permission = await SharedPreferencesManager.get('permission');

      final response = await Get.find<ApiService>().get(
        EndPoints.collectedVsPlan,
        queryParameters: {
          'branch_id': branchId,
          'user_id': userId,
          'permission': permission,
          'start_date': startDateCtl.text,
          'end_date': endDateCtl.text,
        },
        isShowLoading: false,
      );

      final List data = getPropertyFromJson(response.data, 'data') ?? [];
      items.value = data.map((e) => CollectedVsPlan.fromJson(e)).toList();
      selectedCo.value = null;
    } catch (e) {
      DialogManager.showDialog(
        title: LocaleKeys.error.tr,
        subTitle: LocaleKeys.syncFailed.tr,
        onPressed: () => Get.back(),
      );
    } finally {
      isLoadingList.value = false;
    }
  }
}
