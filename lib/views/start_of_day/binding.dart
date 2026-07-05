import 'package:get/get.dart';
import 'controller.dart';

class StartOfDayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartOfDayController());
  }
}
