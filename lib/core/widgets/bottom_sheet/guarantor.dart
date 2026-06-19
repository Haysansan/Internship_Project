import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';
import 'shared_coborrower_guarantor.dart';

class GuarantorFormSheet extends GetView<GuarantorController> {
  const GuarantorFormSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: Get.back,
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Add Guarantors',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.grey),
                  onPressed: Get.back,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BorrowerFieldLabel('Full Name', required: true),
                    _buildTextField(controller.fullNameController, 'Full name'),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BorrowerFieldLabel('Date of birth'),
                              BorrowerDatePickerField(
                                obs: controller.selectedDate,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BorrowerFieldLabel('Gender'),
                              BorrowerGenderDropdown(
                                selected: controller.selectedGender,
                                options: controller.genderOptions,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const BorrowerFieldLabel('Phone number', required: true),
                    _buildTextField(
                      controller.phoneController,
                      'Phone number',
                      keyboard: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    const BorrowerFieldLabel('Type of ID', required: true),
                    BorrowerIdTypeDropdown<GuarantorIdTypeModel>(
                      selected: controller.selectedIdType,
                      items: controller.idTypes,
                    ),
                    const SizedBox(height: 20),
                    const BorrowerFieldLabel('ID Number', required: true),
                    _buildTextField(
                      controller.nationalIdController,
                      'Numbers..',
                      keyboard: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    const BorrowerFieldLabel('Relationship', required: true),
                    BorrowerIdTypeDropdown<GuarantorRelationshipModel>(
                      selected: controller.selectedRelationship,
                      items: controller.relationships,
                    ),
                    const SizedBox(height: 32),
                    BorrowerSubmitButton(onPressed: controller.submit),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String hint, {
    TextInputType? keyboard,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      validator:
          (v) =>
              (v == null || v.trim().isEmpty) ? 'This field is required' : null,
      decoration: borrowerInputDecoration(hint),
    );
  }
}
