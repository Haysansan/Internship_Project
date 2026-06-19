import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class RepaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepaymentController>(() => RepaymentController());
  }
}
