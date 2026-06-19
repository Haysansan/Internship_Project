import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class LoanDisbursmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoanDisbursmentsController());
  }
}
