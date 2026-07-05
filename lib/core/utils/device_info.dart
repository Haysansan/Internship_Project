import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper {
  DeviceInfoHelper._();

  static final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  /// A human-readable device name to identify the device on login,
  /// e.g. "iPhone 14 Pro" or "Samsung SM-A536E".
  static Future<String> getDeviceName() async {
    try {
      if (Platform.isIOS) {
        final info = await _plugin.iosInfo;
        return info.utsname.machine;
      }
      if (Platform.isAndroid) {
        final info = await _plugin.androidInfo;
        return '${info.manufacturer} ${info.model}';
      }
    } catch (_) {
      // fall through to default below
    }
    return 'Unknown Device';
  }

  /// A unique identifier for this device.
  /// Android: androidInfo.id (stable per signing key).
  /// iOS: identifierForVendor (stable per vendor per device).
  static Future<String> getDeviceId() async {
    try {
      if (Platform.isIOS) {
        final info = await _plugin.iosInfo;
        return info.identifierForVendor ?? '';
      }
      if (Platform.isAndroid) {
        final info = await _plugin.androidInfo;
        return info.id;
      }
    } catch (_) {
      // fall through to empty
    }
    return '';
  }
}
