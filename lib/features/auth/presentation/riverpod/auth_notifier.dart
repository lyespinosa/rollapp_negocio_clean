import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rollapp_negocio_clean/core/error/failures.dart';
import 'package:rollapp_negocio_clean/core/usecases/usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/login_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/domain/usecases/logout_usecase.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/riverpod/auth_state.dart';
import 'package:rollapp_negocio_clean/injection_container.dart' as di;

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => AuthInitial();

  Future<void> login({required String email, required String password}) async {
    state = AuthLoading();

    final result = await di.sl<LoginUseCase>()(
      LoginParams(email: email, password: password),
    );

    result.fold((l) {
      String message = 'Auth error';
      if (l is InvalidCredentialsFailure) {
        message = 'Correo o contraseña incorrectos';
      } else if (l is ServerFailure) {
        message = 'Error del servidor';
      }
      state = AuthError(message: message);
    }, (r) => state = AuthAuthenticated(userEntity: r));
  }

  Future<void> checkAuth() async {
    state = AuthLoading();

    final checkResult = await di.sl<CheckAuthUseCase>()(NoParams());
    final isAuthenticated = checkResult.fold((_) => false, (r) => r);

    if (!isAuthenticated) {
      state = AuthUnauthenticated();
      return;
    }

    final userResult = await di.sl<GetCurrentUserUseCase>()(NoParams());
    state = userResult.fold(
      (_) => AuthUnauthenticated(),
      (user) => user != null
          ? AuthAuthenticated(userEntity: user)
          : AuthUnauthenticated(),
    );
  }

  Future<void> logout() async {
    state = AuthLoading();
    final result = await di.sl<LogoutUseCase>()(NoParams());
    result.fold(
      (l) => state = AuthError(message: 'Error al iniciar sesión'),
      (r) => state = AuthUnauthenticated(),
    );
  }
}
