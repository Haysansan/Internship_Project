import 'package:dio/dio.dart';
import 'package:apploan/core/utils/utils.dart';

class ExceptionHandler {
  ExceptionHandler._();

  static void handleException(
    dynamic error, {
    bool alert = true,
    Function(dynamic)? onValue,
  }) {
    if (!alert) {
      return;
    }

    const String title = 'Error';
    String subTitle = 'UnKnown Error';

    if (error is DioException) {
      final res = error.response;
      if (res != null) {
        if (res.data is Map) {
          subTitle = res.data['message'];
        } else {
          subTitle = res.data;
        }
      }
    } else if (error is String) {
      subTitle = error;
    } else {
      subTitle = 'Something went wrong ($error)';
    }

    DialogManager.showDialog(
      title: title,
      subTitle: subTitle.isEmpty ? 'Something went wrong' : subTitle,
    ).then((value) {
      if (onValue == null) {
        return;
      }
      onValue(value);
    });
  }
}
