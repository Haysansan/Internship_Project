import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/flavor/app_config.dart';

class LanguageController extends GetxController {
  final RxBool isCambodia = true.obs;

  @override
  void onInit() async {
    if (AppConfig.shared.language == Language.en.key) {
      isCambodia.value = false;
    }
    super.onInit();
  }

  void updateLanguage() {
    isCambodia.value = !isCambodia.value;
    AppConfig.shared.updateLanguage(isCambodia.value ? Language.kh.key : Language.en.key);
  }
}
