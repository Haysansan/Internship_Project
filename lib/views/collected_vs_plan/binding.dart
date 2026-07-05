import 'package:get/get.dart';
import 'controller.dart';

class CollectedVsPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollectedVsPlanController>(() => CollectedVsPlanController());
  }
}
