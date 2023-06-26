import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_store_app/features/auth/presentation/screen/login/login_screen.dart';
import 'package:multi_store_app/features/auth/presentation/screen/recovery_password/email_sended.dart';
import 'package:multi_store_app/features/auth/presentation/screen/recovery_password/recovery_passsword_screen.dart';
import 'package:multi_store_app/features/auth/presentation/screen/register/sign_in_screen.dart';
import 'package:multi_store_app/features/auth/presentation/screen/splash/splash_screen.dart';
import 'package:multi_store_app/features/home/presentation/home_store/deliver_to_screen.dart';
import 'package:multi_store_app/features/home/presentation/home_store/notifications_screen.dart';
import 'package:multi_store_app/features/home/presentation/page_view_home.dart';
import 'package:multi_store_app/features/providers/auth/global_auth/global_auth_provider.dart';

final routeProvider = Provider((ref) {
  final goProvider = ref.read(goRouterProvider);
  return GoRouter(
    initialLocation: SplashScreen.path,
    refreshListenable: goProvider,
    routes: [
      //AuthRoutes*
      GoRoute(
        path: PageViewHome.path,
        builder: (context, state) => const PageViewHome(),
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
      GoRoute(
        path: DeliveryToScreen.path,
        builder: (context, state) => const DeliveryToScreen(),
      ),
      GoRoute(
        path: NotificationsScreens.path,
        builder: (context, state) => const NotificationsScreens(),
      ),
    ],
    redirect: (context, state) {
      final goingTo = state.location;
      final authStatus = goProvider.authStatus;

      switch (goingTo) {
        case PageViewHome.path:
          if (authStatus == AuthStatus.notAuthenticated) {
            return LoginScreen.path;
          } else if (authStatus == AuthStatus.authenticated) {
            return null;
          } else {
            return null;
          }
        case LoginScreen.path:
          if (authStatus == AuthStatus.authenticated) {
            return PageViewHome.path;
          } else {
            return null;
          }
        case SignInScreen.path:
          if (authStatus == AuthStatus.authenticated) {
            return PageViewHome.path;
          } else {
            return null;
          }
        case SplashScreen.path:
          if (authStatus == AuthStatus.notAuthenticated) {
            return LoginScreen.path;
          } else if (authStatus == AuthStatus.authenticated) {
            return PageViewHome.path;
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
