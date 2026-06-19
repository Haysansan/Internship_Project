import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class ReceivedItemWidget extends StatelessWidget {
  const ReceivedItemWidget({Key? key, required this.delivery})
    : super(key: key);

  final PaymentModel delivery;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // InkWell(
        //   onTap: () {
        //     if (!UserRepository.shared.isCo) {
        //       final StartController startCtl = Get.find<StartController>();
        //       startCtl.selectedIndex.value = 2;
        //       startCtl.selectedScreen.value = const TrackingView();
        //
        //       final TrackingController trackingCtl = Get.find<TrackingController>();
        //       trackingCtl.trackings.clear();
        //       trackingCtl.isDone = false;
        //       trackingCtl.searchCtl.text = delivery.client_code;
        //       trackingCtl.fetchTracking();
        //     }
        //   },
        //   child: Padding(
        //     padding: 2.padVertical,
        //     child: Text(
        //       'លេខបុង ${delivery.id}',
        //       style: AppTextStyle.smallPrimaryRegular.copyWith(decoration: TextDecoration.underline),
        //     ),
        //   ),
        // ),
        Container(
          padding: 12.padAll,
          decoration: BoxDecoration(
            borderRadius: UIConstants.radius.radiusAll,
            border: Border.all(width: 1, color: _customColor('បញ្ចប់')),
          ),
          child: Row(
            children: [
              // Logo
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColor.white,
                child: CustomNetworkImage(imageUrl: delivery.photo),
              ),
              12.width,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          delivery.client,
                          style: AppTextStyle.normalPrimaryBold,
                        ),
                        6.width,
                        Expanded(
                          child: Text(
                            delivery.loan_id == 1
                                ? '(${delivery.loan_id})'
                                : '',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: AppTextStyle.normalPrimarySemiBold,
                          ),
                        ),
                      ],
                    ),
                    4.height,

                    // Phone number
                    Text(
                      delivery.client,
                      style: AppTextStyle.normalPrimarySemiBold,
                    ),
                    4.height,

                    // Zone
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(
                        'CID ${delivery.client_code}',
                        maxLines: 2,
                        style: AppTextStyle.smallGreyRegular,
                      ),
                    ),
                  ],
                ),
              ),

              // Total amount
              Text(
                '${formatCurrency(delivery.total_repayment)}',
                style: AppTextStyle.midRedBold,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatCurrency(String amount) {
    // ignore: unnecessary_null_comparison
    return amount != null
        ? 'រៀល ${NumberFormat.currency(locale: 'en_US', symbol: '').format(double.parse(amount))}'
            .replaceAll('.00', '')
        : 'N/A';
  }

  Color _customColor(String status) {
    switch (status) {
      case 'កំពុងដំណើរការ':
        return AppColor.blue;
      case 'បញ្ចប់':
        return AppColor.green;
      case 'ក្នុងស្តុក':
        return const Color(0xFFF5C815);
      case 'ត្រឡប់':
        return const Color(0xFF4C56AF);
      default:
        return const Color(0xFFF21A3E);
    }
  }
}
