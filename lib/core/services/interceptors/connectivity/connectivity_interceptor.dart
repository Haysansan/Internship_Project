import 'package:apploan/core/libraries/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:apploan/core/core.dart';

class ConnectivityInterceptor extends dio.Interceptor {
  ConnectivityInterceptor();

  @override
  void onRequest(dio.RequestOptions options, dio.RequestInterceptorHandler handler) async {
    if (await ConnectivityPlusManager.shared.isConnected) {
      return super.onRequest(options, handler);
    } else {
      DialogManager.showConnectionDialog();
      return;
    }
  }
}
