// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:apploan/core/core.dart';
// import 'package:apploan/models/models.dart';
// import 'package:apploan/views/views.dart';

// class PaidOffItemWidget extends StatelessWidget {
//   const PaidOffItemWidget({Key? key, required this.delivery}) : super(key: key);

//   final PaidOffModel delivery;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap:
//           () => BottomSheetManager.custom(
//             content: PaidOffSheet(delivery: delivery),
//           ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Container(
//           //   padding: 12.padAll,
//           //   decoration: BoxDecoration(
//           //     borderRadius: UIConstants.radius.radiusAll,
//           //     border: Border.all(
//           //       width: 1,
//           //       color: _customColor('បញ្ចប់'),
//           //     ),
//           //   ),
//           //   child: Row(
//           //     children: [
//           //       // Logo
//           //
//           //       CircleAvatar(
//           //         radius: 30,
//           //         backgroundColor: AppColor.white,
//           //         child: CustomNetworkImage(imageUrl: delivery.photo),
//           //       ),
//           //       12.width,
//           //
//           //       Expanded(
//           //         child: Column(
//           //           crossAxisAlignment: CrossAxisAlignment.start,
//           //           children: [
//           //             // Status
//           //             Row(
//           //               crossAxisAlignment: CrossAxisAlignment.start,
//           //               mainAxisAlignment: MainAxisAlignment.start,
//           //               children: [
//           //                 Text(
//           //                   delivery.client,
//           //                   style: AppTextStyle.normalPrimaryBold,
//           //                 ),
//           //                 6.width,
//           //                 Expanded(
//           //                   child: Text(
//           //                     delivery.loan_id == 1 ? '(${delivery.loan_id})' : '',
//           //                     maxLines: 4,
//           //                     overflow: TextOverflow.ellipsis,
//           //                     textAlign: TextAlign.start,
//           //                     style: AppTextStyle.normalPrimarySemiBold,
//           //                   ),
//           //                 ),
//           //               ],
//           //             ),
//           //             4.height,
//           //
//           //             // Phone number
//           //             Text(
//           //               delivery.mobile,
//           //               style: AppTextStyle.normalPrimarySemiBold,
//           //             ),
//           //             4.height,
//           //
//           //             // Zone
//           //             SizedBox(
//           //               width: Get.width * 0.4,
//           //               child: Text('CID ${delivery.client_code}',
//           //                 maxLines: 2,
//           //                 style: AppTextStyle.smallGreyRegular,
//           //               ),
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //
//           //       // Total amount
//           //       Text(
//           //         '${formatCurrency(delivery.total_repayment)}',
//           //         style: AppTextStyle.midRedBold,
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: UIConstants.radius.radiusAll,
//               border: Border.all(width: 1, color: _customColor('ជោគជ័យ')),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 ListTile(
//                   contentPadding: EdgeInsets.zero, // Remove default padding
//                   leading: CircleAvatar(
//                     radius: 30,
//                     backgroundColor: AppColor.white,
//                     child: Image.asset(
//                       _AssetPath('ជោគជ័យ'),
//                       height: 50,
//                       width: 50,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   title: Text(
//                     '${delivery.client} (វដ្គទី ${delivery.cycle})',
//                     style: AppTextStyle.normalPrimarySemiBold.copyWith(
//                       color: Color(0xFF171617),
//                     ),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Phone number
//                                 Text(
//                                   '${delivery.mobile} (ចំនួនថ្ងៃយឺត ${delivery.arrea})',
//                                   style: AppTextStyle.smallGreyRegular,
//                                 ),
//                                 SizedBox(
//                                   width: Get.width * 0.4,
//                                   child: Text(
//                                     delivery.villages_name,
//                                     style: AppTextStyle.smallGreyRegular,
//                                   ),
//                                 ),
//                                 Text(
//                                   delivery.last_payment_date,
//                                   style: AppTextStyle.smallGreyRegular,
//                                 ),
//                                 Text(
//                                   'ប្រាក់កម្ចី៖ ${formatCurrency(delivery.disburmentAmt)}',
//                                   style: AppTextStyle.smallGreyRegular,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Total amount Row integrated into the subtitle
//                     ],
//                   ),
//                   // trailing: SizedBox(
//                   //   width: 50, // Adjust this width as necessary
//                   //   child: Align(
//                   //     alignment: Alignment.topRight,
//                   //     child: IconButton(
//                   //       tooltip: 'Send',
//                   //       onPressed: () async {
//                   //
//                   //       },
//                   //       icon: Image.asset(
//                   //         AssetPath.apptelegram.path,
//                   //         height: 50,
//                   //         width: 50,
//                   //         fit: BoxFit.contain,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   isThreeLine: true,
//                 ),
//                 const DarkGreyDivider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     // Text(
//                     //   'ប្រាក់កម្ចី៖ ${formatCurrency(delivery.principal)}',
//                     //   style: AppTextStyle.smallRedRegular,
//                     // ),
//                     TextButton(
//                       child: Text(
//                         'ប្រាក់ត្រូវបង់ផ្ដាច់៖ ${formatCurrency(delivery.total_repayment.toString())} រៀល',
//                         style: AppTextStyle.normalSecondaryBold,
//                       ),
//                       onPressed: () {
//                         /* ... */
//                       },
//                     ),
//                     // TextButton(
//                     //   child: Text(
//                     //     'ព័ត៌មានលំអិត',
//                     //     style: AppTextStyle.smallBlueSemibold,
//                     //   ),
//                     //   onPressed: () {
//                     //     BottomSheetManager.custom(content: DeliverySheet(delivery: delivery));
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String formatCurrency(String amount) {
//     // ignore: unnecessary_null_comparison
//     return amount != null
//         ? '${NumberFormat.currency(locale: 'en_US', symbol: '').format(double.parse(amount))}'
//             .replaceAll('.00', '')
//         : 'N/A';
//   }

//   Color _customColor(String status) {
//     switch (status) {
//       case 'កំពុងដឹក':
//         return AppColor.blue;
//       case 'កំពុងរង់ចាំ':
//         return AppColor.blue;
//       case 'ជោគជ័យ':
//         return AppColor.green;
//       case 'មានបញ្ហា':
//         return const Color(0xFFF5C815);
//       case 'ត្រឡប់':
//         return const Color(0xFF4C56AF);
//       default:
//         return const Color(0xFFDE0CDE);
//     }
//   }

//   String _AssetPath(String status) {
//     switch (status) {
//       case 'កំពុងដឹក':
//         return AssetPath.appprocessing.path;
//       case 'ជោគជ័យ':
//         return AssetPath.appsuccess.path;
//       case 'កំពុងរង់ចាំ':
//         return AssetPath.appprocessing.path;
//       case 'មានបញ្ហា':
//         return AssetPath.apprejects.path;
//       case 'ត្រឡប់':
//         return AssetPath.apprejects.path;
//       default:
//         return AssetPath.apprejects.path;
//     }
//   }
// }
