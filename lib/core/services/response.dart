dynamic getPropertyFromJson(dynamic data, String? key) {
  if (data == null || key == null) {
    return null;
  }

  final arr = key.split('.');

  dynamic cp = data;
  for (var key in arr) {
    if (cp is Map && cp.containsKey(key)) {
      cp = cp[key];
    } else {
      return null;
    }
  }
  return cp;
}
