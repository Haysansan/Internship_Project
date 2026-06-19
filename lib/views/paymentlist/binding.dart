import 'package:get/get.dart';
import 'package:apploan/views/paymentlist/controller.dart';
import 'package:apploan/views/views.dart';

class PaymentCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentListController>(() => PaymentListController());
  }
}
