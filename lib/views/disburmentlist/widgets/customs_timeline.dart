import 'package:apploan/views/disburmentlist/widgets/end_childs.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/models/disbursement/model.dart';

class CustomsTimeLinesWidget extends StatelessWidget {
  const CustomsTimeLinesWidget({
    Key? key,
    required this.isFirst,
    required this.isLast,
    required this.tracking,
  }) : super(key: key);

  final bool isFirst;
  final bool isLast;
  final DisbursementListModel tracking;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: const LineStyle(
        color: AppColor.primary,
        thickness: 2,
      ),
      indicatorStyle: IndicatorStyle(
        width: 30,
        color: AppColor.primary,
        drawGap: true,
        iconStyle: IconStyle(
          iconData: Icons.done,
          color: AppColor.white,
        ),
      ),
      endChild: EndsChildWidget(tracking: tracking),
    );
  }
}
