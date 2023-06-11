import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/providers/auth/global_auth/global_auth_provider.dart';

class LoginFormState {
  final String? email;
  final String? password;
  final bool isPosting;
  final bool isFormPosted;
  final String? errorMessage;
  // final bool isValid;

  LoginFormState({this.email, this.password, required this.isPosting, required this.isFormPosted, this.errorMessage
      // required this.isValid,
      });

  LoginFormState copyWith({String? email, String? password, bool? isPosting, bool? isFormPosted, String? errorMessage
      // bool? isValid,
      }) {
    return LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        // isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class LoginFormNotifierProvider extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;
  final Function() signInGoogleCallback;
  final Function() signInFacebookCallback;

  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  LoginFormNotifierProvider(this.loginUserCallback, this.signInGoogleCallback, this.signInFacebookCallback)
      : super(LoginFormState(
          isPosting: false,
          isFormPosted: false,
        ));

  onEmailChange() {
    final String emailTMP = emailLoginController.text;
    state = state.copyWith(email: emailTMP);
  }

  onPasswordChange() {
    final String passwordTMP = passwordLoginController.text;
    state = state.copyWith(password: passwordTMP);
  }

  onSubmmitloginButton() async {
    state = state.copyWith(isFormPosted: false, isPosting: true, errorMessage: '');
    try {
      await loginUserCallback(state.email ?? '', state.password ?? '');
      state = state.copyWith(isFormPosted: true, isPosting: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(errorMessage: e.message, isFormPosted: true, isPosting: false);
      state = state.copyWith(errorMessage: '', isFormPosted: true, isPosting: false);
    }
  }

  onSubmmitGoogleButton() async {
    state = state.copyWith(isFormPosted: false, isPosting: true, errorMessage: '');
    try {
      await signInGoogleCallback();
      state = state.copyWith(isFormPosted: true, isPosting: false);
      debugPrint('INICIO CON GOOOGLEEEEEE');
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(errorMessage: e.message, isFormPosted: true, isPosting: false);
      state = state.copyWith(errorMessage: '', isFormPosted: true, isPosting: false);
    }
  }

  onSubmmitFacebookButton() async {
    state = state.copyWith(isFormPosted: false, isPosting: true, errorMessage: '');
    try {
      await signInFacebookCallback();
      state = state.copyWith(isFormPosted: true, isPosting: false);
      debugPrint('INICIO CON FACEBOOOOOOOOOOOK');
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(errorMessage: e.message, isFormPosted: true, isPosting: false);
      state = state.copyWith(errorMessage: '', isFormPosted: true, isPosting: false);
    }
  }
}

final loginFormNotifierProvider = StateNotifierProvider.autoDispose<LoginFormNotifierProvider, LoginFormState>((ref) {
  final loginRegisterCB = ref.read(authStateProvider.notifier);
  return LoginFormNotifierProvider(
      loginRegisterCB.userLogIn, loginRegisterCB.signInWithGoogle, loginRegisterCB.signInWithFacebook);
});
