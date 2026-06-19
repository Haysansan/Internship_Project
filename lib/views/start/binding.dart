import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/paymentlist/controller.dart';
import 'package:apploan/views/views.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartController>(() => StartController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<PaymentListController>(() => PaymentListController());
    Get.lazyPut<DisburmentListController>(() => DisburmentListController());
    Get.lazyPut<PaidOffController>(() => PaidOffController());
    Get.lazyPut<ReasonController>(() => ReasonController());
    Get.put<ApproveLoansController>(ApproveLoansController());
  }
}
