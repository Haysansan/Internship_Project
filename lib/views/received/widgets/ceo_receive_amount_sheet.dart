import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class CeoReceiveAmountSheet extends StatefulWidget {
  const CeoReceiveAmountSheet({super.key, required this.group});

  final CoRepaymentGroup group;

  @override
  State<CeoReceiveAmountSheet> createState() => _CeoReceiveAmountSheetState();
}

class _CeoReceiveAmountSheetState extends State<CeoReceiveAmountSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtl = TextEditingController();

  @override
  void dispose() {
    _amountCtl.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (!_formKey.currentState!.validate()) return;
    final amountReal = double.tryParse(
      _amountCtl.text.trim().replaceAll(',', ''),
    );
    if (amountReal == null) return;
    Get.back();
    Get.find<ReceivedController>().receiveGroup(
      widget.group,
      amountReal: amountReal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final expected = NumberFormat('#,##0').format(widget.group.amount);
    return SafeArea(
      bottom: false,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIConstants.spacing.height,
            Text('Receive from BM', style: AppTextStyle.normalPrimaryBold),
            UIConstants.midSpacing.height,
            const DarkGreyDivider(),
            UIConstants.midSpacing.height,
            _row('BM Name', widget.group.coName),
            UIConstants.midSpacing.height,
            _row(
              'Transfer Amount',
              '$expected ៛',
              valueStyle: AppTextStyle.normalRedBold,
            ),
            UIConstants.spacing.height,
            Text('Amount Real', style: AppTextStyle.normalPrimaryBold),
            const SizedBox(height: 6),
            CustomTextField(
              controller: _amountCtl,
              hintText: 'Enter actual amount received',
              keyboardType: TextInputType.number,
              inputFormatters: [ThousandsSeparatorInputFormatter()],
              autofocus: true,
              validator: (v) {
                final raw = v?.trim().replaceAll(',', '') ?? '';
                if (raw.isEmpty) return 'Please enter amount';
                if (double.tryParse(raw) == null) return 'Invalid amount';
                return null;
              },
            ),
            UIConstants.midSpacing.height,
            Obx(
              () => PrimaryButton(
                text: LocaleKeys.received.tr,
                onPressed:
                    Get.find<ReceivedController>().isReceiving.value
                        ? null
                        : _onConfirm,
              ),
            ),
            UIConstants.spacing.height,
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {TextStyle? valueStyle}) {
    return Row(
      children: [
        Text(label, style: AppTextStyle.normalPrimaryRegular),
        const Spacer(),
        Text(value, style: valueStyle ?? AppTextStyle.normalPrimaryRegular),
      ],
    );
  }
}
