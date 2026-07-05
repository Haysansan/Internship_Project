import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:get/get.dart';

class CashSummaryCoController extends GetxController {
  final RxBool isLoadingList = false.obs;
  final RxList<CoSummary> summaries = <CoSummary>[].obs;

  double get totalAmount =>
      summaries.fold(0.0, (sum, s) => sum + s.totalAmount);

  int get totalClients =>
      summaries.fold(0, (sum, s) => sum + s.totalClients);

  @override
  void onInit() {
    super.onInit();
    fetchSummary();
  }

  Future<int?> _getBranchId() async =>
      SharedPreferencesManager.getIntValue('branch_id');

  Future<int?> _getUserId() async =>
      SharedPreferencesManager.getIntValue('user_id');

  Future<String?> _getPermission() async =>
      await SharedPreferencesManager.get('permission');

  Future<void> fetchSummary() async {
    isLoadingList.value = true;
    try {
      final branchId = await _getBranchId();
      final userId = await _getUserId();
      final permission = await _getPermission();

      final isCEO = UserRepository.shared.isEco;
      final endpoint = isCEO
          ? EndPoints.outstandingSummaryByBM
          : EndPoints.cashSummaryCo;

      final response = await Get.find<ApiService>().get(
        endpoint,
        queryParameters: {
          'branch_id': branchId,
          'user_id': userId,
          'permission': permission,
        },
        isShowLoading: false,
      );

      final List data = getPropertyFromJson(response.data, 'data') ?? [];
      summaries.value = data.map((e) => CoSummary.fromJson(e)).toList();
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
