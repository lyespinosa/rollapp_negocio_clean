import 'package:dartz/dartz.dart';
import 'package:rollapp_negocio_clean/core/error/exceptios.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:rollapp_negocio_clean/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/entity/user_entity.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await authLocalDataSource.getCachedUser();
      return Right(user);
    } on JsonParsingException catch (e) {
      return Left(JsonParsingFailure(e.message));
    } on ModelMappingException catch (e) {
      return Left(ModelMappingFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await authLocalDataSource.getCachedToken();
      return Right(token != null);
    } on JsonParsingException catch (e) {
      return Left(JsonParsingFailure(e.message));
    } on ModelMappingException catch (e) {
      return Left(ModelMappingFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginResponse = await authRemoteDataSource.login(email, password);
      await authLocalDataSource.cacheToken(loginResponse.token);
      final userResponse = await authRemoteDataSource.getUser();
      await authLocalDataSource.cacheUser(userResponse);
      return Right(userResponse);
    } on JsonParsingException catch (e) {
      return Left(JsonParsingFailure(e.message));
    } on ModelMappingException catch (e) {
      return Left(ModelMappingFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDataSource.logout();
      await authLocalDataSource.clearToken();
      return Right(null);
    } on JsonParsingException catch (e) {
      return Left(JsonParsingFailure(e.message));
    } on ModelMappingException catch (e) {
      return Left(ModelMappingFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
