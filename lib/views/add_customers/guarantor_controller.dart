import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';

class GuarantorController extends GetxController {
  final _api = Get.find<ApiService>();

  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalIdController = TextEditingController();

  final selectedGender = RxnString();
  final selectedIdType = Rxn<GuarantorIdTypeModel>();
  final selectedDate = Rxn<DateTime>();

  final idTypes = <GuarantorIdTypeModel>[].obs;
  final added = <GuarantorModel>[].obs;

  final relationships = <GuarantorRelationshipModel>[].obs;
  final selectedRelationship = Rxn<GuarantorRelationshipModel>();

  final genderOptions = ['Female', 'Male'];

  @override
  void onInit() {
    super.onInit();
    _fetchIdTypes();
  }

  Future<void> _fetchIdTypes() async {
    try {
      final res = await _api.get(EndPoints.clientCreate);
      idTypes.assignAll(
        (res.data['identification_types'] as List)
            .map(
              (e) => GuarantorIdTypeModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      relationships.assignAll(
        (res.data['client_relationships'] as List)
            .map(
              (e) => GuarantorRelationshipModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
    } catch (e) {
      debugPrint('guarantor init error: $e');
    }
  }

  void submit() {
    if (!formKey.currentState!.validate()) return;
    if (selectedIdType.value == null) return;
    if (selectedIdType.value == null || selectedRelationship.value == null)
      return;

    final guarantor = GuarantorModel(
      fullname: fullNameController.text.trim(),
      dateOfBirth:
          selectedDate.value != null
              ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
              : null,
      gender: selectedGender.value,
      phoneNumber: phoneController.text.trim(),
      idTypeId: selectedIdType.value!.id,
      nationalId: nationalIdController.text.trim(),
      relationship: selectedRelationship.value!.id,
    );

    added.add(guarantor);
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
    selectedRelationship.value = null;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    nationalIdController.dispose();
    super.onClose();
  }
}
