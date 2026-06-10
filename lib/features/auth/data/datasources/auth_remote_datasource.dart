import 'package:dio/dio.dart';
import 'package:rollapp_negocio_clean/core/error/exceptios.dart';
import 'package:rollapp_negocio_clean/features/auth/data/models/login_model.dart';
import 'package:rollapp_negocio_clean/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login(String email, String password);
  Future<UserModel> getUser();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<LoginModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/usuarios/login',
        data: {'correo': email, 'contrasena': password},
      );

      return LoginModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw InvalidCredentialsException();
      }

      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final response = await dio.get('/negocio/usuarios/permisos');

      return UserModel.fromJson(response.data['data']['usuario']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw InvalidCredentialsException();
      }

      throw ServerException();
    }
  }
}
