import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/bloc/auth_state.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/screens/home_screen.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/screens/login_screen.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/screens/splash_screen.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  GoRouter get router => GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;

      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSplash = state.matchedLocation == '/splash';

      if (authState is AuthUnauthenticated || authState is AuthError) {
        return isGoingToLogin ? null : '/login';
      }
      if (authState is AuthAuthenticated) {
        if (isGoingToLogin || isGoingToSplash) {
          return '/home';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return HomeScreen();
        },
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;
}
