import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/auth/data/models/auth_model.dart';
import 'package:multi_store_app/features/auth/domain/repository/auth/auth_repository.dart';
import 'package:multi_store_app/features/auth/domain/source/auth/firebase_auth_datasource.dart';
import 'package:multi_store_app/main.dart';

final authStateProvider = StateNotifierProvider<AuthStateProvider, AuthState>((ref) {
  final authRepository = AuthRepository(FirebaseAuthDataSource(globalyAuth));
  return AuthStateProvider(authRepository: authRepository);
});

class AuthStateProvider extends StateNotifier<AuthState> {
  AuthRepositoryBase authRepository;
  AuthStateProvider({required this.authRepository}) : super(AuthState()) {
    checkAuthStatus();
  }

  sendRecoveryPasswordEmail(String email) async {
    try {
      await authRepository.sendRecoveryPasswordEmail(email);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  checkAuthStatus() async {
    final userStatus = await authRepository.checkUserStatus();
    if (userStatus == AuthStatus.authenticated) {
      final userData = await authRepository.getUserModel();
      state = state.copyWith(authStatus: userStatus, user: userData);
    }
    state = state.copyWith(authStatus: userStatus);
  }

  userSignIn(String email, String password, String name, String lastName) async {
    try {
      final globalUser = await authRepository.userSignIn(email, password, name, lastName);
      state = state.copyWith(authStatus: AuthStatus.authenticated, user: globalUser);
    } on FirebaseAuthException catch (_) {
      rethrow;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  userLogIn(String email, String password) async {
    try {
      final globalUser = await authRepository.userLogin(email, password);
      state = state.copyWith(authStatus: AuthStatus.authenticated, user: globalUser);
    } catch (_) {
      rethrow;
    }
  }

  userLogout() async {
    await authRepository.userLogOut();
    state = state.copyWith(authStatus: AuthStatus.notAuthenticated);
  }

  signInWithFacebook() async {
    try {
      final globalUser = await authRepository.signInWithGoogle();
      state = state.copyWith(authStatus: AuthStatus.authenticated, user: globalUser);
    } catch (_) {
      throw UnimplementedError();
    }
  }

  signInWithGoogle() async {
    try {
      final globalUser = await authRepository.signInWithGoogle();
      state = state.copyWith(authStatus: AuthStatus.authenticated, user: globalUser);
    } catch (_) {
      throw UnimplementedError();
    }
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final UserModel? user;
  final String errorMessage;

  AuthState({this.authStatus = AuthStatus.checking, this.user, this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    UserModel? user,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
