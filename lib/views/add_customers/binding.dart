import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class AddCustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCustomersController>(() => AddCustomersController());
    Get.lazyPut<CoBorrowerController>(() => CoBorrowerController());
    Get.lazyPut<GuarantorController>(() => GuarantorController());
  }
}
