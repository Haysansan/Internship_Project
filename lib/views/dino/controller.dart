import 'package:apploan/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DinoController extends GetxController {
  // Denominations from image
  final List<int> denominations = [
    100000,
    50000,
    30000,
    20000,
    15000,
    10000,
    5000,
    2000,
    1000,
    500,
    100,
  ];

  // Reactive Map for Denomination Quantities
  final RxMap<int, int> quantities = <int, int>{}.obs;
  // Create a Map to store the controllers
  final Map<int, TextEditingController> textControllers = {};
  // Reactive Variables for Balance Section
  final RxDouble receivedAmt = .0.obs; // លុយបានទម្លាក់ទុន
  final RxDouble adminFee = .0.obs; // សេវារដ្ឋបាល
  final RxDouble collectedTotal = .0.obs; // លុយប្រមូលសរុប
  final RxBool isLoading = false.obs;
  TextEditingController receivedAmtController = TextEditingController();
  TextEditingController adminFeeController = TextEditingController();
  TextEditingController collectedTotalController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    for (int d in denominations) {
      quantities[d] = 0;
      textControllers[d] = TextEditingController(text: "0");
    }
    getDeNoCo();
  }

  Future<int?> getBranchId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return SharedPreferencesManager.getIntValue('branch_id');
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return SharedPreferencesManager.getIntValue('user_id');
  }

  Future<void> getDeNoCo() async {
    try {
      isLoading.value = true;
      int? userId = await getUserId();

      int? branchID = await getBranchId();
      Map<String, dynamic> param = {'user_id': userId, 'branch_id': branchID};
      final response = await Get.find<ApiService>().get(
        EndPoints.getDeNoCo,
        queryParameters: param,
      );
      receivedAmt.value = double.parse(
        response.data['data']['amountDis']?.toString() ?? '0',
      );
      receivedAmtController.text = receivedAmt.value.toString();

      adminFee.value = double.parse(
        response.data['data']['amountadminfee']?.toString() ?? '0',
      );
      adminFeeController.text = adminFee.value.toString();

      collectedTotal.value = double.parse(
        response.data['data']['amountCollection']?.toString() ?? '0',
      );

      collectedTotalController.text = collectedTotal.value.toString();
      isLoading.value = false;
    } catch (e) {
      ExceptionHandler.handleException(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Total from Denominations
  int get denoTotal {
    int total = 0;
    quantities.forEach((denom, qty) => total += (denom * qty));
    return total;
  }

  // Total from Balance Section
  double get balanceTotal => adminFee.value + collectedTotal.value;

  // Final Over/Shortage Calculation
  double get overShortage => denoTotal - balanceTotal;

  void updateQty(int denom, String val) =>
      quantities[denom] = int.tryParse(val) ?? 0;

  Future<void> submit() async {
    try {
      isLoading.value = true;
      DialogManager.showLoadingDialog();
      int? userId = await getUserId();
      int? branchID = await getBranchId();

      // Construct the parameter map based on your requirements
      Map<String, dynamic> param = {
        'users_id': userId,
        'branch_id': branchID,
        'grand_total_khr': denoTotal, // Total from the denominations input
        'amountDis': receivedAmt.value,
        'amountadminfee': adminFee.value,
        'amountCollection': collectedTotal.value,
        'amount_over': overShortage, // The difference (Over/Short)
      };

      // Loop through denominations to add individual keys and their totals
      for (int d in denominations) {
        int qty = quantities[d] ?? 0;
        param['khr_$d'] = qty; // e.g., khr_100000: 2
        param['total_khr_$d'] = qty * d; // e.g., total_khr_100000: 200000
      }

      // Perform the POST request
      final response = await Get.find<ApiService>().post(
        EndPoints
            .storeDeNoCo, // Ensure this is the correct endpoint for submission
        param,
        // isShowLoading: true,
      );

      if (response.statusCode == 200) {
        DialogManager.showDialog(
          title: 'ជោគជ័យ',
          subTitle: 'បានរក្សាទុកដោយជោគជ័យ',
          onPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      print("Error submitting data: $e");
      DialogManager.showDialog(
        title: 'បរាជ័យ',
        subTitle: 'មិនអាចរក្សាទុកបាននៅពេលនេះ',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
