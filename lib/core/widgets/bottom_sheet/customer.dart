import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class CustomerSheet extends StatelessWidget {
  CustomerSheet({Key? key, required this.delivery}) : super(key: key);

  final ClientModel delivery;
  final CustomersController deliveryCtl = Get.find<CustomersController>();

  final TextEditingController totalRepaymentCtl = TextEditingController();
  final TextEditingController totalPenaltyCtl = TextEditingController();

  final RxBool isPassVisible = true.obs;
  final RxBool isLogVaiEmail = false.obs;
  void loginTab() async {

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          25.height,
          _buildInfoRowPopUpBoldInput(
            "ទឹកប្រាក់ពិន័យ",
            totalPenaltyCtl,
          ),
          _buildInfoRowPopUpBoldInput(
            "ទឹកប្រាក់ត្រូវបង់",
            totalRepaymentCtl,
          ),
          // 8.height,
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     // Logo
          //     CircleAvatar(
          //       radius: 30,
          //       backgroundColor: AppColor.transparent,
          //       child: CustomNetworkImage(imageUrl: delivery.photo),
          //     ),
          //     12.width,
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         8.height,
          //
          //         // Delivery name
          //         Text(
          //           '${delivery.client_code} . ${delivery.client}',
          //           style: AppTextStyle.normalPrimarySemiBold,
          //         ),
          //         8.height,
          //
          //         // Delivery status
          //         Text(
          //           '${ formatCurrency(delivery.total_repayment) } ',
          //           style: AppTextStyle.normalRedSemiBold,
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          15.height,
          const DarkGreyDivider(),
          15.height,
          // Type of service
          _item(
            title: 'វដ្ដទី៖  | ចំនួនយឺត  ថ្ងៃ',
            value: '',
          ),
          10.height,

          // Location
          _item(
            title: 'ប្រាក់កម្ចីជា៖  ភូមិ៖ ',
            value: '',
          ),
          10.height,
          const DarkGreyDivider(),
          10.height,
          // Total amount
          _item(
            title: 'ប្រាក់ដើមត្រូវបង់',
            value: '',
          ),
          10.height,
          // Date
          _item(
            title: 'ការប្រាក់ត្រូវបង់',
            value: '',
          ),
          10.height,
          // Destination phone number
          _item(
            title: "សេវាត្រូវបង់",
            value: '0',
          ),

          10.height,
          _item(
            title: "ប្រាក់ពីន័យត្រូវបង់",
            value: '0',
          ),
          10.height,
          // Change
          PrimaryButton(
            text: LocaleKeys.confirmation.tr,
            onPressed: loginTab,
          ),
          ]
      ),
    );
  }

  String formatCurrency(String amount) {
    // ignore: unnecessary_null_comparison
    return amount != null
        ? 'រៀល ${NumberFormat.currency(locale: 'en_US', symbol: '').format(double.parse(amount))}'.replaceAll('.00', '')
        : 'N/A';
  }

  Widget _item({
    required String title,
    String value = '',
    bool isTotal = false,
    String phoneNumber = '',
    bool requiredTelegram = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: isTotal ? AppTextStyle.normalPrimarySemiBold : AppTextStyle.normalPrimaryRegular,
        ),
        const Spacer(),
        if (phoneNumber.isNotEmpty)
          Padding(
            padding: UIConstants.spacing.padHorizontal,
            child: Row(
              children: [
                if (requiredTelegram)
                  Row(
                    children: [
                      CircleIcon(
                        icon: Icons.telegram,
                        onTap: () => UrlLauncherManager.telegram(UserRepository.shared.telegram),
                      ),
                      12.width,
                    ],
                  ),
                CircleIcon(
                  icon: Icons.call,
                  onTap: () => UrlLauncherManager.call(phoneNumber),
                ),
                2.width,
              ],
            ),
          ),
        Text(
          value,
          style: isTotal ? AppTextStyle.normalRedBold : AppTextStyle.normalPrimaryRegular,
        ),
      ],
    );
  }
}
Widget _buildInfoRowPopUpBoldInput(String label, TextEditingController controller) {
  final totalPaid = controller;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            "$label:",
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 10, 10, 10),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: TextFormField(
              keyboardType: TextInputType.number, // Use TextInputType.text for general text input
              controller: totalPaid,
              style: const TextStyle(fontSize: 18.0, color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                filled: true,
                fillColor: const Color.fromARGB(255, 223, 222, 222),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: SizedBox(
                  width: 20.0, // Set the desired width
                  height: 20.0, // Set the desired height
                  child: Image.asset('assets/images/moneyx.png'),

                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}