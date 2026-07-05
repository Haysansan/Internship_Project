import 'package:get/get.dart';
import 'controller.dart';

class EndOfDayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EndOfDayController());
  }
}
