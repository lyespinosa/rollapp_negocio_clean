import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/riverpod/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Antes: context.read<AuthBloc>().add(AuthLoginRequested(...))
      ref
          .read(authProvider.notifier)
          .login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider); // Antes: BlocBuilder
    final isLoading = state is AuthLoading;

    // Antes: listener dentro de BlocConsumer
    ref.listen<AuthState>(authProvider, (previous, current) {
      if (current is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(current.message), backgroundColor: Colors.red),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.lock_outline, size: 80, color: Colors.blue),
              SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                enabled: !isLoading,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: ShapedInputBorder(
                    gapPadding: 20,
                    borderSide: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.none,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  alignLabelWithHint: true,
                  labelText: 'Email',
                  hintText: 'dasdad',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  }
                  if (!value.contains('@')) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                enabled: !isLoading,
                obscureText: true,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Password',
                  prefix: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  }
                  if (value.length < 3) {
                    return 'La longitud mínima es 3';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
