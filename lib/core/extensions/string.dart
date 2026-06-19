extension StringExtension on String {
  String get capitalized {
    if (isEmpty) {
      return '';
    }
    return this[0].toUpperCase() + substring(1);
  }
}
