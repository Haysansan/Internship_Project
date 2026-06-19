import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/flavor/flavor.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';

class FinishDeliveryController extends GetxController {
  final RxString groupValue = 'staff'.obs;
  final RxBool cancelState = false.obs;
  final RxBool successDeliveryFee = false.obs;

  final TextEditingController deliveryRielCtl = TextEditingController();
  final TextEditingController deliveryUsdCtl = TextEditingController();
  final TextEditingController cancelCtl = TextEditingController();
  final RxBool isStaffError = false.obs;
  final RxString payType = 'shop'.obs;
  final GlobalKey<FormState> deliveryFeeformKey = GlobalKey<FormState>();
  final TextEditingController deliveryFeeCtl = TextEditingController();

  final ReasonController reasonCtl = Get.find<ReasonController>();

  String reasonId = '';
  int delivreyId = 0;
  num totalAmount = 0;

  late List<ReasonModel> reasons;

  @override
  void onInit() {
    delivreyId = Get.arguments['deliveryId'] ?? 0;
    totalAmount = Get.arguments['totalAmount'] ?? 0;
    reasons = reasonCtl.reasonModel;
    super.onInit();
  }

  @override
  void onClose() {
    deliveryRielCtl.dispose();
    deliveryUsdCtl.dispose();
    cancelCtl.dispose();
    deliveryFeeCtl.dispose();
    super.onClose();
  }

  void clearMoney() {
    deliveryRielCtl.text = '';
    deliveryUsdCtl.text = '';
  }

  Future<void> submit() async {
    try {
      int paymentAtId =
          groupValue.value == 'seller'
              ? 1
              : (groupValue.value == 'staff' ? 2 : 3);

      bool isCancel = false;
      String reasonId = '';
      double codKhr = 0;
      double codUsd = 0;

      if (successDeliveryFee.value) {
        isStaffError.value = false;
        if (!deliveryFeeformKey.currentState!.validate()) {
          return;
        }
      } else {
        if (cancelState.value) {
          isCancel = true;
          reasonId = this.reasonId;
        } else {
          if (groupValue.value == 'staff') {
            isStaffError.value =
                deliveryRielCtl.text.isEmpty && deliveryUsdCtl.text.isEmpty;
            if (isStaffError.value) {
              return;
            }
            codUsd = totalAmount.toDouble();
          }
          codKhr = 0;
        }
      }

      final Map<String, dynamic> params = {
        'seller': paymentAtId == 1 ? totalAmount : 0,
        'staff': paymentAtId == 2 ? totalAmount : 0,
        'company': paymentAtId == 3 ? totalAmount : 0,
        'payment_at_id': paymentAtId,
        if (isCancel) 'reason_id': reasonId,
        'cod_amount_usd': codUsd,
        'cod_amount_khr': codKhr,
      };

      await Get.find<ApiService>().get(
        '${EndPoints.finishDelivery}/$delivreyId',
        queryParameters: params,
        isShowLoading: true,
      );

      if (AppConfig.shared.isDeliveryTapOpened) {
        final RepaymentController deliveryCtl = Get.find<RepaymentController>();
        deliveryCtl.clearFilter();
        // await deliveryCtl.fetchDelivery(isRefresh: true, isFilter: true);
      }

      DialogManager.showCustom(
        PrimaryDialog(
          title: LocaleKeys.finishDelivery.tr,
          subTitle: LocaleKeys.successfulFinishDelivery.tr,
          onPressed: () {
            Get.back();
            Get.back();
          },
        ),
      );
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    }
  }
}
