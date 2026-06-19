import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class PayfoeachotherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayfoeachotherController>(() => PayfoeachotherController());
  }
}
