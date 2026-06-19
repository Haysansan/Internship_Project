import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class KeyValueWidget extends StatelessWidget {
  const KeyValueWidget({
    Key? key,
    required this.leading,
    required this.trilling,
    this.isTotal = false,
    this.isOpenMap = false,
  }) : super(key: key);

  final String leading;
  final String trilling;
  final bool isTotal;
  final bool isOpenMap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Leading text
        Text(
          leading,
          style: isTotal ? AppTextStyle.normalPrimarySemiBold : AppTextStyle.normalPrimaryRegular,
        ),

        const Spacer(),

        // Trilling text
        if (isOpenMap)
          InkWell(
            onTap: () => UrlLauncherManager.map(lat: '11.568559931643785', lng: '104.89063940573604'),
            child: Text(
              trilling,
              style: isTotal ? AppTextStyle.normalRedSemiBold : AppTextStyle.normalBlueBold,
            ),
          )
        else
          Text(
            trilling,
            style: isTotal ? AppTextStyle.normalRedSemiBold : AppTextStyle.normalPrimaryRegular,
          ),
      ],
    );
  }
}
