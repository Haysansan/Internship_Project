import 'package:apploan/core/offline/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class PaidOffSheet extends StatelessWidget {
  PaidOffSheet({Key? key, required this.paidoff}) : super(key: key);

  final PaidOffModel paidoff;
  final PaidOffController startCtl = Get.find<PaidOffController>();

  final TextEditingController totalRepaymentCtl = TextEditingController();
  final TextEditingController totalPenaltyCtl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<int?> getUserId() async {
    return SharedPreferencesManager.getIntValue('user_id');
  }

  String? _validateAmount(String? value) {
    if ((value ?? '').isEmpty) return LocaleKeys.cannotBeEmpty.tr;
    if (value!.contains('.')) return 'Please enter a valid amount';
    return null;
  }

  Future<void> submitBooking() async {
    if (!formKey.currentState!.validate()) return;

    final rawAmount = double.parse(totalRepaymentCtl.text.replaceAll(',', ''));

    try {
      final userId = await getUserId();

      await DatabaseHelper.instance.insertCollected({
        'id': paidoff.id,
        'client': paidoff.client,
        'loan_officer': userId,
        'created_by_id': userId,
        'branch': paidoff.branch,
        'client_id': paidoff.client_id,
        'loan_id': paidoff.loan_id,
        'client_code': paidoff.client_code,
        'photo': paidoff.photo,
        'total_repayment': rawAmount,
        'amount_penalty': totalPenaltyCtl.text,
        'currency_id': 2,
        'description': 'Post Repayment',
        'gateway_id': 1,
        'status_pay': 'មិនទាន់ផ្ទេរ',
        'submitted_on': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'syncedate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'synced': '0',
      });

      final index = startCtl.repaymentModels.indexWhere(
        (e) => e.loan_id == paidoff.loan_id,
      );
      if (index != -1) {
        final u = startCtl.repaymentModels[index];
        startCtl.repaymentModels[index] = PaidOffModel(
          id: u.id,
          client: u.client,
          loan_officer: u.loan_officer,
          branch: u.branch,
          client_id: u.client_id,
          loan_id: u.loan_id,
          mobile: u.mobile,
          client_code: u.client_code,
          account_number: u.account_number,
          cycle: u.cycle,
          loan_term: u.loan_term,
          photo: u.photo,
          principal: u.principal,
          disburmentAmt: u.disburmentAmt,
          end_pricipal: u.end_pricipal,
          interest: u.interest,
          monthly_fee: u.monthly_fee,
          penalty: u.penalty,
          villages_name: u.villages_name,
          last_payment_date: u.last_payment_date,
          total_repayment:
              (double.parse(u.total_repayment) - rawAmount).toString(),
          arrea: u.arrea,
          total_toclose: u.total_toclose,
          syncedate: u.syncedate,
          synced: u.synced,
        );
      }

      DialogManager.showDialog(
        title: LocaleKeys.successfully.tr,
        subTitle: LocaleKeys.youHaveSuccessfullyCreated.tr,
        onPressed: () => Get.back(result: true),
      );
    } catch (e) {
      ExceptionHandler.handleException(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIConstants.spacing.height,
            LabeledField(
              label: LocaleKeys.amttoclose.tr,
              required: true,
              child: _AmountField(
                controller: totalRepaymentCtl,
                validator: _validateAmount,
              ),
            ),
            UIConstants.midSpacing.height,
            const DarkGreyDivider(),
            UIConstants.midSpacing.height,

            _item(
              title: LocaleKeys.amttoclose.tr,
              value: formatCurrency(paidoff.total_repayment),
              isTotal: true,
            ),
            UIConstants.midSpacing.height,
            const DarkGreyDivider(),
            UIConstants.midSpacing.height,
            _item(
              title: LocaleKeys.principals.tr,
              value: formatCurrency(paidoff.principal),
            ),
            UIConstants.midSpacing.height,
            _item(
              title: LocaleKeys.interast.tr,
              value: formatCurrency(paidoff.interest),
            ),
            UIConstants.midSpacing.height,
            _item(
              title: LocaleKeys.fee.tr,
              value: formatCurrency(paidoff.monthly_fee),
            ),
            UIConstants.midSpacing.height,
            _item(
              title: LocaleKeys.penalty.tr,
              value: formatCurrency(paidoff.penalty),
            ),
            UIConstants.spacing.height,

            PrimaryButton(
              text: LocaleKeys.confirmation.tr,
              onPressed: UserRepository.shared.isBM ? null : submitBooking,
            ),
            UIConstants.spacing.height,
          ],
        ),
      ),
    );
  }

  String formatCurrency(String amount) {
    return 'រៀល ${NumberFormat.currency(locale: 'en_US', symbol: '').format(double.parse(amount))}'
        .replaceAll('.00', '');
  }

  Widget _item({required String title, required String value, bool isTotal = false}) {
    return Row(
      children: [
        Text(
          title,
          style:
              isTotal
                  ? AppTextStyle.normalPrimarySemiBold
                  : AppTextStyle.normalPrimaryRegular,
        ),
        const Spacer(),
        Text(
          value,
          style:
              isTotal
                  ? AppTextStyle.normalRedBold
                  : AppTextStyle.normalPrimaryRegular,
        ),
      ],
    );
  }
}

class _AmountField extends StatelessWidget {
  const _AmountField({required this.controller, required this.validator});

  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');
    controller.addListener(() {
      final text = controller.text.replaceAll(',', '');
      if (text.isEmpty) return;
      final formatted = numberFormat.format(int.parse(text));
      if (formatted == controller.text) return;
      controller.value = controller.value.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });

    return CustomTextField(
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.number,
      hintText: '0',
      prefixIcon: SizedBox(
        width: 20,
        height: 20,
        child: Image.asset('assets/images/moneyx.png'),
      ),
      validator: validator,
    );
  }
}
