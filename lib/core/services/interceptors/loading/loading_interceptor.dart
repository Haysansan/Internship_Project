import 'package:dio/dio.dart' as dio;
import 'package:apploan/core/core.dart';

class LoadingInterceptor extends dio.Interceptor {
  LoadingInterceptor({required this.isShow});
  final bool isShow;

  @override
  void onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) {
    if (isShow) DialogManager.showLoadingDialog();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) {
    if (isShow) DialogManager.hideLoading();
    super.onResponse(response, handler);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    if (isShow) DialogManager.hideLoading();
    super.onError(err, handler);
  }
}
