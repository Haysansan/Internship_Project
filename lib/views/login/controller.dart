import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/flavor/flavor.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/routes.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameCtl = TextEditingController();
  final TextEditingController passCtl = TextEditingController();

  final RxBool isPassVisible = true.obs;

  @override
  void onInit() {
    _onInit();
    super.onInit();
  }

  Future<void> _onInit() async {
    final String username =
        await SharedPreferencesManager.get(Credential.username.name) ?? '';
    final String password =
        await SharedPreferencesManager.get(Credential.password.name) ?? '';

    if (username.isNotEmpty && password.isNotEmpty) {
      usernameCtl.text = username;
      passCtl.text = password;
    }
  }

  @override
  void onClose() {
    usernameCtl.dispose();
    passCtl.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      final deviceId = await DeviceInfoHelper.getDeviceId();
      final deviceName = await DeviceInfoHelper.getDeviceName();
      final Map<String, dynamic> payload = {
        'username': usernameCtl.text.replaceAll(' ', '').trim(),
        'password': passCtl.text,
        'device_name': deviceName,
        'device_id': deviceId,
      };

      final res = await Get.find<ApiService>().post(
        EndPoints.login,
        payload,
        encode: false,
        contentType: Headers.formUrlEncodedContentType,
        isShowLoading: true,
      );

      // Check if the response indicates failure
      if (res.statusCode != 200 || res.data['success'] == false) {
        // Get the error message from the response
        final String errorMessage =
            res.data['message'] ?? 'Login failed. Please try again.';

        // Show error dialog with the message
        DialogManager.showDialog(title: 'Error', subTitle: errorMessage);
        return;
      }

      final data = getPropertyFromJson(res.data, 'data');

      final LoginModel login = LoginModel.fromJson(data);

      await SharedPreferencesManager.setValue(
        Credential.username.name,
        usernameCtl.text,
      );
      await SharedPreferencesManager.setValue(
        Credential.password.name,
        passCtl.text,
      );

      DialogManager.hideLoading();

      // OTP is only required on a fresh install's first login — once this
      // device has verified OTP, plain logins (even after logout) skip it.
      if (await _requiresOtp()) {
        Get.offAllNamed(
          Routes.otpVerification,
          arguments: {'userId': login.user_id},
        );
        return;
      }

      await _persistSession(login);
      Get.offAllNamed(Routes.start);

      // Refresh local cache in the background so offline screens and the
      // disbursement form's cached lookups are up to date after login.
      // SyncDataController().syncCore();
    } catch (e) {
      if (isClosed) {
        return;
      }
      // Generic error handling
      String errorMessage =
          'Login failed. Please check your credentials and try again.';

      // Show error dialog
      DialogManager.showDialog(title: 'Error', subTitle: errorMessage);

      ExceptionHandler.handleException(e);
    }
  }

  Future<bool> _requiresOtp() async {
    final bool deviceVerified =
        await SharedPreferencesManager.get(Credential.device_verified.name) ??
        false;
    return !deviceVerified;
  }

  Future<void> _persistSession(LoginModel login) async {
    AppConfig.shared.token = login.token;

    await SharedPreferencesManager.setValue(Credential.token.name, login.token);
    await SharedPreferencesManager.setValue('name', login.name);
    await SharedPreferencesManager.setValue(
      Credential.branch_id.name,
      login.branch_id,
    );
    await SharedPreferencesManager.setValue(
      Credential.user_id.name,
      login.user_id,
    );
    await SharedPreferencesManager.setValue(
      Credential.permission.name,
      login.permission,
    );
    await SharedPreferencesManager.setValue('eod_enable', login.eod_enable);
    UserRepository.shared.setEodEnabled(login.eod_enable);
    UserRepository.shared.setUserTypeFromPermission(login.permission);
    await UserRepository.shared.fetchProfile(login.user_id);
  }
}
