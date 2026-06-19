import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class WrittenoffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WrittenoffController>(() => WrittenoffController());
  }
}
