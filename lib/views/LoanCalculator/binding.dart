import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class LoanCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanCalculatorController>(() => LoanCalculatorController());
  }
}
