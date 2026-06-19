import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class TermConditionsItemWidget extends StatelessWidget {
  const TermConditionsItemWidget({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final List<String> subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIConstants.spacing.padHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: AppTextStyle.midPrimaryBold,
          ),
          10.height,

          // Sub title
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
            ),
            decoration: customDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...subTitle.map(
                  (e) => Padding(
                    padding: 8.padBottom,
                    child: Text(e, style: AppTextStyle.normalPrimaryRegular),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
