import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static Future<SharedPreferences> get _instance => SharedPreferences.getInstance();

  static Future<bool> containsKey(String key) async => (await _instance).containsKey(key);

  static Future<dynamic> get(String key) async => (await _instance).get(key);

  static Future<int?> getIntValue(String key) async {
    final value = (await _instance).get(key);
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static Future<bool> remove(String key) async => (await _instance).remove(key);

  static Future<bool> setValue(String key, dynamic value) async {
    switch (value.runtimeType) {
      case int:
        return (await _instance).setInt(key, value);
      case double:
        return (await _instance).setDouble(key, value);
      case bool:
        return (await _instance).setBool(key, value);
      case String:
        return (await _instance).setString(key, value);
      case const (List<String>):
        return (await _instance).setStringList(key, value);
      default:
        return false;
    }
  }
}
