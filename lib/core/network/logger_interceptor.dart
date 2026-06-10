import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('');
    debugPrint('🚀 REQUEST');
    debugPrint('${options.method} ${options.uri}');
    debugPrint('Headers: ${options.headers}');
    debugPrint('Body: ${options.data}');
    debugPrint('');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('');
    debugPrint('✅ RESPONSE');
    debugPrint(
      '${response.requestOptions.method} '
      '${response.requestOptions.uri}',
    );
    debugPrint('Status: ${response.statusCode}');
    debugPrint('Data: ${response.data}');
    debugPrint('');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('');
    debugPrint('❌ ERROR');
    debugPrint(
      '${err.requestOptions.method} '
      '${err.requestOptions.uri}',
    );
    debugPrint('Status: ${err.response?.statusCode}');
    debugPrint('Data: ${err.response?.data}');
    debugPrint('Message: ${err.message}');
    debugPrint('');

    handler.next(err);
  }
}
