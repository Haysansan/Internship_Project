import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class CustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(() => CustomersController());
  }
}
