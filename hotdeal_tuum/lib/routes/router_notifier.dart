import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotdeal_tuum/core/di/providers.dart';
import 'package:hotdeal_tuum/domain/providers/auth/auth_state.dart';
import 'package:hotdeal_tuum/routes/route_names.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  bool _isAuthenticated = false;

  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      final newStateIsAuthenticated = next.maybeWhen(
        authenticated: () => true,
        orElse: () => false,
      );
      
      if (_isAuthenticated != newStateIsAuthenticated) {
        _isAuthenticated = newStateIsAuthenticated;
        notifyListeners();
      }
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final loggingIn = state.matchedLocation == AppRoutePaths.login;
    final splashing = state.matchedLocation == AppRoutePaths.splash;
    final registering = state.matchedLocation == AppRoutePaths.register;

    // If not authenticated and trying to access a protected route, redirect to login.
    if (!_isAuthenticated && !loggingIn && !splashing && !registering) {
      return AppRoutePaths.login;
    }

    // If authenticated and trying to access login, register or splash, redirect to home.
    if (_isAuthenticated && (loggingIn || splashing || registering)) {
      return AppRoutePaths.home;
    }

    return null; // No redirect needed
  }
}
