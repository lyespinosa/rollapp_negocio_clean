import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/screens/home_screen.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/screens/login_screen.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/screens/splash_screen.dart';
import 'package:rollapp_negocio_clean/features/producto/presentation/screens/lista_productos_screen.dart';
import 'package:rollapp_negocio_clean/router_notifier.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);

  ref.onDispose(notifier.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/productos',
        builder: (context, state) => const ListaProductosScreen(),
      ),
    ],
  );
});
