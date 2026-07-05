import 'package:get/get.dart';
import 'controller.dart';

class EditCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditCustomerController>(() => EditCustomerController());
  }
}
