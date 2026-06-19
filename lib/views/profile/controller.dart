import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apploan/core/core.dart';

class ProfileController extends GetxController {
  final Rxn<XFile> profile = Rxn<XFile>(XFile(''));

  Future<void> updateProfile(XFile file) async {
    try {
      final dio.FormData formData = dio.FormData.fromMap({
        'name': UserRepository.shared.profile.name,
        'profile': await dio.MultipartFile.fromFile(
          file.path,
          filename: file.name,
        ),
      });

      await Get.find<ApiService>().post(
        EndPoints.updateProfile,
        formData,
        isShowLoading: true,
        cusHeaders: {'Content-Type': 'multipart/form-data'},
      );

      profile.value = file;

      DialogManager.hideLoading();
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
