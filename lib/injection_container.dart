import 'package:get_it/get_it.dart';
import 'package:rollapp_negocio_clean/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:rollapp_negocio_clean/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rollapp_negocio_clean/features/auth/data/repository/auth_repository_impl.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/repository/auth_repository.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/login_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/logout_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
      checkAuthUseCase: sl(),
    ),
  );

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
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<SharedPreferencesAsync>(
    () => SharedPreferencesAsync(),
  );
}
