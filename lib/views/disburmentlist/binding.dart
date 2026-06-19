import 'package:get/get.dart';
import 'package:apploan/views/views.dart';

class DisburmentListViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DisburmentListController>(() => DisburmentListController());
  }
}
