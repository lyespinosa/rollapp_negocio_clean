import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/riverpod/auth_state.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  late AuthState _authState;

  RouterNotifier(this._ref) {
    // Lee el estado inicial sin suscribirse (evita rebuilds del provider)
    _authState = _ref.read(authProvider);

    // ref.listen es el equivalente a stream.listen
    _ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous == next) return;
      _authState = next;
      notifyListeners(); // GoRouter reacciona aquí, igual que antes
    });
  }

  AuthState get authState => _authState;

  // La lógica de redirect vive aquí para mantenerla junto al estado
  String? redirect(BuildContext context, GoRouterState routerState) {
    final isGoingToLogin = routerState.matchedLocation == '/login';
    final isGoingToSplash = routerState.matchedLocation == '/splash';

    if (_authState is AuthUnauthenticated || _authState is AuthError) {
      return isGoingToLogin ? null : '/login';
    }

    if (_authState is AuthAuthenticated) {
      if (isGoingToLogin || isGoingToSplash) return '/home';
    }

    return null; // AuthInitial / AuthLoading — no redirige (splash espera)
  }
}
