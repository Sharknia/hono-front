import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotdeal_tuum/presentation/screens/home_screen.dart';
import 'package:hotdeal_tuum/presentation/screens/login_screen.dart';
import 'package:hotdeal_tuum/presentation/screens/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: <GoRoute>[
      GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext from, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
    // errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}
