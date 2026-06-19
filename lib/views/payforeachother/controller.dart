import 'dart:io';
import 'package:apploan/core/offline/database_helper.dart';
import 'package:apploan/core/utils/date_picker.dart';
import 'package:apploan/views/start/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayfoeachotherController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController totalAmountCtl = TextEditingController();
  final TextEditingController descriptionCtl = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isLoadings = false.obs;

  final PaginationModel pagination = PaginationModel(limit: 15);
  final RefreshController refreshCtl = RefreshController(initialRefresh: false);
  final StartController startCtl = Get.find<StartController>();
  List<ClientPrepaidModel> ClientList = [];
  ClientPrepaidModel? clientSelected;
  final NumberFormat numberFormat = NumberFormat('#,###');
  List<StaffModel> StaffList = [];
  StaffModel? StaffSelected;

  @override
  void onInit() async {
    await fetchUser();
    totalAmountCtl.addListener(() {
      String text = totalAmountCtl.text.replaceAll(
        ',',
        '',
      ); // Remove existing commas
      if (text.isNotEmpty) {
        String formattedText = numberFormat.format(int.parse(text));
        totalAmountCtl.value = totalAmountCtl.value.copyWith(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }
    });
    super.onInit();
  }

  void updateClientList(String query) {
    // Implement your filtering logic based on the query
    var filteredList =
        ClientList.where((client) {
          return client.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
    ClientList.assignAll(filteredList);
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

  Future<void> fetchUser() async {
    int? branchId = await getbranchId();

    try {
      isLoadings.value = true;
      final Map<String, dynamic> params = {'branch_id': branchId};

      final res = await Get.find<ApiService>().get(
        EndPoints.getStaff,
        queryParameters: params,
      );

      final data = getPropertyFromJson(res.data, 'data');
      StaffList = List.from(
        ((data as List?) ?? []).map((e) => StaffModel.fromJson(e)),
      );
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    } finally {
      isLoadings.value = false;
    }
  }

  void onClientChanged(ClientPrepaidModel? selectedClient) {
    clientSelected = selectedClient;
  }

  // Method to handle staff selection change
  Future<void> onStaffChanged(StaffModel? selectedStaff) async {
    StaffSelected = selectedStaff;
    await fetchClient(
      selectedStaff?.id,
    ); // Fetch clients based on selected staff
  }

  Future<void> fetchClient(num? staffId) async {
    int? branchId = await getbranchId();

    try {
      isLoading.value = true;
      final Map<String, dynamic> params = {
        'branch_id': branchId,
        'user_id': staffId,
      };
      final res = await Get.find<ApiService>().get(
        EndPoints.getClient,
        queryParameters: params,
      );
      final data = getPropertyFromJson(res.data, 'data');
      ClientList = List.from(
        ((data as List?) ?? []).map((e) => ClientPrepaidModel.fromJson(e)),
      );
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitBooking() async {
    try {
      int? user_id = await getUserId();
      dio.FormData formData = dio.FormData.fromMap({
        // This static because of feature removed
        'loan_id': clientSelected?.id,
        'amount': double.parse(totalAmountCtl.text.replaceAll(",", "")),
        'user_id': user_id,
        'currency_id': 2,
        'description': descriptionCtl.text,
        'geteway_id': 2,
        'repayment_for_id': StaffSelected?.id,
      });

      int? maxId = await DatabaseHelper.instance.getCollectedMaxId();
      ClientList =
          ClientList.where(
            (client) => client.id == clientSelected?.id,
          ).toList();

      await DatabaseHelper.instance.insertCollected({
        'id': maxId,
        'client': ClientList[0].name + "(បង់ប្រាក់ជំនួស)",
        'loan_officer': user_id,
        'created_by_id': user_id,
        'branch': "",
        'client_id': 0,
        'loan_id': clientSelected?.id,
        'client_code': "",
        'photo': "",
        'total_repayment': double.parse(
          totalAmountCtl.text.replaceAll(",", ""),
        ),
        'amount_penalty': 0,
        'currency_id': 2,
        'description': "Post Repayment",
        'gateway_id': 1,
        "status_pay": "មិនទាន់អនុម័ត",
        'submitted_on': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'syncedate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'synced': 1,
      });

      await Get.find<ApiService>().post(
        EndPoints.prePaid,
        formData,
        isShowLoading: true,
      );

      DialogManager.showDialog(
        title: LocaleKeys.successfully.tr,
        subTitle: LocaleKeys.youHavesuccessfullyCreatedTheBooking.tr,
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
