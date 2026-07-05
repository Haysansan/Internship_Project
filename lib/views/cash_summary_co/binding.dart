import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class CashSummaryCoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashSummaryCoController>(() => CashSummaryCoController());
  }
}
