import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/flavor/flavor.dart';
import 'package:logging/logging.dart';
import 'package:dio/dio.dart' as d;

class ApiService extends GetxService {
  ApiService init() => this;

  String get baseUrl => AppConfig.shared.baseUrl;

  Logger get logger => Logger.root;

  Future<d.Dio> _dioClient({
    bool? isShowLoading,
    bool requiresAuth = true,
  }) async {
    final client = d.Dio(
      d.BaseOptions(
        followRedirects: false,
        contentType: 'application/json',
        responseType: d.ResponseType.json,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Charset': 'utf-8',
        },
        baseUrl: baseUrl,
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
      ),
    );

    client.interceptors.add(LoadingInterceptor(isShow: isShowLoading ?? false));

    if (requiresAuth) {
      client.interceptors.add(
        AuthenticationInterceptor(accessToken: AppConfig.shared.token),
      );
    }

    // DO NOT change order of these interceptors
    client.interceptors.add(
      LoggingInterceptor(
        requestHeader: true,
        logPrint: (step, message) {
          switch (step) {
            case InterceptStep.request:
              logger.info(message);
              break;
            case InterceptStep.response:
              logger.info(message);
              break;
            case InterceptStep.error:
              logger.severe(message);
              break;
          }
        },
      ),
    );

    return client;
  }

  Future<d.Response> get(
    String? path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool? isShowLoading,
  }) async {
    if (path == null) {
      throw 'Path is null';
    }
    final client = await _dioClient(isShowLoading: isShowLoading);

    if (headers != null) {
      for (MapEntry entry in headers.entries) {
        client.options.headers[entry.key] = entry.value;
      }
    }

    return client.get(path, queryParameters: queryParameters);
  }

  Future<d.Response> post(
    String path,
    dynamic formData, {
    int retries = 2, // 🔁 CHANGED: default retries from null to 2
    String? baseUrl,
    bool encode = true,
    Map<String, dynamic>? cusHeaders,
    String? contentType,
    bool? isShowLoading,
  }) async {
    final client = await _dioClient(
      isShowLoading: isShowLoading,
      requiresAuth: path != EndPoints.login,
    );

    if (baseUrl != null) {
      client.options.baseUrl = baseUrl;
    }

    if (cusHeaders != null) {
      client.options.headers.addEntries(cusHeaders.entries);
    }

    if (contentType != null) {
      client.options.contentType = contentType;
    }

    int attempt = 0; // ✅ ADDED: track retry attempts
    late d.Response response;

    while (attempt <= retries) {
      try {
        response = await client.post(
          path,
          data:
              formData is d.FormData
                  ? formData
                  : encode
                  ? jsonEncode(formData)
                  : formData,
        );
        return response; // ✅ ADDED: return on success
      } on DioException catch (e) {
        attempt++;

        // Don't retry on client errors (4xx) — these are validation errors, not network issues
        if (e.response?.statusCode != null &&
            e.response!.statusCode! >= 400 &&
            e.response!.statusCode! < 500) {
          rethrow;
        }

        if (attempt > retries) {
          rethrow;
        }

        await Future.delayed(const Duration(seconds: 2));
      }
    }

    throw Exception(
      'Unexpected failure after retries',
    ); // ✅ ADDED: fallback throw
  }

  Future<d.Response> put(String path, {dynamic formData}) async {
    final client = await _dioClient();

    return client.put(
      path,
      data: formData is d.FormData ? formData : jsonEncode(formData),
    );
  }

  Future<d.Response> delete(String path, {dynamic data}) async {
    final client = await _dioClient();

    return client.delete(path, data: data);
  }

  Future<d.Response> patch(String path, {dynamic formData}) async {
    final client = await _dioClient();

    return client.patch(
      path,
      data: formData is d.FormData ? formData : jsonEncode(formData),
    );
  }
}
