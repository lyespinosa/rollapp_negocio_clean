import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rollapp_negocio_clean/core/network/auth_interceptor.dart';
import 'package:rollapp_negocio_clean/core/network/logger_interceptor.dart';
import 'package:rollapp_negocio_clean/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:rollapp_negocio_clean/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rollapp_negocio_clean/features/auth/data/repository/auth_repository_impl.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/repository/auth_repository.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/login_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/logout_usecase.dart';
import 'package:rollapp_negocio_clean/features/producto/data/datasource/producto_remote_datasource.dart';
import 'package:rollapp_negocio_clean/features/producto/data/repository/producto_repository_impl.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/repository/producto_repository.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/usecases/crear_producto_usecase.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/usecases/editar_producto_usecase.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/usecases/eliminar_producto_usecase.dart';
import 'package:rollapp_negocio_clean/features/producto/domain/usecases/ver_lista_productos_usecase.dart';
import 'package:rollapp_negocio_clean/features/sucursal/data/datasource/sucursal_remote_datasource.dart';
import 'package:rollapp_negocio_clean/features/sucursal/data/repository/sucursal_repository_impl.dart';
import 'package:rollapp_negocio_clean/features/sucursal/domain/repository/sucursal_repository.dart';
import 'package:rollapp_negocio_clean/features/sucursal/domain/usecases/ver_lista_sucursales_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(repository: sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton(() => CrearProductoUsecase(repository: sl()));
  sl.registerLazySingleton(() => EditarProductoUseCase(repository: sl()));
  sl.registerLazySingleton(() => EliminarProductoUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerListaProductosUseCase(repository: sl()));

  sl.registerLazySingleton<ProductoRepository>(
    () => ProductoRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<ProductoRemoteDataSource>(
    () => ProductoRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<SharedPreferencesAsync>(
    () => SharedPreferencesAsync(),
  );

  sl.registerLazySingleton(() => VerListaSucursalesUseCase(repository: sl()));

  sl.registerLazySingleton<SucursalRepository>(
    () => SucursalRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<SucursalRemoteDataSource>(
    () => SucursalRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://darkslategrey-bison-707919.hostingersite.com/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(AuthInterceptor(authLocalDataSource: sl()));

    dio.interceptors.add(LoggerInterceptor());

    return dio;
  });
}
