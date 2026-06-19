import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class PaidOffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaidOffController>(() => PaidOffController());
  }
}
