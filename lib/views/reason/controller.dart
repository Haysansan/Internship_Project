import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';

class ReasonController extends GetxController {
  final RxList<ReasonModel> reasonModel = <ReasonModel>[].obs;

  Future<void> fetchReason() async {
    try {
      final res = await Get.find<ApiService>().get(EndPoints.reason);
      final data = getPropertyFromJson(res.data, 'data');
      reasonModel.value = List<ReasonModel>.from(
        (data as List).map((e) => ReasonModel.fromJson(e)).toList(),
      );
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    }
  }
}
