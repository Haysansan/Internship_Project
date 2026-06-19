import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class ArrearLoanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArrearLoanController>(() => ArrearLoanController());
  }
}
