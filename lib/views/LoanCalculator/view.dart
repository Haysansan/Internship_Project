import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCalculatorView extends GetView<LoanCalculatorController> {
  const LoanCalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.loanCalculator.tr),
      body: Padding(
        padding: UIConstants.spacing.padHorizontal,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                UIConstants.spacing.height,
                // Receiver phone number
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.loantype.tr,
                                style: AppTextStyle.normalPrimaryRegular,
                              ),
                              SizedBox(height: 8), // Adjust height as needed
                              CustomDropdown(
                                hintText: "ប្រភេទកម្ចី",
                                items: controller.StaffList,
                                // validator: (text) => FormValidator.empty(text),
                                onChanged: (value) {
                                  // Handle the value change
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ប្រភេទរយៈពេលខ្ចីប្រាក់",
                                style: AppTextStyle.normalPrimaryRegular,
                              ),
                              SizedBox(height: 8), // Adjust height as needed
                              CustomDropdown(
                                hintText: 'ប្រភេទរយៈពេលខ្ចីប្រាក់',
                                items: controller.StaffList,
                                // validator: (text) => FormValidator.empty(text),
                                onChanged: (value) {
                                  // Handle the value change
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                UIConstants.spacing.height,
                // Destination zone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.product.tr,
                      style: AppTextStyle.normalPrimaryRegular,
                    ),
                    SearchDropDown<StaffModel>(
                      items: controller.StaffList,
                      itemAsString: (item) =>
                          '${item.id} - ${item.name}', // Convert StaffModel to String
                      onChanged: (value) {
                        controller.onStaffChanged(value as StaffModel?);
                      },
                      selectedItem: controller.StaffSelected,
                    ),
                  ],
                ),
                UIConstants.spacing.height,
                // Total amount
                Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.product.tr,
                                    style: AppTextStyle.normalPrimaryRegular,
                                  ),
                                  2.height,
                                  CustomTextField(
                                    controller: controller.totalAmountCtl,
                                    hintText: '\$0.00',
                                    textInputAction: TextInputAction.next,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    validator: (text) =>
                                        FormValidator.empty(text),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.principals.tr,
                                    style: AppTextStyle.normalPrimaryRegular,
                                  ),
                                  2.height,
                                  CustomTextField(
                                    controller: controller.totalAmountCtl,
                                    hintText: '\$0.00',
                                    textInputAction: TextInputAction.next,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    validator: (text) =>
                                        FormValidator.empty(text),
                                  ),
                                ]),
                          ),
                        ]),
                  ],
                ),
                UIConstants.spacing.height,
                // Total amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.interast.tr,
                                    style: AppTextStyle.normalPrimaryRegular,
                                  ),
                                  2.height,
                                  CustomTextField(
                                    controller: controller.totalAmountCtl,
                                    hintText: '\$0.00',
                                    textInputAction: TextInputAction.next,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    validator: (text) =>
                                        FormValidator.empty(text),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.fee.tr,
                                    style: AppTextStyle.normalPrimaryRegular,
                                  ),
                                  2.height,
                                  CustomTextField(
                                    controller: controller.totalAmountCtl,
                                    hintText: '\$0.00',
                                    textInputAction: TextInputAction.next,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    validator: (text) =>
                                        FormValidator.empty(text),
                                  ),
                                ]),
                          ),
                        ]),
                  ],
                ),
                // Choose date
                UIConstants.spacing.height,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.opendate.tr,
                      style: AppTextStyle.normalPrimaryRegular,
                    ),
                    2.height,
                    InkWell(
                      onTap: () => controller.getDatePicker().show(),
                      child: StackTextField(
                        controller: controller.dateCtl,
                        hintText: LocaleKeys.chooseDate.tr,
                        validator: (text) => FormValidator.phoneNumber(text),
                      ),
                    ),
                  ],
                ),
                UIConstants.spacing.height,
                // Choose date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.firstdaterepayment.tr,
                      style: AppTextStyle.normalPrimaryRegular,
                    ),
                    2.height,
                    InkWell(
                      onTap: () => controller.getDatePicker().show(),
                      child: StackTextField(
                        controller: controller.dateCtl,
                        hintText: LocaleKeys.chooseDate.tr,
                        validator: (text) => FormValidator.phoneNumber(text),
                      ),
                    ),
                  ],
                ),
                UIConstants.spacing.height,
                // Submit
                PrimaryButton(
                  text: LocaleKeys.submit.tr,
                  onPressed: () async {
                    if (!controller.formKey.currentState!.validate()) {
                      return;
                    }
                    controller.formKey.currentState!.save();
                    await controller.submitBooking();
                  },
                ),

                30.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
