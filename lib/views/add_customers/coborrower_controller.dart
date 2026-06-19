import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';

class CoBorrowerController extends GetxController {
  final _api = Get.find<ApiService>();

  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalIdController = TextEditingController();

  final selectedGender = RxnString();
  final selectedIdType = Rxn<CoBorrowerIdTypeModel>();
  final selectedDate = Rxn<DateTime>();

  final idTypes = <CoBorrowerIdTypeModel>[].obs;
  final added = <CoBorrowerModel>[].obs;
  final isSubmitting = false.obs;

  final genderOptions = ['Female', 'Male'];

  @override
  void onInit() {
    super.onInit();
    _fetchIdTypes();
  }

  Future<void> _fetchIdTypes() async {
    try {
      final res = await _api.get(EndPoints.clientCreate);
      final list =
          (res.data['identification_types'] as List)
              .map(
                (e) =>
                    CoBorrowerIdTypeModel.fromJson(e as Map<String, dynamic>),
              )
              .toList();
      idTypes.assignAll(list);
    } catch (e) {
      debugPrint('idTypes error: $e');
    }
  }

  void submit() {
    if (!formKey.currentState!.validate()) return;
    if (selectedIdType.value == null) return;

    final coborrower = CoBorrowerModel(
      fullname: fullNameController.text.trim(),
      dateOfBirth:
          selectedDate.value != null
              ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
              : null,
      gender: selectedGender.value,
      phoneNumber: phoneController.text.trim(),
      idTypeId: selectedIdType.value!.id,
      nationalId: nationalIdController.text.trim(),
    );

    added.add(coborrower);
    _resetForm();
    Get.back();
  }

  void remove(int index) => added.removeAt(index);

  void _resetForm() {
    fullNameController.clear();
    phoneController.clear();
    nationalIdController.clear();
    selectedGender.value = null;
    selectedIdType.value = null;
    selectedDate.value = null;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    nationalIdController.dispose();
    super.onClose();
  }
}
