import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class SuccessfulRegisterdView extends StatelessWidget {
  const SuccessfulRegisterdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.successfullyRegister.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UIConstants.spacing.height,

          // logo
          const LogoWidget(),

          const Spacer(),

          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                padding: UIConstants.spacing.padHorizontal,
                margin: 30.padHorizontal,
                decoration: BoxDecoration(
                  color: AppColor.lightPink,
                  borderRadius: 10.radiusAll,
                  border: Border.all(color: AppColor.grey, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    80.height,
                    const Text(
                      'ការចុះឈ្មោះបានបញ្ចប់',
                      style: AppTextStyle.mediumPrimarySemiBold,
                    ),
                    35.height,
                    const Text(
                      'ស្ថានភាពអនុម័តគណនី',
                      style: AppTextStyle.normalPrimaryRegular,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        15.height,
                        Image.asset(AssetPath.checking.path, scale: 20),
                        4.height,
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.red,
                            borderRadius: 10.radiusAll,
                          ),
                          height: 5,
                          width: 130,
                        ),
                        4.height,
                        const Text(
                          'កុំពុងពិនិត្រ',
                          style: AppTextStyle.smallPrimaryRegular,
                        ),
                      ],
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning, color: AppColor.red),
                        Text(
                          'ក្រុមរបស់យើងកុំពុងពិនិត្រមើលព័ត៏មានហាងរបស់អ្នក ហើយអ្នកនឹងត្រូវបានផ្តល់ព័ត៏មានចូលនៅពេលយើងបញ្ចាក់ថាយើងអាចប្រគល់ទំនិញរបស់អ្នកបាន។',
                          style: AppTextStyle.smallPrimaryRegular,
                        ),
                      ],
                    ),
                    20.height,
                  ],
                ),
              ),
              _checkIcon(),
            ],
          ),

          const Spacer(),

          // Logo height
          130.height,
        ],
      ),
    );
  }

  Widget _checkIcon() {
    return Positioned(
      top: -40,
      child: Container(
        padding: 1.padAll,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.grey, width: 1),
        ),
        child: Image.asset(AssetPath.check.path, height: 80, width: 80),
      ),
    );
  }
}
