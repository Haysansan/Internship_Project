import 'package:get/get.dart';
import 'package:apploan/views/language/language.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
  }
}
