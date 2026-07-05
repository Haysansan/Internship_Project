import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class StartOfDayController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isChecking = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkEodStatus();
  }


  Future<void> checkEodStatus() async {
    try {
      isChecking.value = true;
      final userId = await SharedPreferencesManager.getIntValue('user_id');
      final branchId = SharedPreferencesManager.getIntValue('branch_id');
      final res = await Get.find<ApiService>().get(
        EndPoints.checkEndOfDay,
        queryParameters: {'user_id': userId,'branch_id':branchId},
        isShowLoading: false,
      );

      final eodEnable = res.data['eod_enable'] ??
          getPropertyFromJson(res.data, 'data')?['eod_enable'] ??
          0;

      final val = eodEnable is int ? eodEnable : int.tryParse('$eodEnable') ?? 0;
      await SharedPreferencesManager.setValue('eod_enable', val);
      UserRepository.shared.setEodEnabled(val);
    } catch (e) {
      if (isClosed) return;
      ExceptionHandler.handleException(e);
    } finally {
      isChecking.value = false;
    }
  }

  Future<void> submit() async {
    isLoading.value = true;
    try {
      final userId = await SharedPreferencesManager.getIntValue('user_id');
      await Get.find<ApiService>().post(
        EndPoints.startOfDay,
        {'user_id': userId},
        isShowLoading: true,
      );

      // after successful start, mark EOD as open (eod_enable=0)
      await SharedPreferencesManager.setValue('eod_enable', 0);
      UserRepository.shared.setEodEnabled(0);

      DialogManager.showDialog(
        title: LocaleKeys.successfully.tr,
        subTitle: 'Start of day completed.',
        onPressed: () => Get.back(),
      );
    } catch (e) {
      ExceptionHandler.handleException(e);
    } finally {
      isLoading.value = false;
    }
  }
}
