import 'package:get/get.dart';
import 'package:apploan/views/sync_data/controller.dart';
import 'package:apploan/views/views.dart';

class SyncDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SyncDataController>(() => SyncDataController());
  }
}
