import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/riverpod/auth_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            // context.read<AuthBloc>().add(AuthLogoutRequested()) →
            onPressed: () => ref.read(authProvider.notifier).logout(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: state is AuthAuthenticated
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: Colors.green,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text('Email: ${state.userEntity.correo}'),
                  SizedBox(height: 16),
                  Text('Name: ${state.userEntity.nombre}'),
                  TextButton(
                    onPressed: () => context.go('/productos'),
                    child: const Text('Ir a los productos'),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
