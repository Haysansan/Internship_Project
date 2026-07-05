import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class EditCustomerController extends GetxController {
  final ClientModel client = Get.arguments as ClientModel;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController firstName;
  late final TextEditingController lastName;
  late final TextEditingController dateOfBirth;
  late final TextEditingController phoneNumber;
  late final TextEditingController gisCode;
  late final TextEditingController externalIdController;

  final RxList<CoBorrowerIdTypeModel> idTypes = <CoBorrowerIdTypeModel>[].obs;
  final Rxn<CoBorrowerIdTypeModel> selectedIdType = Rxn<CoBorrowerIdTypeModel>();

  final RxList<ProvinceModel> provinceList = <ProvinceModel>[].obs;
  final RxList<DistrictModel> districtList = <DistrictModel>[].obs;
  final RxList<CommuneModel> communeList = <CommuneModel>[].obs;
  final RxList<VillageModel> villageList = <VillageModel>[].obs;

  final RxBool isLoadingDistrict = false.obs;
  final RxBool isLoadingCommune = false.obs;
  final RxBool isLoadingVillage = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isFetchingLocation = false.obs;

  final Rx<String?> selectedGender = Rx<String?>(null);
  final List<String> genderItems = ['Female', 'Male'];

  final Rxn<XFile> profileImage = Rxn<XFile>();
  final Rxn<XFile> idCardImage = Rxn<XFile>();

  final Rxn<ProvinceModel> provinceSelected = Rxn<ProvinceModel>();
  final Rxn<DistrictModel> districtSelected = Rxn<DistrictModel>();
  final Rxn<CommuneModel> communeSelected = Rxn<CommuneModel>();
  final Rxn<VillageModel> villageSelected = Rxn<VillageModel>();

  @override
  void onInit() {
    super.onInit();
    // Pre-fill from existing ClientModel
    firstName = TextEditingController(text: client.first_name == 'N/A' ? '' : client.first_name);
    lastName = TextEditingController(text: client.last_name == 'N/A' ? '' : client.last_name);
    dateOfBirth = TextEditingController();
    phoneNumber = TextEditingController(text: client.mobile == 'N/A' ? '' : client.mobile);
    gisCode = TextEditingController();
    externalIdController = TextEditingController(text: client.external_id == 'N/A' ? '' : client.external_id);
    selectedGender.value = (client.gender == 'N/A' || client.gender.isEmpty) ? null : client.gender;
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    await Future.wait([_fetchProvince(), _fetchIdTypes()]);
    await _fetchClientDetail();
    isLoading.value = false;
  }

  Future<void> _fetchClientDetail() async {
    try {
      final res = await Get.find<ApiService>().get(
        EndPoints.clientEdit(client.id),
        isShowLoading: false,
      );

      final data = getPropertyFromJson(res.data, 'data') ?? res.data;
      if (data == null) return;

      String? str(dynamic v) => v?.toString().trim().isEmpty == true ? null : v?.toString().trim();
      int? toInt(dynamic v) => v is int ? v : int.tryParse(v?.toString() ?? '');

      if (str(data['first_name']) != null) firstName.text = str(data['first_name'])!;
      if (str(data['last_name']) != null) lastName.text = str(data['last_name'])!;
      if (str(data['mobile']) != null) phoneNumber.text = str(data['mobile'])!;
      if (str(data['external_id']) != null) externalIdController.text = str(data['external_id'])!;
      if (str(data['dob']) != null) dateOfBirth.text = str(data['dob'])!;
      if (str(data['gis_code']) != null) gisCode.text = str(data['gis_code'])!;
      if (str(data['gender']) != null) selectedGender.value = str(data['gender']);

      final idTypeId = data['client_identification_type_id']?.toString();
      if (idTypeId != null && idTypeId.isNotEmpty) {
        selectedIdType.value = idTypes.firstWhereOrNull((t) => t.id == idTypeId);
      }

      // Chain-load location dropdowns
      final provinceId = toInt(data['province_id']);
      if (provinceId == null) return;
      provinceSelected.value = provinceList.firstWhereOrNull((p) => p.id == provinceId);
      if (provinceSelected.value == null) return;
      await fetchDistrict(provinceSelected.value!.id);

      final districtId = toInt(data['district_id']);
      if (districtId == null) return;
      districtSelected.value = districtList.firstWhereOrNull((d) => d.id == districtId);
      if (districtSelected.value == null) return;
      await fetchCommune(districtSelected.value!.id);

      final communeId = toInt(data['commune_id']);
      if (communeId == null) return;
      communeSelected.value = communeList.firstWhereOrNull((c) => c.id == communeId);
      if (communeSelected.value == null) return;
      await fetchVillage(communeSelected.value!.id);

      final villageId = toInt(data['village_id']);
      if (villageId == null) return;
      villageSelected.value = villageList.firstWhereOrNull((v) => v.id == villageId);
    } catch (e) {
      if (isClosed) return;
      ExceptionHandler.handleException(e);
    }
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    dateOfBirth.dispose();
    phoneNumber.dispose();
    gisCode.dispose();
    externalIdController.dispose();
    super.onClose();
  }

  void pickProfileImage() => ImagePickerManager.pickImage((f) {
        if (f != null) profileImage.value = f;
      });

  void pickIdCardImage() => ImagePickerManager.pickImage((f) {
        if (f != null) idCardImage.value = f;
      });

  void selectGender(String value) => selectedGender.value = value;

  void onProvinceChanged(ProvinceModel? value) {
    provinceSelected.value = value;
    districtSelected.value = null;
    communeSelected.value = null;
    villageSelected.value = null;
    districtList.clear();
    communeList.clear();
    villageList.clear();
    if (value != null) fetchDistrict(value.id);
  }

  void onDistrictChanged(DistrictModel? value) {
    districtSelected.value = value;
    communeSelected.value = null;
    villageSelected.value = null;
    communeList.clear();
    villageList.clear();
    if (value != null) fetchCommune(value.id);
  }

  void onCommuneChanged(CommuneModel? value) {
    communeSelected.value = value;
    villageSelected.value = null;
    villageList.clear();
    if (value != null) fetchVillage(value.id);
  }

  void onVillageChanged(VillageModel? value) => villageSelected.value = value;

  Future<void> _fetchIdTypes() async {
    try {
      final res = await Get.find<ApiService>().get(EndPoints.clientCreate, isShowLoading: false);
      idTypes.assignAll(
        (res.data['identification_types'] as List)
            .map((e) => CoBorrowerIdTypeModel.fromJson(e))
            .toList(),
      );
    } catch (_) {}
  }

  Future<void> _fetchProvince() async {
    try {
      final res = await Get.find<ApiService>().get(EndPoints.getprovince, isShowLoading: false);
      provinceList.assignAll(
        (res.data['data'] as List).map((e) => ProvinceModel.fromJson(e)).toList(),
      );
    } catch (_) {}
  }

  Future<void> fetchDistrict(int id) async {
    try {
      isLoadingDistrict.value = true;
      final res = await Get.find<ApiService>().get('${EndPoints.getdistrict}/$id', isShowLoading: false);
      districtList.assignAll(
        (res.data['data'] as List).map((e) => DistrictModel.fromJson(e)).toList(),
      );
    } catch (_) {} finally {
      isLoadingDistrict.value = false;
    }
  }

  Future<void> fetchCommune(int id) async {
    try {
      isLoadingCommune.value = true;
      final res = await Get.find<ApiService>().get('${EndPoints.getcommune}/$id', isShowLoading: false);
      communeList.assignAll(
        (res.data['data'] as List).map((e) => CommuneModel.fromJson(e)).toList(),
      );
    } catch (_) {} finally {
      isLoadingCommune.value = false;
    }
  }

  Future<void> fetchVillage(int id) async {
    try {
      isLoadingVillage.value = true;
      final res = await Get.find<ApiService>().get('${EndPoints.getvillage}/$id', isShowLoading: false);
      villageList.assignAll(
        (res.data['data'] as List).map((e) => VillageModel.fromJson(e)).toList(),
      );
    } catch (_) {} finally {
      isLoadingVillage.value = false;
    }
  }

  DatePicker getDatePicker() {
    final now = DateTime.now();
    final initial = dateOfBirth.text.isEmpty ? now : DateTime.tryParse(dateOfBirth.text) ?? now;
    return DatePicker(
      controller: dateOfBirth,
      initialDate: initial,
      minDate: DateTime(now.year - 90),
      maxDate: now,
      minYear: now.year - 90,
      maxYear: now.year,
    );
  }

  Future<void> fetchCurrentLocation() async {
    if (isFetchingLocation.value) return;
    isFetchingLocation.value = true;
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        DialogManager.showDialog(title: LocaleKeys.error.tr, subTitle: 'Please enable location services.');
        return;
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        DialogManager.showDialog(title: LocaleKeys.error.tr, subTitle: 'Location permission is required.');
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      gisCode.text = '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
    } catch (e) {
      if (isClosed) return;
      ExceptionHandler.handleException(e);
    } finally {
      isFetchingLocation.value = false;
    }
  }

  Future<void> submitUpdate() async {
    try {
      isLoading.value = true;
      final branchId = await SharedPreferencesManager.getIntValue('branch_id');
      final userId = await SharedPreferencesManager.getIntValue('user_id');

      final Map<String, dynamic> payload = {
        'first_name': firstName.text,
        'last_name': lastName.text,
        'gender': selectedGender.value,
        'dob': dateOfBirth.text,
        'mobile': phoneNumber.text,
        'gis_code': gisCode.text,
        'client_identification_type_id': selectedIdType.value?.id,
        'external_id': externalIdController.text,
        'province_id': provinceSelected.value?.id,
        'district_id': districtSelected.value?.id,
        'commune_id': communeSelected.value?.id,
        'village_id': villageSelected.value?.id,
        'branch_id': branchId,
        'user_id': userId,
      };

      final formData = dio.FormData.fromMap(payload);

      if (profileImage.value != null) {
        formData.files.add(MapEntry(
          'photo',
          await dio.MultipartFile.fromFile(
            profileImage.value!.path,
            filename: profileImage.value!.name,
            contentType: MediaType('image', 'jpeg'),
          ),
        ));
      }

      if (idCardImage.value != null) {
        formData.files.add(MapEntry(
          'id_card_photo',
          await dio.MultipartFile.fromFile(
            idCardImage.value!.path,
            filename: idCardImage.value!.name,
            contentType: MediaType('image', 'jpeg'),
          ),
        ));
      }

      await Get.find<ApiService>().post(
        EndPoints.clientUpdate(client.id),
        formData,
        isShowLoading: true,
      );

      DialogManager.showDialog(
        title: LocaleKeys.successfully.tr,
        subTitle: LocaleKeys.youHaveSuccessfullyCreated.tr,
        onPressed: () {
          Get.back();
          Get.back();
        },
      );
    } catch (e) {
      if (isClosed) return;
      ExceptionHandler.handleException(e);
    } finally {
      isLoading.value = false;
    }
  }
}
