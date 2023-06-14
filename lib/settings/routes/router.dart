import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_store_app/features/auth/presentation/home_store.dart/home_store_screen.dart';
import 'package:multi_store_app/features/auth/presentation/screen/login/login_screen.dart';
import 'package:multi_store_app/features/auth/presentation/screen/recovery_password/email_sended.dart';
import 'package:multi_store_app/features/auth/presentation/screen/recovery_password/recovery_passsword_screen.dart';
import 'package:multi_store_app/features/auth/presentation/screen/register/sign_in_screen.dart';
import 'package:multi_store_app/features/auth/presentation/screen/splash/splash_screen.dart';
import 'package:multi_store_app/features/providers/auth/global_auth/global_auth_provider.dart';

final routeProvider = Provider((ref) {
  final goProvider = ref.read(goRouterProvider);
  return GoRouter(
    initialLocation: SplashScreen.path,
    refreshListenable: goProvider,
    routes: [
      //AuthRoutes*
      GoRoute(
        path: MyHomePage.path,
        builder: (context, state) => const MyHomePage(title: 'Title'),
      ),
      GoRoute(
        path: LoginScreen.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: SignInScreen.path,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: SplashScreen.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RecoveryPasswordScreen.path,
        builder: (context, state) => const RecoveryPasswordScreen(),
      ),
      GoRoute(
        path: EmailSendedScreen.path,
        builder: (context, state) => const EmailSendedScreen(),
      ),
      //  GoRoute(
      //     path: '/home/:page',
      //     name: HomeScreen.name,
      //     builder: (context, state) {
      //       final pageIndex = int.parse( state.params['page'] ?? '0' );

      //       return HomeScreen( pageIndex: pageIndex );
      //     },
      //     routes: [
      //        GoRoute(
      //         path: 'movie/:id',
      //         name: MovieScreen.name,
      //         builder: (context, state) {
      //           final movieId = state.params['id'] ?? 'no-id';

      //           return MovieScreen( movieId: movieId );
      //         },
      //       ),
      //     ]
      //   ),
    ],
    redirect: (context, state) {
      final goingTo = state.location;
      final authStatus = goProvider.authStatus;

      switch (goingTo) {
        case MyHomePage.path:
          if (authStatus == AuthStatus.notAuthenticated) {
            return LoginScreen.path;
          } else if (authStatus == AuthStatus.authenticated) {
            return null;
          } else {
            return null;
          }
        case LoginScreen.path:
          if (authStatus == AuthStatus.authenticated) {
            return MyHomePage.path;
          } else {
            return null;
          }
        case SignInScreen.path:
          if (authStatus == AuthStatus.authenticated) {
            return MyHomePage.path;
          } else {
            return null;
          }
        case SplashScreen.path:
          if (authStatus == AuthStatus.notAuthenticated) {
            return LoginScreen.path;
          } else if (authStatus == AuthStatus.authenticated) {
            return MyHomePage.path;
          } else {
            return null;
          }
      }

      return null;
    },
  );
});

final goRouterProvider = Provider((ref) {
  final authNotifier = ref.watch(authStateProvider.notifier);
  return RouteNotifierProvider(authNotifier);
});

class RouteNotifierProvider extends ChangeNotifier {
  final AuthStateProvider _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;
  RouteNotifierProvider(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
