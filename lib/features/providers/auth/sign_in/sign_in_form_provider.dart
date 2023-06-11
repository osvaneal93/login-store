import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/providers/auth/global_auth/global_auth_provider.dart';

final signInProvider = StateNotifierProvider.autoDispose<SignInFormStateProvider, SignInFormState>((ref) {
  final signInCallBack = ref.read(authStateProvider.notifier);
  return SignInFormStateProvider(
      signInCallBack.userSignIn, signInCallBack.signInWithGoogle, signInCallBack.signInWithFacebook);
});

class SignInFormStateProvider extends StateNotifier<SignInFormState> {
  SignInFormStateProvider(this.signInUserCallback, this.signInWithGoogleCallback, this.signInWithFacebookCallback)
      : super(SignInFormState(
          isPosting: false,
          isPosted: false,
        ));

  final Function(String email, String password, String name, String lastName) signInUserCallback;
  final Function() signInWithGoogleCallback;
  final Function() signInWithFacebookCallback;

  final TextEditingController emailSignInController = TextEditingController();
  final TextEditingController passwordSignInController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final TextEditingController nameSignInController = TextEditingController();
  final TextEditingController lastNameSignInController = TextEditingController();

  onEmailChange() {
    final String emailTMP = emailSignInController.text;
    state = state.copyWith(email: emailTMP);
  }

  onPasswordChange() {
    final String passwordTMP = passwordSignInController.text;
    state = state.copyWith(password: passwordTMP);
  }

  onConfirmPasswordChange() {
    final String passwordTMP = passwordConfirmController.text;
    state = state.copyWith(confirmPassword: passwordTMP);
  }

  onNameChange() {
    final String nameTMP = nameSignInController.text;
    state = state.copyWith(name: nameTMP);
  }

  onLastNameChange() {
    final lastNameTMP = lastNameSignInController.text;
    state = state.copyWith(lastName: lastNameTMP);
  }

  onSubmmitSignInButton() async {
    state = state.copyWith(isPosted: false, isPosting: true, errorMessage: '');
    try {
      await signInUserCallback(
        state.email ?? '',
        state.password ?? '',
        state.name ?? '',
        state.lastName ?? '',
      );
      state = state.copyWith(isPosting: false);
    } on FirebaseException catch (e) {
      state = state.copyWith(errorMessage: e.code, isPosting: false);
      state = state.copyWith(errorMessage: '', isPosting: false);
    }
  }

  onSubmmitGoogleButton() async {
    state = state.copyWith(isPosted: false, isPosting: true, errorMessage: '');
    try {
      await signInWithGoogleCallback();
      state = state.copyWith(isPosted: true, isPosting: false);
      debugPrint('INICIO CON GOOOGLEEEEEE');
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosted: true, isPosting: false);
      state = state.copyWith(errorMessage: '', isPosted: true, isPosting: false);
    }
  }

  onSubmmitFacebookButton() async {
    state = state.copyWith(isPosted: false, isPosting: true, errorMessage: '');
    try {
      await signInWithFacebookCallback();
      state = state.copyWith(isPosted: true, isPosting: false);
      debugPrint('INICIO CON FACEBOOOOOOOOOOOK');
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosted: true, isPosting: false);
      state = state.copyWith(errorMessage: '', isPosted: true, isPosting: false);
    }
  }
}

class SignInFormState {
  final String? email, password, name, lastName, confirmPassword, errorMessage;
  final bool isPosting, isPosted;
  SignInFormState({
    this.email,
    this.password,
    this.name,
    this.lastName,
    this.errorMessage,
    this.confirmPassword,
    required this.isPosting,
    required this.isPosted,
  });

  SignInFormState copyWith(
          {String? email,
          String? password,
          String? confirmPassword,
          String? name,
          String? lastName,
          bool? isPosting,
          bool? isPosted,
          String? errorMessage}) =>
      SignInFormState(
        errorMessage: errorMessage ?? this.errorMessage,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isPosting: isPosting ?? this.isPosting,
        isPosted: isPosted ?? this.isPosted,
        email: email ?? this.email,
        lastName: lastName ?? this.lastName,
        name: name ?? this.name,
        password: password ?? this.password,
      );
}
