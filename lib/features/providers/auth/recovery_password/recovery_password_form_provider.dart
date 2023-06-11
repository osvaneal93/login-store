import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/providers/auth/global_auth/global_auth_provider.dart';

final recoveryPasswordFormProvider =
    StateNotifierProvider.autoDispose<RecoveryPasswordFormProvider, RecoveryPasswordFormState>(
  (ref) {
    final Function(String) verifyCallback = ref.read(authStateProvider.notifier).sendRecoveryPasswordEmail;

    return RecoveryPasswordFormProvider(verifyCallback);
  },
);

class RecoveryPasswordFormProvider extends StateNotifier<RecoveryPasswordFormState> {
  final TextEditingController emailRecoveryController = TextEditingController();
  final GlobalKey<FormState> recoveryFormKey = GlobalKey<FormState>();
  final Function(String) verifyUserCallback;

  RecoveryPasswordFormProvider(this.verifyUserCallback)
      : super(RecoveryPasswordFormState(sended: false, sending: false));

  onEmailChange() {
    final String emailTMP = emailRecoveryController.text;
    state = state.copyWith(email: emailTMP);
  }

  onSubmmitButton() async {
    state = state.copyWith(sending: true);
    try {
      await verifyUserCallback(state.email ?? '');
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(sended: false, sending: false, errorMessage: e.code);
      return;
    }
    state = state.copyWith(sended: true, sending: false);
  }

  // @override
  // void dispose() {
  //   debugPrint('ENTRO AL DISPPPOOOOOOSEEEEEEEEEEEJKHKJHKJKJHHJ');
  //   emailRecoveryController.dispose();
  //   super.dispose();
  // }
}

class RecoveryPasswordFormState {
  final String? email;
  final bool? sending;
  final bool? sended;
  final String? errorMessage;
  RecoveryPasswordFormState({this.email, this.sending, this.sended, this.errorMessage});

  RecoveryPasswordFormState copyWith({String? email, bool? sending, bool? sended, String? errorMessage}) =>
      RecoveryPasswordFormState(
          email: email ?? this.email,
          sended: sended ?? this.sended,
          sending: sending ?? this.sending,
          errorMessage: errorMessage ?? this.errorMessage);
}
