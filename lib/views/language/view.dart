import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/language/language.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.language.tr,
        onBack: () => Navigator.pop(context, false),
      ),
      body: Padding(
        padding: 16.padAll,
        child: Column(
          children: [
            const ItemView(),
            18.height,
            const ItemView(isCambodia: false),
          ],
        ),
      ),
    );
  }
}
