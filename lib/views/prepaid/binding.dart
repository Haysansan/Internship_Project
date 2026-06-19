import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class PrePaidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrePaidController>(() => PrePaidController());
  }
}
