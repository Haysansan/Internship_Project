import 'package:dio/dio.dart' as dio;

class AuthenticationInterceptor extends dio.Interceptor {
  AuthenticationInterceptor({required this.accessToken});

  final String accessToken;

  @override
  void onRequest(dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = accessToken;
    }
    super.onRequest(options, handler);
  }
}
