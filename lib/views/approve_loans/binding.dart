import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class ApproveLoansBinding extends Bindings {
  @override
  void dependencies() {
    //   Get.lazyPut<ApproveLoansController>(
    //     () => ApproveLoansController(),
    //     fenix: true, // ← keeps controller alive, won't re-init on revisit
    //   );
    Get.lazyPut<ApproveLoansController>(() => ApproveLoansController());
  }
}
