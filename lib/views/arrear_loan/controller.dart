import 'dart:io';

import 'package:apploan/core/core.dart';
import 'package:apploan/core/offline/database_helper.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/start/start.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArrearLoanController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RefreshController refreshCtl = RefreshController(initialRefresh: false);
  final PaginationModel pagination = PaginationModel(limit: 15);
  final RxList<RepaymentModel> repaymentModel = <RepaymentModel>[].obs;
  bool isDone = false;
  final RxBool isLoadings = false.obs;
  final RxBool isLoading = false.obs;

  final TextEditingController dateCtl = TextEditingController();

  List<StaffModel> StaffList = [];
  StaffModel? StaffSelected;

  @override
  void onInit() async {
    fetchUser();
    super.onInit();
  }

  // show branch_id for login
  Future<int?> getbranchId() async {
    int? branchId = await SharedPreferencesManager.getIntValue('branch_id');
    return branchId;
  }

  // show user_id from login
  Future<int?> getUserId() async {
    int? user_id = await SharedPreferencesManager.getIntValue('user_id');
    return user_id;
  }

  final StartController startCtl = Get.find<StartController>();

  Future<void> fetchRepayment({
    bool isRefresh = false,
    bool isLoadMore = false,
    bool isFilter = false,
  }) async {
    try {
      if (isRefresh) {
        if (!isFilter) {
          clearFilter();
        }
        pagination.refresh();
      }

      if (pagination.isEndOfPage) {
        return;
      }

      // Show loading only when first time and filter
      if ((!isRefresh && !isLoadMore) || isFilter) {
        isLoadings.value = true;
      }

      // Take care of load more error when while load more user switch the tap
      if (startCtl.selectedIndex.value != 3 && isLoadMore) {
        return;
      }

      // totalClient.text  = getPropertyFromJson(res.data, 'totalClient');
      // totalAmount.text  = getPropertyFromJson(res.data, 'totalAmount');

      // total = getPropertyFromJson(res.data['totalAmount'], 'total') ?? 0;
      // pagination.checkLoadMore((data['data'] as List).length);

      if (isRefresh) {
        repaymentModel.value = await DatabaseHelper.instance
            .queryAllRowsRepayments(1);
      } else {
        repaymentModel.addAll(
          await DatabaseHelper.instance.queryAllRowsRepayments(1),
        );
      }
      isDone = true;
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    } finally {
      isLoadings.value = false;
    }
  }

  Future<void> onRefresh({bool isFilter = false}) async {
    await fetchRepayment(isRefresh: true, isFilter: isFilter);
    refreshCtl.refreshCompleted();
  }

  Future<void> onLoading() async {
    await fetchRepayment(isLoadMore: true);
    refreshCtl.loadComplete();
  }

  void clearFilter() {}

  Future<void> fetchUser() async {
    try {
      isLoading.value = true;
      StaffList = await DatabaseHelper.instance.queryAllRowsStaff();
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    } finally {
      isLoading.value = false;
    }
  }

  DatePicker getDatePicker() {
    final DatePicker startPicker = DatePicker(
      controller: dateCtl,
      initialDate:
          dateCtl.text.isEmpty
              ? DateTime.parse(
                '${DateFormat("yyyy-MM-dd").format(DateTime.now())} 00:00:00',
              )
              : DateTime.parse(dateCtl.text),
      minDate: DateTime(DateTime.now().year),
      maxDate: DateTime(DateTime.now().year + 200),
      minYear: DateTime.now().year,
      maxYear: DateTime.now().year + 200,
    );
    return startPicker;
  }

  String formatCurrency(String amount) {
    // ignore: unnecessary_null_comparison
    return amount != null
        ? '${NumberFormat.currency(locale: 'en_US', symbol: '').format(double.parse(amount))}'
            .replaceAll('.00', '')
        : 'N/A';
  }

  void onClientChanged(StaffModel? selectedClient) {
    StaffSelected = selectedClient;
  }

  Future<void> submitBooking() async {
    try {
      int? branchId = await getbranchId();
      int? userId = await getUserId();
      dio.FormData formData = dio.FormData.fromMap({
        // This static because of feature removed
        'branch_id': branchId,
        'user_id': userId,
      });

      await Get.find<ApiService>().post(
        EndPoints.clientStore,
        formData,
        isShowLoading: true,
      );

      DialogManager.showDialog(
        title: LocaleKeys.successfully.tr,
        subTitle: LocaleKeys.youHaveSuccessfullyCreated.tr,
        onPressed: () => Get.back(),
      );
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    }
  }

  final RxList<File> imageFiles = RxList<File>([File('')]);
  final int totalImage = 5;
  bool isNoMoreUpload() {
    return imageFiles.length == totalImage + 1; // 1 is for placeholder image
  }
}
