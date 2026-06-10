import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/riverpod/auth_notifier.dart';
import 'package:rollapp_negocio_clean/features/auth/presentation/riverpod/auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
