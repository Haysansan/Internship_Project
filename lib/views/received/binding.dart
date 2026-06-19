import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class ReceivedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceivedController>(() => ReceivedController());
  }
}
