import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotdeal_tuum/presentation/screens/error_screen.dart';
import 'package:hotdeal_tuum/presentation/screens/home_screen.dart';
import 'package:hotdeal_tuum/presentation/screens/login_screen.dart';
import 'package:hotdeal_tuum/presentation/screens/splash_screen.dart';
import 'package:hotdeal_tuum/routes/route_names.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // final routerNotifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutePaths.splash,
    // refreshListenable: routerNotifier,
    routes: <GoRoute>[
      GoRoute(
        path: AppRoutePaths.splash,
        name: AppRouteNames.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.login,
        name: AppRouteNames.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (BuildContext from, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
  );
});
