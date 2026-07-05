import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apploan/core/core.dart';

class ProfileController extends GetxController {
  final Rxn<XFile> profile = Rxn<XFile>(XFile(''));
  final RxString photoUrl = ''.obs;

  Future<int?> _getUserId() async =>
      SharedPreferencesManager.getIntValue('user_id');

  @override
  void onInit() {
    super.onInit();
    _refreshProfile();
  }

  Future<void> _refreshProfile() async {
    final userId = await _getUserId();
    await UserRepository.shared.fetchProfile(
      userId ?? UserRepository.shared.profile.id.toInt(),
    );
    _syncPhotoUrl();
  }

  void _syncPhotoUrl() {
    final p = UserRepository.shared.profile;
    final raw = (p.profilePath.isNotEmpty && p.profilePath != 'N/A')
        ? p.profilePath
        : p.profile;
    photoUrl.value = (raw.isNotEmpty && raw != 'N/A' && !raw.startsWith('http') && !raw.startsWith('/'))
        ? '/storage/uploads/$raw'
        : raw;
  }
      
  Future<void> updateProfile(XFile file) async {
    try {
      // Read bytes immediately — fromFile uses a lazy stream that can fail on iOS
      final bytes = await File(file.path).readAsBytes();
      final userId = await _getUserId();
      final formData = dio.FormData.fromMap({
        'photo': dio.MultipartFile.fromBytes(
          bytes,
          filename: file.name,
        ),
        'user_id':userId
      });

      await Get.find<ApiService>().post(
        EndPoints.updateProfile,
        formData,
        isShowLoading: true,
        retries: 0, // FormData bytes can't be re-read on retry
      );

      profile.value = file;

      await UserRepository.shared.fetchProfile(userId ?? UserRepository.shared.profile.id.toInt());
      _syncPhotoUrl();

      Get.snackbar(
        LocaleKeys.successfully.tr,
        LocaleKeys.update.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await Get.find<ApiService>().get(
        EndPoints.deleteAccount,
        isShowLoading: true,
      );
      await UserRepository.shared.logout();
    } catch (e) {
      if (isClosed) {
        return;
      }
      ExceptionHandler.handleException(e);
    }
  }
}
