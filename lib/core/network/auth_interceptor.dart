import 'package:dio/dio.dart';
import 'package:rollapp_negocio_clean/features/auth/data/datasources/auth_local_datasource.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource authLocalDataSource;

  AuthInterceptor({required this.authLocalDataSource});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authLocalDataSource.getCachedToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
