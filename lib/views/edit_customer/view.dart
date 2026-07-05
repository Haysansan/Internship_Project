import 'dart:io';

import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/views/views.dart';
import 'controller.dart';

class EditCustomerView extends GetView<EditCustomerController> {
  const EditCustomerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Customer',
        onBack: () => Navigator.pop(context, false),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColor.red));
        }
        return Padding(
          padding: UIConstants.spacing.padHorizontal,
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  16.height,

                  // Profile photo
                  Center(
                    child: Obx(() {
                      final hasNew = controller.profileImage.value != null;
                      final hasExisting = controller.client.photo.isNotEmpty;
                      return GestureDetector(
                        onTap: controller.pickProfileImage,
                        child: Stack(
                          children: [
                            ClipOval(
                              child: Container(
                                width: 100,
                                height: 100,
                                color: AppColor.lightGrey,
                                child: hasNew
                                    ? Image.file(File(controller.profileImage.value!.path), fit: BoxFit.cover)
                                    : hasExisting
                                        ? CustomNetworkImage(imageUrl: controller.client.photo, width: 100, height: 100)
                                        : const Icon(Icons.person, size: 50, color: AppColor.grey),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppColor.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.camera_alt, size: 16, color: AppColor.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  16.height,

                  // First name / Last name
                  Row(
                    children: [
                      Expanded(
                        child: LabeledField(
                          label: 'First name',
                          required: true,
                          child: CustomTextField(
                            controller: controller.firstName,
                            hintText: 'First name',
                            textInputAction: TextInputAction.next,
                            validator: (text) => FormValidator.empty(text),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LabeledField(
                          label: 'Last name',
                          required: true,
                          child: CustomTextField(
                            controller: controller.lastName,
                            hintText: 'Last name',
                            textInputAction: TextInputAction.next,
                            validator: (text) => FormValidator.empty(text),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Gender / Date of birth
                  Row(
                    children: [
                      Expanded(
                        child: LabeledField(
                          label: 'Gender',
                          required: true,
                          child: Obx(() => DropdownSearch<String>(
                            items: controller.genderItems,
                            selectedItem: controller.selectedGender.value,
                            onChanged: (value) => controller.selectGender(value ?? ''),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding: 15.padHorizontal,
                                helperText: ' ',
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColor.lightGrey, width: 1),
                                  borderRadius: UIConstants.radius.radiusAll,
                                ),
                              ),
                            ),
                            popupProps: PopupProps.menu(showSearchBox: false),
                          )),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LabeledField(
                          label: 'Date Of Birth',
                          child: InkWell(
                            onTap: () => controller.getDatePicker().show(),
                            child: StackTextField(
                              controller: controller.dateOfBirth,
                              hintText: LocaleKeys.chooseDate.tr,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Phone / GIS
                  Row(
                    children: [
                      Expanded(
                        child: LabeledField(
                          label: 'Phone number',
                          required: true,
                          child: CustomTextField(
                            controller: controller.phoneNumber,
                            hintText: 'Phone number',
                            textInputAction: TextInputAction.next,
                            validator: (text) => FormValidator.empty(text),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LabeledField(
                          label: 'GIS',
                          child: Obx(() => CustomTextField(
                            controller: controller.gisCode,
                            hintText: 'Lat/Long',
                            readOnly: true,
                            onTap: controller.fetchCurrentLocation,
                            suffixIcon: controller.isFetchingLocation.value
                                ? const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.my_location, color: AppColor.primary),
                                    onPressed: controller.fetchCurrentLocation,
                                  ),
                          )),
                        ),
                      ),
                    ],
                  ),

                  // Type of ID
                  Obx(() => LabeledField(
                    label: 'Type of ID',
                    child: DropdownSearch<CoBorrowerIdTypeModel>(
                      items: controller.idTypes,
                      selectedItem: controller.selectedIdType.value,
                      itemAsString: (item) => item.name,
                      onChanged: (value) => controller.selectedIdType.value = value,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(4),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      popupProps: PopupProps.menu(showSearchBox: false),
                    ),
                  )),
                  10.height,

                  // ID Number
                  LabeledField(
                    label: 'ID Number',
                    child: CustomTextField(
                      controller: controller.externalIdController,
                      hintText: 'Numbers..',
                      textInputAction: TextInputAction.next,
                    ),
                  ),

                  // ID Card photo
                  LabeledField(
                    label: 'ID Card Photo',
                    child: Obx(() => _IdCardPicker(
                      newImage: controller.idCardImage.value,
                      existingUrl: controller.client.id_card_photo,
                      onTap: controller.pickIdCardImage,
                    )),
                  ),
                  10.height,

                  // Province / District
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => LabeledField(
                          label: 'Province / City',
                          child: SearchDropDown<ProvinceModel>(
                            items: controller.provinceList,
                            itemAsString: (item) => '${item.id} - ${item.name}',
                            onChanged: controller.onProvinceChanged,
                            selectedItem: controller.provinceSelected.value,
                          ),
                        )),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoadingDistrict.value) {
                            return const Center(child: CircularProgressIndicator(color: AppColor.red));
                          }
                          return LabeledField(
                            label: 'District / Khan',
                            child: SearchDropDown<DistrictModel>(
                              items: controller.districtList,
                              itemAsString: (item) => '${item.id} - ${item.name_kh}',
                              onChanged: controller.onDistrictChanged,
                              selectedItem: controller.districtSelected.value,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  10.height,

                  // Commune / Village
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoadingCommune.value) {
                            return const Center(child: CircularProgressIndicator(color: AppColor.red));
                          }
                          return LabeledField(
                            label: 'Commune',
                            child: SearchDropDown<CommuneModel>(
                              items: controller.communeList,
                              itemAsString: (item) => '${item.id} - ${item.name}',
                              onChanged: controller.onCommuneChanged,
                              selectedItem: controller.communeSelected.value,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoadingVillage.value) {
                            return const Center(child: CircularProgressIndicator(color: AppColor.red));
                          }
                          return LabeledField(
                            label: 'Village',
                            child: SearchDropDown<VillageModel>(
                              items: controller.villageList,
                              itemAsString: (item) => '${item.id} - ${item.name}',
                              onChanged: controller.onVillageChanged,
                              selectedItem: controller.villageSelected.value,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  10.height,

                  // Submit
                  Obx(() {
                    final eodEnabled = UserRepository.shared.eodEnabled.value;
                    return Column(
                      children: [
                        if (!eodEnabled)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.lock_outline, size: 14, color: Colors.orange),
                                SizedBox(width: 6),
                                Text('End of day already closed',
                                    style: TextStyle(color: Colors.orange, fontSize: 13)),
                              ],
                            ),
                          ),
                        PrimaryButton(
                          text: LocaleKeys.submit.tr,
                          onPressed: eodEnabled
                              ? () async {
                                  if (!controller.formKey.currentState!.validate()) return;
                                  controller.formKey.currentState!.save();
                                  await controller.submitUpdate();
                                }
                              : null,
                        ),
                      ],
                    );
                  }),
                  30.height,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _IdCardPicker extends StatelessWidget {
  const _IdCardPicker({
    required this.newImage,
    required this.existingUrl,
    required this.onTap,
  });

  final dynamic newImage;
  final String existingUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasNew = newImage != null;
    final hasExisting = existingUrl.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.lightGrey,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.grey300),
        ),
        child: hasNew
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(File(newImage!.path), fit: BoxFit.cover),
              )
            : hasExisting
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomNetworkImage(imageUrl: existingUrl, fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_photo_alternate_outlined, size: 36, color: AppColor.grey),
                      8.height,
                      Text('Tap to upload ID card', style: AppTextStyle.smallGreyRegular),
                    ],
                  ),
      ),
    );
  }
}
