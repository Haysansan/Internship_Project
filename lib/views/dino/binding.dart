import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class DinoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DinoController>(() => DinoController());
  }
}
