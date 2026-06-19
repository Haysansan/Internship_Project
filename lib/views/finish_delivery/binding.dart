import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class FinishDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinishDeliveryController>(() => FinishDeliveryController());
  }
}
