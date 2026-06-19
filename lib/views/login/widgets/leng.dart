import 'package:apploan/flavor/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/language/language.dart';

class SocialLoginWidget extends StatelessWidget {
   SocialLoginWidget({Key? key}) : super(key: key);
   final RxBool isCambodia = true.obs;

  void ChangeLengEngHandleTap() {
    isCambodia.value = true;
    updateLanguage();
  }
   void ChangeLengKhrHandleTap() {
     isCambodia.value = false;
     updateLanguage();
   }

  void updateLanguage() {
    isCambodia.value = !isCambodia.value;
    AppConfig.shared.updateLanguage(isCambodia.value ? Language.kh.key : Language.en.key);
  }
  @override
  Widget build(BuildContext context) {
      return Column(
          children: [
            SizedBox(height: 20.0),
            Container(
              alignment: Alignment.center,
              child: Text(LocaleKeys.chooseyourlanguage.tr, style: AppTextStyle.normalPrimaryRegular,),
              ),
              Container(
                alignment: Alignment.center,
                  child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                        onTap: ChangeLengKhrHandleTap,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                  Image.asset(
                                    AssetPath.cambodiaFlag.path,
                                    fit: BoxFit.cover,
                                    width: 15,
                                    height: 15,
                                    scale: 20,
                                  ),
                                  8.width,
                                  Text(
                                    'ខ្មែរ',
                                    style: AppTextStyle.midPrimarySemiBold,
                                  ),
                            ]),
                          ),
                          8.width,
                          Text(
                          '|',
                            style: AppTextStyle.midPrimarySemiBold,
                          ),
                          8.width,
                          GestureDetector(
                            onTap: ChangeLengEngHandleTap,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                 Image.asset(
                                AssetPath.englishFlag.path,
                                fit: BoxFit.cover,
                                width: 15,
                                height: 15,
                                scale: 20,
                            ),
                          8.width,
                          Text(
                            'Eng',
                            style: AppTextStyle.midPrimarySemiBold,
                          ),
                          ]),),
                        ],
                      ),
                  ),
          ],
      );
  }
}
