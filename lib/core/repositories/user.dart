import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/flavor/flavor.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/routes.dart';

class UserRepository {
  UserRepository._() {
    _context = Get.context;
    _checkDeviceType();
  }

  static final UserRepository _instance = UserRepository._();
  static UserRepository get shared => _instance;

  final String _telegram = 'soft_creative';
  String get telegram => _telegram.replaceAll('@', '');

  final String _phoneNumber = '078 358 272';
  String get phoneNumber => _phoneNumber.replaceAll('@', '');

  final RxString _permission = ''.obs;
  String get permission => _permission.value;

  String get userName {
    final name = profile.name;
    return name.isNotEmpty ? name : 'User';
  }

  static final ProfileModel _emptyProfile = ProfileModel(
    id: 0,
    name: '',
    email: '',
    profile: '',
    phone: '',
    gender: '',
    status: '',
    branch_id: 0,
    created_at: '',
    updated_at: '',
    profilePath: '',
    policy: '',
    type: '',
    full_name: '',
  );

  ProfileModel? _profile;
  ProfileModel get profile => _profile ?? _emptyProfile;

  Future<void> logout() async {
    SharedPreferencesManager.remove(Credential.token.name);
    AppConfig.shared.isDeliveryTapOpened = false;
    Get.offAllNamed(Routes.login);
  }

  void setProfile(ProfileModel profile) {
    setUserType(profile.type);
    _profile = profile;
  }

  Future<void> fetchProfile(int userId) async {
    try {
      final res = await Get.find<ApiService>().get(
        EndPoints.profile,
        queryParameters: {'id': userId},
        isShowLoading: false,
      );

      final data = getPropertyFromJson(res.data, 'data');
      if (data != null) {
        setProfile(ProfileModel.fromJson(data));
      }
    } catch (e) {
      ExceptionHandler.handleException(e);
    }
  }

  void setUserType(String value) {
    final normalized = value.trim().toLowerCase();
    switch (normalized) {
      case 'credit officer':
      case 'co':
        _isCO = true;
        _isBM = false;
        _isEco = false;
        break;
      case 'branch manager':
      case 'bm':
        _isCO = false;
        _isBM = true;
        _isEco = false;
        break;
      case 'ceo':
      case 'eco':
        _isCO = false;
        _isBM = false;
        _isEco = true;
        break;
      default:
        // Unrecognized profile type (e.g. 'N/A') — keep whatever role
        // was already resolved (e.g. from login permission) instead of
        // silently clearing it.
        break;
    }
  }

  void setUserTypeFromPermission(String value) {
    _permission.value = value.toLowerCase(); // ← triggers Obx rebuild
    _isCO = false;
    _isBM = false;
    _isEco = false;
    switch (value.toLowerCase()) {
      case 'co':
        _isCO = true;
        break;
      case 'bm':
        _isBM = true;
        break;
      case 'eco':
      case 'ceo':
        _isEco = true;
        break;
    }
  }

  // eod_enable=0 means EOD is open (buttons enabled); 1 means closed (buttons disabled)
  final RxBool eodEnabled = true.obs;
  void setEodEnabled(int val) => eodEnabled.value = (val == 0);

  bool _isTablet = false;
  bool _isCO = false;
  bool _isBM = false;
  bool _isEco = false;
  bool get isTablet => _isTablet;
  bool get isCO => _isCO;
  bool get isBM => _isBM;
  bool get isEco => _isEco;

  BuildContext? _context;
  BuildContext? get context => _context;

  void _checkDeviceType() {
    _isTablet = context!.isTablet;
  }
}
