import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class TransferDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferDataController>(() => TransferDataController());
  }
}
